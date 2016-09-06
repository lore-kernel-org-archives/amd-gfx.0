From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unused SI DPM struct
Date: Tue,  6 Sep 2016 12:18:44 -0400
Message-ID: <20160906161844.21370-8-tom.stdenis@amd.com>
References: <20160906161844.21370-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160906161844.21370-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VGhlIHRhaGl0aV9sZSBzdHJ1Y3R1cmUgaXMgbm90IGN1cnJlbnRseSB1c2VkLiAgQ29tbWVudCBp
dCBvdXQKdG8gYXZvaWQgd2FybmluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRv
bS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBt
LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zaV9kcG0uYwppbmRleCA3YjlkZWJlZmQ2NGEuLjkyYTA0MTc1NWU4ZSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKQEAgLTM0MCw2ICszNDAsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHNpX2R0ZV9kYXRhIGR0ZV9kYXRhX3RhaGl0aSA9CiAJZmFsc2UKIH07CiAKKyNp
ZiAwCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNpX2R0ZV9kYXRhIGR0ZV9kYXRhX3RhaGl0aV9sZSA9
CiB7CiAJeyAweDFFODQ4MCwgMHg3QTEyMDAsIDB4MjE2MEVDMCwgMHgzOTM4NzAwLCAwIH0sCkBA
IC0zNTcsNiArMzU4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzaV9kdGVfZGF0YSBkdGVfZGF0
YV90YWhpdGlfbGUgPQogCTg1LAogCXRydWUKIH07CisjZW5kaWYKIAogc3RhdGljIGNvbnN0IHN0
cnVjdCBzaV9kdGVfZGF0YSBkdGVfZGF0YV90YWhpdGlfcHJvID0KIHsKLS0gCjIuOS4zCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
