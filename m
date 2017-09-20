From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 05/10] drm/amdkfd: Fix incorrect destroy_mqd parameter
Date: Wed, 20 Sep 2017 18:10:17 -0400
Message-ID: <1505945422-8851-6-git-send-email-Felix.Kuehling@amd.com>
References: <1505945422-8851-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505945422-8851-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

V2hlbiB1bmluaXRpYWxpemluZyBhIGtlcm5lbCBxdWV1ZS4KClNpZ25lZC1vZmYtYnk6IFlvbmcg
WmhhbyA8eW9uZy56aGFvQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2Fi
YmF5QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMK
aW5kZXggMDQzNzlhNi4uYTQ3Y2EzYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9rZXJuZWxfcXVldWUuYwpAQCAtMTg0LDcgKzE4NCw3IEBAIHN0YXRpYyB2b2lkIHVuaW5p
dGlhbGl6ZShzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSkKIAlpZiAoa3EtPnF1ZXVlLT5wcm9wZXJ0
aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfSElRKQogCQlrcS0+bXFkLT5kZXN0cm95X21xZChr
cS0+bXFkLAogCQkJCQlrcS0+cXVldWUtPm1xZCwKLQkJCQkJZmFsc2UsCisJCQkJCUtGRF9QUkVF
TVBUX1RZUEVfV0FWRUZST05UX1JFU0VULAogCQkJCQlLRkRfVU5NQVBfTEFURU5DWV9NUywKIAkJ
CQkJa3EtPnF1ZXVlLT5waXBlLAogCQkJCQlrcS0+cXVldWUtPnF1ZXVlKTsKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
