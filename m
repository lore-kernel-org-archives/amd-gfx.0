From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 31/57] drm/amd/display: Add Vega20 config. support
Date: Tue, 15 May 2018 09:59:07 -0500
Message-ID: <20180515145933.12063-32-alexander.deucher@amd.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180515145933.12063-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

RnJvbTogIkplcnJ5IChGYW5nemhpKSBadW8iIDxKZXJyeS5adW9AYW1kLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IEplcnJ5IChGYW5nemhpKSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+ClJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvS2NvbmZpZyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L0tj
b25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvS2NvbmZpZwppbmRleCBlNmNhNzJj
MGQzNDcuLjZkY2VjOWM5MTI2YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L0tjb25maWcKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L0tjb25maWcKQEAg
LTQwLDQgKzQwLDEzIEBAIGNvbmZpZyBEUk1fQU1EX0RDX1ZFR0FNCiAgICAgICAgIGhlbHAKICAg
ICAgICAgIENob29zZSB0aGlzIG9wdGlvbiBpZiB5b3Ugd2FudCB0byBoYXZlCiAgICAgICAgICBW
RUdBTSBzdXBwb3J0IGZvciBkaXNwbGF5IGVuZ2luZQorCitjb25maWcgRFJNX0FNRF9EQ19WRzIw
CisJYm9vbCAiVmVnYTIwIHN1cHBvcnQiCisJZGVwZW5kcyBvbiBEUk1fQU1EX0RDCisJaGVscAor
CQlDaG9vc2UgdGhpcyBvcHRpb24gaWYgeW91IHdhbnQgdG8gaGF2ZQorCQlWZWdhMjAgc3VwcG9y
dCBmb3IgZGlzcGxheSBlbmdpbmUKKworCiBlbmRtZW51Ci0tIAoyLjEzLjYKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
