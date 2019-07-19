From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] tests/amdgpu: fix for dispatch/draw test
Date: Fri, 19 Jul 2019 09:40:35 +0200
Message-ID: <39c1c37e-89d8-bb00-2cc6-aa048aed77c8@daenzer.net>
References: <1563437433-4157-1-git-send-email-flora.cui@amd.com>
 <1c9de651-bbb2-6802-e729-182cab5ca427@gmail.com>
 <febeaec7-db65-e18d-d073-d7e19f972edb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <febeaec7-db65-e18d-d073-d7e19f972edb-5C7GfCeVMHo@public.gmane.org>
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
To: "Cui, Flora" <fcui-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNy0xOSA4OjAwIGEubS4sIEN1aSwgRmxvcmEgd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IFRoZXNlIDIgY29tbWl0cyBpcyBwdXNoZWQgdG8gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0
b3Aub3JnL2ZjdWkvZHJtLiAKPiBDb3VsZCB5b3UgaGVscCB0byBtZXJnZSB0byBtZXNhL2RybT8K
ClBsZWFzZSByZW1vdmUgdGhlIENoYW5nZS1JZCB0YWdzLgoKClAuUy4gV2hlbiBhIGNvbW1pdCBs
b2cgbGlzdHMgbXVsdGlwbGUgc2VwYXJhdGUgY2hhbmdlcywgaXQncyBhIGdvb2QKaW5kaWNhdGlv
biB0aGF0IHRoZSBjaGFuZ2Ugc2hvdWxkIGJlIHNwbGl0IHVwLgoKUC5QLlMuIFdlJ2xsIG5lZWQg
dG8gZmlndXJlIG91dCBhIGJldHRlciB3YXkgdG8gaGFuZGxlIG1lcmdpbmcgbGliZHJtCmNoYW5n
ZXMuIE15IHBlcnNvbmFsIHByZWZlcmVuY2Ugd291bGQgYmUgdG8gZW5hYmxlIEdpdExhYiBtZXJn
ZSByZXF1ZXN0cwpmb3IgaXQuCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
