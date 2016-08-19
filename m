From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xserver 0/6] modesetting: add DRI2 page flip support
Date: Fri, 19 Aug 2016 11:09:26 +0900
Message-ID: <09c2176a-6a7e-b28d-d7e1-6a4bb76dab58@daenzer.net>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
 <CACvgo52vhzcyAS384uQdYy_XrA0LmKRdsRnLF0UB0OhV49A7uw@mail.gmail.com>
 <MWHPR12MB121593BB7CA6C60D65B21E6B8F160@MWHPR12MB1215.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB121593BB7CA6C60D65B21E6B8F160-Gy0DoCVfaSXDoeKT4XqzagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ML xorg-devel <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTkvMDgvMTYgMTE6MDIgQU0sIFl1LCBRaWFuZyB3cm90ZToKPiAKPiBFYWNoIHBvaW50IG9m
IHRoZSBwYXRjaCBzZXQgaXMgbm90IGJyb2tlbi4gUGF0Y2hlcyBhcmUgYXJyYW5nZWQgbGlrZQo+
IHRoaXMgdG8gc2hvdyBob3cgSSBkbyBpdDoKPiAxLiBjcmVhdGUgYSBwYWdlZmxpcC5jIHRvIGhv
c3QgY29tbW9uIHBhZ2UgZmxpcCBjb2RlCj4gMi4gY29weSBhbWRncHUgRERYIERSSTIgcGFnZSBm
bGlwIGNvZGUgdG8gbW9kZXNldHRpbmcgZHJpMi5jCj4gMy4gbWVyZ2UgY29tbW9uIERSSTIgYW5k
IHByZXNlbnQgcGFnZSBmbGlwIGNvZGUgdG8gcGFnZWZsaXAuYwo+IAo+IFBhdGNoIDQgaXMgbm90
IGEgZml4IGZvciBicm9rZW4gY29kZSwganVzdCBhIGNvbW1pdCBmcm9tIGFtZGdwdSBERFgKPiB0
byBwcmV2ZW50IHByZXNlbnQgYW5kIERSSTIgZnJvbSBmbGlwcGluZyBhdCB0aGUgc2FtZSB0aW1l
LgoKVGhpcyBkb2VzIG1lYW4gdGhvdWdoIHRoYXQgaWYgb25lIGhhcyBvbmx5IHVwIHRvIHBhdGNo
IDMgYXBwbGllZCAoZS5nLgpkdXJpbmcgYSBiaXNlY3Rpb24pLCBvbmUgaXMgZXhwb3NlZCB0byB0
aGUgaXNzdWVzIGZpeGVkIGJ5IHBhdGNoIDQuIFNvCm1heWJlIHBhdGNoIDQgc2hvdWxkIGJlIHNx
dWFzaGVkIGludG8gcGF0Y2ggMy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
