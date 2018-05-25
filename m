From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/17] drm/amdgpu: add vcn jpeg ring
Date: Fri, 25 May 2018 11:08:20 +0200
Message-ID: <dda40ec4-8011-55eb-5f4f-adf6e9a25159@gmail.com>
References: <1527192929-2480-1-git-send-email-boyuan.zhang@amd.com>
 <1527192929-2480-2-git-send-email-boyuan.zhang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527192929-2480-2-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
To: boyuan.zhang-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, peter.fang-5C7GfCeVMHo@public.gmane.org

QW0gMjQuMDUuMjAxOCB1bSAyMjoxNSBzY2hyaWViIGJveXVhbi56aGFuZ0BhbWQuY29tOgo+IEZy
b206IEJveXVhbiBaaGFuZyA8Ym95dWFuLnpoYW5nQGFtZC5jb20+Cj4KPiBBZGQganBlZyB0byBh
bWRncHVfdmNuCj4KPiBTaWduZWQtb2ZmLWJ5OiBCb3l1YW4gWmhhbmcgPGJveXVhbi56aGFuZ0Bh
bWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5o
IHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+IGluZGV4IDJmZDdkYjguLjY0OGY2NjIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4gQEAgLTU1LDkgKzU1
LDExIEBAIHN0cnVjdCBhbWRncHVfdmNuIHsKPiAgIAljb25zdCBzdHJ1Y3QgZmlybXdhcmUJKmZ3
OwkvKiBWQ04gZmlybXdhcmUgKi8KPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcJcmluZ19kZWM7Cj4g
ICAJc3RydWN0IGFtZGdwdV9yaW5nCXJpbmdfZW5jW0FNREdQVV9WQ05fTUFYX0VOQ19SSU5HU107
Cj4gKwlzdHJ1Y3QgYW1kZ3B1X3JpbmcJcmluZ19qcGVnOwo+ICAgCXN0cnVjdCBhbWRncHVfaXJx
X3NyYwlpcnE7Cj4gICAJc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgZW50aXR5X2RlYzsKPiAgIAlz
dHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSBlbnRpdHlfZW5jOwo+ICsJc3RydWN0IGRybV9zY2hlZF9l
bnRpdHkgZW50aXR5X2pwZWc7CgpXaHkgZG8geW91IG5lZWQgdGhlIGVudGl0eSBoZXJlPyBJIHRo
b3VnaHQgdGhlIEpQRUcgcmluZyBpcyBzdGF0ZWxlcz8KCkNocmlzdGlhbi4KCj4gICAJdW5zaWdu
ZWQJCW51bV9lbmNfcmluZ3M7Cj4gICB9Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
