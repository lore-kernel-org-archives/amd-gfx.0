From: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove redundant memset
Date: Wed, 29 Aug 2018 11:01:20 -0400
Message-ID: <1535554880-1503-1-git-send-email-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZjk0YTU5ZDNjYmYyNjkwZGQyYTFlMmFkZDcxYmMzOTNkZjZhOTY4NgpTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDE1
M2M5YmUuLjMzZDljZTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBA
IC01NDAsNyArNTQwLDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfbGV2ZWxzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkJICAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8p
OwogCQlpZiAoIXBhcmVudC0+ZW50cmllcykKIAkJCXJldHVybiAtRU5PTUVNOwotCQltZW1zZXQo
cGFyZW50LT5lbnRyaWVzLCAwICwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdm1fcHQpKTsKIAl9CiAK
IAlmcm9tID0gc2FkZHIgPj4gc2hpZnQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
