From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/ttm: initialize globals during device init
Date: Tue, 23 Oct 2018 09:48:30 +0800
Message-ID: <031a34d4-28cc-174b-3c25-89ec185d80df@amd.com>
References: <20181019164138.32993-1-christian.koenig@amd.com>
 <20181019164138.32993-4-christian.koenig@amd.com>
 <91e7b5e4-f91a-f3a9-983a-2f1dbb5bc6c9@amd.com>
 <05f388d9-7f49-125c-22a7-395aec17e324@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <05f388d9-7f49-125c-22a7-395aec17e324-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tzimmermann-l3A5Bk7waGM@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTAvMjIvMjAxOCAwODozNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMi4x
MC4xOCB1bSAwODo0NSBzY2hyaWViIFpoYW5nLCBKZXJyeShKdW53ZWkpOgo+PiBBIHF1ZXN0aW9u
IGluIHR0bV9iby5jCj4+IFtTTklQXQo+Pj4gwqAgwqAgaW50IHR0bV9ib19kZXZpY2VfcmVsZWFz
ZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldikKPj4+IMKgIHsKPj4+IEBAIC0xNjIzLDE4ICsx
NjIwLDI1IEBAIGludCB0dG1fYm9fZGV2aWNlX3JlbGVhc2Uoc3RydWN0IAo+Pj4gdHRtX2JvX2Rl
dmljZSAqYmRldikKPj4+IGRybV92bWFfb2Zmc2V0X21hbmFnZXJfZGVzdHJveSgmYmRldi0+dm1h
X21hbmFnZXIpOwo+Pj4gwqAgK8KgwqDCoCBpZiAoIXJldCkKPj4+ICvCoMKgwqDCoMKgwqDCoCB0
dG1fYm9fZ2xvYmFsX3JlbGVhc2UoKTsKPj4KPj4gaWYgdHRtX2JvX2NsZWFuX21tKCkgZmFpbHMs
IGl0IHdpbGwgc2tpcCB0dG1fYm9fZ2xvYmFsX3JlbGVhc2UoKS4KPj4gV2hlbiB3aWxsIGl0IGJl
IGNhbGxlZD8KPgo+IE5ldmVyLgo+Cj4+Cj4+IFNoYWxsIGFkZCBpdCB0byBkZWxheWVkIHdvcms/
IG9yIG1heWJlIHdlIGNvdWxkIHJlbGVhc2UgaXQgZGlyZWN0bHk/Cj4KPiBObywgd2hlbiB0dG1f
Ym9fZGV2aWNlX3JlbGVhc2UoKSBmYWlscyBzb21lYm9keSBpcyB0cnlpbmcgdG8gdW5sb2FkIGEg
Cj4gZHJpdmVyIHdoaWxlIHRoaXMgZHJpdmVyIHN0aWxsIGhhcyBtZW1vcnkgYWxsb2NhdGVkLgo+
Cj4gSW4gdGhpcyBjYXNlIEJPIGFjY291bnRpbmcgc2hvdWxkIG5vdCBiZSByZWxlYXNlZCBiZWNh
dXNlIHdlIHNob3VsZCAKPiBtYWtlIHN1cmUgdGhhdCBhbGwgdGhlIGxlYWtlZCBtZW1vcnkgaXMg
c3RpbGwgYWNjb3VudGVkLgoKSW4gdGhpcyBjYXNlLCBpdCdzIHJhdGhlciBhIGJ1ZyB0byBmaXgg
dGhlbi4KVGhhbmtzIHRvIGV4cGxhaW4gaXQgLgoKbG9va3MgZmluZSBmb3IgbWUsIGZlZWwgZnJl
ZSB0byBhZGQKUmV2aWV3ZWQtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4K
CkplcnJ5Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMsCj4+IEplcnJ5Cj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
