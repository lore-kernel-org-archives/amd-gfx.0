From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu/sriov: Only sriov runtime support use kiq
Date: Tue, 21 Aug 2018 09:50:31 +0200
Message-ID: <03c57e23-8f97-9d95-27d9-214fea8b7529@gmail.com>
References: <1534828612-6608-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534828612-6608-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMDguMjAxOCB1bSAwNzoxNiBzY2hyaWViIEVtaWx5IERlbmc6Cj4gUmVmaW5lIHRoZSBj
b2RlIHN0eWxlLCBhZGQgYnJhY2tldHMuCj4KPiBGb3Igc3Jpb3YsIGRvbid0IHVzZSBraXEgaW4g
ZXhjbHVzaXZlIG1vZGUsIGFzIGRvbid0IGtub3cgaG93IGxvbmcgdGltZQo+IGl0IHdpbGwgdGFr
ZSwgc29tZSB0aW1lcyBpdCB3aWxsIG9jY3VyIGV4Y2x1c2l2ZSB0aW1lb3V0Lgo+Cj4gU2lnbmVk
LW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCj4gaW5kZXggZjcxNjE1ZS4uYWRmZDBiZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC0zMjAsNyArMzIwLDcgQEAgc2lnbmVkIGxvbmcg
IGFtZGdwdV9raXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICAgCXN0cnVjdCBhbWRncHVfa2lxICpraXEgPSAmYWRldi0+Z2Z4LmtpcTsKPiAgIAlzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAma2lxLT5yaW5nOwo+ICAgCj4gLQlpZiAoIXJpbmctPnJl
YWR5KQo+ICsJaWYgKCFyaW5nLT5yZWFkeSB8fCAoIWFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYp
ICYmIGFtZGdwdV9zcmlvdl92ZihhZGV2KSkpCgpQbGVhc2UgcmV3b3JrIHRoZSBjb2RlIGZsb3cg
YSBiaXQgdG8gbWFrZSBpdCBtb3JlIG9idmlvdXMgd2hhdCBoYXBwZW5zIGhlcmUuCgpFLmcuIG1v
dmUgdGhlIGNoZWNrIGludG8gdGhlIGNhbGxlciBpbnN0ZWFkIG9mIHJldHVybmluZyBhbiBlcnJv
ciBjb2RlIGhlcmUuCgpDaHJpc3RpYW4uCgo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICAg
CXNwaW5fbG9ja19pcnFzYXZlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
