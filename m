From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 2/4] headers: sync up amdgpu_drm.h with drm-next
Date: Sun,  7 Jan 2018 10:11:33 +0100
Message-ID: <20180107091135.2373-2-christian.koenig@amd.com>
References: <20180107091135.2373-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180107091135.2373-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

U3luYyB1cCBhbWRncHUgY2hhbmdlcyBmcm9tIGRybS1uZXh0LgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGluY2x1ZGUvZHJt
L2FtZGdwdV9kcm0uaCB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdw
dV9kcm0uaAppbmRleCA5MTkyNDhmYi4uYTAyM2I0NzYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJt
L2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKQEAgLTg2OSw2ICs4
NjksMTAgQEAgc3RydWN0IGRybV9hbWRncHVfaW5mb19kZXZpY2UgewogCV9fdTMyIF9wYWQxOwog
CS8qIGFsd2F5cyBvbiBjdSBiaXRtYXAgKi8KIAlfX3UzMiBjdV9hb19iaXRtYXBbNF1bNF07CisJ
LyoqIFN0YXJ0aW5nIGhpZ2ggdmlydHVhbCBhZGRyZXNzIGZvciBVTURzLiAqLworCV9fdTY0IGhp
Z2hfdmFfb2Zmc2V0OworCS8qKiBUaGUgbWF4aW11bSBoaWdoIHZpcnR1YWwgYWRkcmVzcyAqLwor
CV9fdTY0IGhpZ2hfdmFfbWF4OwogfTsKIAogc3RydWN0IGRybV9hbWRncHVfaW5mb19od19pcCB7
Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
