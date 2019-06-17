From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 109/459] drm/amdgpu: add pa_sc_tile_steering_override to
 drm_amdgpu_info_device
Date: Mon, 17 Jun 2019 14:11:10 -0500
Message-ID: <20190617191700.17899-98-alexander.deucher@amd.com>
References: <20190617191700.17899-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617191700.17899-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKdGhlIGluaXRpYWwv
ZGVmYXVsdCB2YWx1ZSBvZiBwYV9zY190aWxlX3N0ZWVyaW5nX292ZXJyaWRlIG5lZWQgdG8KYmUg
ZXhwb3NlZCB0byB1c2VyIG1vZGUgZHJpdmVyCgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8
IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5o
CmluZGV4IDM0NGMzNmU4OTkyMy4uNjE4NzA0NzhiYzljIDEwMDY0NAotLS0gYS9pbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaApA
QCAtOTk1LDYgKzk5NSw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fZGV2aWNlIHsKIAlfX3U2
NCBoaWdoX3ZhX29mZnNldDsKIAkvKiogVGhlIG1heGltdW0gaGlnaCB2aXJ0dWFsIGFkZHJlc3Mg
Ki8KIAlfX3U2NCBoaWdoX3ZhX21heDsKKwkvKiBnZngxMCBwYV9zY190aWxlX3N0ZWVyaW5nX292
ZXJyaWRlICovCisJX191MzIgcGFfc2NfdGlsZV9zdGVlcmluZ19vdmVycmlkZTsKIH07CiAKIHN0
cnVjdCBkcm1fYW1kZ3B1X2luZm9faHdfaXAgewotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
