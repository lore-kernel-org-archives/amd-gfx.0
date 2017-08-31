From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/77] drm/amd/display: Leave DCN config guard around fpu
 header
Date: Thu, 31 Aug 2017 14:08:08 -0400
Message-ID: <20170831180912.5898-14-harry.wentland@amd.com>
References: <20170831180912.5898-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831180912.5898-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2VlCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE3
LUF1Z3VzdC8xNDk5MzguaHRtbAoKU2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5
LndlbnRsYW5kQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKb3JkYW4gTGF6YXJlIDxKb3JkYW4uTGF6
YXJlQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaCB8
IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlcy5oCmluZGV4IGE3ZDY2MWQxZmYxZC4uZTliZjRj
NDE3Y2M3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2Vy
dmljZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMu
aApAQCAtNzUsNyArNzUsOSBAQAogCUJSRUFLX1RPX0RFQlVHR0VSKCk7IFwKIH0gd2hpbGUgKDAp
CiAKKyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMCkKICNpbmNsdWRlIDxhc20v
ZnB1L2FwaS5oPgorI2VuZGlmCiAKICNkZWZpbmUgZG1fYWxsb2Moc2l6ZSkga3phbGxvYyhzaXpl
LCBHRlBfS0VSTkVMKQogI2RlZmluZSBkbV9yZWFsbG9jKHB0ciwgc2l6ZSkga3JlYWxsb2MocHRy
LCBzaXplLCBHRlBfS0VSTkVMKQotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
