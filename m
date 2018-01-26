From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/13] drm/amdgpu: drop root shadow sync
Date: Fri, 26 Jan 2018 21:13:15 +0100
Message-ID: <20180126201326.8829-2-christian.koenig@amd.com>
References: <20180126201326.8829-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126201326.8829-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

Q29tcGxldGVseSBwb2ludGxlc3MsIGl0IGlzIHRoZSBzYW1lIHJlc2VydmF0aW9uIG9iamVjdCBh
cyB0aGUgcm9vdCBQRAphbnl3YXkuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgfCA1IC0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGEzYjljMzk3NmViMy4uNWU1
M2I3YTJkNGQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtOTU2
LDExICs5NTYsNiBAQCBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9kaXJlY3RvcmllcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkJYW1kZ3B1X3JpbmdfcGFkX2liKHJpbmcsIHBhcmFtcy5pYik7
CiAJCWFtZGdwdV9zeW5jX3Jlc3YoYWRldiwgJmpvYi0+c3luYywgcm9vdC0+dGJvLnJlc3YsCiAJ
CQkJIEFNREdQVV9GRU5DRV9PV05FUl9WTSwgZmFsc2UpOwotCQlpZiAocm9vdC0+c2hhZG93KQot
CQkJYW1kZ3B1X3N5bmNfcmVzdihhZGV2LCAmam9iLT5zeW5jLAotCQkJCQkgcm9vdC0+c2hhZG93
LT50Ym8ucmVzdiwKLQkJCQkJIEFNREdQVV9GRU5DRV9PV05FUl9WTSwgZmFsc2UpOwotCiAJCVdB
Uk5fT04ocGFyYW1zLmliLT5sZW5ndGhfZHcgPiBuZHcpOwogCQlyID0gYW1kZ3B1X2pvYl9zdWJt
aXQoam9iLCByaW5nLCAmdm0tPmVudGl0eSwKIAkJCQkgICAgICBBTURHUFVfRkVOQ0VfT1dORVJf
Vk0sICZmZW5jZSk7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
