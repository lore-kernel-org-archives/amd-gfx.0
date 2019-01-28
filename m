From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display - Don't leak memory when updating streams
Date: Mon, 28 Jan 2019 16:14:29 +0100
Message-ID: <1261da29-e8da-2525-9cfa-08a93529951d@daenzer.net>
References: <20190128140052.17217-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190128140052.17217-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOS0wMS0yOCAzOjAwIHAubS4sIE5pY2hvbGFzIEthemxhdXNrYXMgd3JvdGU6Cj4gW1do
eV0KPiBUaGUgZmxpcCBhbmQgZnVsbCBzdHJ1Y3R1cmVzIHdlcmUgYWxsb2NhdGVkIGJ1dCBuZXZl
ciBmcmVlZC4KPiAKPiBbSG93XQo+IEZyZWUgdGhlbSBhdCB0aGUgZW5kIG9mIHRoZSBmdW5jdGlv
bi4gVGhlcmUncyBhIHNtYWxsIGJlaGF2aW9yYWwKPiBjaGFuZ2UgaGVyZSB3aXRoIHRoZSBmdW5j
dGlvbiByZXR1cm5pbmcgZWFybHkgaWYgdGhlIGFsbG9jYXRpb24gZmFpbHMKPiBidXQgd2Ugd291
bGRuJ3Qgc2hvdWxkIGJlIGRvaW5nIGFueXRoaW5nIGluIHRoYXQgY2FzZSBhbnl3YXkuCj4gCj4g
Rml4ZXM6IGMwMGUwY2MwZmRjMCAoImRybS9hbWQvZGlzcGxheTogQ2FsbCBpbnRvIERDIG9uY2Ug
cGVyIG11bHRpcGxhbmUgZmxpcCIpCj4gRml4ZXM6IGVhMzk1OTRlMDg1NSAoImRybS9hbWQvZGlz
cGxheTogUGVyZm9ybSBwbGFuZSB1cGRhdGVzIG9ubHkgd2hlbiBuZWVkZWQiKQo+IAo+IENjOiBN
aWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0Pgo+IENjOiBMZW8gTGkgPHN1bnBlbmcu
bGlAYW1kLmNvbT4KPiBDYzogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2th
c0BhbWQuY29tPgoKVGVzdGVkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1k
LmNvbT4KClRoYW5rcyBOaWNob2xhcyEKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
