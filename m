From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Fri, 23 Jun 2017 10:25:05 +0200
Message-ID: <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de> <594CBEBC.5010703@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <594CBEBC.5010703-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

QW0gMjMuMDYuMjAxNyB1bSAwOTowOSBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTflubQw
NuaciDIz5pelIDE0OjU3LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBCdXQgZ2l2aW5nIHRo
ZSBDUyBJT0NUTCBhbiBvcHRpb24gZm9yIGRpcmVjdGx5IHNwZWNpZnlpbmcgdGhlIEJPcyAKPj4g
aW5zdGVhZCBvZiBhIEJPIGxpc3QgbGlrZSBNYXJlayBzdWdnZXN0ZWQgd291bGQgaW5kZWVkIHNh
dmUgdXMgc29tZSAKPj4gdGltZSBoZXJlLiAKPiBpbnRlcmVzdGluZywgSSBhbHdheXMgZm9sbG93
IGhvdyB0byBpbXByb3ZlIG91ciBjcyBpb2N0bCwgc2luY2UgVU1EIAo+IGd1eXMgYWZ0ZW4gY29t
cGxhaW4gb3VyIGNvbW1hbmQgc3VibWlzc2lvbiBpcyBzbG93ZXIgdGhhbiB3aW5kb3dzLgo+IFRo
ZW4gaG93IHRvIGRpcmVjdGx5IHNwZWNpZnlpbmcgdGhlIEJPcyBpbnN0ZWFkIG9mIGEgQk8gbGlz
dD8gQk8gCj4gaGFuZGxlIGFycmF5IGZyb20gVU1EPyBDb3VsZCB5b3VyIGd1eXMgZGVzY3JpYmUg
bW9yZSBjbGVhcj8gSXMgaXQgZG9hYmxlPwoKTWFraW5nIHRoZSBCTyBsaXN0IHBhcnQgb2YgdGhl
IENTIElPQ1RMIHdvdWxkbid0IGhlbHAgYXQgYWxsIGZvciB0aGUgCmNsb3NlIHNvdXJjZSBVTURz
LiBUbyBiZSBwcmVjaXNlIHdlIGFjdHVhbGx5IGNhbWUgdXAgd2l0aCB0aGUgQk8gbGlzdCAKYXBw
cm9hY2ggYmVjYXVzZSBvZiB0aGVpciByZXF1aXJlbWVudC4KClRoZSBiaWdnZXN0IGJ1bmNoIG9m
IHdvcmsgZHVyaW5nIENTIGlzIHJlc2VydmluZyBhbGwgdGhlIGJ1ZmZlcnMsIAp2YWxpZGF0aW5n
IHRoZW0gYW5kIGNoZWNraW5nIHRoZWlyIFZNIHN0YXR1cy4gSXQgZG9lc24ndCBtYXR0ZXIgaWYg
dGhlIApCT3MgY29tZSBmcm9tIHRoZSBCTyBsaXN0IG9yIGRpcmVjdGx5IGluIHRoZSBDUyBJT0NU
TC4KClRoZSBrZXkgcG9pbnQgaXMgdGhhdCBDUyBvdmVyaGVhZCBpcyBwcmV0dHkgbXVjaCBpcnJl
bGV2YW50IGZvciB0aGUgb3BlbiAKc291cmNlIHN0YWNrLCBzaW5jZSBNZXNhIGRvZXMgY29tbWFu
ZCBzdWJtaXNzaW9uIGZyb20gYSBzZXBhcmF0ZSB0aHJlYWQgCmFueXdheS4KClJlZ2FyZHMsCkNo
cmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IERhdmlkIFpob3UKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
