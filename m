From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix solid screen and hard hang when 2k + 4k
 display connected with DP
Date: Mon, 26 Jun 2017 13:59:09 +0200
Message-ID: <33104cc5-ae94-be39-e254-afddef10f3fa@vodafone.de>
References: <1498460629-9481-1-git-send-email-ray.huang@amd.com>
 <24e624a1-3f79-752a-ef12-adf5c1b407a2@vodafone.de>
 <20170626105302.GA1824@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170626105302.GA1824@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Jiang,
 Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

QW0gMjYuMDYuMjAxNyB1bSAxMjo1MyBzY2hyaWViIEh1YW5nIFJ1aToKPiBPbiBNb24sIEp1biAy
NiwgMjAxNyBhdCAwMzoxODo1MlBNICswODAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBB
bSAyNi4wNi4yMDE3IHVtIDA5OjAzIHNjaHJpZWIgSHVhbmcgUnVpOgo+Pj4gU2lnbmVkLW9mZi1i
eTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4+IENjOiBYaWFvamllIFl1YW4gPFhp
YW9qaWUuWXVhbkBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgfCAyICstCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC8KPj4gYW1kZ3B1
L2FtZGdwdV9wc3AuYwo+Pj4gaW5kZXggNWJlZDQ4My4uNjBkMDQ1NSAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4+PiBAQCAtMTMwLDcgKzEzMCw3IEBA
IHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKPj4+ICAgICAgICAg
cmV0ID0gcHNwX2NtZF9zdWJtaXQocHNwLCB1Y29kZSwgY21kX2J1Zl9tY19hZGRyLAo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBmZW5jZV9tY19hZGRyLCBpbmRleCk7Cj4+PiAgIAo+
Pj4gLSAgICAgd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSAhPSBpbmRl
eCkgewo+Pj4gKyAgICAgd2hpbGUgKCooKHVuc2lnbmVkIGludCAqKXBzcC0+ZmVuY2VfYnVmKSA8
IGluZGV4KSB7Cj4+IFRoYXQgaXMgc3RpbGwgaG9ycmlibGUgaW5jb3JyZWN0LiBBdCBiYXJlIG1p
bmltdW0geW91IG5lZWQgdG8gdXNlIHRoZQo+PiBSRUFEX09OQ0UoKSBtYWNybyBoZXJlLgo+Pgo+
IFNvLCBSRUFEX09OQ0UoKigodW5zaWduZWQgaW50ICopcHNwLT5mZW5jZV9idWYpKSA8IGluZGV4
Lgo+IERvIHlvdSBtZWFuIHRoZSBjb21wbGllciBtaWdodCBjYXVzZSB0byByZWFkIHRoZSBwcmV2
aW91cyBmZW5jZSBidWZmZXIKPiB2YWx1ZSBpZiB3ZSBkb24ndCBhZGQgUkVBRF9PTkNFPwoKWWVz
LCBleGFjdGx5LiBJIHdvdWxkIGd1ZXNzIHRoYXQgdGhpcyBvbmx5IHdvcmtzIGJ5IGNvaW5jaWRl
bnQgYmVjYXVzZSAKdGhlIG1zbGVlcCgpIGlzIGNhdXNpbmcgYSBiYXJyaWVyIGhlcmUuCgpDaHJp
c3RpYW4uCgo+Cj4+IEJ1dCBpdCB3b3VsZCBiZSBldmVuIGJldHRlciB0byBjb21wbGV0ZWx5IGRy
b3AgdGhpcyBhbmQgdXNlIHRoZSBmZW5jZQo+PiBpbXBsZW1lbnRhdGlvbiBpbiBhbWRncHVfZmVu
Y2UuYyBhcyB3ZWxsLgo+Pgo+IEkgdW5kZXJzdGFuZCwgSSB3aWxsIHJlZmFjdG9yIGl0IGFmdGVy
IFMzIHN0cmVzcyBjb21wbGV0ZWQuCj4KPiBUaGFua3MsCj4gUmF5CgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
