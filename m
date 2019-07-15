From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 054/102] drm/amdgpu: Clear build undefined warning
Date: Mon, 15 Jul 2019 16:23:49 -0500
Message-ID: <20190715212437.31793-52-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KCkFkZCBhbWRncHVfYW1ka2ZkX2Fy
Y3R1cnVzX2dldF9mdW5jdGlvbnMgc3R1YiB3aGVuCkNPTkZJR19IU0FfQU1EIGlzIHVuZGVmaW5k
ZWQuCgpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgpSZXZpZXdl
ZC1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMK
aW5kZXggNzAyZDA1Y2UxZmE1Li5mMDUyYzcwZTQ2NTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKQEAgLTcxOCw2ICs3MTgsMTEgQEAgc3RydWN0IGtmZDJr
Z2RfY2FsbHMgKmFtZGdwdV9hbWRrZmRfZ2Z4XzlfMF9nZXRfZnVuY3Rpb25zKHZvaWQpCiAJcmV0
dXJuIE5VTEw7CiB9CiAKK3N0cnVjdCBrZmQya2dkX2NhbGxzICphbWRncHVfYW1ka2ZkX2FyY3R1
cnVzX2dldF9mdW5jdGlvbnModm9pZCkKK3sKKwlyZXR1cm4gTlVMTDsKK30KKwogc3RydWN0IGtm
ZDJrZ2RfY2FsbHMgKmFtZGdwdV9hbWRrZmRfZ2Z4XzEwXzBfZ2V0X2Z1bmN0aW9ucyh2b2lkKQog
ewogCXJldHVybiBOVUxMOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
