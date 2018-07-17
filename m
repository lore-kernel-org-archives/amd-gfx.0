From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add amdgpu_bo_handle_type_kms_noimport
Date: Tue, 17 Jul 2018 09:33:36 +0200
Message-ID: <3cc456c1-929d-4aee-2e8b-7d4edb023382@amd.com>
References: <20180712004750.2024-1-maraeo@gmail.com>
 <9a8d8f7f-a468-fd5b-dec5-472ce9c88483@daenzer.net>
 <CAAxE2A6Vz08sWXiaB6B-F4_P7Fy6uDuJ7aF2gHLXZ4N3zj9sXw@mail.gmail.com>
 <a291b3b5-25bc-385a-5242-9bd75ec423e9@daenzer.net>
 <CAAxE2A7ffmO=Tv_DSWhPciF+y5q_wbaBYgcqHvxQVkeVfhBhdg@mail.gmail.com>
 <31980a46-1d16-8ead-cc2b-5a5b9eb4d530@daenzer.net>
 <5374dffa-45c9-1bd6-79b9-cc4450a96aeb@gmail.com>
 <126a68a9-43f4-c747-89d1-114dc29ea4e9@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <126a68a9-43f4-c747-89d1-114dc29ea4e9-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMTcuMDcuMjAxOCB1bSAwOToyNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMTcgMDg6NTAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE2LjA3LjIwMTgg
dW0gMTg6MDUgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDctMTMgMDg6NDcg
UE0sIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4+PiBbU05JUF0KPj4+IE90aGVyIG9waW5pb25zPwo+
PiBJIHVuZGVyc3RhbmQgdGhlIHJlYXNvbiB3aHkgTWFyZWsgd2FudHMgdG8gZG8gdGhpcywgYnV0
IEkgYWdyZWUgdGhhdAo+PiB0aGlzIGlzIGEgbGl0dGxlIGJpdCBkYW5nZXJvdXMgaWYgdXNlZCBp
bmNvcnJlY3RseS4KPj4KPj4gT24gdGhlIG90aGVyIGhhbmQgSSBkb24ndCBzZWUgYW55IG90aGVy
IHdheSB0byBzYW5lbHkgaGFuZGxlIGl0IGVpdGhlci4KPiBTYW5lbHkgaGFuZGxlIHdoYXQgZXhh
Y3RseT8gOikgSSBzdGlsbCBoYXZlbid0IHNlZW4gYW55IGRlc2NyaXB0aW9uIG9mCj4gYW4gYWN0
dWFsIHByb2JsZW0sIG90aGVyIHRoYW4gInRoZSBoYW5kbGUgaXMgc3RvcmVkIGluIHRoZSBoYXNo
IHRhYmxlIi4KCldlbGwgdGhlIHByb2JsZW0gaXMgdGhhdCBpdCdzIG5vdCAidGhlIGhhbmRsZSIg
YnV0IHJhdGhlciAiYWxsIGhhbmRsZXMiIAp3aGljaCBhcmUgbm93IHN0b3JlZCBpbiB0aGUgaGFz
aCB0YWJsZS4KClRvIGJlZ2luIHdpdGggdGhhdCBpcyBxdWl0ZSBhIGJ1bmNoIG9mIHdhc3RlZCBt
ZW1vcnksIG5vdCB0YWxraW5nIGFib3V0IAp0aGUgZXh0cmEgQ1BVIGN5Y2xlcy4KCj4+IE1NIGlu
dGVyb3Agd2l0aCBHRlggdXN1YWxseSBpbXBvcnRzIEJPcyBvbiBlYWNoIGZyYW1lLCBzbyB0aGF0
IGNhbiBodXJ0Cj4+IGhlcmUuCj4gVGhhdCdzIGFsd2F5cyB0aGUgc2FtZSBzZXQgb2YgQk9zIGlu
IHRoZSBzdGVhZHkgc3RhdGUsIHJpZ2h0PyBTbyBpdCdzCj4gZWFzeSB0byBtYWtlIHRoZSByZXBl
YXRlZCBsb29rdXBzIGZhc3QsIGJ5IG1vdmluZyB0aGVtIHRvIHRoZSBzdGFydCBvZgo+IHRoZWly
IGhhc2ggYnVja2V0cy4KClllYWgsIHRoYXQgY2FuIGhlbHAgd2l0aCB0aGUgQ1BVIGN5Y2xlcyBi
dXQgaXQgaXMgc3RpbGwgbm90IGlkZWFsLgoKSSB0aGluayB0aGF0IE1hcmVrcyBjaGFuZ2UgaXMg
anVzdGlmaWVkLCBidXQgd2Ugc2hvdWxkIGFkZCBhIGNvbW1lbnQgCmV4cGxhaW5pbmcgdGhlIHJl
c3RyaWN0aW9ucy4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
