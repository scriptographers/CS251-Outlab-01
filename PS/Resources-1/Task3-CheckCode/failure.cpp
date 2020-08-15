#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

long long int factorial(int n)
{
    if (n==0 || n==1) return 1;
    else return n*factorial(n-1);
}

long long int num_anagrams(int freq[26])
{
    int n=0;
    
    for (int i=0; i<26; i++)
    {
        n = n+freq[i];
    }
    long long int numerator = factorial(n);
    long long int denominator = 1;
    for (int i=0; i<26; i++)
    {
        denominator = denominator*factorial(freq[i]);
    }
    return numerator/denominator;
}

long long int rank1(string s)
{
    if (s.size() == 0 || s.size() == 1) return 0;
    long long int base_term = 0;
    int freq[26];
    for (int i=0; i<26; i++)
    {
        freq[i] = 0;
    }
    for (int i=0 ; i<s.size(); i++)
    {
        freq[s[i] - 'a']++;
    } //here a frequency chart is ready
    for (int i=0; i< s[0] - 'a'; i++ )
    {
        int freqc[26];
        for (int i=0; i<26; i++) freqc[i] = freq[i];
        if (freqc[i] == 0) continue;
        freqc[i]--;
        base_term = base_term + num_anagrams(freqc);
    }
    int n=s.size();
    string s1 = s.substr(1);
    long long int r = rank1(s1);
    return base_term + r;
    //return 0;
}

string proxy(int freq[26])
{
    string s = "";
    for (int i=0; i<26; i++)
    {
        char add = 'a'+i;
        for (int j=0; j<freq[i]; j++)
        {
            s = s+add;
        }
    }
    return s;
}

string ans(string s, long long int n)
{
    int a = s.size();
    if (a == 0 || a == 1) return s;
    int freq[26];
    for (int i=0; i<26; i++)
    {
        freq[i] = 0;
    }
    int m = s.size();
    for (int i=0; i<m; i++)
    {
        freq[s[i] - 'a']++;
    } //freq chart ready
    
    long long int cumu_sum = 0;
    long long int prev_sum = 0;
    int i;
    int freqc[26];
    for (i=0; i<26; i++)
    {
        
        if (freq[i] == 0) continue;
        //int freqc[26];
        for (int j=0; j<26; j++) {freqc[j] = freq[j];}
        freqc[i]--;
        prev_sum = cumu_sum;
        cumu_sum = cumu_sum + num_anagrams(freqc);
        if (cumu_sum > n) break;
        //this is the i we want to start with
    }
    
    char first = 'a'+i;
    string pr = proxy(freqc);
    //cout<<"hi"<<endl;
    string pred = ans(pr, n-prev_sum);
    return first+pred;
}

int main()
{
    string s;
    long long int n;
    
    cin>>s>>n;
    long long int r1 = rank1(s);
    if (r1%4 == 1)
    {
        r1++;
    }
    string t = ans(s, n);
    //string t = "hello";
    cout<<r1<<" "<<t<<endl;
}
