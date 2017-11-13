From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 2/3] headers: sync up amdgpu_drm.h with proposed change
Date: Mon, 13 Nov 2017 14:27:47 +0100
Message-ID: <20171113132748.16298-2-christian.koenig@amd.com>
References: <20171113132748.16298-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171113132748.16298-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

U3luYyB1cCB0aGUgbm90IHlldCB1cHN0cmVhbSBjaGFuZ2UgZm9yIHRoZSBuZXh0IHBhdGNoLgoK
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgotLS0KIGluY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBi
L2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRleCA5MTkyNDhmYi4uYTAyM2I0NzYgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVf
ZHJtLmgKQEAgLTg2OSw2ICs4NjksMTAgQEAgc3RydWN0IGRybV9hbWRncHVfaW5mb19kZXZpY2Ug
ewogCV9fdTMyIF9wYWQxOwogCS8qIGFsd2F5cyBvbiBjdSBiaXRtYXAgKi8KIAlfX3UzMiBjdV9h
b19iaXRtYXBbNF1bNF07CisJLyoqIFN0YXJ0aW5nIGhpZ2ggdmlydHVhbCBhZGRyZXNzIGZvciBV
TURzLiAqLworCV9fdTY0IGhpZ2hfdmFfb2Zmc2V0OworCS8qKiBUaGUgbWF4aW11bSBoaWdoIHZp
cnR1YWwgYWRkcmVzcyAqLworCV9fdTY0IGhpZ2hfdmFfbWF4OwogfTsKIAogc3RydWN0IGRybV9h
bWRncHVfaW5mb19od19pcCB7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
