From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 34/73] drm/amd/display: Add transfer function to
 dc_surface_update
Date: Thu, 9 Nov 2017 15:05:30 -0500
Message-ID: <20171109200609.14566-35-harry.wentland@amd.com>
References: <20171109200609.14566-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109200609.14566-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: SivapiriyanKumarasamy <sivapiriyan.kumarasamy-5C7GfCeVMHo@public.gmane.org>

RnJvbTogU2l2YXBpcml5YW5LdW1hcmFzYW15IDxzaXZhcGlyaXlhbi5rdW1hcmFzYW15QGFtZC5j
b20+CgpDaGFuZ2UtSWQ6IEljNDJiZTRlMDAzM2RiOGQ0MDJmNTY4OGFlZjdjM2NlYTZmN2UwMTE5
ClNpZ25lZC1vZmYtYnk6IFNpdmFwaXJpeWFuS3VtYXJhc2FteSA8c2l2YXBpcml5YW4ua3VtYXJh
c2FteUBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29t
PgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCA4
NmE5YzkyN2EzMTIuLmFjYjM2NTk0YWNjMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmgKQEAgLTQ3NSw2ICs0NzUsOCBAQCBzdHJ1Y3QgZGNfc3VyZmFjZV91cGRhdGUgewogCSAqLwog
CS8qIGdhbW1hIFRPIEJFIFJFTU9WRUQgKi8KIAlzdHJ1Y3QgZGNfZ2FtbWEgKmdhbW1hOworCWVu
dW0gY29sb3JfdHJhbnNmZXJfZnVuYyBjb2xvcl9pbnB1dF90ZjsKKwllbnVtIGNvbG9yX3RyYW5z
ZmVyX2Z1bmMgY29sb3Jfb3V0cHV0X3RmOwogCXN0cnVjdCBkY190cmFuc2Zlcl9mdW5jICppbl90
cmFuc2Zlcl9mdW5jOwogCiAJc3RydWN0IGNzY190cmFuc2Zvcm0gKmlucHV0X2NzY19jb2xvcl9t
YXRyaXg7Ci0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
