From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati] Only call drmmode_scanout_free for non-GPU
 screens in LeaveVT
Date: Thu, 22 Jun 2017 12:40:55 +0900
Message-ID: <20170622034055.3024-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpEZXN0cm95aW5n
IHRoZSBzY2Fub3V0IGJ1ZmZlcnMgb2YgR1BVIHNjcmVlbnMgcmVzdWx0ZWQgaW4gYSBjcmFzaCB3
aGVuCnN3aXRjaGluZyBiYWNrIHRvIHRoZSBYb3JnIFZULgoKU2lnbmVkLW9mZi1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL3JhZGVvbl9rbXMuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9rbXMuYyBiL3NyYy9yYWRlb25fa21zLmMKaW5kZXggYzRi
ZGZjZmFjLi41NjM3ZTdmOGEgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fa21zLmMKKysrIGIvc3Jj
L3JhZGVvbl9rbXMuYwpAQCAtMjQ3OCw3ICsyNDc4LDggQEAgdm9pZCBSQURFT05MZWF2ZVZUX0tN
UyhWVF9GVU5DX0FSR1NfREVDTCkKICAgICByYWRlb25fZHJvcF9kcm1fbWFzdGVyKHBTY3JuKTsK
IAogICAgIHhmODZSb3RhdGVGcmVlU2hhZG93KHBTY3JuKTsKLSAgICBkcm1tb2RlX3NjYW5vdXRf
ZnJlZShwU2Nybik7CisgICAgaWYgKCFwU2Nybi0+aXNfZ3B1KQorCWRybW1vZGVfc2Nhbm91dF9m
cmVlKHBTY3JuKTsKIAogICAgIHhmODZfaGlkZV9jdXJzb3JzIChwU2Nybik7CiAgICAgaW5mby0+
YWNjZWxfc3RhdGUtPlhJbml0ZWQzRCA9IEZBTFNFOwotLSAKMi4xMS4wCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
