From: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Date: Thu, 14 Feb 2019 05:09:45 +0000
Message-ID: <DM6PR12MB2908A5B2BD12B9139C5DAB01B4670@DM6PR12MB2908.namprd12.prod.outlook.com>
References: <20190214044628.26759-1-tsu.yubo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190214044628.26759-1-tsu.yubo@gmail.com>
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
To: Bo YU <tsu.yubo@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Zhu, Rex" <Rex.Zhu@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogQm8gWVUgPHRzdS55dWJvQGdt
YWlsLmNvbT4KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTQsIDIwMTkgMTI6NDYgUE0KPiBU
bzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmln
LCBDaHJpc3RpYW4KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1
bk1pbmcpCj4gPERhdmlkMS5aaG91QGFtZC5jb20+OyBhaXJsaWVkQGxpbnV4LmllOyBkYW5pZWxA
ZmZ3bGwuY2g7IFpodSwgUmV4Cj4gPFJleC5aaHVAYW1kLmNvbT47IEdyb2R6b3Zza3ksIEFuZHJl
eQo+IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgbGludXgtCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZwo+IENjOiBCbyBZdSA8dHN1
Lnl1Ym9AZ21haWwuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWRncHU6IEVycm9yIGhhbmRsaW5nIGlzc3VlcyBhYm91dAo+IENIRUNL
RURfUkVUVVJOCj4gCj4gRnJvbTogQm8gWXUgPHRzdS55dWJvQGdtYWlsLmNvbT4KPiAKPiBDYWxs
aW5nICJhbWRncHVfcmluZ190ZXN0X2hlbHBlciIgd2l0aG91dCBjaGVja2luZyByZXR1cm4gdmFs
dWUKCldlIGNvdWxkIG5lZWQgdG8gY29udGludWUgdG8gcmluZyB0ZXN0IGV2ZW4gdGhlcmUgaXMg
b25lIHJpbmcgdGVzdCBmYWlsZWQuCgotRGF2aWQKCj4gCj4gU2lnbmVkLW9mZi1ieTogQm8gWXUg
PHRzdS55dWJvQGdtYWlsLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y4XzAuYyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OF8wLmMKPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiBp
bmRleCA1N2NiM2E1MWJkYTcuLjQ4NDY1YTYxNTE2YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYwo+IEBAIC00NzI4LDcgKzQ3MjgsOSBAQCBzdGF0aWMgaW50IGdmeF92
OF8wX2NwX3Rlc3RfYWxsX3JpbmdzKHN0cnVjdAo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gCj4g
IAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3JpbmdzOyBpKyspIHsKPiAg
CQlyaW5nID0gJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV07Cj4gLQkJYW1kZ3B1X3JpbmdfdGVz
dF9oZWxwZXIocmluZyk7Cj4gKwkJciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKHJpbmcpOwo+
ICsJCWlmIChyKQo+ICsJCQlyZXR1cm4gcjsKPiAgCX0KPiAKPiAgCXJldHVybiAwOwo+IC0tCj4g
Mi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
