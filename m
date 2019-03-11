From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Update gc golden setting for vega family
Date: Mon, 11 Mar 2019 15:59:25 +0000
Message-ID: <1552319956-23529-1-git-send-email-shaoyun.liu@amd.com>
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

R0Mgb3duZXIgc3VnZ2VzdGVkIHRoZSBzZXR0aW5nIHNob3VsZCBiZSBhcHBsaWVkIHdoaWNoIGlz
IG1pc3NlZCBieSBIVyBkZWZhdWx0CgpTaWduZWQtb2ZmLWJ5OiBzaGFveXVubCA8c2hhb3l1bi5s
aXVAYW1kLmNvbT4KCkNoYW5nZS1JZDogSTA5ZGQwMGM2NGI4OGYzZDczNmVjMWRkNjdkNTQ0ZmFi
NTk3YjFjMjgKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYwppbmRleCAzMDk3MThjLi42MGM1ODJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKQEAgLTIyMiw2ICsyMjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNv
YzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdzX2djXzlfMV9ydjJbXSA9CiAKIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfOV94X2NvbW1v
bltdID0KIHsKKwlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNQX1NEX0NOVEwsIDB4
ZmZmZmZmZmYsIDB4MDAwMDAxZmYpLAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1t
R1JCTV9DQU1fSU5ERVgsIDB4ZmZmZmZmZmYsIDB4MDAwMDAwMDApLAogCVNPQzE1X1JFR19HT0xE
RU5fVkFMVUUoR0MsIDAsIG1tR1JCTV9DQU1fREFUQSwgMHhmZmZmZmZmZiwgMHgyNTQ0YzM4MikK
IH07Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
