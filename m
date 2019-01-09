From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 2/2] Only call drmmode_validate_leases if RandR
 is enabled
Date: Wed,  9 Jan 2019 11:43:23 +0100
Message-ID: <20190109104323.4524-2-michel@daenzer.net>
References: <20190109104323.4524-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190109104323.4524-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCB3b3VsZCBj
cmFzaCBpZiBSYW5kUiBpcyBkaXNhYmxlZCwgZS5nLiBiZWNhdXNlIFhpbmVyYW1hIGlzIGVuYWJs
ZWQuCgpCdWd6aWxsYTogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8xMDkyMzAKU2lnbmVk
LW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3Jj
L2RybW1vZGVfZGlzcGxheS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNwbGF5LmMgYi9z
cmMvZHJtbW9kZV9kaXNwbGF5LmMKaW5kZXggZTA0YTE3ZDVlLi43MWYzNTM5ZjYgMTAwNjQ0Ci0t
LSBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYworKysgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKQEAg
LTMxMDAsNyArMzEwMCw4IEBAIEJvb2wgZHJtbW9kZV9zZXRfZGVzaXJlZF9tb2RlcyhTY3JuSW5m
b1B0ciBwU2NybiwgZHJtbW9kZV9wdHIgZHJtbW9kZSwKIAl9CiAKIAkvKiBWYWxpZGF0ZSBsZWFz
ZXMgb24gVlQgcmUtZW50cnkgKi8KLQlkcm1tb2RlX3ZhbGlkYXRlX2xlYXNlcyhwU2Nybik7CisJ
aWYgKGRpeFByaXZhdGVLZXlSZWdpc3RlcmVkKHJyUHJpdktleSkpCisJICAgIGRybW1vZGVfdmFs
aWRhdGVfbGVhc2VzKHBTY3JuKTsKIAogCXJldHVybiBUUlVFOwogfQotLSAKMi4yMC4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
