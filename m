From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
Date: Wed, 11 Apr 2018 11:17:04 +0200
Message-ID: <6f99b01f-2f3c-7263-9df8-f8a73f4a9372@amd.com>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <20180411062602.GA29109@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180411062602.GA29109@hr-amur2>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Huang Rui <ray.huang@amd.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: Tom St Denis <tom.stdenis@amd.com>, David Panariti <David.Panariti@amd.com>, sulrich@codeaurora.org, Jim Qu <Jim.Qu@amd.com>, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Emily Deng <Emily.Deng@amd.com>, Roger He <Hongbo.He@amd.com>, amd-gfx@lists.freedesktop.org, Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Monk Liu <Monk.Liu@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTEuMDQuMjAxOCB1bSAwODoyNiBzY2hyaWViIEh1YW5nIFJ1aToKPiBPbiBUdWUsIEFwciAx
MCwgMjAxOCBhdCAwNDo1OTo1NVBNIC0wNDAwLCBTaW5hbiBLYXlhIHdyb3RlOgo+PiBDb2RlIGlz
IGV4cGVjaW5nIHRvIG9ic2VydmUgdGhlIHNhbWUgbnVtYmVyIG9mIGJ1ZmZlcnMgcmV0dXJuZWQg
ZnJvbQo+PiBkbWFfbWFwX3NnKCkgZnVuY3Rpb24gY29tcGFyZWQgdG8gc2dfYWxsb2NfdGFibGVf
ZnJvbV9wYWdlcygpLiBUaGlzCj4+IGRvZXNuJ3QgaG9sZCB0cnVlIHVuaXZlcnNhbGx5IGVzcGVj
aWFsbHkgZm9yIHN5c3RlbXMgd2l0aCBJT01NVS4KPj4KPj4gSU9NTVUgZHJpdmVyIHRyaWVzIHRv
IGNvbWJpbmUgYnVmZmVycyBpbnRvIGEgc2luZ2xlIERNQSBhZGRyZXNzIGFzIG11Y2gKPj4gYXMg
aXQgY2FuLiBUaGUgcmlnaHQgdGhpbmcgaXMgdG8gdGVsbCB0aGUgRE1BIGxheWVyIGhvdyBtdWNo
IGNvbWJpbmluZwo+PiBJT01NVSBjYW4gZG8uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEth
eWEgPG9rYXlhQGNvZGVhdXJvcmEub3JnPgo+IFNpbmFuLCBJIGd1ZXNzIENocmlzdGlhbidzIHN1
Z2dlc3Rpb24gaXMgdG8gYWRkIGFtZGdwdV9kZXZpY2VfaW5pdCBmdW5jdGlvbgo+IGxpa2UgaGVy
ZToKClllcywgZXhhY3RseS4gTG9va3MgbGlrZSBTaW5hbiBqdXN0IHRyaWVkIHRvIHBsYWNlIHRo
ZSBjYWxsIG5leHQgdG8gCnBjaV9zZXRfZG1hX21hc2soKS9wY2lfc2V0X2NvbnNpc3RlbnRfZG1h
X21hc2soKS4KCk5vdCBuZWNlc3NhcnkgYSBiYWQgaWRlYSwgYnV0IGluIHRoaXMgY2FzZSBub3Qg
b3B0aW1hbC4KClNpbmFuIHBsZWFzZSByZWZpbmUgeW91ciBwYXRjaCBhcyBSdWkgc3VnZ2VzdGVk
IGFuZCByZXNlbmQuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPiA4PC0tLS0tLS0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggMGU3OThiMy4uOWI5
Njc3MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMK
PiBAQCAtMjMzOSw2ICsyMzM5LDggQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgICAgICAgICAvKiBpbml0IHRoZSBtb2RlIGNvbmZpZyAqLwo+
ICAgICAgICAgIGRybV9tb2RlX2NvbmZpZ19pbml0KGFkZXYtPmRkZXYpOwo+Cj4gKyAgICAgICBk
bWFfc2V0X21heF9zZWdfc2l6ZShhZGV2LT5kZXYsIFBBR0VfU0laRSk7Cj4gKwo+ICAgICAgICAg
IHIgPSBhbWRncHVfZGV2aWNlX2lwX2luaXQoYWRldik7Cj4gICAgICAgICAgaWYgKHIpIHsKPiAg
ICAgICAgICAgICAgICAgIC8qIGZhaWxlZCBpbiBleGNsdXNpdmUgbW9kZSBkdWUgdG8gdGltZW91
dCAqLwo+IDg8LS0tLS0tLQo+Cj4gQWZ0ZXIgdGhhdCwgd2UgZG9uJ3QgZG8gaXQgaW4gZWFjaCBn
ZW5lcmF0aW9uLgo+Cj4gVGhhbmtzLAo+IFJheQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
