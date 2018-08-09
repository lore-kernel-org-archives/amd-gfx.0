From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/5] drm/amdgpu:add new firmware id for VCN
Date: Thu,  9 Aug 2018 12:31:40 -0400
Message-ID: <1533832302-21440-3-git-send-email-James.Zhu@amd.com>
References: <1533832302-21440-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533832302-21440-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Likun.Gao-5C7GfCeVMHo@public.gmane.org, james.zhu-5C7GfCeVMHo@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org

RnJvbTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KCkFkZCB0aGUgbmV3IGZpcm13YXJl
IGlkIGZvciBWQ04gaW50byB0aGUgZW51bQoKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1l
cy5aaHVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUu
aCB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaAppbmRleCBlOWQ2NGU3Li5hMWVkYzcwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaApAQCAtMTk0LDYgKzE5NCw3IEBA
IGVudW0gQU1ER1BVX1VDT0RFX0lEIHsKIAlBTURHUFVfVUNPREVfSURfU01DLAogCUFNREdQVV9V
Q09ERV9JRF9VVkQsCiAJQU1ER1BVX1VDT0RFX0lEX1ZDRSwKKwlBTURHUFVfVUNPREVfSURfVkNO
LAogCUFNREdQVV9VQ09ERV9JRF9NQVhJTVVNLAogfTsKIAotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
