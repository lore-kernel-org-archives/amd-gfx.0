From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/11] drm/amdgpu/soc15: enable UVD code path for sriov
Date: Mon, 24 Apr 2017 14:58:04 +0800
Message-ID: <1493017089-23101-7-git-send-email-Xiangliang.Yu@amd.com>
References: <1493017089-23101-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493017089-23101-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KCkVuYWJsZSBVVkQgYmxvY2sgZm9y
IFNSSU9WLgoKU2lnbmVkLW9mZi1ieTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogWGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jCmluZGV4IDY5OTlhYzMuLjRlNTE0YjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
YwpAQCAtNDgyLDggKzQ4Miw3IEBAIGludCBzb2MxNV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogI2VuZGlmCiAJCWFtZGdwdV9pcF9ibG9ja19hZGQoYWRldiwgJmdm
eF92OV8wX2lwX2Jsb2NrKTsKIAkJYW1kZ3B1X2lwX2Jsb2NrX2FkZChhZGV2LCAmc2RtYV92NF8w
X2lwX2Jsb2NrKTsKLQkJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCi0JCQlhbWRncHVfaXBf
YmxvY2tfYWRkKGFkZXYsICZ1dmRfdjdfMF9pcF9ibG9jayk7CisJCWFtZGdwdV9pcF9ibG9ja19h
ZGQoYWRldiwgJnV2ZF92N18wX2lwX2Jsb2NrKTsKIAkJYW1kZ3B1X2lwX2Jsb2NrX2FkZChhZGV2
LCAmdmNlX3Y0XzBfaXBfYmxvY2spOwogCQlicmVhazsKIAlkZWZhdWx0OgotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
