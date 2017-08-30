From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 5/6] Make all active CRTCs scan out an
 all-black framebuffer in LeaveVT
Date: Wed, 30 Aug 2017 17:04:46 +0900
Message-ID: <8d6d0c04-7994-3b7a-6db6-cac8d8be3a4c@daenzer.net>
References: <20170828092343.27742-1-michel@daenzer.net>
 <20170828092343.27742-6-michel@daenzer.net>
 <CACvgo52+5yVkKdwDMSdGnbM2C-Z-wUt3NdewP8oystW6=LVn2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo52+5yVkKdwDMSdGnbM2C-Z-wUt3NdewP8oystW6=LVn2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjkvMDgvMTcgMDc6NTYgUE0sIEVtaWwgVmVsaWtvdiB3cm90ZToKPiBPbiAyOCBBdWd1c3Qg
MjAxNyBhdCAxMDoyMywgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6
Cj4+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pgo+PiBB
bmQgZGVzdHJveSBhbGwgb3RoZXIgRkJzLiBUaGlzIGlzIHNvIHRoYXQgb3RoZXIgRFJNIG1hc3Rl
cnMgY2FuIG9ubHkKPj4gZ2V0IGFjY2VzcyB0byB0aGlzIGFsbC1ibGFjayBGQiwgbm90IHRvIGFu
eSBvdGhlciBGQiB3ZSBjcmVhdGVkLCB3aGlsZQo+PiB3ZSdyZSBzd2l0Y2hlZCBhd2F5IGFuZCBu
b3QgRFJNIG1hc3Rlci4KPj4KPiBJc24ndCB0aGUgaXNzdWUgYXBwbGljYWJsZSBvdmVyYWxsIC0g
YmUgdGhhdCBpbiBYLCB3YXlsYW5kIGNvbXBvc2l0b3JzLCBvdGhlcj8KClBvdGVudGlhbGx5LgoK
Cj4gSUlSQyB0aGUgdm13Z2Z4J3Mga2VybmVsIGRyaXZlciwgd2hpY2ggaGFzIGV4dHJhIGxvY2tp
bmcgWzFdIGluIG9yZGVyCj4gdG8gYWRkcmVzcyB0aGF0Lgo+IFdvdWxkIGEgc2ltaWxhciBhcHBy
b2FjaCBsaWtlIHRoYXQgYmUgYXBwbGljYWJsZSBmb3IgcmFkZW9uL2FtZGdwdT8KCkkgZG9uJ3Qg
c2VlIGhvdyB0aGF0J3MgcmVsYXRlZC4KClRoZSBpc3N1ZSBpcyB0aGF0IGlmIHRoZSBjYWxsZXIg
b2YgRFJNX0lPQ1RMX01PREVfR0VURkIgaXMgRFJNIG1hc3Rlcgoob3Igcm9vdCwgb3IgdXNpbmcg
YSBEUk0gY29udHJvbCBkZXZpY2Ugbm9kZSksIHRoZSBpb2N0bCByZXR1cm5zIGEgdmFsaWQKR0VN
IGhhbmRsZSBmb3IgdGhlIGZyYW1lYnVmZmVyLCBzbyB0aGUgY2FsbGVyIGNhbiB1c2UgdGhlIHVu
ZGVybHlpbmcKYnVmZmVyIGFyYml0cmFyaWx5LiBUaGlzIGlzIGhhbmRsZWQgYnkgY29yZSBEUk0g
Y29kZSwgdGhlcmUncyBub3RoaW5nCmtlcm5lbCBkcml2ZXJzIGNhbiBkbyBhYm91dCBpdC4KCgot
LSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
IGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAg
IHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
