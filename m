From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/13] drm/amdgpu:virt_init_setting invoke is missed!
Date: Fri, 24 Mar 2017 18:38:23 +0800
Message-ID: <1490351912-10122-5-git-send-email-Monk.Liu@amd.com>
References: <1490351912-10122-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490351912-10122-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

dGhpcyBtdXN0IGJlIGludm9rZWQgZHVyaW5nIGVhcmx5IGluaXQKCkNoYW5nZS1JZDogSTY4NzI2
ZGQzNjgyNTI1OTkxM2I0NzQ5M2JhMWU5YzQ2N2IzNjhkMGMKU2lnbmVkLW9mZi1ieTogTW9uayBM
aXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDdlNTRkOWRjLi40ZWJlOTRiIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTU1Myw2ICs1NTMsMTAgQEAgc3RhdGljIGludCBzb2MxNV9j
b21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCShhbWRncHVfaXBfYmxvY2tfbWFzayAm
ICgxIDw8IEFNRF9JUF9CTE9DS19UWVBFX1BTUCkpKQogCQlwc3BfZW5hYmxlZCA9IHRydWU7CiAK
KwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCWFtZGdwdV92aXJ0X2luaXRfc2V0dGlu
ZyhhZGV2KTsKKwl9CisKIAkvKgogCSAqIG5iaW8gbmVlZCBiZSB1c2VkIGZvciBib3RoIHNkbWEg
YW5kIGdmeDksIGJ1dCBvbmx5CiAJICogaW5pdGlhbGl6ZXMgb25jZQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
