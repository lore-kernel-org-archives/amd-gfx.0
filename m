From: Horace Chen <horace.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: Add a new flag for SR-IOV to share memory
 between PF & VF
Date: Wed, 27 Sep 2017 17:23:49 +0800
Message-ID: <1506504231-24507-1-git-send-email-horace.chen@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Horace Chen <horace.chen-5C7GfCeVMHo@public.gmane.org>

QWRkIEFUT01fVlJBTV9CTE9DS19TUklPVl9NU0dfU0hBUkVfUkVTRVJWQVRJT04gdG8gaWRlbnRp
Znkgd2hldGhlcgpkcml2ZXIgbmVlZCB0byByZXNlcnZlIFZSQU0gZm9yIFNSLUlPViBzaGFyZWQg
bWVtb3J5LgoKU2lnbmVkLW9mZi1ieTogSG9yYWNlIENoZW4gPGhvcmFjZS5jaGVuQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21iaW9zLmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hdG9tYmlvcy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21i
aW9zLmgKaW5kZXggMTgxYTJjMy4uZjY5NmJiYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2F0b21iaW9zLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2F0b21iaW9zLmgKQEAgLTQyOTIsNiArNDI5Miw3IEBAIHR5cGVkZWYgc3RydWN0IF9BVE9NX0RQ
Q0RfSU5GTwogI2RlZmluZSBBVE9NX1ZSQU1fT1BFUkFUSU9OX0ZMQUdTX1NISUZUICAgICAgICAz
MAogI2RlZmluZSAgIEFUT01fVlJBTV9CTE9DS19ORUVEU19OT19SRVNFUlZBVElPTiAgIDB4MQog
I2RlZmluZSAgIEFUT01fVlJBTV9CTE9DS19ORUVEU19SRVNFUlZBVElPTiAgICAgIDB4MAorI2Rl
ZmluZSAgIEFUT01fVlJBTV9CTE9DS19TUklPVl9NU0dfU0hBUkVfUkVTRVJWQVRJT04gMHgyCiAK
IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIC8vIFN0cnVjdHVyZSB1c2VkIGluIFZSQU1f
VXNhZ2VCeUZpcm13YXJlVGFibGUKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
