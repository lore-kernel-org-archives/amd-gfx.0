From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/23] drm/amdgpu: add kiq into compiling
Date: Sun, 18 Dec 2016 00:16:24 +0800
Message-ID: <1481991405-30422-3-git-send-email-Xiangliang.Yu@amd.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481991405-30422-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

QWRkIHN1cHBvcnQgS0lRIGluIE1ha2VmaWxlIHRvIG1ha2UgaXQgaW50byBtb2R1bGUuCgpTaWdu
ZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2Vm
aWxlCmluZGV4IGRkMGI2ZGIuLjYzNWZmOTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2Vm
aWxlCkBAIC0zMCw3ICszMCw3IEBAIGFtZGdwdS15ICs9IGFtZGdwdV9kZXZpY2UubyBhbWRncHVf
a21zLm8gXAogCWF0b21iaW9zX2VuY29kZXJzLm8gYW1kZ3B1X3NhLm8gYXRvbWJpb3NfaTJjLm8g
XAogCWFtZGdwdV9wcmltZS5vIGFtZGdwdV92bS5vIGFtZGdwdV9pYi5vIGFtZGdwdV9wbGwubyBc
CiAJYW1kZ3B1X3Vjb2RlLm8gYW1kZ3B1X2JvX2xpc3QubyBhbWRncHVfY3R4Lm8gYW1kZ3B1X3N5
bmMubyBcCi0JYW1kZ3B1X2d0dF9tZ3IubyBhbWRncHVfdnJhbV9tZ3IubworCWFtZGdwdV9ndHRf
bWdyLm8gYW1kZ3B1X3ZyYW1fbWdyLm8gYW1kZ3B1X2tpcS5vCiAKICMgYWRkIGFzaWMgc3BlY2lm
aWMgYmxvY2sKIGFtZGdwdS0kKENPTkZJR19EUk1fQU1ER1BVX0NJSykrPSBjaWsubyBjaWtfaWgu
byBrdl9zbWMubyBrdl9kcG0ubyBcCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
