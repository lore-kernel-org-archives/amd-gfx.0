From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Deadlocks with multiple applications on AMD RX 460 and RX 550 -
 Update 2
Date: Wed, 3 Jan 2018 18:09:24 +0100
Message-ID: <99a9e27e-f166-f969-416f-f128b0673388@daenzer.net>
References: <CAEzXK1o+FewfiG84pCj8c_1Xz5KVsOOU7EX13LWaFVxK7s66fg@mail.gmail.com>
 <1ca083a5-f33c-7be0-a3c8-c2996a087f70@amd.com>
 <CAEzXK1odkDX-D3MOGHLFJuKNHh0RjSfsFL8PtB=6YQRDf1+Tkw@mail.gmail.com>
 <d755cd12-1a1e-ce98-2b0d-ea4b5eafc483@amd.com>
 <CAEzXK1qCfnHUvnuuViTP5fZQx2StjecV6o_QfJ2uJk603_9nhA@mail.gmail.com>
 <CAEzXK1oUyHsSGHeXS9qzWBSDL-FfRq2h-EiQMCfa=5BroO50gg@mail.gmail.com>
 <8bcdc933-050b-12ca-46e6-54bb66b6824d@gmail.com>
 <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1pPzRM=EpL8fKQ5SdDvEePR+_KPhrtPMPiArt==BsJspA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMS0wMyAxMjowMiBQTSwgTHXDrXMgTWVuZGVzIHdyb3RlOgo+IAo+IFdoYXQgSSBi
ZWxpZXZlIGl0IHNlZW1zIHRvIGJlIHRoZSBjYXNlIGlzIHRoYXQgdGhlIEdQVSBsb2NrIHVwIG9u
bHkKPiBoYXBwZW5zIHdoZW4gZG9pbmcgYSBwYWdlIGZsaXAsIHNpbmNlIHRoZSBrZXJuZWwgbG9j
a3Mgd2l0aDoKPiBbICAyNDMuNjkzMjAwXSBrd29ya2VyL3U0OjMgICAgRCAgICAwICAgIDg5ICAg
ICAgMiAweDAwMDAwMDAwCj4gWyAgMjQzLjY5MzIzMl0gV29ya3F1ZXVlOiBldmVudHNfdW5ib3Vu
ZCBjb21taXRfd29yayBbZHJtX2ttc19oZWxwZXJdCj4gWyAgMjQzLjY5MzI1MV0gWzw4MGI4YzZk
ND5dIChfX3NjaGVkdWxlKSBmcm9tIFs8ODBiOGNkZDA+XSAoc2NoZWR1bGUrMHg0Yy8weGFjKQo+
IFsgIDI0My42OTMyNTldIFs8ODBiOGNkZDA+XSAoc2NoZWR1bGUpIGZyb20gWzw4MGI5MTAyND5d
Cj4gKHNjaGVkdWxlX3RpbWVvdXQrMHgyMjgvMHg0NDQpCj4gWyAgMjQzLjY5MzI3MF0gWzw4MGI5
MTAyND5dIChzY2hlZHVsZV90aW1lb3V0KSBmcm9tIFs8ODA4ODY3Mzg+XQo+IChkbWFfZmVuY2Vf
ZGVmYXVsdF93YWl0KzB4MmI0LzB4MmQ4KQo+IFsgIDI0My42OTMyNzZdIFs8ODA4ODY3Mzg+XSAo
ZG1hX2ZlbmNlX2RlZmF1bHRfd2FpdCkgZnJvbSBbPDgwODg1ZDYwPl0KPiAoZG1hX2ZlbmNlX3dh
aXRfdGltZW91dCsweDQwLzB4MTUwKQo+IFsgIDI0My42OTMyODRdIFs8ODA4ODVkNjA+XSAoZG1h
X2ZlbmNlX3dhaXRfdGltZW91dCkgZnJvbSBbPDgwODg3YjFjPl0KPiAocmVzZXJ2YXRpb25fb2Jq
ZWN0X3dhaXRfdGltZW91dF9yY3UrMHhmYy8weDM0YykKPiBbICAyNDMuNjkzNTA5XSBbPDgwODg3
YjFjPl0gKHJlc2VydmF0aW9uX29iamVjdF93YWl0X3RpbWVvdXRfcmN1KSBmcm9tCj4gWzw3ZjMz
MTk4OD5dIChhbWRncHVfZG1fZG9fZmxpcCsweGVjLzB4MzZjIFthbWRncHVdKQo+IFsgIDI0My42
OTM3ODldIFs8N2YzMzE5ODg+XSAoYW1kZ3B1X2RtX2RvX2ZsaXAgW2FtZGdwdV0pIGZyb20KPiBb
PDdmMzMzMDljPl0gKGFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwrMHhiZmMvMHhlNTggW2Ft
ZGdwdV0pCj4gLi4uCgpEb2VzIHRoZSBwcm9ibGVtIGFsc28gb2NjdXIgaWYgeW91IGRpc2FibGUg
REMgd2l0aCBhbWRncHUuZGM9MCBvbiB0aGUKa2VybmVsIGNvbW1hbmQgbGluZT8KCkRvZXMgaXQg
YWxzbyBoYXBwZW4gd2l0aCBhIGtlcm5lbCBidWlsdCBmcm9tIHRoZSBhbWQtc3RhZ2luZy1kcm0t
bmV4dApicmFuY2ggaW5zdGVhZCBvZiBkcm0tbmV4dC00LjE2PwoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
