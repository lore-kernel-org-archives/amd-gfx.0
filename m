From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Use new TTM flag to avoid OOM triggering.
Date: Tue, 16 Jan 2018 10:18:26 -0500
Message-ID: <1516115906-26095-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1e5d9bed-fe91-360f-e798-772d669f6377@gmail.com>
 <1516115906-26095-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516115906-26095-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Hongbo.He-5C7GfCeVMHo@public.gmane.org

QXZvaWQgT09NIG9uIHN5YXRlbSBwYWdlcyBhbGxvY2F0aW9ucy4KCnYyOgpSZW1vdmUgbW9kZXBy
b2JlIHBhcmFtZXRlciwgbWFraW5nIHRoaXMgYmVoYXZpb3VyIHRoZSBvbmx5IG9wdGlvbi4KClNp
Z25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDQgKysr
KwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYwppbmRleCA1YzRjM2UwLi5iNGRjM2JkIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC00MjAsNiArNDIwLDEwIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2JvX2RvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKICNlbmRpZgogCiAJYm8tPnRiby5iZGV2ID0gJmFkZXYtPm1tYW4uYmRldjsKKworCS8qIFdl
IG9wdCB0byBhdm9pZCBPT00gb24gc3lzdGVtIHBhZ2VzIGFsbG9jYXRpb25zICovCisJYm8tPnRi
by5iZGV2LT5ub19yZXRyeSA9IHRydWU7CisKIAlhbWRncHVfdHRtX3BsYWNlbWVudF9mcm9tX2Rv
bWFpbihibywgZG9tYWluKTsKIAogCXIgPSB0dG1fYm9faW5pdF9yZXNlcnZlZCgmYWRldi0+bW1h
bi5iZGV2LCAmYm8tPnRibywgc2l6ZSwgdHlwZSwKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
