From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati] Include xf86Pci.h for DRICreatePCIBusID with
 xserver Git master
Date: Mon, 26 Jun 2017 18:58:56 +0900
Message-ID: <20170626095856.14464-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGUgZGVjbGFy
YXRpb24gaGFzIGJlZW4gbW92ZWQgdGhlcmUgZnJvbSBkcmkuaC4KClNpZ25lZC1vZmYtYnk6IE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNyYy9yYWRlb25fcHJv
YmUuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9zcmMvcmFkZW9uX3Byb2JlLmMgYi9zcmMvcmFkZW9uX3Byb2JlLmMKaW5kZXggYWFhY2Uy
YjVmLi4xOTI5NWYwMGMgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb25fcHJvYmUuYworKysgYi9zcmMv
cmFkZW9uX3Byb2JlLmMKQEAgLTQ4LDcgKzQ4LDEyIEBACiAjaW5jbHVkZSAieGY4Ni5oIgogCiAj
aW5jbHVkZSAieGY4NmRybU1vZGUuaCIKKworI2lmIFhPUkdfVkVSU0lPTl9DVVJSRU5UID49IFhP
UkdfVkVSU0lPTl9OVU1FUklDKDEsMTksOTksMSwwKQorI2luY2x1ZGUgPHhmODZQY2kuaD4KKyNl
bHNlCiAjaW5jbHVkZSAiZHJpLmgiCisjZW5kaWYKIAogI2lmIGRlZmluZWQoX19GcmVlQlNEX18p
IHx8IGRlZmluZWQoX19GcmVlQlNEX2tlcm5lbF9fKQogI2luY2x1ZGUgPHhmODZfT1Nwcm9jLmg+
Ci0tIAoyLjEzLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
