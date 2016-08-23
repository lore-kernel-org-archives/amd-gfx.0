From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Fix amdgpu_dri2_exchange_buffers
 width/height miss copy
Date: Tue, 23 Aug 2016 11:49:51 +0900
Message-ID: <e969a8e7-7497-fa3e-0f9d-44658e638f19@daenzer.net>
References: <1471864406-25978-1-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471864406-25978-1-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjIvMDgvMTYgMDg6MTMgUE0sIFFpYW5nIFl1IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IFFp
YW5nIFl1IDxRaWFuZy5ZdUBhbWQuY29tPgo+IC0tLQo+ICBzcmMvYW1kZ3B1X2RyaTIuYyB8IDIg
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL3NyYy9hbWRncHVfZHJpMi5jIGIvc3JjL2FtZGdwdV9kcmkyLmMKPiBpbmRl
eCAwM2UzYTBiLi5kZTcwMWMyIDEwMDY0NAo+IC0tLSBhL3NyYy9hbWRncHVfZHJpMi5jCj4gKysr
IGIvc3JjL2FtZGdwdV9kcmkyLmMKPiBAQCAtNjY1LDcgKzY2NSw3IEBAIGFtZGdwdV9kcmkyX2V4
Y2hhbmdlX2J1ZmZlcnMoRHJhd2FibGVQdHIgZHJhdywgRFJJMkJ1ZmZlclB0ciBmcm9udCwKPiAg
Cj4gIAlyZWdpb24uZXh0ZW50cy54MSA9IHJlZ2lvbi5leHRlbnRzLnkxID0gMDsKPiAgCXJlZ2lv
bi5leHRlbnRzLngyID0gZnJvbnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZS53aWR0aDsKPiAtCXJl
Z2lvbi5leHRlbnRzLnkyID0gZnJvbnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZS53aWR0aDsKPiAr
CXJlZ2lvbi5leHRlbnRzLnkyID0gZnJvbnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZS5oZWlnaHQ7
Cj4gIAlyZWdpb24uZGF0YSA9IE5VTEw7Cj4gIAlEYW1hZ2VSZWdpb25BcHBlbmQoJmZyb250X3By
aXYtPnBpeG1hcC0+ZHJhd2FibGUsICZyZWdpb24pOwo+ICAKPiAKClJldmlld2VkIGFuZCBwdXNo
ZWQsIHRoYW5rcyEKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
