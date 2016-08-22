From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3 xserver 1/4] modesetting: make ms_do_pageflip generic
 for share with DRI2
Date: Mon, 22 Aug 2016 16:58:54 +0900
Message-ID: <3a23aea4-400b-3b3e-83c4-10652ead319f@daenzer.net>
References: <1471838038-16382-1-git-send-email-Qiang.Yu@amd.com>
 <1471838038-16382-2-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471838038-16382-2-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIvMDgvMTYgMTI6NTMgUE0sIFFpYW5nIFl1IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IFFp
YW5nIFl1IDxRaWFuZy5ZdUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnplciA8
bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KClsuLi5dCgo+IEBAIC01ODgsOCArNTk0LDExIEBAIG1z
X3ByZXNlbnRfZmxpcChSUkNydGNQdHIgY3J0YywKPiAgICAgIGlmICghZXZlbnQpCj4gICAgICAg
ICAgcmV0dXJuIEZBTFNFOwo+ICAKPiArICAgIERlYnVnUHJlc2VudCgoIlx0XHRtczpmcSAlbGxk
XG4iLCBldmVudF9pZCkpOwoKV291bGQgYmUgbmljZSB0byBpbmNsdWRlIHRoZSB0YXJnZXRfbXNj
IHZhbHVlIGhlcmUsIHNvIHRoZSBlZmZlY3RpdmUgTVNDCnZhbHVlIGluIG1zX3ByZXNlbnRfZmxp
cF9oYW5kbGVyIGNhbiBiZSBjb21wYXJlZCB0byBpdC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBE
w6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpM
aWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBh
bmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
