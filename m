From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 26/31] drm/amd/display: Add mem_input header to non-DCN builds
Date: Fri, 12 May 2017 11:20:59 -0400
Message-ID: <20170512152104.5354-27-harry.wentland@amd.com>
References: <20170512152104.5354-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170512152104.5354-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMDQ0NmU3NzMzNGIxNDI4NzYxNGIyMWZlODQ3YWZlNDRlNGM1YmFjNApTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9pbmMvY29yZV90eXBlcy5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2luYy9jb3JlX3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvaW5jL2NvcmVfdHlwZXMuaAppbmRleCA1MmFjNmQxOWFkZWMuLjQ2YmQwMzE4ZTZiZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9jb3JlX3R5cGVz
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9jb3JlX3R5cGVzLmgK
QEAgLTMxLDggKzMxLDggQEAKICNpbmNsdWRlICJkY25fY2FsY3MuaCIKICNpbmNsdWRlICJkZGNf
c2VydmljZV90eXBlcy5oIgogI2luY2x1ZGUgImRjX2Jpb3NfdHlwZXMuaCIKLSNpZiBkZWZpbmVk
KENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMCkKICNpbmNsdWRlICJtZW1faW5wdXQuaCIKKyNpZiBk
ZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMCkKICNpbmNsdWRlICJtcGMuaCIKICNlbmRp
ZgogCi0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
