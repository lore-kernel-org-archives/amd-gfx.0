From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/10] drm/amdgpu: use the smaller hole for GART
Date: Mon, 27 Aug 2018 18:53:31 +0200
Message-ID: <20180827165337.1651-4-christian.koenig@amd.com>
References: <20180827165337.1651-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180827165337.1651-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

SW5zdGVhZCBvZiB0aGUgbGFyZ2VyIG9uZSB1c2UgdGhlIHNtYWxsZXIgaG9sZSBpbiB0aGUgTUMg
YWRkcmVzcwpzcGFjZSBmb3IgdGhlIEdBUlQgbWFwcGluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ21jLmMKaW5kZXggODI2OTE5N2RmOGUwLi4yNjVlYzY4MDcxMzAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKQEAgLTEzMiw3ICsxMzIsOCBAQCB2b2lkIGFtZGdw
dV9nbWNfZ2FydF9sb2NhdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFt
ZGdwdV9nbWMgKm1jKQogCQltYy0+Z2FydF9zaXplID0gbWF4KHNpemVfYmYsIHNpemVfYWYpOwog
CX0KIAotCWlmIChzaXplX2JmID4gc2l6ZV9hZikKKwlpZiAoKHNpemVfYmYgPj0gbWMtPmdhcnRf
c2l6ZSAmJiBzaXplX2JmIDwgc2l6ZV9hZikgfHwKKwkgICAgKHNpemVfYWYgPCBtYy0+Z2FydF9z
aXplKSkKIAkJbWMtPmdhcnRfc3RhcnQgPSAwOwogCWVsc2UKIAkJbWMtPmdhcnRfc3RhcnQgPSBB
TElHTihtYy0+dnJhbV9lbmQgKyAxLCAweDEwMDAwMDAwMFVMTCk7Ci0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
