From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 4/4] drm/amdgpu: Disable gfx off if VCN is busy
Date: Mon, 30 Jul 2018 17:23:45 +0800
Message-ID: <1532942625-26876-4-git-send-email-Rex.Zhu@amd.com>
References: <1532942625-26876-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532942625-26876-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

dGhpcyBwYXRjaCBpcyBhIHdvcmthcm91bmQgZm9yIHRoZSBncHUgaGFuZwphdCB2aWRlbyBlbmQg
dGltZSBpZiBwbGF5IHZpZGVvIHdpdGggZ2Z4IG9mZiBlbmFibGVkLgoKU2lnbmVkLW9mZi1ieTog
UmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKaW5kZXggNzk4NjQ4YS4uODc4ZjYy
YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpAQCAtMjE0LDYgKzIx
NCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQogCWZlbmNlcyArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgm
YWRldi0+dmNuLnJpbmdfanBlZyk7CiAKIAlpZiAoZmVuY2VzID09IDApIHsKKwkJYW1kZ3B1X2dm
eF9vZmZfY3RybChhZGV2LCB0cnVlKTsKIAkJaWYgKGFkZXYtPnBtLmRwbV9lbmFibGVkKQogCQkJ
YW1kZ3B1X2RwbV9lbmFibGVfdXZkKGFkZXYsIGZhbHNlKTsKIAkJZWxzZQpAQCAtMjMwLDYgKzIz
MSw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpCiAJYm9vbCBzZXRfY2xvY2tzID0gIWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRl
di0+dmNuLmlkbGVfd29yayk7CiAKIAlpZiAoc2V0X2Nsb2NrcykgeworCQlhbWRncHVfZ2Z4X29m
Zl9jdHJsKGFkZXYsIGZhbHNlKTsKIAkJaWYgKGFkZXYtPnBtLmRwbV9lbmFibGVkKQogCQkJYW1k
Z3B1X2RwbV9lbmFibGVfdXZkKGFkZXYsIHRydWUpOwogCQllbHNlCi0tIAoxLjkuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
