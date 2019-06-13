From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Date: Wed, 12 Jun 2019 22:35:26 -0400
Message-ID: <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
References: <20190613023208.GA29690@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190613023208.GA29690@hari-Inspiron-1545>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Yongqiang Sun <yongqiang.sun@amd.com>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Gloria Li <geling.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tony Cheng <tony.cheng@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBKdW4gMTIsIDIwMTkgYXQgMTA6MzQgUE0gSGFyaXByYXNhZCBLZWxhbQo8aGFyaXBy
YXNhZC5rZWxhbUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gdGhpcyBwYXRjaCBmaXhlcyBiZWxvdyBj
b21waWxhdGlvbiBlcnJvcgo+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYzogSW4KPiBmdW5jdGlvbiDigJhkY24xMF9h
cHBseV9jdHhfZm9yX3N1cmZhY2XigJk6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYzoyMzc4OjM6Cj4gZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHVkZWxheeKAmQo+IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgIHVkZWxheSh1bmRlcmZsb3dfY2hlY2tf
ZGVsYXlfdXMpOwo+Cj4gU2lnbmVkLW9mZi1ieTogSGFyaXByYXNhZCBLZWxhbSA8aGFyaXByYXNh
ZC5rZWxhbUBnbWFpbC5jb20+CgpXaGF0IGJyYW5jaCBpcyB0aGlzIHBhdGNoIGJhc2VkIG9uPwoK
QWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEw
X2h3X3NlcXVlbmNlci5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24x
MF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9k
Y24xMF9od19zZXF1ZW5jZXIuYwo+IGluZGV4IGQyMzUyOTQ5Li4xYWM5YTRmIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5j
ZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9o
d19zZXF1ZW5jZXIuYwo+IEBAIC0yMyw2ICsyMyw3IEBACj4gICAqCj4gICAqLwo+Cj4gKyNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPgo+ICAjaW5jbHVkZSAiZG1fc2VydmljZXMuaCIKPiAgI2luY2x1
ZGUgImNvcmVfdHlwZXMuaCIKPiAgI2luY2x1ZGUgInJlc291cmNlLmgiCj4gLS0KPiAyLjcuNAo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
