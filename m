From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: disable GPU reset if amdgpu.lockup_timeout=0
Date: Tue, 12 Dec 2017 15:57:11 +0100
Message-ID: <CAAxE2A72rODGx5SgsHutRQVag+_1o-s8oykXwbmJUZugh0-S4A@mail.gmail.com>
References: <1513027772-32408-1-git-send-email-maraeo@gmail.com>
 <95bd3554-f9e3-6ad7-32e5-9921da23feaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <95bd3554-f9e3-6ad7-32e5-9921da23feaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBEZWMgMTIsIDIwMTcgYXQgMTA6MDEgQU0sIENocmlzdGlhbiBLw7ZuaWcKPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiBBbSAxMS4xMi4yMDE3IHVtIDIy
OjI5IHNjaHJpZWIgTWFyZWsgT2zFocOhazoKPj4KPj4gRnJvbTogTWFyZWsgT2zFocOhayA8bWFy
ZWsub2xzYWtAYW1kLmNvbT4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgT2zFocOhayA8bWFy
ZWsub2xzYWtAYW1kLmNvbT4KPj4gLS0tCj4+Cj4+IElzIHRoaXMgcmVhbGx5IGNvcnJlY3Q/IEkg
aGF2ZSBubyBlYXN5IHdheSB0byB0ZXN0IGl0Lgo+Cj4KPiBJdCdzIGEgc3RlcCBpbiB0aGUgcmln
aHQgZGlyZWN0aW9uLCBidXQgSSB3b3VsZCByYXRoZXIgdm90ZSBmb3Igc29tZXRoaW5nCj4gZWxz
ZToKPgo+IEluc3RlYWQgb2YgZGlzYWJsaW5nIHRoZSB0aW1lb3V0IGJ5IGRlZmF1bHQgd2Ugb25s
eSBkaXNhYmxlIHRoZSBHUFUKPiByZXNldC9yZWNvdmVyeS4KPgo+IFRoZSBpZGVhIGlzIHRvIGFk
ZCBhIG5ldyBwYXJhbWV0ZXIgYW1kZ3B1X2dwdV9yZWNvdmVyeSB3aGljaCBtYWtlcwo+IGFtZGdw
dV9ncHVfcmVjb3ZlciBvbmx5IHByaW50cyBvdXQgYW4gZXJyb3IgYW5kIGRvZXNuJ3QgdG91Y2gg
dGhlIEdQVSBhdCBhbGwKPiAob24gYmFyZSBtZXRhbCBzeXN0ZW1zKS4KPgo+IFRoZW4gd2UgZmlu
YWxseSBzZXQgdGhlIGFtZGdwdV9sb2NrdXBfdGltZW91dCB0byBhIG5vbiB6ZXJvIHZhbHVlIGJ5
Cj4gZGVmYXVsdC4KPgo+IEFuZHJleSBjb3VsZCB5b3UgdGFrZSBjYXJlIG9mIHRoaXMgd2hlbiB5
b3UgaGF2ZSB0aW1lPwoKSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMuCgpXaHkgY2FuJ3Qgd2Uga2Vl
cCB0aGUgcHJldmlvdXMgYmVoYXZpb3Igd2hlcmUgYW1kZ3B1LmxvY2t1cF90aW1lb3V0PTAKZGlz
YWJsZWQgR1BVIHJlc2V0PyBXaHkgZG8gd2UgaGF2ZSB0byBhZGQgYW5vdGhlciBvcHRpb24gZm9y
IHRoZSBzYW1lCnRoaW5nPwoKTWFyZWsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
