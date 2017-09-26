From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix copy error in powerplay
Date: Tue, 26 Sep 2017 10:35:45 +0800
Message-ID: <1506393345-2487-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

Y2F1c2UgYW1kZ3B1IGZhaWwgdG8gaW5pdGlhbGl6ZSBvbiBDWi9TVAoKQ2hhbmdlLUlkOiBJY2Ew
NTI3ZTk5NzkyNjhmNjA5ZGJiZTY5ZmI4YzdlY2Q5N2QyNjg3NQpTaWduZWQtb2ZmLWJ5OiBSZXgg
Wmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvaHdtZ3IuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3
bWdyL2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9od21nci5j
CmluZGV4IDQ5ODRjOWQuLjczOTY5ZjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaHdtZ3IvaHdtZ3IuYwpAQCAtMTY0LDcgKzE2NCw3IEBAIGludCBod21ncl9lYXJseV9pbml0
KHN0cnVjdCBwcF9pbnN0YW5jZSAqaGFuZGxlKQogCQlzbXU3X2luaXRfZnVuY3Rpb25fcG9pbnRl
cnMoaHdtZ3IpOwogCQlicmVhazsKIAljYXNlIEFNREdQVV9GQU1JTFlfQ1o6Ci0JCWh3bWdyLT5z
bXVtZ3JfZnVuY3MgPSAmY2lfc211X2Z1bmNzOworCQlod21nci0+c211bWdyX2Z1bmNzID0gJmN6
X3NtdV9mdW5jczsKIAkJY3pfaW5pdF9mdW5jdGlvbl9wb2ludGVycyhod21ncik7CiAJCWJyZWFr
OwogCWNhc2UgQU1ER1BVX0ZBTUlMWV9WSToKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
