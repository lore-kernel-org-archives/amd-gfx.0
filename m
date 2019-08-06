From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 3/3] amdgpu: add umc ras eject test configuration
Date: Tue, 6 Aug 2019 15:36:29 +0800
Message-ID: <20190806073629.10976-4-guchun.chen@amd.com>
References: <20190806073629.10976-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190806073629.10976-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, Xinhui.Pan-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Dennis Li <dennis.li-5C7GfCeVMHo@public.gmane.org>, Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzc5ZjJmNGY1OWM2OWZiMDhmZGMwOWI3YWRiYTViMzZlM2FmMjBjZQpTaWdu
ZWQtb2ZmLWJ5OiBEZW5uaXMgTGkgPGRlbm5pcy5saUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBH
dWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KLS0tCiBkYXRhL2FtZGdwdV9yYXMuanNv
biB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZGF0YS9hbWRncHVfcmFzLmpzb24gYi9kYXRhL2FtZGdwdV9yYXMuanNvbgppbmRl
eCAwODYzYTE4Mi4uM2QwOTA5OTQgMTAwNjQ0Ci0tLSBhL2RhdGEvYW1kZ3B1X3Jhcy5qc29uCisr
KyBiL2RhdGEvYW1kZ3B1X3Jhcy5qc29uCkBAIC0xLDYgKzEsOSBAQAogewogICAgICJ2ZXJzaW9u
IjogIjAuMC4xIiwKICAgICAiYmxvY2siOiB7CisgICAgICAgICJ1bWMiOiB7CisgICAgICAgICAg
ICAiaW5kZXgiOiAwCisgICAgICAgIH0sCiAgICAgICAgICJnZngiOiB7CiAgICAgICAgICAgICAi
aW5kZXgiOiAyLAogICAgICAgICAgICAgInN1YmJsb2NrIjogewpAQCAtMTI2LDYgKzEyOSwxMyBA
QAogICAgICAgICAicG9pc29uIjogOAogICAgIH0sCiAgICAgInRlc3RzIjogWworICAgICAgICB7
CisgICAgICAgICAgICAibmFtZSI6ICJyYXNfdW1jLjEuMCIsCisgICAgICAgICAgICAiYmxvY2si
OiAidW1jIiwKKyAgICAgICAgICAgICJ0eXBlIjogInNpbmdsZV9jb3JyZWN0YWJsZSIsCisgICAg
ICAgICAgICAiYWRkcmVzcyI6IDAsCisgICAgICAgICAgICAidmFsdWUiOiAwCisgICAgICAgIH0s
CiAgICAgICAgIHsKICAgICAgICAgICAgICJuYW1lIjogInJhc19nZnguMi4xIiwKICAgICAgICAg
ICAgICJibG9jayI6ICJnZngiLAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
