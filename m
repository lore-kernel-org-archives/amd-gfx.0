From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/15] drm/amd/display: rename bandwidth_calcs.c to dce_calcs.c
Date: Tue, 28 Feb 2017 19:26:06 -0500
Message-ID: <20170301002620.24595-2-harry.wentland@amd.com>
References: <20170301002620.24595-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170301002620.24595-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KCkNo
YW5nZS1JZDogSTc4YWNmM2Q3MWQ3ZDNjZDgzOGFkMGQzNTVkMGYxNmM5ZjBkMDg2ZjEKU2lnbmVk
LW9mZi1ieTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4K
QWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgpSZXZpZXdl
ZC1ieTogRWFnbGUgWWVoIDxlYWdsZS55ZWhAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY2FsY3Mve2JhbmR3aWR0aF9jYWxjcy5jID0+IGRjZV9jYWxjcy5jfSB8
IDAKIDEgZmlsZSBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiByZW5h
bWUgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL3tiYW5kd2lkdGhfY2FsY3Mu
YyA9PiBkY2VfY2FsY3MuY30gKDEwMCUpCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NhbGNzL2JhbmR3aWR0aF9jYWxjcy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5h
bWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvYmFuZHdpZHRoX2Nh
bGNzLmMKcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2Vf
Y2FsY3MuYwotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
