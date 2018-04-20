From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/pp: Change pstate_clk frequency unit to 10KHz on
 Rv to keep consistent with other asics
Date: Fri, 20 Apr 2018 14:29:45 +0800
Message-ID: <1524205786-17106-1-git-send-email-Rex.Zhu@amd.com>
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

U2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMKaW5kZXggMGYyNTIyNi4u
NTYzZGNkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Iv
c211MTBfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9z
bXUxMF9od21nci5jCkBAIC00MzYsOCArNDM2LDggQEAgc3RhdGljIGludCBzbXUxMF9od21ncl9i
YWNrZW5kX2luaXQoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAogCWh3bWdyLT5wbGF0Zm9ybV9k
ZXNjcmlwdG9yLm1pbmltdW1DbG9ja3NSZWR1Y3Rpb25QZXJjZW50YWdlID0gNTA7CiAKLQlod21n
ci0+cHN0YXRlX3NjbGsgPSBTTVUxMF9VTURfUFNUQVRFX0dGWENMSzsKLQlod21nci0+cHN0YXRl
X21jbGsgPSBTTVUxMF9VTURfUFNUQVRFX0ZDTEs7CisJaHdtZ3ItPnBzdGF0ZV9zY2xrID0gU01V
MTBfVU1EX1BTVEFURV9HRlhDTEsgKiAxMDA7CisJaHdtZ3ItPnBzdGF0ZV9tY2xrID0gU01VMTBf
VU1EX1BTVEFURV9GQ0xLICogMTAwOwogCiAJcmV0dXJuIHJlc3VsdDsKIH0KLS0gCjEuOS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
