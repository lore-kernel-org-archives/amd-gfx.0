From: rex zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/display: Ctrl stutter mode through module
 parameter
Date: Wed, 27 Jun 2018 18:25:29 +0800
Message-ID: <1530095129-26916-2-git-send-email-rex.zhu@amd.com>
References: <1530095129-26916-1-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1530095129-26916-1-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

dXNlIHBwZmVhdHVyZW1hc2sgdG8gZW5hYmxlL2Rpc2FibGUgc3R1dHRlciBtb2RlLgoKU2lnbmVk
LW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCBkMzk5Zjc2Li4wMWQxNGQ4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMKQEAgLTE1MzEsNyArMTUzMSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2luaXRpYWxpemVf
ZHJtX2RldmljZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJLyoKIAkJICogVGVtcG9y
YXJ5IGRpc2FibGUgdW50aWwgcHBsaWIvc211IGludGVyYWN0aW9uIGlzIGltcGxlbWVudGVkCiAJ
CSAqLwotCQlkbS0+ZGMtPmRlYnVnLmRpc2FibGVfc3R1dHRlciA9IHRydWU7CisJCWRtLT5kYy0+
ZGVidWcuZGlzYWJsZV9zdHV0dGVyID0gYW1kZ3B1X3BwX2ZlYXR1cmVfbWFzayAmIFBQX1NUVVRU
RVJfTU9ERSA/IGZhbHNlIDogdHJ1ZTsKIAkJYnJlYWs7CiAjZW5kaWYKIAlkZWZhdWx0OgotLSAK
MS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
