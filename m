From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] fix GFX8 dmaframe scheme (v2)
Date: Mon, 29 Aug 2016 16:55:35 +0800
Message-ID: <1472460939-31571-1-git-send-email-Monk.Liu@amd.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <y>
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

cmViYXNlIHBhdGNoZXMgb24gbGF0ZXN0IHN0YWdpbmcwNC42CgpNb25rIExpdSAoNCk6CiAgZHJt
L2FtZGdwdTphZGQgc3dpdGNoIGJ1ZmZlciB0byBlbmQgb2YgQ1MgKHYyKQogIGRybS9hbWRncHU6
bmV3IG1ldGhvZCB0byBzeW5jIGNlJmRlCiAgZHJtL2FtZGdwdTpjaGFuZ2Ugam9iLT5jdHggZmll
bGQgbmFtZQogIGRybS9hbWRncHU6aW1wbGVtZW50IENPTlRFWFRfQ09OVFJPTAoKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8IDEzICsrKysrKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jICB8IDE0ICsrKysrKystCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyAgfCAyOCArKysrKysrKy0tLS0tLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjhfMC5jICAgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0KIDUgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0p
CgotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
