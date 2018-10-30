From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Tue, 30 Oct 2018 09:20:57 +0100
Message-ID: <e8cf4264-f211-70b3-01ec-34d0eb5e7edb@daenzer.net>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
 <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0xMC0yOSAxMDoxNSBwLm0uLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+IFlvdSBhbmQg
SSBkaXNjdXNzZWQgdGhpcyBleHRlbnNpdmVseSBpbnRlcm5hbGx5IGEgd2hpbGUgYWdvLiBJdCdz
IGV4cGVjdGVkCj4gYW5kIGNvcnJlY3QgYmVoYXZpb3IuIE1lc2EgZG9lc24ndCB1bm1hcCBzb21l
IGJ1ZmZlcnMgYW5kIG5ldmVyIHdpbGwuCgpJdCBkb2Vzbid0IG5lZWQgdG8ga2VlcCBtYXBwaW5n
IHRoZSBzYW1lIGJ1ZmZlciBvdmVyIGFuZCBvdmVyIGFnYWluCnRob3VnaCwgZG9lcyBpdD8KCgot
LSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
IGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAg
IHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
