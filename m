From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 21/35] drm/amd/display: Add DCN_VM aperture registers
Date: Wed, 13 Feb 2019 15:05:37 -0500
Message-ID: <1550088351-19449-22-git-send-email-sunpeng.li@amd.com>
References: <1550088351-19449-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1550088351-19449-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eryk Brol <eryk.brol-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJ5ayBCcm9sIDxlcnlrLmJyb2xAYW1kLmNvbT4KCltXaHldCkZvciBsYXRlciB1c2Ug
YnkgdGhlIERDIFZNIGltcGxlbWVudGF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBFcnlrIEJyb2wgPGVy
eWsuYnJvbEBhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgpB
Y2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h1YnAuaCB8IDMgKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjEwL2RjbjEwX2h1YnAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24xMC9kY24xMF9odWJwLmgKaW5kZXggYTZkNmRmZS4uMzI2OGFiMCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h1YnAuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHVicC5oCkBAIC01OTUs
NiArNTk1LDkgQEAKIAl0eXBlIEFHUF9CQVNFO1wKIAl0eXBlIEFHUF9CT1Q7XAogCXR5cGUgQUdQ
X1RPUDtcCisJdHlwZSBEQ05fVk1fU1lTVEVNX0FQRVJUVVJFX0RFRkFVTFRfU1lTVEVNO1wKKwl0
eXBlIERDTl9WTV9TWVNURU1fQVBFUlRVUkVfREVGQVVMVF9BRERSX01TQjtcCisJdHlwZSBEQ05f
Vk1fU1lTVEVNX0FQRVJUVVJFX0RFRkFVTFRfQUREUl9MU0I7XAogCS8qIHRvZG86ICBnZXQgdGhl
c2UgZnJvbSBHVk0gaW5zdGVhZCBvZiByZWFkaW5nIHJlZ2lzdGVycyBvdXJzZWx2ZXMgKi9cCiAJ
dHlwZSBQQUdFX0RJUkVDVE9SWV9FTlRSWV9ISTMyO1wKIAl0eXBlIFBBR0VfRElSRUNUT1JZX0VO
VFJZX0xPMzI7XAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
