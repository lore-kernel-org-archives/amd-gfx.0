From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd: validate user pitch alignment
Date: Fri, 21 Dec 2018 10:07:26 +0100
Message-ID: <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
References: <20181221031053.240161-1-yuzhao@google.com>
 <20181221031053.240161-2-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181221031053.240161-2-yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMi0yMSA0OjEwIGEubS4sIFl1IFpoYW8gd3JvdGU6Cj4gVXNlcnNwYWNlIG1heSBy
ZXF1ZXN0IHBpdGNoIGFsaWdubWVudCB0aGF0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgR1BVLgo+IFNv
bWUgcmVxdWVzdHMgMzIsIGJ1dCBHUFUgaWdub3JlcyBpdCBhbmQgdXNlcyBkZWZhdWx0IDY0IHdo
ZW4gY3BwIGlzCj4gNC4gSWYgR0VNIG9iamVjdCBpcyBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIHNt
YWxsZXIgYWxpZ25tZW50LCBHUFUKPiBETUEgd2lsbCBnbyBvdXQgb2YgYm91bmQuCj4gCj4gRm9y
IEdQVSB0aGF0IGRvZXMgZnJhbWUgYnVmZmVyIGNvbXByZXNzaW9uLCBETUEgd3JpdGluZyBvdXQg
b2YgYm91bmQKPiBtZW1vcnkgd2lsbCBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbi4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xlLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDkgKysrKysrKysrCj4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKPiBpbmRleCBlMzA5ZDI2MTcwZGIuLjc1NWRhYTMzMmY4YSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IEBA
IC01MjcsNiArNTI3LDE1IEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRl
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gIAlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iajsK
PiAgCXN0cnVjdCBhbWRncHVfZnJhbWVidWZmZXIgKmFtZGdwdV9mYjsKPiAgCWludCByZXQ7Cj4g
KwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7Cj4gKwlpbnQg
Y3BwID0gZHJtX2Zvcm1hdF9wbGFuZV9jcHAobW9kZV9jbWQtPnBpeGVsX2Zvcm1hdCwgMCk7Cj4g
KwlpbnQgcGl0Y2ggPSBhbWRncHVfYWxpZ25fcGl0Y2goYWRldiwgbW9kZV9jbWQtPndpZHRoLCBj
cHAsIGZhbHNlKTsKCkFsc28sIHRoaXMgbmVlZHMgdG8gdXNlIG1vZGVfY21kLT5waXRjaGVzWzBd
IGluc3RlYWQgb2YgbW9kZV9jbWQtPndpZHRoLApvdGhlcndpc2UgaXQnbGwgc3B1cmlvdXNseSBm
YWlsIGZvciBsYXJnZXIgYnV0IHdlbGwtYWxpZ25lZCBwaXRjaGVzLgoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5h
bWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
