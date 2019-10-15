From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] Fixed amdgpu resume failure from suspend
Date: Tue, 15 Oct 2019 22:08:06 +0000
Message-ID: <1571177279-9435-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>

VVZEIHNlc3Npb24gaW5mbyBzaXplIGNhbiBiZSB1cHRvIDEyOEssIHdlIG5lZWQgdG8gYWxsb2Nh
dGUgYSBsYXJnZQplbm91Z2ggYnVmZmVyIGZvciB0aGUgc2Vzc2lvbiBpbmZvLCBvdGhlcndpc2Ug
dGhlIElCIHRlc3QgY2FuIG92ZXJ3cml0ZQpvdGhlcidzIG1lbW9yeS4KCkJ1ZzogaHR0cHM6Ly9i
dWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDQyNDEKCkphbWVzIFpodSAoMyk6
CiAgZHJtL2FtZGdwdS91dmQ6QWRkIHV2ZCBlbmMgc2Vzc2lvbiBibwogIGRybS9hbWRncHUvdXZk
OkFsbG9jYXRlIGVuYyBzZXNzaW9uIGJvIGZvciB1dmQ2LjAgcmluZyBJQiB0ZXN0CiAgZHJtL2Ft
ZGdwdS91dmQ6QWxsb2NhdGUgZW5jIHNlc3Npb24gYm8gZm9yIHV2ZDcuMCByaW5nIElCIHRlc3QK
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmggfCAgNCArKysrCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jICAgfCAxNiArKysrKysrKysrKysrKy0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jICAgfCAxNiArKysrKysrKysr
KysrKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
