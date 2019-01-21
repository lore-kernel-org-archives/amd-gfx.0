From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: change the max clock level to 16
Date: Mon, 21 Jan 2019 18:02:16 +0800
Message-ID: <20190121100216.29122-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Eagle.Yeh-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Harry.Wentland-5C7GfCeVMHo@public.gmane.org

QXMgdGhlIGdmeGNsayBmb3IgU01VMTEgY2FuIGhhdmUgYXQgbW9zdCAxNiBkaXNjcmV0ZSBsZXZl
bHMuCgpDaGFuZ2UtSWQ6IEkwYzZhOGRiOGY0MDIwNmEyNDAyODY0NzFjNmY3YjFmZmZlZjE1ZWEy
ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2VzX3R5cGVzLmggfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXNfdHlwZXMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBlcy5oCmluZGV4IDlhZmQz
NmEwMzFhOS4uNzcyMDA3MTFhYmJlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1fc2VydmljZXNfdHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1fc2VydmljZXNfdHlwZXMuaApAQCAtOTIsNyArOTIsNyBAQCBlbnVtIGRtX3Bw
X2Nsb2NrX3R5cGUgewogCShjbGtfdHlwZSkgPT0gRE1fUFBfQ0xPQ0tfVFlQRV9GQ0xLID8gIkYi
IDogXAogCSJJbnZhbGlkIgogCi0jZGVmaW5lIERNX1BQX01BWF9DTE9DS19MRVZFTFMgOAorI2Rl
ZmluZSBETV9QUF9NQVhfQ0xPQ0tfTEVWRUxTIDE2CiAKIHN0cnVjdCBkbV9wcF9jbG9ja19sZXZl
bHMgewogCXVpbnQzMl90IG51bV9sZXZlbHM7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
