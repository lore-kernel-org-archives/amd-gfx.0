From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Enable gfx cache probing on HDP write for
 arcturus
Date: Mon, 7 Oct 2019 20:34:17 +0000
Message-ID: <1570480448-29861-2-git-send-email-Oak.Zeng@amd.com>
References: <1570480448-29861-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1570480448-29861-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyBhbGxvd3MgZ2Z4IGNhY2hlIHRvIGJlIHByb2JlZCBhbmQgaW52YWxpZGF0ZWQgKGZvciBu
b25lLWRpcnR5IGNhY2hlIGxpbmVzKQpvbiBhIEhEUCB3cml0ZSAoZnJvbSBlaXRoZXIgYW5vdGhl
ciBHUFUgb3IgQ1BVKS4gVGhpcyBzaG91bGQgd29yayBvbmx5IGZvciB0aGUKbWVtb3J5IG1hcHBl
ZCBhcyBSVyBtZW1vcnkgdHlwZSBuZXdseSBhZGRlZCBmb3IgYXJjdHVydXMsIHRvIGFjaGlldmUg
c29tZSBjYWNoZQpjb2hlcmVuY2UgYi90IG11bHRpcGxlIG1lbW9yeSBjbGllbnRzLgoKQ2hhbmdl
LUlkOiBJNWM5YTZhMjVkODhjZDc1YzcxYzg4ODIyMTIzZTBkNGMwNjdhYTNmOApTaWduZWQtb2Zm
LWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBjN2UwN2YxLi42ZTQ1
ZWJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTExOTIsNiArMTE5
Miw5IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJCS8qIFRP
RE8gZm9yIHJlbm9pciAqLwogCQltbWh1Yl92MV8wX3VwZGF0ZV9wb3dlcl9nYXRpbmcoYWRldiwg
dHJ1ZSk7CiAJCWJyZWFrOworCWNhc2UgQ0hJUF9BUkNUVVJVUzoKKwkJV1JFRzMyX0ZJRUxEMTUo
SERQLCAwLCBIRFBfTU1IVUJfQ05UTCwgSERQX01NSFVCX0dDQywgMSk7CisJCWJyZWFrOwogCWRl
ZmF1bHQ6CiAJCWJyZWFrOwogCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
