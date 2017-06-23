From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Fri, 23 Jun 2017 17:01:20 +0800
Message-ID: <594CD8E0.3080702@amd.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de> <594CBEBC.5010703@amd.com>
 <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0d847baf-8296-f3ce-7a8d-8823f33e392e-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Xie,
 AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

CgpPbiAyMDE35bm0MDbmnIgyM+aXpSAxNjoyNSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBB
bSAyMy4wNi4yMDE3IHVtIDA5OjA5IHNjaHJpZWIgemhvdWNtMToKPj4KPj4KPj4gT24gMjAxN+W5
tDA25pyIMjPml6UgMTQ6NTcsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBCdXQgZ2l2aW5n
IHRoZSBDUyBJT0NUTCBhbiBvcHRpb24gZm9yIGRpcmVjdGx5IHNwZWNpZnlpbmcgdGhlIEJPcyAK
Pj4+IGluc3RlYWQgb2YgYSBCTyBsaXN0IGxpa2UgTWFyZWsgc3VnZ2VzdGVkIHdvdWxkIGluZGVl
ZCBzYXZlIHVzIHNvbWUgCj4+PiB0aW1lIGhlcmUuIAo+PiBpbnRlcmVzdGluZywgSSBhbHdheXMg
Zm9sbG93IGhvdyB0byBpbXByb3ZlIG91ciBjcyBpb2N0bCwgc2luY2UgVU1EIAo+PiBndXlzIGFm
dGVuIGNvbXBsYWluIG91ciBjb21tYW5kIHN1Ym1pc3Npb24gaXMgc2xvd2VyIHRoYW4gd2luZG93
cy4KPj4gVGhlbiBob3cgdG8gZGlyZWN0bHkgc3BlY2lmeWluZyB0aGUgQk9zIGluc3RlYWQgb2Yg
YSBCTyBsaXN0PyBCTyAKPj4gaGFuZGxlIGFycmF5IGZyb20gVU1EPyBDb3VsZCB5b3VyIGd1eXMg
ZGVzY3JpYmUgbW9yZSBjbGVhcj8gSXMgaXQgCj4+IGRvYWJsZT8KPgo+IE1ha2luZyB0aGUgQk8g
bGlzdCBwYXJ0IG9mIHRoZSBDUyBJT0NUTCB3b3VsZG4ndCBoZWxwIGF0IGFsbCBmb3IgdGhlIAo+
IGNsb3NlIHNvdXJjZSBVTURzLiBUbyBiZSBwcmVjaXNlIHdlIGFjdHVhbGx5IGNhbWUgdXAgd2l0
aCB0aGUgQk8gbGlzdCAKPiBhcHByb2FjaCBiZWNhdXNlIG9mIHRoZWlyIHJlcXVpcmVtZW50Lgo+
Cj4gVGhlIGJpZ2dlc3QgYnVuY2ggb2Ygd29yayBkdXJpbmcgQ1MgaXMgcmVzZXJ2aW5nIGFsbCB0
aGUgYnVmZmVycywgCj4gdmFsaWRhdGluZyB0aGVtIGFuZCBjaGVja2luZyB0aGVpciBWTSBzdGF0
dXMuIApUb3RhbGx5IGFncmVlLiBFdmVyeSB0aW1lIHdoZW4gSSByZWFkIGNvZGUgdGhlcmUsIEkg
b2Z0ZW4gd2FudCB0byAKb3B0aW1pemUgdGhlbS4KCj4gSXQgZG9lc24ndCBtYXR0ZXIgaWYgdGhl
IEJPcyBjb21lIGZyb20gdGhlIEJPIGxpc3Qgb3IgZGlyZWN0bHkgaW4gdGhlIAo+IENTIElPQ1RM
Lgo+Cj4gVGhlIGtleSBwb2ludCBpcyB0aGF0IENTIG92ZXJoZWFkIGlzIHByZXR0eSBtdWNoIGly
cmVsZXZhbnQgZm9yIHRoZSAKPiBvcGVuIHNvdXJjZSBzdGFjaywgc2luY2UgTWVzYSBkb2VzIGNv
bW1hbmQgc3VibWlzc2lvbiBmcm9tIGEgc2VwYXJhdGUgCj4gdGhyZWFkIGFueXdheS4KSWYgaXJy
ZWxldmFudCBmb3IgdGhlIG9wZW4gc3RhY2ssIHRoZW4gaG93IGRvZXMgb3BlbiBzb3VyY2Ugc3Rh
Y2sgaGFuZGxlIAoiVGhlIGJpZ2dlc3QgYnVuY2ggb2Ygd29yayBkdXJpbmcgQ1MgaXMgcmVzZXJ2
aW5nIGFsbCB0aGUgYnVmZmVycywgCnZhbGlkYXRpbmcgdGhlbSBhbmQgY2hlY2tpbmcgdGhlaXIg
Vk0gc3RhdHVzLiI/CklmIG9wZW4gc3RhY2sgaGFzIGEgYmV0dGVyIHdheSwgSSB0aGluayBjbG9z
ZWQgc3RhY2sgY2FuIGZvbGxvdyBpdCwgSSAKZG9uJ3Qga25vdyB0aGUgaGlzdG9yeS4KClJlZ2Fy
ZHMsCkRhdmlkIFpob3UKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMs
Cj4+IERhdmlkIFpob3UKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
