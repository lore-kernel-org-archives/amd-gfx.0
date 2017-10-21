From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/16] drm/amdkfd: increase IH num entries to 8192
Date: Fri, 20 Oct 2017 20:23:18 -0400
Message-ID: <1508545400-24338-15-git-send-email-Felix.Kuehling@amd.com>
References: <1508545400-24338-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508545400-24338-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andres.rodriguez-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW5kcmVzIFJvZHJpZ3VleiA8YW5kcmVzLnJvZHJpZ3VlekBhbWQuY29tPgoKQSBsYXJn
ZXIgYnVmZmVyIHdpbGwgbGV0IHVzIGFjY29tbW9kYXRlIGFwcGxpY2F0aW9ucyB3aXRoIGEgbGFy
Z2UgYW1vdW50Cm9mIHNlbWktc2ltdWx0YW5lb3VzIGV2ZW50IHNpZ25hbHMuCgpTaWduZWQtb2Zm
LWJ5OiBBbmRyZXMgUm9kcmlndWV6IDxhbmRyZXMucm9kcmlndWV6QGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYwppbmRleCBmZmJiOTFhLi5hMTQ3MjY5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50ZXJydXB0LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCkBAIC00NSw3ICs0NSw3IEBACiAj
aW5jbHVkZSA8bGludXgva2ZpZm8uaD4KICNpbmNsdWRlICJrZmRfcHJpdi5oIgogCi0jZGVmaW5l
IEtGRF9JSF9OVU1fRU5UUklFUyAxMDI0CisjZGVmaW5lIEtGRF9JSF9OVU1fRU5UUklFUyA4MTky
CiAKIHN0YXRpYyB2b2lkIGludGVycnVwdF93cShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKik7CiAKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
