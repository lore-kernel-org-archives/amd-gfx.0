From: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v2] drm/amd/amdgpu: disable MMHUB PG for navi10
Date: Thu, 26 Sep 2019 08:47:06 +0000
Message-ID: <MN2PR12MB35985800E64D5987D10D5CDE8E860@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <1569487411-24923-1-git-send-email-kenneth.feng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569487411-24923-1-git-send-email-kenneth.feng-5C7GfCeVMHo@public.gmane.org>
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
To: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

U29ycnkgdGhpcyBpcyBhIHByZXZpb3VzIHBhdGNoLiBTZW50IGl0IHdyb25nLiAKUGxlYXNlIGln
bm9yZSBpdC4KVGhhbmtzLgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogS2VubmV0
aCBGZW5nIFttYWlsdG86a2VubmV0aC5mZW5nQGFtZC5jb21dIApTZW50OiBUaHVyc2RheSwgU2Vw
dGVtYmVyIDI2LCAyMDE5IDQ6NDQgUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4KU3ViamVjdDogW1BBVENI
IHYyXSBkcm0vYW1kL2FtZGdwdTogZGlzYWJsZSBNTUhVQiBQRyBmb3IgbmF2aTEwCgpEaXNhYmxl
IE1NSFVCIFBHIGZvciBuYXZpMTAgYWNjb3JkaW5nIHRvIHRoZSBwcm9kdWN0aW9uIHJlcXVpcmVt
ZW50LgoKU2lnbmVkLW9mZi1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMSAtCiAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGluZGV4IGQ0YTIwMTIuLjQ2
ZjQwMmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwpAQCAtNjE2LDcgKzYxNiw2IEBAIHN0YXRp
YyBpbnQgbnZfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBP
UlRfQklGX0xTOwogCQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1ZDTiB8CiAJCQlB
TURfUEdfU1VQUE9SVF9WQ05fRFBHIHwKLQkJCUFNRF9QR19TVVBQT1JUX01NSFVCIHwKIAkJCUFN
RF9QR19TVVBQT1JUX0FUSFVCOwogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZf
aWQgKyAweDE7CiAJCWJyZWFrOwotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
