From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdkfd: NULL dereference involving create_process()
Date: Wed, 14 Jun 2017 13:58:53 +0300
Message-ID: <20170614105853.GP29394@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYWNjaWRlbnRhbGx5IHJldHVybiBFUlJfUFRSKDApIHdoaWNoIGlzIE5VTEwuICBUaGUgY2Fs
bGVyIGlzIG5vdApleHBlY3RpbmcgdGhhdCBhbmQgaXQgbGVhZHMgdG8gYW4gT29wcy4KCkZpeGVz
OiBkZDU5MjM5YTk4NjIgKCJhbWRrZmQ6IGluaXQgYXBlcnR1cmUgb25jZSBwZXIgcHJvY2VzcyIp
ClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4K
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwppbmRleCA4NGQxZmZkMWVl
ZjkuLjExOTBkMDY4ODRlZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3Byb2Nlc3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jCkBAIC0zMTgsNyArMzE4LDggQEAgc3RhdGljIHN0cnVjdCBrZmRfcHJvY2VzcyAqY3JlYXRl
X3Byb2Nlc3MoY29uc3Qgc3RydWN0IHRhc2tfc3RydWN0ICp0aHJlYWQpCiAKIAkvKiBpbml0IHBy
b2Nlc3MgYXBlcnR1cmVzKi8KIAlwcm9jZXNzLT5pc18zMmJpdF91c2VyX21vZGUgPSBpbl9jb21w
YXRfc3lzY2FsbCgpOwotCWlmIChrZmRfaW5pdF9hcGVydHVyZXMocHJvY2VzcykgIT0gMCkKKwll
cnIgPSBrZmRfaW5pdF9hcGVydHVyZXMocHJvY2Vzcyk7CisJaWYgKGVyciAhPSAwKQogCQlnb3Rv
IGVycl9pbml0X2FwcmV0dXJlczsKIAogCXJldHVybiBwcm9jZXNzOwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
