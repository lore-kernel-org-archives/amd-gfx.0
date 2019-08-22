From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable
 'psp_enabled'
Date: Wed, 21 Aug 2019 22:37:26 -0400
Message-ID: <CADnq5_PE3r+4ZrUmc7o0_ah4wZpBi5jhR-yBHA_F+9gzX7Os5Q@mail.gmail.com>
References: <20190627075350.86800-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190627075350.86800-1-yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Jack Xiao <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>, tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCk9uIFRodSwgSnVuIDI3LCAyMDE5IGF0IDEwOjI5IEFN
IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiBGaXhlcyBnY2Mg
Jy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cj4KPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jOiBJbiBmdW5jdGlvbiAnbnZfY29tbW9uX2Vhcmx5X2luaXQnOgo+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmM6NDcxOjc6IHdhcm5pbmc6Cj4gIHZhcmlhYmxl
ICdwc3BfZW5hYmxlZCcgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJs
ZV0KPgo+IEl0J3Mgbm90IHVzZWQgc2luY2UgaW5yb2R1Y3Rpb24gaW4KPiBjb21taXQgYzZiNmE0
MjE3NWY1ICgiZHJtL2FtZGdwdTogYWRkIG5hdmkxMCBjb21tb24gaXAgYmxvY2sgKHYzKSIpCj4K
PiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgfCA1IC0tLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCj4gaW5kZXgg
YWYyMGZmYjU1YzU0Li44YjlmYTNkYjhkYWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMK
PiBAQCAtNDY4LDcgKzQ2OCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVu
Y3MgbnZfYXNpY19mdW5jcyA9Cj4KPiAgc3RhdGljIGludCBudl9jb21tb25fZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCj4gIHsKPiAtICAgICAgIGJvb2wgcHNwX2VuYWJsZWQgPSBmYWxzZTsKPiAg
ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICopaGFuZGxlOwo+Cj4gICAgICAgICBhZGV2LT5zbWNfcnJlZyA9IE5VTEw7Cj4gQEAgLTQ4NSwx
MCArNDg0LDYgQEAgc3RhdGljIGludCBudl9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUp
Cj4KPiAgICAgICAgIGFkZXYtPmFzaWNfZnVuY3MgPSAmbnZfYXNpY19mdW5jczsKPgo+IC0gICAg
ICAgaWYgKGFtZGdwdV9kZXZpY2VfaXBfZ2V0X2lwX2Jsb2NrKGFkZXYsIEFNRF9JUF9CTE9DS19U
WVBFX1BTUCkgJiYKPiAtICAgICAgICAgICAoYW1kZ3B1X2lwX2Jsb2NrX21hc2sgJiAoMSA8PCBB
TURfSVBfQkxPQ0tfVFlQRV9QU1ApKSkKPiAtICAgICAgICAgICAgICAgcHNwX2VuYWJsZWQgPSB0
cnVlOwo+IC0KPiAgICAgICAgIGFkZXYtPnJldl9pZCA9IG52X2dldF9yZXZfaWQoYWRldik7Cj4g
ICAgICAgICBhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSAweGZmOwo+ICAgICAgICAgc3dpdGNoIChh
ZGV2LT5hc2ljX3R5cGUpIHsKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
