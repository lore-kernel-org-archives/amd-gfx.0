From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/11] drm/amdgpu/psp: skip loading SDMA/RLCG under SRIOV VF
Date: Mon, 24 Apr 2017 14:58:01 +0800
Message-ID: <1493017089-23101-4-git-send-email-Xiangliang.Yu@amd.com>
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
Cc: Daniel Wang <Daniel.Wang2-5C7GfCeVMHo@public.gmane.org>, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRGFuaWVsIFdhbmcgPERhbmllbC5XYW5nMkBhbWQuY29tPgoKTm93IEdQVSBoeXBlcnZp
c29yIHdpbGwgbG9hZCBTRE1BIGFuZCBSTENHIHVjb2RlLCBzbyBza2lwIGl0CmluIGd1ZXN0LgoK
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhbmcgPERhbmllbC5XYW5nMkBhbWQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMKaW5kZXggMWUzODBmZS4uYWM1ZTkyZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYwpAQCAtMjg5LDYgKzI4OSwxMiBAQCBzdGF0aWMgaW50IHBzcF9ucF9md19sb2Fk
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCQlpZiAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQ
VV9VQ09ERV9JRF9TTUMgJiYKIAkJICAgIHBzcF9zbXVfcmVsb2FkX3F1aXJrKHBzcCkpCiAJCQlj
b250aW51ZTsKKwkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJgorCQkgICAodWNvZGUtPnVj
b2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BMAorCQkgICAgfHwgdWNvZGUtPnVjb2RlX2lk
ID09IEFNREdQVV9VQ09ERV9JRF9TRE1BMQorCQkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFN
REdQVV9VQ09ERV9JRF9STENfRykpCisJCQkvKnNraXAgdWNvZGUgbG9hZGluZyBpbiBTUklPViBW
RiAqLworCQkJY29udGludWU7CiAKIAkJcmV0ID0gcHNwX3ByZXBfY21kX2J1Zih1Y29kZSwgcHNw
LT5jbWQpOwogCQlpZiAocmV0KQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
