From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix a && vs || typo
Date: Mon, 7 Oct 2019 12:30:41 -0400
Message-ID: <CADnq5_NHDwYhF+Z7Kn6a4=qp9S9==7hSjKWQWwsJT9SPTdfePg@mail.gmail.com>
References: <20191007085210.GC3865@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191007085210.GC3865@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Yong Zhao <Yong.Zhao@amd.com>, David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgNywgMjAxOSBhdCA0OjUyIEFNIERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50
ZXJAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBJbiB0aGUgY3VycmVudCBjb2RlIGlmICJkZXZpY2Vf
aW5mbyIgaXMgZXZlciBOVUxMIHRoZW4gdGhlIGtlcm5lbCB3aWxsCj4gT29wcyBzbyBwcm9iYWJs
eSB8fCB3YXMgaW50ZW5kZWQgaW5zdGVhZCBvZiAmJi4KPgo+IEZpeGVzOiBlMzkyYzg4N2RmOTcg
KCJkcm0vYW1ka2ZkOiBVc2UgYXJyYXkgdG8gcHJvYmUga2ZkMmtnZF9jYWxscyIpCj4gU2lnbmVk
LW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgoKQXBwbGll
ZC4gIHRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2UuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gaW5k
ZXggMGRiMjczNTg3YWY0Li4wNzBjOWI1NTkzYzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jCj4gQEAgLTQ5OCw3ICs0OTgsNyBAQCBzdHJ1Y3Qga2ZkX2RldiAq
a2dkMmtmZF9wcm9iZShzdHJ1Y3Qga2dkX2RldiAqa2dkLAo+ICAgICAgICAgZGV2aWNlX2luZm8g
PSBrZmRfc3VwcG9ydGVkX2RldmljZXNbYXNpY190eXBlXVt2Zl07Cj4gICAgICAgICBmMmcgPSBr
ZmQya2dkX2Z1bmNzW2FzaWNfdHlwZV07Cj4KPiAtICAgICAgIGlmICghZGV2aWNlX2luZm8gJiYg
IWYyZykgewo+ICsgICAgICAgaWYgKCFkZXZpY2VfaW5mbyB8fCAhZjJnKSB7Cj4gICAgICAgICAg
ICAgICAgIGRldl9lcnIoa2ZkX2RldmljZSwgIiVzICVzIG5vdCBzdXBwb3J0ZWQgaW4ga2ZkXG4i
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9hc2ljX25hbWVbYXNpY190eXBlXSwg
dmYgPyAiVkYiIDogIiIpOwo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiAtLQo+IDIu
MjAuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
