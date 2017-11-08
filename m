From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/scheduler: add WARN_ON for s_fence->parent
Date: Wed, 8 Nov 2017 10:44:50 +0100
Message-ID: <9ce8a337-19f5-8404-2b6f-7b75fe8f2fa2@gmail.com>
References: <20171108064618.9184-1-david1.zhou@amd.com>
 <20171108064618.9184-2-david1.zhou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108064618.9184-2-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: jim.qu-5C7GfCeVMHo@public.gmane.org

QW0gMDguMTEuMjAxNyB1bSAwNzo0NiBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gQ2hhbmdlLUlk
OiBJMWY2YzgxMDAyZmIyYmEyMWMxN2NkYzE0ZmRkZTg2NTc5YjI4Mzc0ZQo+IFNpZ25lZC1vZmYt
Ynk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYyB8IDEgKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hl
ZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4gaW5kZXggYmI4YTI4YjhiOTkzLi4yZGI2NmNiOTZlOTIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxl
ci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5j
Cj4gQEAgLTI0MSw2ICsyNDEsNyBAQCB2b2lkIGFtZF9zY2hlZF9lbnRpdHlfZmluaShzdHJ1Y3Qg
YW1kX2dwdV9zY2hlZHVsZXIgKnNjaGVkLAo+ICAgCQkJYW1kX3NjaGVkX2ZlbmNlX3NjaGVkdWxl
ZChzX2ZlbmNlKTsKPiAgIAkJCWRtYV9mZW5jZV9zZXRfZXJyb3IoJnNfZmVuY2UtPmZpbmlzaGVk
LCAtRVNSQ0gpOwo+ICAgCQkJYW1kX3NjaGVkX2ZlbmNlX2ZpbmlzaGVkKHNfZmVuY2UpOwo+ICsJ
CQlXQVJOX09OKHNfZmVuY2UtPnBhcmVudCk7Cj4gICAJCQlkbWFfZmVuY2VfcHV0KCZzX2ZlbmNl
LT5maW5pc2hlZCk7Cj4gICAJCQlzY2hlZC0+b3BzLT5mcmVlX2pvYihqb2IpOwo+ICAgCQl9CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
