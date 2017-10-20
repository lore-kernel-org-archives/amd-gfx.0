From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/4] Free memory returned by xf86GetEntityInfo
Date: Fri, 20 Oct 2017 17:28:18 +0200
Message-ID: <20171020152820.14545-2-michel@daenzer.net>
References: <20171020152820.14545-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171020152820.14545-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpXZSB3ZXJlIGxl
YWtpbmcgaXQuCgooUG9ydGVkIGZyb20gYW1kZ3B1IGNvbW1pdCBjZmNjZjRjNGU3ZTVjNzNmZTQw
NDBmYWJlYjFiNDMyODNjZjI5YjMzKQoKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1p
Y2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL3JhZGVvbl9rbXMuYyB8IDEgKwogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9rbXMuYyBi
L3NyYy9yYWRlb25fa21zLmMKaW5kZXggZGY0Mzg3NjhjLi5mNzlhZjM0MTUgMTAwNjQ0Ci0tLSBh
L3NyYy9yYWRlb25fa21zLmMKKysrIGIvc3JjL3JhZGVvbl9rbXMuYwpAQCAtMjI4LDYgKzIyOCw3
IEBAIHN0YXRpYyB2b2lkIFJBREVPTkZyZWVSZWMoU2NybkluZm9QdHIgcFNjcm4pCiAJaW5mby0+
YWNjZWxfc3RhdGUgPSBOVUxMOwogICAgIH0KIAorICAgIGZyZWUoaW5mby0+cEVudCk7CiAgICAg
ZnJlZShwU2Nybi0+ZHJpdmVyUHJpdmF0ZSk7CiAgICAgcFNjcm4tPmRyaXZlclByaXZhdGUgPSBO
VUxMOwogfQotLSAKMi4xNC4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
