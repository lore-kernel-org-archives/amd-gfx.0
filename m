From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 15/15] drm/amd/display: fix dce100_validate_bandwidth return
 value
Date: Tue, 28 Feb 2017 19:26:20 -0500
Message-ID: <20170301002620.24595-16-harry.wentland@amd.com>
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
YW5nZS1JZDogSTVkZWU0MzNkODYwMThiZDkyMWY1YzJjMmE5ODZmZjk2NDJmMTEzOWMKU2lnbmVk
LW9mZi1ieTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJj
ZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2Ux
MDBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvZGNl
MTAwX3Jlc291cmNlLmMKaW5kZXggZmM4NWVmYWZiMTA0Li5jNzI4NThhMTQ1MmYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNl
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVz
b3VyY2UuYwpAQCAtNzcyLDcgKzc3Miw3IEBAIGJvb2wgZGNlMTAwX3ZhbGlkYXRlX2JhbmR3aWR0
aCgKIAkvKiBUT0RPIGltcGxlbWVudCB3aGVuIG5lZWRlZCBidXQgZm9yIG5vdyBoYXJkY29kZSBt
YXggdmFsdWUqLwogCWNvbnRleHQtPmRpc3BjbGtfa2h6ID0gNjgxMDAwOwogCi0JcmV0dXJuIGZh
bHNlOworCXJldHVybiB0cnVlOwogfQogCiBzdGF0aWMgYm9vbCBkY2UxMDBfdmFsaWRhdGVfc3Vy
ZmFjZV9zZXRzKAotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
