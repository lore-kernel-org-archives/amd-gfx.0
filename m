From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 10:35:15 +0200
Message-ID: <1bf9efc9-73d2-d8e3-2176-c1273be5447f@amd.com>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <5374dffa-45c9-1bd6-79b9-cc4450a96aeb@gmail.com>
 <126a68a9-43f4-c747-89d1-114dc29ea4e9@daenzer.net>
 <3cc456c1-929d-4aee-2e8b-7d4edb023382@amd.com>
 <0f28de35-1928-2af3-8b8d-13c61b25e285@daenzer.net>
 <45bab640-d574-b822-e5c8-69fe67626a9a@amd.com>
 <988daf71-51ef-65e7-48ed-9dc2f3acb3a1@daenzer.net>
 <a5be38fa-4da6-642f-b297-21261820a908@gmail.com>
 <9a3c0fb3-c6a8-d59f-89cf-ec32ff6ed630@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9a3c0fb3-c6a8-d59f-89cf-ec32ff6ed630-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTcuMDcuMjAxOCB1bSAxMDozMCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMTcgMTA6MTkgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE3LjA3LjIwMTgg
dW0gMTA6MDMgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDctMTcgMDk6NTkg
QU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTcuMDcuMjAxOCB1bSAwOTo0NiBz
Y2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+PiBPbiAyMDE4LTA3LTE3IDA5OjMzIEFNLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4gQW0gMTcuMDcuMjAxOCB1bSAwOToyNiBzY2hyaWVi
IE1pY2hlbCBEw6RuemVyOgo+Pj4+Pj4gW1NOSVBdCj4+Pj4+IEFsbCB0aGF0IHNob3VsZCBiZSBu
ZWVkZWQgaXMgb25lIHN0cnVjdCBsaXN0X2hlYWQgcGVyIEJPLCAxNiBieXRlcyBvbgo+Pj4+PiA2
NC1iaXQuCj4+Pj4gK21hbGxvYyBvdmVyaGVhZCBhbmQgdGhhdCBmb3IgKmV2ZXJ5KiBCTyB0aGUg
YXBwbGljYXRpb24vZHJpdmVyCj4+Pj4gYWxsb2NhdGVkLgo+Pj4gVGhlIHN0cnVjdCBsaXN0X2hl
YWQgY2FuIGJlIHN0b3JlZCBpbiBzdHJ1Y3QgYW1kZ3B1X2JvLCBubyBhZGRpdGlvbmFsCj4+PiBt
YWxsb2MgbmVjZXNzYXJ5Lgo+PiBXZWxsIHRoYXQgc291bmRzIHdlIGFyZSBub3QgdGFsa2luZyBh
Ym91dCB0aGUgc2FtZSBjb2RlLCBkbyB3ZT8KPj4KPj4gSUlSQyB0aGUgaGFzaHRhYmxlIGltcGxl
bWVudGF0aW9uIGluIGxpYmRybSBpcyB1c2luZyBhbiBldmVyIGdyb3dpbmcKPj4gYXJyYXkgZm9y
IHRoZSBCT3MgYW5kICpOT1QqIGEgbGlua2VkIGxpc3QuCj4gU28gbGV0J3MgdXNlIHNvbWV0aGlu
ZyBtb3JlIHN1aXRhYmxlLCBlLmcuOgo+Cj4gQW4gYXJyYXkgb2YgMl5uIHN0cnVjdCBsaXN0X2hl
YWQgaW4gc3RydWN0IGFtZGdwdV9kZXZpY2UgZm9yIHRoZSBoYXNoCj4gYnVja2V0cy4gVGhlIEJP
J3MgaGFuZGxlIGlzIGhhc2hlZCB0byB0aGUgYnVja2V0IG51bWJlcgo+Cj4gICBoYW5kbGUgJiAo
Ml5uIC0gMSkKPgo+IGFuZCBsaW5rZWQgaW4gdGhlcmUgdmlhIHN0cnVjdCBsaXN0X2hlYWQgaW4g
c3RydWN0IGFtZGdwdV9iby4KPiBhbWRncHVfYm9fYWxsb2MgYW5kIGFtZGdwdV9jcmVhdGVfYm9f
ZnJvbV91c2VyX21lbSBhZGQgdGhlIGhhbmRsZSBhdCB0aGUKPiBlbmQgb2YgdGhlIGxpc3QsIGFt
ZGdwdV9ib19pbXBvcnQgYWRkcyBpdCBhdCBvciBtb3ZlcyBpdCB0byB0aGUgYmVnaW5uaW5nLgoK
WWVhaCwgdGhhdCB3b3VsZCBjZXJ0YWlubHkgcmVkdWNlIHRoZSBwcm9ibGVtIHF1aXRlIGEgYml0
IGFuZCB3b3VsZCAKYWxsb3cgdXMgdG8gZ2V0IHJpZCBvZiB0aGUgdXRpbF9oYXNoKiBpbXBsZW1l
bnRhdGlvbiB3aGljaCB0byBtZSBhbHdheXMgCnNlZW1lZCB0byBiZSBhIGJpdCBvdmVya2lsbC4K
CkkgYWN0dWFsbHkgZG9uJ3Qgc2VlIGEgcmVhc29uIHdoeSBhbWRncHVfY3JlYXRlX2JvX2Zyb21f
dXNlcl9tZW0oKSAKc2hvdWxkIGFkZCB0aGUgaGFuZGxlIGF0IGFsbCwgdGhvc2UgQk9zIGFyZSBu
b3QgZXhwb3J0YWJsZS4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
