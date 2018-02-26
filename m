From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/22] drm/amdgpu: remove duplicated job_free_resources
Date: Mon, 26 Feb 2018 13:18:00 +0800
Message-ID: <1519622300-8990-3-git-send-email-Monk.Liu@amd.com>
References: <1519622300-8990-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519622300-8990-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

aWYgYSBqb2IgaXMgZ28gdGhyb3VnaCBzY2hlZHVsZXIsIGl0IGlzIGZvcmJpZGRlbiB0bwpjYWxs
IGpvYl9mcmVlX3Jlc291cmNlcyBhZnRlciBpYl9zY2hlZHVsZSwgYmVjYXVzdCB0aGF0CndvdWxk
IGFzc2lnbiB3aWxkIHBvaW50ZXIgb2YgZmVuY2Ugb24gdGhlIHNhX2JvLT5mZW5jZQp3aGljaCBj
b3VsZCBsZWFkIHRvIHdlaXJkIGJ1ZwoKQ2hhbmdlLUlkOiBJYWQ3ZWUwMTFjNjQxY2I3MzU3NTY5
Y2JjZTM2ZmRjMTBmMGVkOTExZApTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgfCAxIC0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pvYi5jCmluZGV4IDJiZDU2NzYuLjdjYjM0MzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfam9iLmMKQEAgLTIwNyw3ICsyMDcsNiBAQCBzdGF0aWMgc3RydWN0IGRt
YV9mZW5jZSAqYW1kZ3B1X2pvYl9ydW4oc3RydWN0IGRybV9zY2hlZF9qb2IgKnNjaGVkX2pvYikK
IAlkbWFfZmVuY2VfcHV0KGpvYi0+ZmVuY2UpOwogCWpvYi0+ZmVuY2UgPSBkbWFfZmVuY2VfZ2V0
KGZlbmNlKTsKIAotCWFtZGdwdV9qb2JfZnJlZV9yZXNvdXJjZXMoam9iKTsKIAlyZXR1cm4gZmVu
Y2U7CiB9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
