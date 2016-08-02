From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/10] drm/amdgpu: fix memory leak of sched fence
Date: Tue, 2 Aug 2016 16:00:40 +0800
Message-ID: <1470124840-26170-11-git-send-email-David1.Zhou@amd.com>
References: <1470124840-26170-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470124840-26170-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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

YW1kZ3B1X2pvYl9mcmVlX3Jlc291cmNlcyBpcyBhbHJlYWR5IGNhbGxlZCBieSBzdWJtaXRfam9i
LgpJZiBpdCBpcyBjYWxsZWQgaW4gcnVuX2pvYiwgdGhlIHNjaGVkIGZlbmNlIGNvdWxkIGJlIGdv
dCB0d2ljZSBpbiBzYSBibyBmcmVlLAp0aGVuIG1lbW9yeSBsZWFrIGhhcHBlbnMuCgpDaGFuZ2Ut
SWQ6IEk4MzM2MTJlMzFjZjIyYjYyMTc0ZjNmNzY1NDZmZDExYzllYTM4NzgwClNpZ25lZC1vZmYt
Ynk6IENodW5taW5nIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2pvYi5jCmluZGV4IDhkODdhOWEuLmQ1NjI0N2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfam9iLmMKQEAgLTE4Myw3ICsxODMsNyBAQCBzdGF0aWMgc3RydWN0IGZlbmNlICph
bWRncHVfam9iX3J1bihzdHJ1Y3QgYW1kX3NjaGVkX2pvYiAqc2NoZWRfam9iKQogCS8qIGlmIGdw
dSByZXNldCwgaHcgZmVuY2Ugd2lsbCBiZSByZXBsYWNlZCBoZXJlICovCiAJZmVuY2VfcHV0KGpv
Yi0+ZmVuY2UpOwogCWpvYi0+ZmVuY2UgPSBmZW5jZV9nZXQoZmVuY2UpOwotCWFtZGdwdV9qb2Jf
ZnJlZV9yZXNvdXJjZXMoam9iKTsKKwogCXJldHVybiBmZW5jZTsKIH0KIAotLSAKMS45LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
