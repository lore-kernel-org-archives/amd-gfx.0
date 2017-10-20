From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 3/4] Call TimerFree for timer created in LeaveVT
Date: Fri, 20 Oct 2017 17:28:19 +0200
Message-ID: <20171020152820.14545-3-michel@daenzer.net>
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
YWtpbmcgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgYnkgVGltZXJTZXQuCgooUG9ydGVkIGZyb20gYW1k
Z3B1IGNvbW1pdCA4NGFhZDA5ZjE4ZmVkNmI1MmIwYzA3M2YwYmJkNjc1YTZkZTA3ODA3KQoKU2ln
bmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQog
c3JjL3JhZGVvbl9rbXMuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9rbXMuYyBiL3NyYy9yYWRlb25fa21zLmMKaW5kZXggZjc5
YWYzNDE1Li4wNmM4YTQ3ZmIgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fa21zLmMKKysrIGIvc3Jj
L3JhZGVvbl9rbXMuYwpAQCAtMjQ4NCw2ICsyNDg0LDcgQEAgQ0FSRDMyIGNsZWFudXBfYmxhY2tf
ZmIoT3NUaW1lclB0ciB0aW1lciwgQ0FSRDMyIG5vdywgcG9pbnRlciBkYXRhKQogCWRybW1vZGVf
ZmJfcmVmZXJlbmNlKHBSQURFT05FbnQtPmZkLCAmZHJtbW9kZV9jcnRjLT5mYiwgTlVMTCk7CiAg
ICAgfQogCisgICAgVGltZXJGcmVlKHRpbWVyKTsKICAgICByZXR1cm4gMDsKIH0KIAotLSAKMi4x
NC4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
