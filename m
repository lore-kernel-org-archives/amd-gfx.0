From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu/uvd:Add uvd enc session bo
Date: Wed, 16 Oct 2019 10:59:38 +0200
Message-ID: <3198889b-9df5-dd90-0457-79a1a886ec4d@gmail.com>
References: <1571177279-9435-1-git-send-email-James.Zhu@amd.com>
 <1571177279-9435-2-git-send-email-James.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1571177279-9435-2-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTYuMTAuMTkgdW0gMDA6MDggc2NocmllYiBaaHUsIEphbWVzOgo+IEFkZCB1dmQgZW5jIHNl
c3Npb24gYm8gZm9yIHV2ZCBlbmNvZGUgSUIgdGVzdC4KPgo+IFNpZ25lZC1vZmYtYnk6IEphbWVz
IFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXZkLmggfCA0ICsrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmgKPiBpbmRleCA1
ZWI2MzI4Li4xZTM5YzhhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91dmQuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
dmQuaAo+IEBAIC02Nyw2ICs2NywxMCBAQCBzdHJ1Y3QgYW1kZ3B1X3V2ZCB7Cj4gICAJdW5zaWdu
ZWQJCWhhcnZlc3RfY29uZmlnOwo+ICAgCS8qIHN0b3JlIGltYWdlIHdpZHRoIHRvIGFkanVzdCBu
YiBtZW1vcnkgc3RhdGUgKi8KPiAgIAl1bnNpZ25lZAkJZGVjb2RlX2ltYWdlX3dpZHRoOwo+ICsK
PiArCXN0cnVjdCBhbWRncHVfYm8gKmVuY19zZXNzaW9uX2JvOwo+ICsJdm9pZAkJCSAqZW5jX3Nl
c3Npb25fY3B1X2FkZHI7Cj4gKwl1aW50NjRfdAkJICBlbmNfc2Vzc2lvbl9ncHVfYWRkcjsKClBs
ZWFzZSBkb24ndCBrZWVwIHRoYXQgYWxsb2NhdGVkIGFsbCB0aGUgdGltZSwgYnV0IHJhdGhlciBv
bmx5IGFsbG9jYXRlIAppdCBvbiBkZW1hbmQgZHVyaW5nIHRoZSBJQiB0ZXN0LgoKUmVnYXJkcywK
Q2hyaXN0aWFuLgoKPiAgIH07Cj4gICAKPiAgIGludCBhbWRncHVfdXZkX3N3X2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
