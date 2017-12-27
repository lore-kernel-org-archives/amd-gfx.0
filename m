From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] exa: Accelerate ARGB2101010 pictures (v2)
Date: Wed, 27 Dec 2017 15:57:59 +0100
Message-ID: <5ded4c65-c907-8cb9-e441-db3d922de344@daenzer.net>
References: <20171223060737.12271-1-mario.kleiner.de@gmail.com>
 <20171223060737.12271-3-mario.kleiner.de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171223060737.12271-3-mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Fredrik_H=c3=b6glund?= <fredrik-RoXCvvDuEio@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMi0yMyAwNzowNyBBTSwgTWFyaW8gS2xlaW5lciB3cm90ZToKPiBGcm9tOiBGcmVk
cmlrIEjDtmdsdW5kIDxmcmVkcmlrQGtkZS5vcmc+Cj4gCj4gVGVzdGVkIGJ5IE1hcmlvIG9uIGEg
UmFkZW9uIEhEIDQwMDAgc2VyaWVzIGZvciB0aGUgcjYwMAo+IGV4YSBwYXRoLCBhbmQgb24gUmFk
ZW9uIEhEIDU3NzAgZm9yIHRoZSBldmVyZ3JlZW4gZXhhCj4gcGF0aC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBGcmVkcmlrIEjDtmdsdW5kIDxmcmVkcmlrQGtkZS5vcmc+Cj4gUmV2aWV3ZWQtYW5kLVRl
c3RlZC1ieTogTWFyaW8gS2xlaW5lciA8bWFyaW8ua2xlaW5lci5kZUBnbWFpbC5jb20+Cj4gCj4g
djI6IEFkZCBmb3JtYXQgaGFuZGxpbmcgaW4gWFhYU2V0U29saWRDb25zdHMoKSBhcyB3ZWxsLAo+
ICAgICBhcyBzdWdnZXN0ZWQgYnkgRnJlZHJpay4KCkFzIEZyZWRyaWsgbWVudGlvbmVkLCB0aGlz
IGlzbid0IG5lY2Vzc2FyeSwgYmVjYXVzZSBzb2xpZCBwaWN0dXJlcwpjdXJyZW50bHkgYWx3YXlz
IGhhdmUgZm9ybWF0IGE4cjhnOGI4IChzZWUgQ3JlYXRlU29saWRQaWN0dXJlID0+CmNyZWF0ZVNv
dXJjZVBpY3R1cmUgaW4geHNlcnZlci9yZW5kZXIvcGljdHVyZS5jKS4KCkknbGwganVzdCB0YWtl
IHYxIG9mIHRoaXMgcGF0Y2ggd2l0aCBGcmVkcmlrJ3MgU2lnbmVkLW9mZi1ieSAodGhhbmtzKS4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
