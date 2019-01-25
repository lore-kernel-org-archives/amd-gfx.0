From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 041/138] drm/amd/powerplay: add data structure of bootup values
Date: Fri, 25 Jan 2019 18:24:08 +0800
Message-ID: <1548411945-12396-42-git-send-email-ray.huang@amd.com>
References: <1548411945-12396-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548411945-12396-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBhZGRzIGRhdGEgc3RydWN0dXJlcyBmb3IgYm9vdHVwIHZhbHVlcy4KClNpZ25l
ZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBLZXZp
biBXYW5nIDxLZXZpbjEuV2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9hbWRncHVfc211LmggfCAxNiArKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2luYy9hbWRncHVfc211LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9pbmMvYW1kZ3B1X3NtdS5oCmluZGV4IGExMmFmNzguLjZkMGRiNjEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaApAQCAtMzgsMTMgKzM4LDI5
IEBAIHN0cnVjdCBzbXVfdGFibGUgewogCXVpbnQ2NF90IG1jX2FkZHJlc3M7CiAJdm9pZCAqY3B1
X2FkZHI7CiAJc3RydWN0IGFtZGdwdV9ibyAqYm87Cit9OwogCitzdHJ1Y3Qgc211X2Jpb3NfYm9v
dF91cF92YWx1ZXMKK3sKKwl1aW50MzJfdAkJCXJldmlzaW9uOworCXVpbnQzMl90CQkJZ2Z4Y2xr
OworCXVpbnQzMl90CQkJdWNsazsKKwl1aW50MzJfdAkJCXNvY2NsazsKKwl1aW50MzJfdAkJCWRj
ZWZjbGs7CisJdWludDE2X3QJCQl2ZGRjOworCXVpbnQxNl90CQkJdmRkY2k7CisJdWludDE2X3QJ
CQltdmRkYzsKKwl1aW50MTZfdAkJCXZkZF9nZng7CisJdWludDhfdAkJCQljb29saW5nX2lkOwor
CXVpbnQzMl90CQkJcHBfdGFibGVfaWQ7CiB9OwogCiBzdHJ1Y3Qgc211X3RhYmxlX2NvbnRleHQK
IHsKIAl2b2lkCQkJCSpwb3dlcl9wbGF5X3RhYmxlOwogCXVpbnQzMl90CQkJcG93ZXJfcGxheV90
YWJsZV9zaXplOworCisJc3RydWN0IHNtdV9iaW9zX2Jvb3RfdXBfdmFsdWVzCWJvb3RfdmFsdWVz
OwogCXN0cnVjdCBzbXVfdGFibGUJCSp0YWJsZXM7CiAJdWludDMyX3QJCQl0YWJsZV9jb3VudDsK
IH07Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
