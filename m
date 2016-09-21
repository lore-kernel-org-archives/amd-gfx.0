From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 14/15] Clear damage in radeon_scanout_update if
 it doesn't intersect the CRTC
Date: Wed, 21 Sep 2016 18:50:53 +0900
Message-ID: <20160921095054.28302-14-michel@daenzer.net>
References: <20160921095054.28302-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160921095054.28302-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGVyZSdzIG5v
IG5lZWQgdG8gdGVzdCB0aGF0IHNhbWUgZGFtYWdlIGFnYWluLgoKKFBvcnRlZCBmcm9tIGFtZGdw
dSBjb21taXQgYTU3NjQzMDUyNmNiYzQwNGRlNjRiMzBlMTM3N2EzNTY2NDRlODAyNCkKClNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNy
Yy9yYWRlb25fa21zLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX2ttcy5jIGIvc3JjL3JhZGVv
bl9rbXMuYwppbmRleCAzODRlMDJmLi5mYWExZTBmIDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX2tt
cy5jCisrKyBiL3NyYy9yYWRlb25fa21zLmMKQEAgLTk5OSw4ICs5OTksMTAgQEAgcmFkZW9uX3Nj
YW5vdXRfdXBkYXRlKHhmODZDcnRjUHRyIHhmODZfY3J0YykKIAlyZXR1cm47CiAKICAgICBleHRl
bnRzID0gKlJlZ2lvbkV4dGVudHMocFJlZ2lvbik7Ci0gICAgaWYgKCFyYWRlb25fc2Nhbm91dF9l
eHRlbnRzX2ludGVyc2VjdCh4Zjg2X2NydGMsICZleHRlbnRzKSkKKyAgICBpZiAoIXJhZGVvbl9z
Y2Fub3V0X2V4dGVudHNfaW50ZXJzZWN0KHhmODZfY3J0YywgJmV4dGVudHMpKSB7CisJUmVnaW9u
RW1wdHkocFJlZ2lvbik7CiAJcmV0dXJuOworICAgIH0KIAogICAgIHNjcm4gPSB4Zjg2X2NydGMt
PnNjcm47CiAgICAgZHJtX3F1ZXVlX3NlcSA9IHJhZGVvbl9kcm1fcXVldWVfYWxsb2MoeGY4Nl9j
cnRjLAotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
