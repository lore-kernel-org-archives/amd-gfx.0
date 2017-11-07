From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bypass FB resizing for SRIOV VF
Date: Tue, 7 Nov 2017 11:27:05 +0100
Message-ID: <ee607a6e-de00-8185-9d0e-4ed70055315f@gmail.com>
References: <1510024085-21956-1-git-send-email-Pixel.Ding@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510024085-21956-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDcuMTEuMjAxNyB1bSAwNDowOCBzY2hyaWViIFBpeGVsIERpbmc6Cj4gRnJvbTogcGRpbmcg
PFBpeGVsLkRpbmdAYW1kLmNvbT4KPgo+IEl0IGludHJvZHVjZXMgOTAwbXMgbGF0ZW5jeSBpbiBl
eGNsdXNpdmUgbW9kZSB3aGljaCBjYXVzZXMgZmFpbHVyZQo+IG9mIGRyaXZlciBsb2FkaW5nLiBI
b3N0IGNhbiByZXNpemUgdGhlIEJBUiBiZWZvcmUgZ3Vlc3Qgc3RhcmluZywKPiBzbyB0aGUgcmVz
aXppbmcgaXMgbm90IG5lY2Vzc2FyeSBoZXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogcGRpbmcgPFBp
eGVsLkRpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgNCArKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5k
ZXggNmYwMWRkYS4uYmYyYjAwOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKPiBAQCAtNzY4LDYgKzc2OCwxMCBAQCBpbnQgYW1kZ3B1X2RldmljZV9y
ZXNpemVfZmJfYmFyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCXUxNiBjbWQ7Cj4g
ICAJaW50IHI7Cj4gICAKPiArCS8qIEJ5cGFzcyBmb3IgVkYgKi8KPiArCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICAgCS8qIERpc2FibGUgbWVtb3J5IGRl
Y29kaW5nIHdoaWxlIHdlIGNoYW5nZSB0aGUgQkFSIGFkZHJlc3NlcyBhbmQgc2l6ZSAqLwo+ICAg
CXBjaV9yZWFkX2NvbmZpZ193b3JkKGFkZXYtPnBkZXYsIFBDSV9DT01NQU5ELCAmY21kKTsKPiAg
IAlwY2lfd3JpdGVfY29uZmlnX3dvcmQoYWRldi0+cGRldiwgUENJX0NPTU1BTkQsCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
