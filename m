From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: separate gpu address from bo pin
Date: Tue, 26 Jun 2018 10:35:32 +0200
Message-ID: <eac68f86-a5f9-110e-3970-ee8a8404934a@daenzer.net>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
 <6c63256a-17d2-ee6e-8b3c-2e0a928aeb84@daenzer.net> <5B31F946.6020404@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B31F946.6020404-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0yNiAxMDoyOCBBTSwgWmhhbmcsIEplcnJ5IChKdW53ZWkpIHdyb3RlOgo+IE9u
IDA2LzI2LzIwMTggMDM6NDYgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBPbiAyMDE4LTA2
LTI2IDA4OjAwIEFNLCBKdW53ZWkgWmhhbmcgd3JvdGU6Cj4+PiBJdCBjb3VsZCBiZSBnb3QgYnkg
YW1kZ3B1X2JvX2dwdV9vZmZzZXQoKSBpZiBuZWVkCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSnVu
d2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4gQEAg
LTkzMSw3ICs5MjgsNiBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCBhbWRn
cHVfYm8KPj4+ICpibywgdTMyIGRvbWFpbiwKPj4+IMKgwqAgKiBhbWRncHVfYm9fcGluIC0gcGlu
IGFuICZhbWRncHVfYm8gYnVmZmVyIG9iamVjdAo+Pj4gwqDCoCAqIEBibzogJmFtZGdwdV9ibyBi
dWZmZXIgb2JqZWN0IHRvIGJlIHBpbm5lZAo+Pj4gwqDCoCAqIEBkb21haW46IGRvbWFpbiB0byBi
ZSBwaW5uZWQgdG8KPj4+IC0gKiBAZ3B1X2FkZHI6IEdQVSBvZmZzZXQgb2YgdGhlICZhbWRncHVf
Ym8gYnVmZmVyIG9iamVjdAo+Pj4gwqDCoCAqCj4+PiDCoMKgICogQSBzaW1wbGUgd3JhcHBlciB0
byBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoKS4KPj4+IMKgwqAgKiBQcm92aWRlcyBhIHNpbXBs
ZXIgQVBJIGZvciBidWZmZXJzIHRoYXQgZG8gbm90IGhhdmUgYW55IHN0cmljdAo+Pj4gcmVzdHJp
Y3Rpb25zCj4+Cj4+IFRoaXMgYWxzbyBuZWVkcyB0byBiZSByZW1vdmVkIGluIHRoZSBjb21tZW50
IGJlZm9yZQo+PiBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQuIFdpdGggdGhhdCBmaXhlZCwKPiAK
PiBFeGFjdGx5LCBJIHdpbGwuCgpUaGFua3MuIEZXSVcsIHJ1bm5pbmcgZS5nLgoKIG1ha2UgLWok
KG5wcm9jKSBodG1sZG9jcwoKc2hvdWxkIGhhdmUgcHJvZHVjZWQgdGhlIGZvbGxvd2luZyB3YXJu
aW5nOgoKLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmM6ODQxOiB3
YXJuaW5nOiBFeGNlc3MKZnVuY3Rpb24gcGFyYW1ldGVyICdncHVfYWRkcicgZGVzY3JpcHRpb24g
aW4gJ2FtZGdwdV9ib19waW5fcmVzdHJpY3RlZCcKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
