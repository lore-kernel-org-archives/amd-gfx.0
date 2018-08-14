From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] Unify to set pg/cg state when suspend/fini
Date: Tue, 14 Aug 2018 17:56:22 +0800
Message-ID: <1534240585-7557-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

VW5pZnkgdG8gc2V0IHBvd2VyIHVuZ2F0ZSBhbmQgY2xvY2sgdW5nYXRlIHN0YXRlIHdoZW4gc3Vz
cGVuZC9maW5pLgpKdXN0IGNvcnJlc3BvbmRpbmcgdG8gdGhlIHNlcXVlbmNlIG9mIHNldCBjZyBw
ZyBnYXRlIHN0YXRlIGluIGxhdGVfaW5pdC4KClRlc3RlZCBvbiBUb25nYS9SYXZlbihnZnggb2Zm
IGVuYWJsZWQvZGlzYWJsZWQpClMzIHRlc3Qgd2FzIHBhc3NlZCAzMCB0aW1lcy4KClJleCBaaHUg
KDMpOgogIGRybS9hbWRncHU6IFJlZmluZSBmdW5jdGlvbiBuYW1lIGFuZCBmdW5jdGlvbiBhcmdz
CiAgZHJtL2FtZGdwdTogU2V0IHBvd2VyIHVuZ2F0ZSBzdGF0ZSBiZWZvcmUgc3VzcGVuZC9maW5p
CiAgZHJtL2FtZGdwdTogU2V0IGNsb2NrIHVuZ2F0ZSBzdGF0ZSBiZWZvcmUgc3VzcGVuZC9maW5p
CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTA0ICsrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jICAgICAgfCAgIDQgLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMgICAgICB8ICAxOSArKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwg
ODcgZGVsZXRpb25zKC0pCgotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
