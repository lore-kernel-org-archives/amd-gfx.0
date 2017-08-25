From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH umr 2/2] Add SI/CIK to read_vram.
Date: Fri, 25 Aug 2017 08:55:45 -0400
Message-ID: <20170825125545.17117-2-tom.stdenis@amd.com>
References: <20170825125545.17117-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170825125545.17117-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VGVzdGVkIHdpdGggbXkgVGFoaXRpIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5p
cyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBzcmMvbGliL3JlYWRfdnJhbS5jIHwgMiArKwog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9saWIvcmVh
ZF92cmFtLmMgYi9zcmMvbGliL3JlYWRfdnJhbS5jCmluZGV4IGYyYzNhMTVjMjdmZS4uYzI1NGY1
YTJlNDA2IDEwMDY0NAotLS0gYS9zcmMvbGliL3JlYWRfdnJhbS5jCisrKyBiL3NyYy9saWIvcmVh
ZF92cmFtLmMKQEAgLTgxNSw2ICs4MTUsOCBAQCBpbnQgdW1yX3JlYWRfdnJhbShzdHJ1Y3QgdW1y
X2FzaWMgKmFzaWMsIHVpbnQzMl90IHZtaWQsIHVpbnQ2NF90IGFkZHJlc3MsIHVpbnQzMgogCX0K
IAogCXN3aXRjaCAoYXNpYy0+ZmFtaWx5KSB7CisJCWNhc2UgRkFNSUxZX1NJOgorCQljYXNlIEZB
TUlMWV9DSUs6CiAJCWNhc2UgRkFNSUxZX1ZJOgogCQkJcmV0dXJuIHVtcl9yZWFkX3ZyYW1fdmko
YXNpYywgdm1pZCwgYWRkcmVzcywgc2l6ZSwgZHN0KTsKIAkJY2FzZSBGQU1JTFlfUlY6Ci0tIAoy
LjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
