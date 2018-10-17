From: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 10/10] drm/amd/display: enable SI support in the Kconfig
 (v2)
Date: Wed, 17 Oct 2018 10:35:13 +0200
Message-ID: <20181017083513.20913-11-issor.oruam@gmail.com>
References: <20181017083513.20913-1-issor.oruam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181017083513.20913-1-issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org, ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org

Q09ORklHX0RSTV9BTURfRENfU0kgY29uZmlndXJhdGlvbiBvcHRpb24gaXMgYWRkZWQsIGRlZmF1
bHQgc2V0dGluZyBpcyBkaXNhYmxlZAoKKHYyKSBIYWluYW4gaXMgbm90IHN1cHBvcnRlZCwgZGVz
Y3JpcHRpb24gdXBkYXRlZCBhY2NvcmRpbmdseQotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9LY29uZmlnIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L0tjb25maWcKaW5kZXggMTNhNmNlOWM4ZTk0Li4zMmNk
YjJkYTYwM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmln
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnCkBAIC0yMSw2ICsyMSwx
NCBAQCBjb25maWcgRFJNX0FNRF9EQ19EQ04xXzAxCiAJaGVscAogCSAgUlYyIGZhbWlseSBmb3Ig
ZGlzcGxheSBlbmdpbmUKIAorY29uZmlnIERSTV9BTURfRENfU0kKKwlib29sICJBTUQgREMgc3Vw
cG9ydCBmb3IgU291dGhlcm4gSXNsYW5kcyBBU0lDcyIKKwlkZWZhdWx0IG4KKwloZWxwCisJICBD
aG9vc2UgdGhpcyBvcHRpb24gdG8gZW5hYmxlIG5ldyBBTUQgREMgc3VwcG9ydCBmb3IgU0kgYXNp
Y3MKKwkgIGJ5IGRlZmF1bHQuIFRoaXMgaW5jbHVkZXMgVGFoaXRpLCBQaXRjYWlybiwgQ2FwZSBW
ZXJkZSwgT2xhbmQuCisJICBIYWluYW4gaXMgbm90IHN1cHBvcnRlZCBieSBBTUQgREMgYW5kIGl0
IGhhcyBubyBwaHlzaWNhbCBEQ0U2LgorCiBjb25maWcgREVCVUdfS0VSTkVMX0RDCiAJYm9vbCAi
RW5hYmxlIGtnZGIgYnJlYWsgaW4gREMiCiAJZGVwZW5kcyBvbiBEUk1fQU1EX0RDCi0tIAoyLjE3
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
