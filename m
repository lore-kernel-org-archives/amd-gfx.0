From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/13] drm/amd/display: Debug option to force enable ABM
Date: Tue, 31 Jan 2017 13:24:17 -0500
Message-ID: <20170131182420.14926-11-harry.wentland@amd.com>
References: <20170131182420.14926-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170131182420.14926-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Anthony Koo <anthony.koo-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzYzE3
OTcyZWRiMThlYmIzOTYyMWNhNTU5M2ZkZDQwMDUwMjUyYWZjClNpZ25lZC1vZmYtYnk6IEFudGhv
bnkgS29vIDxhbnRob255Lmtvb0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9u
eS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5k
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjLmgKaW5kZXggMTMwOGFmNTlkODM5Li5kN2Y4NDg0OTVkOGEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kYy5oCkBAIC0xNDMsNiArMTQzLDcgQEAgc3RydWN0IGRjX2RlYnVnIHsKIAli
b29sIGRpc2FibGVfZGZzX2J5cGFzczsKIAlib29sIGRpc2FibGVfY2xvY2tfZ2F0ZTsKIAlib29s
IGRpc2FibGVfZG1jdTsKKwlib29sIGZvcmNlX2FibV9lbmFibGU7CiB9OwogCiBzdHJ1Y3QgZGMg
ewotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
