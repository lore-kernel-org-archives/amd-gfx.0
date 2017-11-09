From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/ttm: user reservation object wrappers
Date: Thu, 9 Nov 2017 17:50:10 +0100
Message-ID: <93f5f720-2de8-ce5c-2b4e-946f6e21bd90@daenzer.net>
References: <20171109085909.1653-1-christian.koenig@amd.com>
 <20171109085909.1653-4-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109085909.1653-4-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hongbo.He-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMTEvMTcgMDk6NTkgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQ29uc2lzdGVu
dGx5IHVzZSB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0IHdyYXBwZXJzIGluc3RlYWQgb2YgYWNjZXNz
aW5nCj4gdGhlIHd3X211dGV4IGRpcmVjdGx5Lgo+IAo+IEFkZGl0aW9uYWwgdG8gdGhhdCB1c2Ug
dGhlIHJlc2VydmF0aW9uIG9iamVjdCB3cmFwcGVycyBkaXJlY3RseSBpbnN0ZWFkIG9mCj4gY2Fs
bGluZyBfX3R0bV9ib19yZXNlcnZlIHdpdGggZml4ZWQgcGFyYW1ldGVycy4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpbLi4u
XQoKPiBAQCAtMTgyMyw3ICsxODIzLDkgQEAgaW50IHR0bV9ib193YWl0X3VucmVzZXJ2ZWQoc3Ry
dWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykKPiAgCQlyZXR1cm4gLUVSRVNUQVJUU1lTOwo+ICAJ
aWYgKCF3d19tdXRleF9pc19sb2NrZWQoJmJvLT5yZXN2LT5sb2NrKSkKPiAgCQlnb3RvIG91dF91
bmxvY2s7Cj4gLQlyZXQgPSBfX3R0bV9ib19yZXNlcnZlKGJvLCB0cnVlLCBmYWxzZSwgTlVMTCk7
Cj4gKwlyZXQgPSByZXNlcnZhdGlvbl9vYmplY3RfbG9ja19pbnRlcnJ1cHRpYmxlKGJvLT5yZXN2
LCBOVUxMKTsKPiArCWlmIChyZXQgPSAtRUlOVFIpCj4gKwkJcmV0ID0gLUVSRVNUQVJUU1lTOwoK
VHlwbyBpbiB0aGUgdGVzdCwgbXVzdCBiZQoKICAgIGlmIChyZXQgPT0gLUVJTlRSKQoKClRoaXMg
YnVnIGNhdXNlZCB0aGUgWG9yZyBwcm9jZXNzIHRvIGhhbmcgZm9yIG1lIHdoZW4gdHJ5aW5nIHRv
IHJ1bgpnbHhnZWFycywgcmVxdWlyaW5nIGEgaGFyZCByZWJvb3QuIERpZCB5b3UgYWNjaWRlbnRh
bGx5IHNlbmQgYW4gdW50ZXN0ZWQKdmVyc2lvbiBvZiB0aGlzIHBhdGNoPwoKCi0tIApFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3
dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
