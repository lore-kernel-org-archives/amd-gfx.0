From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: quick fix since gmc rename
Date: Thu, 18 Jan 2018 19:11:35 +0100
Message-ID: <aac18b1f-037d-6078-ac33-8e72935e24e8@gmail.com>
References: <20180118071316.10046-1-david1.zhou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180118071316.10046-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTguMDEuMjAxOCB1bSAwODoxMyBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gQ2hhbmdlLUlk
OiBJZTZhNGE0MjE5ZDkyYWMxYWQyOGE3YzM0MWNiN2Q3MzkzMGY5Mzg2ZAo+IFNpZ25lZC1vZmYt
Ynk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCA1OTFkZjg2OWI1MmIuLjE0ZDZmMTBlYTcxNSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC03MjgsOCArNzI4LDgg
QEAgc3RhdGljIGludCBnbWNfdjlfMF9tY19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQo+ICAgCj4gICAjaWZkZWYgQ09ORklHX1g4Nl82NAo+ICAgCWlmIChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpIHsKPiAtCQlhZGV2LT5tYy5hcGVyX2Jhc2UgPSBnZnhodWJfdjFfMF9nZXRfbWNf
ZmJfb2Zmc2V0KGFkZXYpOwo+IC0JCWFkZXYtPm1jLmFwZXJfc2l6ZSA9IGFkZXYtPm1jLnJlYWxf
dnJhbV9zaXplOwo+ICsJCWFkZXYtPmdtYy5hcGVyX2Jhc2UgPSBnZnhodWJfdjFfMF9nZXRfbWNf
ZmJfb2Zmc2V0KGFkZXYpOwo+ICsJCWFkZXYtPmdtYy5hcGVyX3NpemUgPSBhZGV2LT5nbWMucmVh
bF92cmFtX3NpemU7Cj4gICAJfQo+ICAgI2VuZGlmCj4gICAJLyogSW4gY2FzZSB0aGUgUENJIEJB
UiBpcyBsYXJnZXIgdGhhbiB0aGUgYWN0dWFsIGFtb3VudCBvZiB2cmFtICovCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
