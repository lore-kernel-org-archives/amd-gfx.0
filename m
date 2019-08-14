From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/amd/powerplay: Fix meaning of 0x1E PPSMC_MSG
Date: Wed, 14 Aug 2019 15:53:32 -0400
Message-ID: <1565812414-26117-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1565812414-26117-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565812414-26117-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, evan.quan-5C7GfCeVMHo@public.gmane.org, Shirish.S-5C7GfCeVMHo@public.gmane.org

QnkgY29tcGFyaW5nIHRvIHdpbmRvd3MgaXQgbWVhbnMgQVNJQyByZXNldC4KClNpZ25lZC1vZmYt
Ynk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9ydl9wcHNtYy5oIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3J2X3Bwc21jLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvcnZfcHBzbWMuaAppbmRleCA5MDg3OWU0Li5kZjQ2NzdkIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvcnZfcHBzbWMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvcnZfcHBzbWMuaApAQCAtNTks
NyArNTksNyBAQAogI2RlZmluZSBQUFNNQ19NU0dfU2V0RHJpdmVyRHJhbUFkZHJMb3cgICAgICAg
ICAgMHgxQgogI2RlZmluZSBQUFNNQ19NU0dfVHJhbnNmZXJUYWJsZVNtdTJEcmFtICAgICAgICAg
MHgxQwogI2RlZmluZSBQUFNNQ19NU0dfVHJhbnNmZXJUYWJsZURyYW0yU211ICAgICAgICAgMHgx
RAotI2RlZmluZSBQUFNNQ19NU0dfQ29udHJvbEdmeFJNICAgICAgICAgICAgICAgICAgMHgxRQor
I2RlZmluZSBQUFNNQ19NU0dfRGV2aWNlRHJpdmVyUmVzZXQgICAgICAgICAgICAgMHgxRQogI2Rl
ZmluZSBQUFNNQ19NU0dfU2V0R2Z4Y2xrT3ZlcmRyaXZlQnlGcmVxVmlkICAgMHgxRgogI2RlZmlu
ZSBQUFNNQ19NU0dfU2V0SGFyZE1pbkRjZWZjbGtCeUZyZXEgICAgICAgMHgyMAogI2RlZmluZSBQ
UFNNQ19NU0dfU2V0SGFyZE1pblNvY2Nsa0J5RnJlcSAgICAgICAgMHgyMQotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
