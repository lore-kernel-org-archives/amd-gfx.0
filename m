From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Add dpm quirk for Jet PRO
Date: Tue, 21 Nov 2017 12:13:57 -0500
Message-ID: <20171121171357.4819-2-alexander.deucher@amd.com>
References: <20171121171357.4819-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171121171357.4819-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

Rml4ZXMgc3RhYmlsaXR5IGlzc3Vlcy4KCkJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MTAzMzcwClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
aV9kcG0uYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCmluZGV4IDI5OWNiMzE2MWIyYy4uMWYzNDE3MjI4MzBl
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAtMzQ2NCw2ICszNDY0LDExIEBA
IHN0YXRpYyB2b2lkIHNpX2FwcGx5X3N0YXRlX2FkanVzdF9ydWxlcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKIAkJICAgIChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2NjY3KSkgewogCQkJ
bWF4X3NjbGsgPSA3NTAwMDsKIAkJfQorCQlpZiAoKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4
QzMpIHx8CisJCSAgICAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NjY2NSkpIHsKKwkJCW1heF9z
Y2xrID0gNjUwMDA7CisJCQltYXhfbWNsayA9IDgwMDAwOworCQl9CiAJfSBlbHNlIGlmIChhZGV2
LT5hc2ljX3R5cGUgPT0gQ0hJUF9PTEFORCkgewogCQlpZiAoKGFkZXYtPnBkZXYtPnJldmlzaW9u
ID09IDB4QzcpIHx8CiAJCSAgICAoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHg4MCkgfHwKLS0g
CjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
