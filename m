From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: check for null dev to avoid a null pointer
 dereference
Date: Sun, 17 Sep 2017 15:05:52 +0300
Message-ID: <CAFCwf10OHekL+0u_ixXDYjZPM1-JT10avxdvWssPNbZ0Y6g41g@mail.gmail.com>
References: <20170908141333.1563-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170908141333.1563-1-colin.king@canonical.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBTZXAgOCwgMjAxNyBhdCA1OjEzIFBNLCBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+IHdyb3RlOgo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+Cj4KPiBUaGUgY2FsbCB0byBrZmRfZGV2aWNlX2J5X2lkIGNhbiBwb3RlbnRp
YWxseSByZXR1cm4gbnVsbCwgc28gY2hlY2sgdGhhdAo+IGRldiBpcyBudWxsIGFuZCByZXR1cm4g
d2l0aCAtRUlOVkFMIHRvIGF2b2lkIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlLgo+Cj4gRGV0
ZWN0ZWQgYnkgQ292ZXJpdHlTY2FuIENJRCMxNDU0NjI5ICgiRGVyZWZlcmVuY2UgbnVsbCByZXR1
cm4gdmFsdWUiKQo+Cj4gRml4ZXM6IDVkNzFkYmMzYTU4OCAoImRybS9hbWRrZmQ6IEltcGxlbWVu
dCBpbWFnZSB0aWxpbmcgbW9kZSBzdXBwb3J0IHYyIikKPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMK
PiBpbmRleCBlNGE4YzJlNTJjYjIuLjY2MGIzZmJhZGU0MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IEBAIC04OTIsNiArODkyLDggQEAgc3RhdGljIGlu
dCBrZmRfaW9jdGxfZ2V0X3RpbGVfY29uZmlnKHN0cnVjdCBmaWxlICpmaWxlcCwKPiAgICAgICAg
IGludCBlcnIgPSAwOwo+Cj4gICAgICAgICBkZXYgPSBrZmRfZGV2aWNlX2J5X2lkKGFyZ3MtPmdw
dV9pZCk7Cj4gKyAgICAgICBpZiAoIWRldikKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7Cj4KPiAgICAgICAgIGRldi0+a2ZkMmtnZC0+Z2V0X3RpbGVfY29uZmlnKGRldi0+a2dkLCAm
Y29uZmlnKTsKPgo+IC0tCj4gMi4xNC4xCj4KVGhhbmtzIQpBcHBsaWVkIHRvIG15IC1maXhlcyB0
cmVlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
