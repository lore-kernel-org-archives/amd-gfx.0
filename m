From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 4/4] DRI2: Fix radeon_dri2_exchange_buffers
 width/height copy'n'paste error
Date: Wed, 14 Sep 2016 17:14:47 +0900
Message-ID: <20160914081447.7221-4-michel@daenzer.net>
References: <20160914081447.7221-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160914081447.7221-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogUWlhbmcgWXUgPFFpYW5nLll1QGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBRaWFuZyBZ
dSA8UWlhbmcuWXVAYW1kLmNvbT4KKFBvcnRlZCBmcm9tIGFtZGdwdSBjb21taXQgNzNjOGRjMDAw
YWQ2YjJiNTNiYTNhYTcxNTVmNWU4ZjZiNTU2MjNiNykKClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBE
w6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9yYWRlb25fZHJpMi5jIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvc3JjL3JhZGVvbl9kcmkyLmMgYi9zcmMvcmFkZW9uX2RyaTIuYwppbmRleCA3OTUw
MWYwLi42OWZkMGVhIDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX2RyaTIuYworKysgYi9zcmMvcmFk
ZW9uX2RyaTIuYwpAQCAtNzc1LDcgKzc3NSw3IEBAIHJhZGVvbl9kcmkyX2V4Y2hhbmdlX2J1ZmZl
cnMoRHJhd2FibGVQdHIgZHJhdywgRFJJMkJ1ZmZlclB0ciBmcm9udCwgRFJJMkJ1ZmZlclB0CiAK
ICAgICByZWdpb24uZXh0ZW50cy54MSA9IHJlZ2lvbi5leHRlbnRzLnkxID0gMDsKICAgICByZWdp
b24uZXh0ZW50cy54MiA9IGZyb250X3ByaXYtPnBpeG1hcC0+ZHJhd2FibGUud2lkdGg7Ci0gICAg
cmVnaW9uLmV4dGVudHMueTIgPSBmcm9udF9wcml2LT5waXhtYXAtPmRyYXdhYmxlLndpZHRoOwor
ICAgIHJlZ2lvbi5leHRlbnRzLnkyID0gZnJvbnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZS5oZWln
aHQ7CiAgICAgcmVnaW9uLmRhdGEgPSBOVUxMOwogICAgIERhbWFnZVJlZ2lvbkFwcGVuZCgmZnJv
bnRfcHJpdi0+cGl4bWFwLT5kcmF3YWJsZSwgJnJlZ2lvbik7CiAKLS0gCjIuOS4zCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
