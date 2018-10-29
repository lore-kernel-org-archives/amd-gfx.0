From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: print an error when the parser can't be
 initialized
Date: Mon, 29 Oct 2018 13:39:00 +0100
Message-ID: <f3c7fefd-4b62-3555-d450-2821984daec3@gmail.com>
References: <20181029112306.1709-1-samuel.pitoiset@gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181029112306.1709-1-samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjkuMTAuMTggdW0gMTI6MjMgc2NocmllYiBTYW11ZWwgUGl0b2lzZXQ6Cj4gU2ltaWxhciB0
byBvdGhlciBlcnJvciBtZXNzYWdlcywgbWlnaHQgaGVscCBmb3IgdHJhY2tpbmcgZG93bgo+IGlz
c3Vlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFNhbXVlbCBQaXRvaXNldCA8c2FtdWVsLnBpdG9pc2V0
QGdtYWlsLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CgpHb2luZyB0byBwdXNoIHRoYXQgaWYgbm9ib2R5IG9iamVjdHMsCkNocmlz
dGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8
IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRleCA4ODM2MTg2ZWI1
ZWYuLmM4YWE5Y2MwYmVkOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
cy5jCj4gQEAgLTEyODUsNyArMTI4NSw3IEBAIGludCBhbWRncHVfY3NfaW9jdGwoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQo+ICAgCj4g
ICAJciA9IGFtZGdwdV9jc19wYXJzZXJfaW5pdCgmcGFyc2VyLCBkYXRhKTsKPiAgIAlpZiAocikg
ewo+IC0JCURSTV9FUlJPUigiRmFpbGVkIHRvIGluaXRpYWxpemUgcGFyc2VyICFcbiIpOwo+ICsJ
CURSTV9FUlJPUigiRmFpbGVkIHRvIGluaXRpYWxpemUgcGFyc2VyICVkIVxuIiwgcik7Cj4gICAJ
CWdvdG8gb3V0Owo+ICAgCX0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
