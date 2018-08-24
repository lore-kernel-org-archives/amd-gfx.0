From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] drm/amdgpu: add GMC9 support for PDs/PTs in system memory
Date: Fri, 24 Aug 2018 16:20:00 +0200
Message-ID: <20180824142002.2315-3-christian.koenig@amd.com>
References: <20180824142002.2315-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180824142002.2315-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

QWRkIHRoZSBuZWNlc3NhcnkgaGFuZGxpbmcuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmluZGV4IGE4
MmIzZWI0MjllOC4uNDUzYmQ3ZWE1MGU3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OV8wLmMKQEAgLTU2MCw3ICs1NjAsNyBAQCBzdGF0aWMgdWludDY0X3QgZ21jX3Y5XzBfZ2V0X3Zt
X3B0ZV9mbGFncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIHN0YXRpYyB2b2lkIGdtY192
OV8wX2dldF92bV9wZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBsZXZlbCwKIAkJ
CQl1aW50NjRfdCAqYWRkciwgdWludDY0X3QgKmZsYWdzKQogewotCWlmICghKCpmbGFncyAmIEFN
REdQVV9QREVfUFRFKSkKKwlpZiAoISgqZmxhZ3MgJiBBTURHUFVfUERFX1BURSkgJiYgISgqZmxh
Z3MgJiBBTURHUFVfUFRFX1NZU1RFTSkpCiAJCSphZGRyID0gYWRldi0+dm1fbWFuYWdlci52cmFt
X2Jhc2Vfb2Zmc2V0ICsgKmFkZHIgLQogCQkJYWRldi0+Z21jLnZyYW1fc3RhcnQ7CiAJQlVHX09O
KCphZGRyICYgMHhGRkZGMDAwMDAwMDAwMDNGVUxMKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
