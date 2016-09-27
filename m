From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] drm/radeon/si/dpm: add workaround for for Jet parts
Date: Tue, 27 Sep 2016 11:41:08 -0400
Message-ID: <1474990869-5788-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QWRkIGNsb2NrIHF1aXJrcyBmb3IgSmV0IHBhcnRzLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZwotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgfCA2ICsrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vc2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCmluZGV4IGU2
YWJjMDkuLjFmNzhlYzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBt
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwpAQCAtMzAxNSw2ICszMDE1
LDEyIEBAIHN0YXRpYyB2b2lkIHNpX2FwcGx5X3N0YXRlX2FkanVzdF9ydWxlcyhzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldiwKIAlpZiAocmRldi0+cGRldi0+ZGV2aWNlID09IDB4NjgxMSAmJgog
CSAgICByZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweDgxKQogCQltYXhfbWNsayA9IDEyMDAwMDsK
KwkvKiBsaW1pdCBzY2xrL21jbGsgb24gSmV0IHBhcnRzIGZvciBzdGFiaWxpdHkgKi8KKwlpZiAo
cmRldi0+cGRldi0+ZGV2aWNlID09IDB4NjY2NSAmJgorCSAgICByZGV2LT5wZGV2LT5yZXZpc2lv
biA9PSAweGMzKSB7CisJCW1heF9zY2xrID0gNzUwMDA7CisJCW1heF9tY2xrID0gODAwMDA7CisJ
fQogCiAJaWYgKHJwcy0+dmNlX2FjdGl2ZSkgewogCQlycHMtPmV2Y2xrID0gcmRldi0+cG0uZHBt
LnZjZV9zdGF0ZXNbcmRldi0+cG0uZHBtLnZjZV9sZXZlbF0uZXZjbGs7Ci0tIAoyLjUuNQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
