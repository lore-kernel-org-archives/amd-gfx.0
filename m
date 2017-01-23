From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/25] drm/amd/display: assert if mask is 0 in
 set_reg_field_value_ex
Date: Mon, 23 Jan 2017 09:35:56 -0500
Message-ID: <20170123143613.15441-9-harry.wentland@amd.com>
References: <20170123143613.15441-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170123143613.15441-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKLSAgbWFzayA9IDAgbWVhbnMg
c29tZXRoaW5nIGlzIHdyb25nIGluIGNhbGxlciBhbmQgbm8gcmVnaXN0ZXIgZmllbGQgd2lsbCBi
ZSB1cGRhdGVkCgpDaGFuZ2UtSWQ6IEliMzBjMjhjYTMwZjU3NGM3MDNjZDNiNmFjYzQyZTVhNDAx
YTlhZmYwClNpZ25lZC1vZmYtYnk6IFRvbnkgQ2hlbmcgPHRvbnkuY2hlbmdAYW1kLmNvbT4KUmV2
aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlcy5oIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kbV9zZXJ2aWNlcy5oCmluZGV4IDExYTBhYmZkMzQxOC4uMDUyYTQzYWYxYmQzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXMuaApAQCAtMTY1LDYgKzE2
NSw3IEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3Qgc2V0X3JlZ19maWVsZF92YWx1ZV9leCgKIAl1
aW50MzJfdCBtYXNrLAogCXVpbnQ4X3Qgc2hpZnQpCiB7CisJQVNTRVJUKG1hc2sgIT0gMCk7CiAJ
cmV0dXJuIChyZWdfdmFsdWUgJiB+bWFzaykgfCAobWFzayAmICh2YWx1ZSA8PCBzaGlmdCkpOwog
fQogCi0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
