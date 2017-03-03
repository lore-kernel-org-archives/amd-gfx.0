From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 9/9] Don't call amdgpu_glamor_flush in
 drmmode_copy_fb
Date: Fri,  3 Mar 2017 18:07:45 +0900
Message-ID: <20170303090745.2254-9-michel@daenzer.net>
References: <20170303090745.2254-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170303090745.2254-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpBTURHUFVXaW5k
b3dFeHBvc3VyZXNfb25lc2hvdCB0YWtlcyBjYXJlIG9mIGl0LgoKKFBvcnRlZCBmcm9tIHJhZGVv
biBjb21taXQgZDYzODgxNjIzZjA2ODZhNjZhMmUzZTNjMWY4NGU0OTZhYTUyZWM2YikKClNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgotLS0KIHNy
Yy9kcm1tb2RlX2Rpc3BsYXkuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYyBiL3NyYy9kcm1tb2RlX2Rpc3Bs
YXkuYwppbmRleCA0MDZiNWVlZDYuLjJjZGVhOTBhZCAxMDA2NDQKLS0tIGEvc3JjL2RybW1vZGVf
ZGlzcGxheS5jCisrKyBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuYwpAQCAtNDI5LDggKzQyOSw2IEBA
IHZvaWQgZHJtbW9kZV9jb3B5X2ZiKFNjcm5JbmZvUHRyIHBTY3JuLCBkcm1tb2RlX3B0ciBkcm1t
b2RlKQogCiAJRnJlZVNjcmF0Y2hHQyhnYyk7CiAKLQlhbWRncHVfZ2xhbW9yX2ZpbmlzaChwU2Ny
bik7Ci0KIAlwU2NyZWVuLT5jYW5Eb0JHTm9uZVJvb3QgPSBUUlVFOwogCiAJaWYgKGluZm8tPmZi
Y29uX3BpeG1hcCkKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
