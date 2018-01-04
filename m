From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Add dpm quirk for Jet PRO (v2)
Date: Thu,  4 Jan 2018 17:03:41 -0500
Message-ID: <20180104220342.30645-2-alexander.deucher@amd.com>
References: <20180104220342.30645-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180104220342.30645-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Rml4ZXMgc3RhYmlsaXR5IGlzc3Vlcy4KCnYyOiBjbGFtcCBzY2xrIHRvIDYwMCBNaHoKCkJ1Zzog
aHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTAzMzcwClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyB8IDUgKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCmluZGV4
IDI5OWNiMzE2MWIyYy4uY2U2NzVhN2YxNzlhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zaV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9k
cG0uYwpAQCAtMzQ2NCw2ICszNDY0LDExIEBAIHN0YXRpYyB2b2lkIHNpX2FwcGx5X3N0YXRlX2Fk
anVzdF9ydWxlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJICAgIChhZGV2LT5wZGV2
LT5kZXZpY2UgPT0gMHg2NjY3KSkgewogCQkJbWF4X3NjbGsgPSA3NTAwMDsKIAkJfQorCQlpZiAo
KGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzMpIHx8CisJCSAgICAoYWRldi0+cGRldi0+ZGV2
aWNlID09IDB4NjY2NSkpIHsKKwkJCW1heF9zY2xrID0gNjAwMDA7CisJCQltYXhfbWNsayA9IDgw
MDAwOworCQl9CiAJfSBlbHNlIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9PTEFORCkgewog
CQlpZiAoKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzcpIHx8CiAJCSAgICAoYWRldi0+cGRl
di0+cmV2aXNpb24gPT0gMHg4MCkgfHwKLS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
