From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: fix "add AMDGPU_VA_RANGE_HIGH"
Date: Wed, 28 Feb 2018 16:21:41 +0100
Message-ID: <2450a93d-fbf0-0a6c-e0b8-2432a401d531@daenzer.net>
References: <20180228144111.1651-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180228144111.1651-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMi0yOCAwMzo0MSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBUaGUgMzJi
aXQgYWRkcmVzcyByYW5nZSBlbmQgaXMgZXhjbHVzaXZlLCBub3QgaW5jbHVzaXZlLgoKVGhlIG90
aGVyIHdheSBhcm91bmQuIDopIEluY2x1c2l2ZSBtZWFucyBbYSxiXSwgaS5lLiBhbiBpbnRlcnZh
bAppbmNsdWRpbmcgdGhlIGVuZHBvaW50cywgd2hlcmVhcyBleGNsdXNpdmUgbWVhbnMgXWEsYlss
IGkuZS4gYW4gaW50ZXJ2YWwKbm90IGluY2x1ZGluZyB0aGUgZW5kcG9pbnRzLiBUaGUgcGF0Y2gg
Y2hhbmdlcyB0aGUgMzItYml0IGFkZHJlc3MgcmFuZ2UKZW5kcG9pbnQgZnJvbSBleGNsdXNpdmUg
dG8gaW5jbHVzaXZlLgoKCj4gVGhpcyBmaXhlcyBjcmFzaGVzIHdoZW4gMzJiaXQgYWRkcmVzc2Vz
IGFyZSBpbiB1c2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2l0aCB0aGUgYWJvdmUgZml4ZWQsCgpSZXZpZXdlZC1hbmQt
VGVzdGVkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0
dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
