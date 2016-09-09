From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/20] drm/amd/powerplay: add pp_table_version in hwmgr.
Date: Fri, 9 Sep 2016 21:39:33 +0800
Message-ID: <1473428378-679-16-git-send-email-Rex.Zhu@amd.com>
References: <1473428378-679-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473428378-679-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJZWUzYzdhYjljMTMxOGVjNzIwNmJmNWE1YWU1OWQ4YzQ4YjhlODIzYgpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpDb25mbGljdHM6Cglkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2luYy9od21nci5oIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9od21nci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmgKaW5k
ZXggODkxNmI5NC4uOTA5Zjg1NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaW5jL2h3bWdyLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5j
L2h3bWdyLmgKQEAgLTU5OSw2ICs1OTksMTMgQEAgZW51bSBQUF9WQ0VfTEVWRUwgewogfTsKIAog
CitlbnVtIFBQX1RBQkxFX1ZFUlNJT04geworCVBQX1RBQkxFX1YwID0gMCwKKwlQUF9UQUJMRV9W
MSwKKwlQUF9UQUJMRV9WMiwKKwlQUF9UQUJMRV9NQVgKK307CisKIC8qKgogICogVGhlIG1haW4g
aGFyZHdhcmUgbWFuYWdlciBzdHJ1Y3R1cmUuCiAgKi8KQEAgLTYwNiw2ICs2MTMsNyBAQCBzdHJ1
Y3QgcHBfaHdtZ3IgewogCXVpbnQzMl90IGNoaXBfZmFtaWx5OwogCXVpbnQzMl90IGNoaXBfaWQ7
CiAKKwl1aW50MzJfdCBwcF90YWJsZV92ZXJzaW9uOwogCXZvaWQgKmRldmljZTsKIAlzdHJ1Y3Qg
cHBfc211bWdyICpzbXVtZ3I7CiAJY29uc3Qgdm9pZCAqc29mdF9wcF90YWJsZTsKLS0gCjEuOS4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
