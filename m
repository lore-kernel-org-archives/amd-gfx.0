From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix iova debugfs for non-iommu case
Date: Wed, 20 Sep 2017 09:07:38 +0200
Message-ID: <9f37eed5-44b9-e175-284a-aa1bfd3223c7@gmail.com>
References: <20170919153042.9994-1-tom.stdenis@amd.com>
 <e9302f12-3f26-5176-79d1-5d837e44ebd5@amd.com>
 <1e817718-572a-6d77-f948-ef3ed5eeef0c@gmail.com>
 <5fbdcf5d-3be9-5af9-2321-8c59ebac4bb3@amd.com>
 <73bfce43-eeb2-f30a-21be-f59e1a9eb509@amd.com>
 <d6fb88bd-0742-29c4-f091-091ea466d599@amd.com>
 <cffc4608-454c-7ef5-c231-77e6b31d660c@amd.com>
 <a0abde86-0700-3155-9410-a14332836b95@amd.com>
 <bb94f775-ecd9-7752-9fc7-41a1a7a1c11d@amd.com>
 <eb89afe7-469a-c298-fba1-eb1d2c4c725d@amd.com>
 <df37f22f-ee32-977a-0d44-2dd35fcac95b@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <df37f22f-ee32-977a-0d44-2dd35fcac95b-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTkuMDkuMjAxNyB1bSAyMzozOCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAxOS8wOS8x
NyAwMjozMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IFtyb290QGNhcnJpem8gfl0j
IHh4ZCAtbCAxMDI0IC1zIDB4QzAwMDAgCj4+PiAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRn
cHVfaW92YQo+Pgo+PiBBY3R1YWxseSAweEMwMDAwIGlzIGEgc3BlY2lhbCBhZGRyZXNzLCBlLmcu
IHZpZGVvIEJJT1MgaWYgSSdtIG5vdCAKPj4gY29tcGxldGVseSBtaXN0YWtlbi4KPgo+IE5vdCBz
dXJlICB3aHkgdGhhdCB3b3VsZCBiZSBtYXBwZWQgYnkgdGhlIGRyaXZlciBidXQgSSBjYW4gYWxz
byByZWFkIAo+IHRoZSBrZXJuZWwncyBic3Mgc2VjdGlvbiB3aXRoIHRoaXMuLi4KPgo+ICQgeHhk
IC1sIDEwNDg1NzYgLXMgMHgwMWU0YzAwMCAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRncHVf
aW92YQo+Cj4gLi4uPHNuaXA+Li4uCj4gMDFlNmE0MzA6IDRjNjkgNmU3NSA3ODIwIDc2NjUgNzI3
MyA2OTZmIDZlMjAgMzQyZSAgTGludXggdmVyc2lvbiA0Lgo+IDAxZTZhNDQwOiAzMTMzIDJlMzAg
MmQ3MiA2MzM1IDJiMjAgMjg3MiA2ZjZmIDc0NDAgIDEzLjAtcmM1KyAocm9vdEAKPiAwMWU2YTQ1
MDogNjM2MSA3MjcyIDY5N2EgNmYyOSAyMDI4IDY3NjMgNjMyMCA3NjY1ICBjYXJyaXpvKSAoZ2Nj
IHZlCj4gMDFlNmE0NjA6IDcyNzMgNjk2ZiA2ZTIwIDM2MmUgMzMyZSAzMTIwIDMyMzAgMzEzNiAg
cnNpb24gNi4zLjEgMjAxNgo+IDAxZTZhNDcwOiAzMTMyIDMyMzEgMjAyOCA1MjY1IDY0MjAgNDg2
MSA3NDIwIDM2MmUgIDEyMjEgKFJlZCBIYXQgNi4KPiAwMWU2YTQ4MDogMzMyZSAzMTJkIDMxMjkg
MjAyOCA0NzQzIDQzMjkgMjkyMCAyMzMzICAzLjEtMSkgKEdDQykpICMzCj4gMDFlNmE0OTA6IDMx
MjAgNTM0ZCA1MDIwIDU0NzUgNjUyMCA1MzY1IDcwMjAgMzEzOSAgMSBTTVAgVHVlIFNlcCAxOQo+
IDAxZTZhNGEwOiAyMDMwIDM3M2EgMzEzOCAzYTMzIDMxMjAgNDU0NCA1NDIwIDMyMzAgICAwNzox
ODozMSBFRFQgMjAKPiA8c25pcD4KPgo+IFRoYXQncyBwYXJ0IG9mIHRoZSBkbWVzZyBidWZmZXIg
YXBwYXJlbnRseS4KPgo+IEkgcG9pbnRlZCBpdCBhdCBhbGwgc29ydHMgb2YgYWRkcmVzcyAoYmlv
cy9zeXN0ZW0gcmFtL2V0YykgaXQgcHJldHR5IAo+IG11Y2ggd2lsbCByZWFkIGFueXRoaW5nLgoK
WWVhaCwgZmVhcmVkIHRoYXQgdGhpcyB3b3VsZCBiZSB0aGUgY2FzZS4gT0sgaW4gdGhpcyBjYXNl
IHlvdXIgb3JpZ2luYWwgCmNvbmNlcm4gd2FzIGNvbXBsZXRlbHkgY29ycmVjdCBhbmQgd2UgY2Fu
J3QgYWxsb3cgdGhpcyBpbiBnZW5lcmFsLgoKQ2hyaXN0aWFuLgoKPgo+IFRvbQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
