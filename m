From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 09:59:14 +0200
Message-ID: <45bab640-d574-b822-e5c8-69fe67626a9a@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0f28de35-1928-2af3-8b8d-13c61b25e285-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMTcuMDcuMjAxOCB1bSAwOTo0NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMTcgMDk6MzMgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE3LjA3LjIwMTgg
dW0gMDk6MjYgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDctMTcgMDg6NTAg
QU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTYuMDcuMjAxOCB1bSAxODowNSBz
Y2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4+PiBPbiAyMDE4LTA3LTEzIDA4OjQ3IFBNLCBNYXJl
ayBPbMWhw6FrIHdyb3RlOgo+Pj4+PiBbU05JUF0KPj4+Pj4gT3RoZXIgb3BpbmlvbnM/Cj4+Pj4g
SSB1bmRlcnN0YW5kIHRoZSByZWFzb24gd2h5IE1hcmVrIHdhbnRzIHRvIGRvIHRoaXMsIGJ1dCBJ
IGFncmVlIHRoYXQKPj4+PiB0aGlzIGlzIGEgbGl0dGxlIGJpdCBkYW5nZXJvdXMgaWYgdXNlZCBp
bmNvcnJlY3RseS4KPj4+Pgo+Pj4+IE9uIHRoZSBvdGhlciBoYW5kIEkgZG9uJ3Qgc2VlIGFueSBv
dGhlciB3YXkgdG8gc2FuZWx5IGhhbmRsZSBpdCBlaXRoZXIuCj4+PiBTYW5lbHkgaGFuZGxlIHdo
YXQgZXhhY3RseT8gOikgSSBzdGlsbCBoYXZlbid0IHNlZW4gYW55IGRlc2NyaXB0aW9uIG9mCj4+
PiBhbiBhY3R1YWwgcHJvYmxlbSwgb3RoZXIgdGhhbiAidGhlIGhhbmRsZSBpcyBzdG9yZWQgaW4g
dGhlIGhhc2ggdGFibGUiLgo+PiBXZWxsIHRoZSBwcm9ibGVtIGlzIHRoYXQgaXQncyBub3QgInRo
ZSBoYW5kbGUiIGJ1dCByYXRoZXIgImFsbCBoYW5kbGVzIgo+PiB3aGljaCBhcmUgbm93IHN0b3Jl
ZCBpbiB0aGUgaGFzaCB0YWJsZS4KPj4KPj4gVG8gYmVnaW4gd2l0aCB0aGF0IGlzIHF1aXRlIGEg
YnVuY2ggb2Ygd2FzdGVkIG1lbW9yeSwgbm90IHRhbGtpbmcgYWJvdXQKPj4gdGhlIGV4dHJhIENQ
VSBjeWNsZXMuCj4gQWxsIHRoYXQgc2hvdWxkIGJlIG5lZWRlZCBpcyBvbmUgc3RydWN0IGxpc3Rf
aGVhZCBwZXIgQk8sIDE2IGJ5dGVzIG9uCj4gNjQtYml0LgoKK21hbGxvYyBvdmVyaGVhZCBhbmQg
dGhhdCBmb3IgKmV2ZXJ5KiBCTyB0aGUgYXBwbGljYXRpb24vZHJpdmVyIAphbGxvY2F0ZWQuIFRo
ZSBsYXN0IHRpbWUgSSBsb29rZWQgd2UgY291bGQgZWFzaWx5IGhhdmUgYSBmZXcgdGhvdXNhbmRz
IApvZiB0aGF0IChidXQgbm90IGluIHRoZSBzYW1lIENTKS4KClNvIEkgd291bGQgZ3Vlc3MgdGhh
dCB0aGUgd2FzdGVkIG1lbW9yeSBjYW4gZWFzaWx5IGJlIGluIHRoZSBsb3dlciBrYiAKcmFuZ2Us
IGNvbXBhcmVkIHRvIGFkZGluZyBqdXN0IGEgZmxhZyB0aGF0IHdlIG5ldmVyIGdvaW5nIHRvIGlt
cG9ydCB0aGUgCmhhbmRsZSBhZ2Fpbi4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
