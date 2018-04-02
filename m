From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH -next] drm/amdkfd: Fix the error return code in
 kfd_ioctl_unmap_memory_from_gpu()
Date: Mon, 2 Apr 2018 14:02:53 -0400
Message-ID: <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
References: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1522376717-136486-1-git-send-email-weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-CA
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
To: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

VGhhbmtzIGZvciBjYXRjaGluZyB0aGF0LiBJJ2QgdXNlIC1FTk9ERVYgdG8gbWF0Y2ggd2hhdCBp
cyBkb25lIGEgZmV3CmxpbmVzIGJlbG93IGZvciBwZWVyX3BkZC4gV2l0aCB0aGF0IGZpeGVkLCB0
aGlzIHBhdGNoIGlzIFJldmlld2VkLWJ5OgpGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKT24gMjAxOC0wMy0yOSAxMDoyNSBQTSwgV2Vp
IFlvbmdqdW4gd3JvdGU6Cj4gUGFzc2luZyBOVUxMIHBvaW50ZXIgdG8gUFRSX0VSUiB3aWxsIHJl
c3VsdCBpbiByZXR1cm4gdmFsdWUgb2YgMAo+IGluZGljYXRpbmcgc3VjY2VzcyB3aGljaCBpcyBj
bGVhcmx5IG5vdCB3aGF0IGl0IGlzIGludGVuZGVkIGhlcmUuCj4gVGhpcyBwYXRjaCByZXR1cm5z
IC1FSU5WQUwgaW5zdGVhZC4KPgo+IEZpeGVzOiA1ZWM3ZTAyODU0YjMgKCJkcm0vYW1ka2ZkOiBB
ZGQgaW9jdGxzIGZvciBHUFVWTSBtZW1vcnkgbWFuYWdlbWVudCIpCj4gU2lnbmVkLW9mZi1ieTog
V2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jCj4gaW5kZXggY2Q2NzljZi4uYzMyYTM0MSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IEBAIC0xNDIxLDcgKzE0MjEsNyBAQCBz
dGF0aWMgaW50IGtmZF9pb2N0bF91bm1hcF9tZW1vcnlfZnJvbV9ncHUoc3RydWN0IGZpbGUgKmZp
bGVwLAo+ICAKPiAgCXBkZCA9IGtmZF9nZXRfcHJvY2Vzc19kZXZpY2VfZGF0YShkZXYsIHApOwo+
ICAJaWYgKCFwZGQpIHsKPiAtCQllcnIgPSBQVFJfRVJSKHBkZCk7Cj4gKwkJZXJyID0gLUVJTlZB
TDsKPiAgCQlnb3RvIGJpbmRfcHJvY2Vzc190b19kZXZpY2VfZmFpbGVkOwo+ICAJfQo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
