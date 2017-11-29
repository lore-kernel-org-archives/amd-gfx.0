From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH 0/5] drm/radeon: Clean up rest of amdkfd support
Date: Wed, 29 Nov 2017 18:24:48 +0100
Message-ID: <20171129172453.4953-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGUgZmlyc3Qg
Zm91ciBwYXRjaGVzIGFyZSBtb3N0bHkgc3RyYWlnaHQgcmV2ZXJ0cyBvZiBjaGFuZ2VzIHdoaWNo
CndlcmUgbWFkZSBmb3IgYW1ka2ZkIHN1cHBvcnQsIHBhdGNoIDUgY2xlYW5zIHVwIGEgbGVmdG92
ZXIgZGVmaW5lLgoKTWljaGVsIETDpG56ZXIgKDUpOgogIFJldmVydCAiZHJtL3JhZGVvbjogYWRk
aW5nIHN5bmNocm9uaXphdGlvbiBmb3IgR1JCTSBHRlgiCiAgUmV2ZXJ0ICJkcm0vcmFkZW9uOiBS
ZXBvcnQgZG9vcmJlbGwgY29uZmlndXJhdGlvbiB0byBhbWRrZmQiCiAgUmV2ZXJ0ICJkcm0vcmFk
ZW9uL2NpazogRG9uJ3QgdG91Y2ggaW50IG9mIHBpcGVzIDEtNyIKICBSZXZlcnQgImRybS9yYWRl
b246IHJlZHVjZSBudW1iZXIgb2YgZnJlZSBWTUlEcyBhbmQgcGlwZXMgaW4gS1YiCiAgZHJtL3Jh
ZGVvbjogUmVtb3ZlIEtGRF9DSUtfU0RNQV9RVUVVRV9PRkZTRVQKCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2Npay5jICAgICAgICAgICB8IDExNCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrX3JlZy5oICAgICAgIHwgICAyIC0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmggICAgICAgIHwgICA2IC0tCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYyB8ICAzMiAtLS0tLS0tLS0KIDQgZmlsZXMgY2hh
bmdlZCwgODEgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pCgotLSAKMi4xNS4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
