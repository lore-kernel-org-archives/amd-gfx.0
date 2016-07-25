From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/13] drm/amd: wait neccessary dependency before running job
Date: Mon, 25 Jul 2016 15:22:32 +0800
Message-ID: <1469431353-15787-13-git-send-email-David1.Zhou@amd.com>
References: <1469431353-15787-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469431353-15787-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYmNjMzU1OGMyMzMwY2FhZDFhMmVkYjk5MDJiM2YyMWJkOTUwZDE5ZgpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDUgKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmMKaW5kZXggNTMzZGExMy4uYzM1MjVi
NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxl
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwpA
QCAtNDM0LDkgKzQzNCwxMiBAQCB2b2lkIGFtZF9zY2hlZF9qb2JfcmVjb3Zlcnkoc3RydWN0IGFt
ZF9ncHVfc2NoZWR1bGVyICpzY2hlZCkKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoc19qb2IsICZz
Y2hlZC0+cmluZ19taXJyb3JfbGlzdCwgbm9kZSkgewogCQlzdHJ1Y3QgYW1kX3NjaGVkX2ZlbmNl
ICpzX2ZlbmNlID0gc19qb2ItPnNfZmVuY2U7Ci0JCXN0cnVjdCBmZW5jZSAqZmVuY2U7CisJCXN0
cnVjdCBmZW5jZSAqZmVuY2UsICpkZXBlbmRlbmN5OwogCiAJCXNwaW5fdW5sb2NrKCZzY2hlZC0+
am9iX2xpc3RfbG9jayk7CisJCXdoaWxlICgoZGVwZW5kZW5jeSA9IHNjaGVkLT5vcHMtPmRlcGVu
ZGVuY3koc19qb2IpKSkKKwkJICAgICAgIGZlbmNlX3dhaXQoZGVwZW5kZW5jeSwgZmFsc2UpOwor
CiAJCWZlbmNlID0gc2NoZWQtPm9wcy0+cnVuX2pvYihzX2pvYik7CiAJCWF0b21pY19pbmMoJnNj
aGVkLT5od19ycV9jb3VudCk7CiAJCWlmIChmZW5jZSkgewotLSAKMS45LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
