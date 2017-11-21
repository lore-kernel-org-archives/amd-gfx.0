From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/ttm: use NUM_PAGES_TO_ALLOC always
Date: Tue, 21 Nov 2017 10:41:52 +0100
Message-ID: <0a21c9fd-8cb3-d311-8c49-093235449811@gmail.com>
References: <1511256742-5601-1-git-send-email-Hongbo.He@amd.com>
 <1511256742-5601-3-git-send-email-Hongbo.He@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511256742-5601-3-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMTEuMjAxNyB1bSAxMDozMiBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSWRl
OTZhMWNjYWQ5YmI0NGIwYmIwZDgwZTEyM2MyZDgxMGJhNjE4ZWQKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuYyB8IDMgKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5j
Cj4gaW5kZXggMmI4M2M1Mi4uMjdiMjQwMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9wYWdlX2FsbG9jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdl
X2FsbG9jLmMKPiBAQCAtNTIwLDggKzUyMCw3IEBAIHN0YXRpYyBpbnQgdHRtX2FsbG9jX25ld19w
YWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICpwYWdlcywgZ2ZwX3QgZ2ZwX2ZsYWdzLAo+ICAgCWludCBy
ID0gMDsKPiAgIAl1bnNpZ25lZCBpLCBqLCBjcGFnZXM7Cj4gICAJdW5zaWduZWQgbnBhZ2VzID0g
MSA8PCBvcmRlcjsKPiAtCXVuc2lnbmVkIG1heF9jcGFnZXMgPSBtaW4oY291bnQsCj4gLQkJCSh1
bnNpZ25lZCkoUEFHRV9TSVpFL3NpemVvZihzdHJ1Y3QgcGFnZSAqKSkpOwo+ICsJdW5zaWduZWQg
bWF4X2NwYWdlcyA9IG1pbihjb3VudCwgKHVuc2lnbmVkKU5VTV9QQUdFU19UT19BTExPQyk7Cj4g
ICAKPiAgIAkvKiBhbGxvY2F0ZSBhcnJheSBmb3IgcGFnZSBjYWNoaW5nIGNoYW5nZSAqLwo+ICAg
CWNhY2hpbmdfYXJyYXkgPSBrbWFsbG9jKG1heF9jcGFnZXMqc2l6ZW9mKHN0cnVjdCBwYWdlICop
LCBHRlBfS0VSTkVMKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
