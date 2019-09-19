From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Enable gfx cache probing on HDP write for arcturus
Date: Thu, 19 Sep 2019 21:17:15 +0000
Message-ID: <1568927828-17593-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
LUlkOiBJMGE2OWQwMDAwZTQ4NzA2YmI3MTMyMzViZmJjODNmY2M2Nzc3NDYxNApTaWduZWQtb2Zm
LWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCA1N2Q3NmVlLi5lMDFh
MzU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTEyNzIsNiArMTI3
Miw5IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZ2FydF9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCS8qIFRPRE8gZm9yIHJlbm9pciAqLwogCQltbWh1Yl92MV8wX3VwZGF0ZV9w
b3dlcl9nYXRpbmcoYWRldiwgdHJ1ZSk7CiAJCWJyZWFrOworCWNhc2UgQ0hJUF9BUkNUVVJVUzoK
KwkJV1JFRzMyX0ZJRUxEMTUoSERQLCAwLCBIRFBfTU1IVUJfQ05UTCwgSERQX01NSFVCX0dDQywg
MSk7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWJyZWFrOwogCX0KLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
