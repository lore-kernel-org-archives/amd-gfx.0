From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix 'ISO C90 forbids mixed declarations'
Date: Wed, 30 May 2018 08:37:32 +0200
Message-ID: <12ec5d12-354c-f03a-fb7f-a477fab4d812@gmail.com>
References: <20180530031447.27119-1-david1.zhou@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180530031447.27119-1-david1.zhou@amd.com>
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
To: Chunming Zhou <david1.zhou@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Emily.Deng@amd.com
List-Id: amd-gfx.lists.freedesktop.org

UGxlYXNlIGFkZCBzb21ldGhpbmcgbGlrZSAiRml4aW5nIGEgY29tcGlsZXIgd2FybmluZy4iIGFz
IGNvbW1pdCBtZXNzYWdlLgoKV2l0aCB0aGF0IGRvbmUgdGhlIHNlcmllcyBpcyBSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpUaGFua3Ms
CkNocmlzdGlhbi4KCkFtIDMwLjA1LjIwMTggdW0gMDU6MTQgc2NocmllYiBDaHVubWluZyBaaG91
Ogo+IENoYW5nZS1JZDogSTQxMmY1NzgzZTI4MzljNTM4NDFlNmFiNjY1ZjkzOTIzNmJkYzViZjEK
PiBTaWduZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCA2ICsrKy0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gaW5kZXggOWVhOGZiMDc3YWJhLi4x
MmYwZDE4YzZlZTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+
IEBAIC02NTcsMTIgKzY1NywxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0
cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCQkJCSAgICAgcC0+Ynl0ZXNfbW92ZWRfdmlz
KTsKPiAgIAo+ICAgCWlmIChwLT5ib19saXN0KSB7Cj4gLQkJZ2RzID0gcC0+Ym9fbGlzdC0+Z2Rz
X29iajsKPiAtCQlnd3MgPSBwLT5ib19saXN0LT5nd3Nfb2JqOwo+IC0JCW9hID0gcC0+Ym9fbGlz
dC0+b2Ffb2JqOwo+ICAgCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9ICZmcHJpdi0+dm07Cj4gICAJ
CXVuc2lnbmVkIGk7Cj4gICAKPiArCQlnZHMgPSBwLT5ib19saXN0LT5nZHNfb2JqOwo+ICsJCWd3
cyA9IHAtPmJvX2xpc3QtPmd3c19vYmo7Cj4gKwkJb2EgPSBwLT5ib19saXN0LT5vYV9vYmo7Cj4g
ICAJCWZvciAoaSA9IDA7IGkgPCBwLT5ib19saXN0LT5udW1fZW50cmllczsgaSsrKSB7Cj4gICAJ
CQlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IHAtPmJvX2xpc3QtPmFycmF5W2ldLnJvYmo7Cj4gICAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
