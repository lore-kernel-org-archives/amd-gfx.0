From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: no need fbcon under sriov
Date: Tue, 4 Jun 2019 15:57:37 +0200
Message-ID: <1686be7b-ca1c-e43c-3906-e6131e8d25e1@gmail.com>
References: <1559655785-30379-1-git-send-email-yttao@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1559655785-30379-1-git-send-email-yttao-5C7GfCeVMHo@public.gmane.org>
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
To: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDQuMDYuMTkgdW0gMTU6NDMgc2NocmllYiBZaW50aWFuIFRhbzoKPiBVbmRlciBTcmlvdiwg
dGhlcmUgaXMgbm8gbmVlZCBvZiB0aGUgc3VwcG9ydCBmb3IgZmJjb24uCgpOQUssIHRoYXQgZXJy
b3IgbWVzc2FnZSBpcyBub3QgcmVsYXRlZCB0byBmYmNvbiBidXQgbWVhbnMgdGhhdCBQQ0llIApk
ZXZpY2UgcmVtb3ZhbCBpcyBub3Qgc3VwcG9ydGVkLgoKQ2hyaXN0aWFuLgoKPgo+IFNpZ25lZC1v
ZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPiBpbmRleCAxZjM4ZDZmLi4yOGQwOTViIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IEBAIC0xMDEyLDcgKzEwMTIsOCBAQCBhbWRn
cHVfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAgIHsKPiAgIAlzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+ICAgCj4gLQlEUk1fRVJST1Io
IkRldmljZSByZW1vdmFsIGlzIGN1cnJlbnRseSBub3Qgc3VwcG9ydGVkIG91dHNpZGUgb2YgZmJj
b25cbiIpOwo+ICsJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCj4gKwkJRFJNX0VSUk9SKCJE
ZXZpY2UgcmVtb3ZhbCBpcyBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCBvdXRzaWRlIG9mIGZiY29u
XG4iKTsKPiAgIAlkcm1fZGV2X3VucGx1ZyhkZXYpOwo+ICAgCWRybV9kZXZfcHV0KGRldik7Cj4g
ICAJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
