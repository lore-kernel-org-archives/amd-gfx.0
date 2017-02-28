From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 3/3] present: Flush before flipping
Date: Tue, 28 Feb 2017 18:20:14 +0900
Message-ID: <20170228092014.27004-3-michel@daenzer.net>
References: <20170228092014.27004-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170228092014.27004-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIGlzbid0
IG5lY2Vzc2FyeSBmb3IgRFJJIGNsaWVudHMsIGJ1dCB0aGUgUHJlc2VudCBleHRlbnNpb24gY2Fu
IGFsc28KYmUgdXNlZCBmb3IgcHJlc2VudGluZyBub3JtYWwgcGl4bWFwcyByZW5kZXJlZCB0byB2
aWEgdGhlIFgxMSBwcm90b2NvbC4KClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNo
ZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9yYWRlb25fcHJlc2VudC5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRlb25fcHJl
c2VudC5jIGIvc3JjL3JhZGVvbl9wcmVzZW50LmMKaW5kZXggMDE0MDlmZmFjLi5hZjU1ZTQ2MmYg
MTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fcHJlc2VudC5jCisrKyBiL3NyYy9yYWRlb25fcHJlc2Vu
dC5jCkBAIC0zNDcsNiArMzQ3LDggQEAgcmFkZW9uX3ByZXNlbnRfZmxpcChSUkNydGNQdHIgY3J0
YywgdWludDY0X3QgZXZlbnRfaWQsIHVpbnQ2NF90IHRhcmdldF9tc2MsCiAKICAgICBldmVudC0+
ZXZlbnRfaWQgPSBldmVudF9pZDsKIAorICAgIHJhZGVvbl9jc19mbHVzaF9pbmRpcmVjdChzY3Ju
KTsKKwogICAgIHJldCA9IHJhZGVvbl9kb19wYWdlZmxpcChzY3JuLCBSQURFT05fRFJNX1FVRVVF
X0NMSUVOVF9ERUZBVUxULCBoYW5kbGUsCiAJCQkgICAgIGV2ZW50X2lkLCBldmVudCwgY3J0Y19p
ZCwKIAkJCSAgICAgcmFkZW9uX3ByZXNlbnRfZmxpcF9ldmVudCwKLS0gCjIuMTEuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
