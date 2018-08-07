From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?Q?Re:_[PATCH]_drm/amdgpu:_fix_unused_variable_=e2=80=98rq?=
 =?UTF-8?B?4oCZ?=
Date: Tue, 7 Aug 2018 11:23:42 +0200
Message-ID: <358a6d53-1445-82d2-4fd8-df766f85924b@gmail.com>
References: <1533631665-24945-1-git-send-email-ray.huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533631665-24945-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDcuMDguMjAxOCB1bSAxMDo0NyBzY2hyaWViIEh1YW5nIFJ1aToKPiBUaGlzIHBhdGNoIGlz
IHRvIGZpeCB0aGUgd2FybmluZyB0byByZW1vdmUgdW51c2VkIHZhcmlhYmxlLgo+Cj4gL2hvbWUv
cmF5L2xpbnV4L2RyaXZlcnMvZ3B1L2RybS8vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmM6Cj4gSW4g
ZnVuY3Rpb24g4oCYYW1kZ3B1X2N0eF9wcmlvcml0eV9vdmVycmlkZeKAmToKPiAvaG9tZS9yYXkv
bGludXgvZHJpdmVycy9ncHUvZHJtLy9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYzozOTc6MjM6Cj4g
d2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmHJx4oCZIFstV3VudXNlZC12YXJpYWJsZV0KPiAg
ICBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBeCj4K
PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAxIC0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2N0eC5jCj4gaW5kZXggOWZjYzE0ZS4uMDJkNTYzYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiBAQCAtMzk0LDcgKzM5NCw2IEBAIHZvaWQgYW1kZ3B1
X2N0eF9wcmlvcml0eV9vdmVycmlkZShzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4LAo+ICAgewo+ICAg
CWludCBpOwo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY3R4LT5hZGV2Owo+IC0J
c3RydWN0IGRybV9zY2hlZF9ycSAqcnE7Cj4gICAJc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVu
dGl0eTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7Cj4gICAJZW51bSBkcm1fc2NoZWRf
cHJpb3JpdHkgY3R4X3ByaW87CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
