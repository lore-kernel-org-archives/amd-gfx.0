From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/45] drm/amd/display: Add a PP_SMU_VER_MAX enum
Date: Tue, 11 Dec 2018 17:57:08 -0500
Message-ID: <1544569071-7114-3-git-send-email-sunpeng.li@amd.com>
References: <1544569071-7114-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544569071-7114-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Jun Lei <Jun.Lei-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgoKU2lnbmVkLW9mZi1ieTogSnVuIExlaSA8
SnVuLkxlaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogTmV2ZW5rbyBTdHVwYXIgPE5ldmVua28uU3R1
cGFyQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fcHBfc211LmggfCAzICsrLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9wcF9zbXUuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbV9wcF9zbXUuaAppbmRleCAwMDI5YTM5Li4xNGJlZDViIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fcHBfc211LmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3BwX3NtdS5oCkBAIC0zOCw3ICszOCw4
IEBAIGVudW0gcHBfc211X3ZlciB7CiAJICogb2YgaW50ZXJmYWNlIHNoYXJpbmcgYmV0d2VlbiBm
YW1pbGllcyBvZiBBU0ljcy4KIAkgKi8KIAlQUF9TTVVfVU5TVVBQT1JURUQsCi0JUFBfU01VX1ZF
Ul9SVgorCVBQX1NNVV9WRVJfUlYsCisJUFBfU01VX1ZFUl9NQVgKIH07CiAKIHN0cnVjdCBwcF9z
bXUgewotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
