From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH -next] drm/amdkfd: Fix the error return code in
 kfd_ioctl_unmap_memory_from_gpu()
Date: Tue, 24 Apr 2018 12:16:19 +0300
Message-ID: <CAFCwf13=M4LiNh+VK9aVZv4stnJHZ3=Oe7LT6p2E4=2O9tudkA@mail.gmail.com>
References: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com>
 <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Wei Yongjun <weiyongjun1@huawei.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBBcHIgMiwgMjAxOCBhdCA5OjAyIFBNLCBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3Vl
aGxpbmdAYW1kLmNvbT4gd3JvdGU6Cj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGF0LiBJJ2QgdXNl
IC1FTk9ERVYgdG8gbWF0Y2ggd2hhdCBpcyBkb25lIGEgZmV3Cj4gbGluZXMgYmVsb3cgZm9yIHBl
ZXJfcGRkLiBXaXRoIHRoYXQgZml4ZWQsIHRoaXMgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6Cj4gRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4KPiBSZWdhcmRzLAo+ICAgRmVs
aXgKPgo+Cj4gT24gMjAxOC0wMy0yOSAxMDoyNSBQTSwgV2VpIFlvbmdqdW4gd3JvdGU6Cj4+IFBh
c3NpbmcgTlVMTCBwb2ludGVyIHRvIFBUUl9FUlIgd2lsbCByZXN1bHQgaW4gcmV0dXJuIHZhbHVl
IG9mIDAKPj4gaW5kaWNhdGluZyBzdWNjZXNzIHdoaWNoIGlzIGNsZWFybHkgbm90IHdoYXQgaXQg
aXMgaW50ZW5kZWQgaGVyZS4KPj4gVGhpcyBwYXRjaCByZXR1cm5zIC1FSU5WQUwgaW5zdGVhZC4K
Pj4KPj4gRml4ZXM6IDVlYzdlMDI4NTRiMyAoImRybS9hbWRrZmQ6IEFkZCBpb2N0bHMgZm9yIEdQ
VVZNIG1lbW9yeSBtYW5hZ2VtZW50IikKPj4gU2lnbmVkLW9mZi1ieTogV2VpIFlvbmdqdW4gPHdl
aXlvbmdqdW4xQGh1YXdlaS5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYyB8IDIgKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2NoYXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFy
ZGV2LmMKPj4gaW5kZXggY2Q2NzljZi4uYzMyYTM0MSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4+IEBAIC0xNDIxLDcgKzE0MjEsNyBAQCBzdGF0aWMg
aW50IGtmZF9pb2N0bF91bm1hcF9tZW1vcnlfZnJvbV9ncHUoc3RydWN0IGZpbGUgKmZpbGVwLAo+
Pgo+PiAgICAgICBwZGQgPSBrZmRfZ2V0X3Byb2Nlc3NfZGV2aWNlX2RhdGEoZGV2LCBwKTsKPj4g
ICAgICAgaWYgKCFwZGQpIHsKPj4gLSAgICAgICAgICAgICBlcnIgPSBQVFJfRVJSKHBkZCk7Cj4+
ICsgICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsKPj4gICAgICAgICAgICAgICBnb3RvIGJpbmRf
cHJvY2Vzc190b19kZXZpY2VfZmFpbGVkOwo+PiAgICAgICB9Cj4+Cj4KClRoYW5rcyEKQXBwbGll
ZCB0byAtZml4ZXMgd2l0aCB0aGUgLUVOT0RFViByZXR1cm4gY29kZQoKT2RlZApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
