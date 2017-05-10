From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 117/117] drm/amdgpu: add RAVEN pci id
Date: Wed, 10 May 2017 14:47:48 -0400
Message-ID: <1494442068-8202-110-git-send-email-alexander.deucher@amd.com>
References: <1494442068-8202-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494442068-8202-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KCkFkZCB0aGUgUkFWRU4g
cGNpIGlkLgoKU2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jCmluZGV4IDIyMTFjZDguLjgyNzk2ZWRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jCkBAIC00NjUsNiArNDY1LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkIHBjaWlkbGlzdFtdID0gewogCXsweDEwMDIsIDB4Njg2OCwgUENJX0FOWV9J
RCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9WRUdBMTB9LAogCXsweDEwMDIsIDB4Njg2YywgUENJ
X0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9WRUdBMTB9LAogCXsweDEwMDIsIDB4Njg3
ZiwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9WRUdBMTB9LAorCS8qIFJhdmVu
ICovCisJezB4MTAwMiwgMHgxNWRkLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQ
X1JBVkVOfEFNRF9JU19BUFV9LAorCiAJezAsIDAsIDB9CiB9OwogCi0tIAoyLjUuNQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
