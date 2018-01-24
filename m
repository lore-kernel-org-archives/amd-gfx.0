From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: remove WARN_ON when VM isn't found
Date: Wed, 24 Jan 2018 13:39:38 +0100
Message-ID: <20180124123938.4792-2-christian.koenig@amd.com>
References: <20180124123938.4792-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180124123938.4792-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

SXQgY2FuIGVhc2lseSBiZSB0aGF0IHRoZSBWTSBpcyBhbHJlYWR5IGRlc3Ryb3llZCB3aGVuIHRo
aXMgcnVucy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKaW5kZXggOTU4OWUwYTJmMTRhLi5lZTdl
MTZkNTc2YzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9p
aC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCkBAIC0yNzgs
NyArMjc4LDcgQEAgc3RhdGljIGJvb2wgdmVnYTEwX2loX3ByZXNjcmVlbl9pdihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkvKiBUcmFjayByZXRyeSBmYXVsdHMgaW4gcGVyLVZNIGZhdWx0
IEZJRk8uICovCiAJc3Bpbl9sb2NrKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2spOwogCXZt
ID0gaWRyX2ZpbmQoJmFkZXYtPnZtX21hbmFnZXIucGFzaWRfaWRyLCBwYXNpZCk7Ci0JaWYgKFdB
Uk5fT05fT05DRSghdm0pKSB7CisJaWYgKHZtKSB7CiAJCS8qIFZNIG5vdCBmb3VuZCwgcHJvY2Vz
cyBpdCBub3JtYWxseSAqLwogCQlzcGluX3VubG9jaygmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9s
b2NrKTsKIAkJYW1kZ3B1X2loX2NsZWFyX2ZhdWx0KGFkZXYsIGtleSk7Ci0tIAoyLjE0LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
