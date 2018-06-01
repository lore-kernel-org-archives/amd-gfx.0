From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH 1/3] drm/amdgpu: Hook up documentation about memory domains
Date: Fri,  1 Jun 2018 12:54:05 +0200
Message-ID: <20180601105407.11123-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBEb2N1bWVu
dGF0aW9uL2dwdS9hbWRncHUucnN0IHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS5yc3QgYi9E
b2N1bWVudGF0aW9uL2dwdS9hbWRncHUucnN0CmluZGV4IGY1NTc4NjZmNjc4OC4uYWQzNzExZmQy
YTI4IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dwdS9hbWRncHUucnN0CisrKyBiL0RvY3Vt
ZW50YXRpb24vZ3B1L2FtZGdwdS5yc3QKQEAgLTEwLDYgKzEwLDE0IEBAIENvcmUgRHJpdmVyIElu
ZnJhc3RydWN0dXJlCiAKIFRoaXMgc2VjdGlvbiBjb3ZlcnMgY29yZSBkcml2ZXIgaW5mcmFzdHJ1
Y3R1cmUuCiAKKy4uIF9hbWRncHVfbWVtb3J5X2RvbWFpbnM6CisKK01lbW9yeSBEb21haW5zCist
LS0tLS0tLS0tLS0tLQorCisuLiBrZXJuZWwtZG9jOjogaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmgKKyAgIDpkb2M6IG1lbW9yeSBkb21haW5zCisKIFBSSU1FIEJ1ZmZlciBTaGFyaW5nCiAt
LS0tLS0tLS0tLS0tLS0tLS0tLQogCi0tIAoyLjE3LjAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
