From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/2] fix dma frame of GFX8
Date: Thu, 25 Aug 2016 13:58:13 +0800
Message-ID: <1472104695-2177-1-git-send-email-Monk.Liu@amd.com>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

b3JpZ2luYWwgU1dJVENIX0JVRkZFUiBzY2hlbWUgZm9yIEdGWDggZG9lc24ndCBzdXBwb3J0IHZp
cnR1YWxpemF0aW9uLCBhbmQKaXQgZ2l2ZSB3b3JzZSBwZXJmb3JtYW5jZSwgbm93IHdlIHVzZSB0
aGUgY2xhc3NpYyBzY2hlbWUgdG8gc3VwcG9ydCAKdmlydHVhbGl6YXRpb24gYW5kIGdhaW4gbW9y
ZSBwZXJmb3JtYW5jZSBieSBvbmx5IGluc2VydGluZyBvbmUgU1dJVENIX0JVRkZFUgphdCB0aGUg
Ym90dG9tIG9mIGVhY2ggY29tbWFuZCBzdWJtaXQsIGFuZCBkb2luZyB0aGlzIHJlcXVpcmVzIDEy
OGR3IE5PUCBpbnNlcnRlZAphZnRlciBWTSBmbHVzaCBhcyB3ZWxsIHRvIHByZXZlbnQgQ0UgdHJp
Z2dlciB2bSBmYXVsdCBiZWZvcmUgRGUgdm1fZmx1c2ggZG9uZS4KCm5vdyAyNTYgZHcgZm9yIGVh
Y2ggY29tbWFuZCBzdWJtaXQgaXMgZW5vdWdoLgoKTW9uayBMaXUgKDIpOgogIGRybS9hbWRncHU6
Zml4IGdmeCBpYiBzY2hlZHVsZQogIGRybS9hbWRncHU6MjU2ZHcgaXMgZW5vdWdoIGZvciBvbmUg
aWJfc2NoZWR1bGUKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICB8ICAy
ICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDEwICsrKysrKysr
Ky0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgIHwgMjggKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkKCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
