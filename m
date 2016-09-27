From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Tue, 27 Sep 2016 16:56:06 +0900
Message-ID: <98c6de12-d44e-1952-f409-b7d1c71b2430@daenzer.net>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A7nSCd-_ViLiJ5RZfTC54DNoYCKL2Ny=WgLSDVCEcdVOQ@mail.gmail.com>
 <MWHPR12MB1694E693082763289AA98A51F7CD0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <CAAxE2A7qzNC1mBJ9Q0SbL3A8xmfjhMrYk6Ey4kB3ws9s7VUDeg@mail.gmail.com>
 <4120919c-2b50-b78a-406d-f3974ef00f12@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4120919c-2b50-b78a-406d-f3974ef00f12-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjcvMDkvMTYgMDQ6MTcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjcuMDku
MjAxNiB1bSAwMToxMyBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4+IE9uIE1vbiwgU2VwIDI2LCAy
MDE2IGF0IDEwOjQyIFBNLCBEZXVjaGVyLCBBbGV4YW5kZXIKPj4gPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+IHdyb3RlOgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJv
bTogTWFyZWsgT2zFocOhayBbbWFpbHRvOm1hcmFlb0BnbWFpbC5jb21dCj4+Pj4gU2VudDogTW9u
ZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMTYgNDozOSBQTQo+Pj4+IFRvOiBIdWFuZywgUmF5Cj4+Pj4g
Q2M6IGFtZC1nZnggbWFpbGluZyBsaXN0OyBEZXVjaGVyLCBBbGV4YW5kZXI7IFdhbmcsIEtlbjsg
SHVhbiwgQWx2aW4KPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gZHJtL2FtZGdwdTogaW1w
bGVtZW50IHJhc3RlciBjb25maWd1cmF0aW9uCj4+Pj4KPj4+PiBUaGUgc2VyaWVzIGlzIG1pc3Np
bmcgYSBEUk0gdmVyc2lvbiBidW1wLCBzbyBNZXNhIGNhbid0IHJlYWxseSB1c2UgaXQKPj4+PiBl
dmVuIGlmIGl0IHdhbnRlZC4KPj4+Pgo+Pj4gV2UgYnVtcGVkIGl0IGFscmVhZHkgdGhpcyBjeWNs
ZSBmb3Igc2V2ZXJhbCBvdGhlciB0aGluZ3MsIGJ1dCBJIGNhbgo+Pj4gYWRkIGEgc3BlY2lmaWMg
YnVtcCBmb3IgdGhpcyBhcyB3ZWxsIGlmIHRoYXQgaXMgcHJlZmVycmVkLgo+PiBPaCwgdGhhdCdz
IG5vdCBuZWNlc3NhcnkuIE9uZSBidW1wIHBlciBjeWNsZSBpcyBPSy4KPiAKPiBBcyBJIHdyb3Rl
IGluIHRoZSBvdGhlciB0aHJlYWQgYXMgd2VsbCwgYnVtcGluZyBvbmNlIHBlciBjeWNsZSBzdWNr
cwo+IHdoZW4geW91IHdhbnQgdG8gYmlzZWN0IHNvbWV0aGluZy4KPiAKPiBXZSBhcmUgYWxzbyBu
b3Qgc2hvcnQgb24gbnVtYmVycywgc28gSSBzdWdnZXN0IHRoYXQgd2UgZXN0YWJsaXNoIHRoYXQg
d2UKPiBhbHdheXMgYnVtcCB3aGVuIHdlIGFkZCBhIG5ldyBpbnRlcmZhY2UgdG8gdGhlIGtlcm5l
bCBJT0NUTC4KClNlY29uZGVkLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
