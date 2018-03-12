From: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: linux-4.16-rc5/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1723]:
 (warning) Possible null pointer dereference: pipe_ctx
Date: Mon, 12 Mar 2018 10:22:42 +0000
Message-ID: <HE1PR0802MB2331D43DAFA4EDDE964F0CC69CD30@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-GB
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
To: "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

CmhlbGxvIHRoZXJlLAoKU291cmNlIGNvZGUgaXMKCgrCoMKgwqAgZm9yIChpID0gMDsgaSA8IGRj
LT5yZXNfcG9vbC0+cGlwZV9jb3VudDsgaSsrKSB7CsKgwqDCoMKgwqDCoMKgIGlmIChyZXNfY3R4
LT5waXBlX2N0eFtpXS5zdHJlYW0pIHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaXBlX2N0eCA9
ICZyZXNfY3R4LT5waXBlX2N0eFtpXTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcGlwZV9pZHgg
PSBpOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwrCoMKgwqDCoMKgwqDCoCB9CsKgwqDC
oCB9CgrCoMKgwqAgLyogT25seSBzdXBwb3J0cyBlRFAgKi8KwqDCoMKgIGlmIChwaXBlX2N0eC0+
c3RyZWFtLT5zaW5rLT5saW5rLT5jb25uZWN0b3Jfc2lnbmFsICE9IFNJR05BTF9UWVBFX0VEUCkK
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwoKU3VnZ2VzdCBhZGQgc29tZSBjb2RlIHRvIGRl
YWwgd2l0aCB0aGUgY2FzZSB0aGF0IHRoZSBmb3IgbG9vcCBkb2Vzbid0IGZpbmQKd2hhdCBpdCBp
cyBsb29raW5nIGZvciBhbmQgc28gcGlwZV9jdHggaXMgTlVMTC4KClJlZ2FyZHMKCkRhdmlkIEJp
bmRlcm1hbgogICAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
