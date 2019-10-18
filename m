From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/psp: fix spelling mistake "initliaze" ->
 "initialize"
Date: Fri, 18 Oct 2019 16:28:50 -0400
Message-ID: <CADnq5_OfwU2yuxrkW0EjqSjxeYBRA4kw1gksDEmE+pcSOuSwAg@mail.gmail.com>
References: <20191018081508.11028-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191018081508.11028-1-colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBPY3QgMTgsIDIwMTkgYXQgNDoxNSBBTSBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdA
Y2Fub25pY2FsLmNvbT4KPgo+IFRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBpbiBhIERSTV9F
UlJPUiBlcnJvciBtZXNzYWdlLiBGaXggaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4g
S2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEKCkFsZXgK
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gaW5kZXggYjk5NmI1YmM1ODA0Li5m
ZDdhNzNmNGZhNzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
Cj4gQEAgLTkwLDcgKzkwLDcgQEAgc3RhdGljIGludCBwc3Bfc3dfaW5pdCh2b2lkICpoYW5kbGUp
Cj4KPiAgICAgICAgIHJldCA9IHBzcF9tZW1fdHJhaW5pbmdfaW5pdChwc3ApOwo+ICAgICAgICAg
aWYgKHJldCkgewo+IC0gICAgICAgICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byBpbml0bGlh
emUgbWVtb3J5IHRyYWluaW5nIVxuIik7Cj4gKyAgICAgICAgICAgICAgIERSTV9FUlJPUigiRmFp
bGVkIHRvIGluaXRpYWxpemUgbWVtb3J5IHRyYWluaW5nIVxuIik7Cj4gICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7Cj4gICAgICAgICB9Cj4gICAgICAgICByZXQgPSBwc3BfbWVtX3RyYWluaW5n
KHBzcCwgUFNQX01FTV9UUkFJTl9DT0xEX0JPT1QpOwo+IC0tCj4gMi4yMC4xCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
