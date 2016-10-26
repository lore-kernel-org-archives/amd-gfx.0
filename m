From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amdgpu: disable dpm before turn off clock when vce
 idle.
Date: Wed, 26 Oct 2016 18:21:11 +0800
Message-ID: <1477477272-5840-5-git-send-email-Rex.Zhu@amd.com>
References: <1477477272-5840-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477477272-5840-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJMzQzNTRjM2FlYzVkNDNhYTI1OWU1NzJmY2E5NGY2NmNiOTkzNTE3MApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvY2lfZHBtLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKaW5kZXgg
NTRhNzAxOS4uNWI0MTE5OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Y2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKQEAgLTQy
NTgsMTMgKzQyNTgsMTIgQEAgc3RhdGljIGludCBjaV91cGRhdGVfdmNlX2RwbShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAogCQkJcmV0ID0gY2lfZW5hYmxlX3ZjZV9kcG0oYWRldiwgdHJ1
ZSk7CiAJCX0gZWxzZSB7CisJCQlyZXQgPSBjaV9lbmFibGVfdmNlX2RwbShhZGV2LCBmYWxzZSk7
CiAJCQkvKiB0dXJuIHRoZSBjbG9ja3Mgb2ZmIHdoZW4gbm90IGVuY29kaW5nICovCiAJCQlyZXQg
PSBhbWRncHVfc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1ZD
RSwKIAkJCQkJCQkgICAgQU1EX0NHX1NUQVRFX0dBVEUpOwogCQkJaWYgKHJldCkKIAkJCQlyZXR1
cm4gcmV0OwotCi0JCQlyZXQgPSBjaV9lbmFibGVfdmNlX2RwbShhZGV2LCBmYWxzZSk7CiAJCX0K
IAl9CiAJcmV0dXJuIHJldDsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
