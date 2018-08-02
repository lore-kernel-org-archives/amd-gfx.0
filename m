From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return bo itself if userptr is cpu addr
 of bo (v3)
Date: Thu, 2 Aug 2018 08:29:25 +0200
Message-ID: <34a2aa0b-11ca-2eea-f980-951b6a079675@amd.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
 <3d423f44-e47a-e70c-dfd9-80c1ff843e45@gmail.com> <5B6008A1.5050401@amd.com>
 <c6b11c1f-b32a-4ab8-6a78-aa7886eed60a@gmail.com> <5B601844.3010405@amd.com>
 <5e8f2a76-6cbd-1f80-ec94-fcd79c0fa55c@gmail.com> <5B60249D.7030503@amd.com>
 <9dc68d5d-561c-242a-b3ba-1c8078ab670f@gmail.com> <5B6031CA.4050102@amd.com>
 <3ffb8b8c-fae3-92d9-80e1-bd7d0498b4c7@gmail.com>
 <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ@mail.gmail.com>
 <53eb686a-0747-394a-b0c3-4cd53ab836e2@amd.com>
 <CAAxE2A6C0mmr2vogcAQL+XNQuPU=BqHUGjqAMVnS3pK37XJa0A@mail.gmail.com>
 <edbcf817-75ea-6e6a-d64a-6274a78308e7@amd.com>
 <CAAxE2A4=k5_20jaPcM9awxQ69MhXY2wtEX9NFxZU9=43_SsRug@mail.gmail.com>
 <ba1798f5-9aa9-6d55-791a-b2fd52087ea7@amd.com>
 <CAAxE2A4bma0u8R+ggETPoUycC=MTkrs0oUGJFW8kGx__Sf35eQ@mail.gmail.com>
 <5B62A2A0.5060508@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B62A2A0.5060508-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDIuMDguMjAxOCB1bSAwODoyMCBzY2hyaWViIFpoYW5nLCBKZXJyeSAoSnVud2VpKToKPiBP
biAwOC8wMi8yMDE4IDA4OjAwIEFNLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+PiBPbiBXZWQsIEF1
ZyAxLCAyMDE4IGF0IDI6MjkgUE0sIENocmlzdGlhbiBLw7ZuaWcKPj4gPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4+PiBBbSAwMS4wOC4yMDE4IHVtIDE5OjU5IHNjaHJpZWIgTWFy
ZWsgT2zFocOhazoKPj4+PiBbU05JUF0KPj4+Cj4+PiBDb21wYXJlZCB0byB3aGF0IHRoZSBrZXJu
ZWwgbmVlZHMgdG8gZG8gZm9yIHVwZGF0aW5nIHRoZSBwYWdlIHRhYmxlcyAKPj4+IGl0IGlzCj4+
PiBsZXNzIHRoYW4gMSUgb2YgdGhlIHRvdGFsIHdvcmsuCj4+Pgo+Pj4gVGhlIHJlYWwgcXVlc3Rp
b24gaXMgaWYgaXQgd291bGRuJ3QgYmUgc2ltcGxlciB0byB1c2UgYSB0cmVlIGZvciB0aGUKPj4+
IGhhbmRsZXMuIFNpbmNlIHRoZSBoYW5kbGVzIGFyZSBkZW5zZSB5b3UgY2FuIGp1c3QgdXNlIGFu
IHVuYmFsYW5jZWQgCj4+PiB0cmVlCj4+PiB3aGljaCBpcyByZWFsbHkgZWFzeS4KPj4+Cj4+PiBG
b3IgYSB0cmVlIG9mIHRoZSBDUFUgbWFwcGluZ3Mgd2Ugd291bGQgbmVlZCBhbiByL2IgaW50ZXJ2
YWwgdHJlZSwgCj4+PiB3aGljaCBpcwo+Pj4gaGFyZCB0byBpbXBsZW1lbnQgYW5kIHF1aXRlIHNv
bWUgb3ZlcmtpbGwuCj4+Pgo+Pj4gRG8geW91IGhhdmUgYW55IG51bWJlcnMgaG93IG1hbnkgQk9z
IHJlYWxseSBnZXQgYSBDUFUgbWFwcGluZyBpbiBhIHJlYWwKPj4+IHdvcmxkIGFwcGxpY2F0aW9u
Pwo+Pgo+PiBXaXRob3V0IG91ciBzdWJhbGxvY2F0b3IsIHdlIHNvbWV0aW1lcyBleGNlZWRlZCB0
aGUgbWF4LiBtbWFwIGxpbWl0Cj4+ICh+NjRLKS4gSXQgc2hvdWxkIGJlIG11Y2ggbGVzcyB3aXRo
IHRoZSBzdWJhbGxvY2F0b3Igd2l0aCAxMjhLQiBzbGFicywKPj4gcHJvYmFibHkgYSBmZXcgdGhv
dXNhbmRzLgo+Cj4gSXMgdGhlcmUgYSB3YXkgdG8gdmVyaWZ5IHRoYXQgaXQgaGFzIHBlcmZvcm1h
bmNlIGlzc3VlIGlmIG1vdmluZyB0aGUgCj4gY3B1IG1hcHBpbmcgaW4gbGliZHJtIGhhc2ggdGFi
bGUKPiBmcm9tIGtlcm5lbCBzaWRlPwoKR29pbmcgdG8gdGFrZSBhIGxvb2sgYXQgdGhpcywgYnV0
IEkgaGF2ZSB0aGUgZmVlbGluZyB0aGF0IHRoZSBDUFUgCm92ZXJoZWFkIHdlIG5lZWQgdG8gYWRk
IGluIHVzZXJzcGFjZSBpc24ndCB0aGF0IG11Y2guCgo+Cj4gQUZBSVcsIG9ubHkgb25lIGdhbWUg
d2lsbCB1c2UgdGhhdCB3aXRoIGNsb3NlIE9HTC4KCldlbGwsIEkgd291bGQgYWxzbyBzYXkgdGhh
dCB0aGlzIGlzIGEgYnVnIGluIHRoZSBnYW1lIGFuZCBzaG91bGQgYmUgCmZpeGVkIHRoZXJlLgoK
Q2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gSmVycnkKPgo+Pgo+PiBNYXJlawo+PgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
