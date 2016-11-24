From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/39] =?UTF-8?q?drm/amd/dal:=20fix=20memory=20leak=20poin?=
 =?UTF-8?q?ted=20out=20by=20Juha=20Lepp=C3=A4nen=20<juha=5Fefku@dnainterne?=
 =?UTF-8?q?t.net>?=
Date: Wed, 23 Nov 2016 21:02:49 -0500
Message-ID: <20161124020308.28124-21-harry.wentland@amd.com>
References: <20161124020308.28124-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161124020308.28124-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKQ2hhbmdlLUlkOiBJZjZhMzM3
YjE2Yjc4ZTFkZDhhOTUyZDZjMTA2NDQyNjk2MWY2ZDVhNwpTaWduZWQtb2ZmLWJ5OiBUb255IENo
ZW5nIDx0b255LmNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnku
d2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2Rj
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMKaW5kZXggNmUzMmYxYmQ5MzVjLi5hYWY2
MWExZmViNDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2NvcmUvZGMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMKQEAgLTQ0OSw3ICs0
NDksNyBAQCBzdGF0aWMgdm9pZCBkZXN0cnVjdChzdHJ1Y3QgY29yZV9kYyAqZGMpCiAJcmVzb3Vy
Y2VfdmFsaWRhdGVfY3R4X2Rlc3RydWN0KGRjLT5jdXJyZW50X2NvbnRleHQpOwogCiAJZG1fZnJl
ZShkYy0+dGVtcF9mbGlwX2NvbnRleHQpOwotCWRjLT5jdXJyZW50X2NvbnRleHQgPSBOVUxMOwor
CWRjLT50ZW1wX2ZsaXBfY29udGV4dCA9IE5VTEw7CiAKIAlkZXN0cm95X2xpbmtzKGRjKTsKIAot
LSAKMi4xMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
