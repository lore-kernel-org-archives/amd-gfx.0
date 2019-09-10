From: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove duplicated header file include
Date: Tue, 10 Sep 2019 08:43:51 +0000
Message-ID: <20190910084333.10538-1-guchun.chen@amd.com>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

YW1kZ3B1X3Jhcy5oIGlzIGFscmVhZHkgaW5jbHVkZWQuCgpGaXhlczogYjE3MThkYSAoZG1yL2Ft
ZGdwdTogQXZvaWQgSFcgR1BVIHJlc2V0IGZvciBSQVMuKQoKQ2hhbmdlLUlkOiBJNGNmMWViNTM5
M2Q4MGM0MmI0MjZkYzFkZGZjNjk2ZTQ4NmEwMmM2ZgpTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hl
biA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YmlvX3Y3XzQuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4IGJmYTkxOTE5MGZiNC4uMmQxNzFiZjA3
YWQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYwpAQCAtMzAsNyArMzAs
NiBAQAogI2luY2x1ZGUgIm5iaW8vbmJpb183XzRfMF9zbW4uaCIKICNpbmNsdWRlICJpdnNyY2lk
L25iaW8vaXJxc3Jjc19uYmlmXzdfNC5oIgogI2luY2x1ZGUgPHVhcGkvbGludXgva2ZkX2lvY3Rs
Lmg+Ci0jaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgogCiAjZGVmaW5lIHNtbk5CSUZfTUdDR19DVFJM
X0xDTEsJMHgxMDEzYTIxYwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
