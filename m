From: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: keep stolen memory on picasso
Date: Fri, 17 May 2019 03:48:21 +0000
Message-ID: <1558064879-32517-1-git-send-email-flora.cui@amd.com>
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
Cc: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

b3RoZXJ3aXNlIHNjcmVlbiBjb3JydXB0cyBkdXJpbmcgbW9kcHJvYmUuDQoNCkNoYW5nZS1JZDog
STczYmNmM2FiMGM2NjYwNzdkZmU4NTQzNmEzNDU3YTAzNzkzODIzMDQNClNpZ25lZC1vZmYtYnk6
IEZsb3JhIEN1aSA8ZmxvcmEuY3VpQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KaW5kZXggYzIyMTU3MC4uNWFm
YmI1OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCkBAIC02MjYsNiAr
NjI2LDcgQEAgc3RhdGljIGJvb2wgZ21jX3Y5XzBfa2VlcF9zdG9sZW5fbWVtb3J5KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KIAljYXNlIENISVBfVkVHQTEwOg0KIAkJcmV0dXJuIHRydWU7
DQogCWNhc2UgQ0hJUF9SQVZFTjoNCisJCXJldHVybiAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4
MTVkOCk7DQogCWNhc2UgQ0hJUF9WRUdBMTI6DQogCWNhc2UgQ0hJUF9WRUdBMjA6DQogCWRlZmF1
bHQ6DQotLSANCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
