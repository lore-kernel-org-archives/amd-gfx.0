From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdkfd: initialize mqd_manager_init function for
 navi10
Date: Tue, 18 Jun 2019 12:39:14 +0800
Message-ID: <1560832754-4482-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

Q2hhbmdlLUlkOiBJNDNjNTA3Njk1NTdhOWJlOTMyODkxZTkyM2Y2NjlmNzk5M2VlZWRmOQpTaWdu
ZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyX3YxMC5jIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXJfdjEwLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXJfdjEwLmMKaW5k
ZXggYWRiMzg4NS4uNzJlNGQ2MWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlcl92MTAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXJfdjEwLmMKQEAgLTM2LDYgKzM2LDcg
QEAgdm9pZCBkZXZpY2VfcXVldWVfbWFuYWdlcl9pbml0X3YxMF9uYXZpMTAoCiB7CiAJYXNpY19v
cHMtPnVwZGF0ZV9xcGQgPSB1cGRhdGVfcXBkX3YxMDsKIAlhc2ljX29wcy0+aW5pdF9zZG1hX3Zt
ID0gaW5pdF9zZG1hX3ZtX3YxMDsKKwlhc2ljX29wcy0+bXFkX21hbmFnZXJfaW5pdCA9IG1xZF9t
YW5hZ2VyX2luaXRfdjEwOwogfQogCiBzdGF0aWMgdWludDMyX3QgY29tcHV0ZV9zaF9tZW1fYmFz
ZXNfNjRiaXQoc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkKQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
