From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: remove redundant assignment to
 variable baco_state
Date: Thu, 22 Aug 2019 16:51:25 -0400
Message-ID: <CADnq5_O=V0_MNenTdxFsprmrGQiwMQNDFFkzYH-ZWw11VaMYmA@mail.gmail.com>
References: <20190822130948.32195-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190822130948.32195-1-colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgOTowOSBBTSBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdA
Y2Fub25pY2FsLmNvbT4KPgo+IFZhcmlhYmxlIGJhY29fc3RhdGUgaXMgaW5pdGlhbGl6ZWQgdG8g
YSB2YWx1ZSB0aGF0IGlzIG5ldmVyIHJlYWQgYW5kIGl0IGlzCj4gcmUtYXNzaWduZWQgbGF0ZXIu
IFRoZSBpbml0aWFsaXphdGlvbiBpcyByZWR1bmRhbnQgYW5kIGNhbiBiZSByZW1vdmVkLgo+Cj4g
QWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCBWYWx1ZSIpCj4gU2lnbmVkLW9mZi1ieTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkFwcGxpZWQuICBUaGFua3Mh
CgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
YyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwo+IGluZGV4IDg5
NzQ5YjFkMjAxOS4uYTRhYmE4NTc2OTAwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMV8wLmMKPiBAQCAtMTY1Niw3ICsxNjU2LDcgQEAgc3RhdGljIGJvb2wgc211
X3YxMV8wX2JhY29faXNfc3VwcG9ydChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKPiAgc3RhdGlj
IGVudW0gc211X2JhY29fc3RhdGUgc211X3YxMV8wX2JhY29fZ2V0X3N0YXRlKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgc211X2JhY29fY29udGV4dCAqc211
X2JhY28gPSAmc211LT5zbXVfYmFjbzsKPiAtICAgICAgIGVudW0gc211X2JhY29fc3RhdGUgYmFj
b19zdGF0ZSA9IFNNVV9CQUNPX1NUQVRFX0VYSVQ7Cj4gKyAgICAgICBlbnVtIHNtdV9iYWNvX3N0
YXRlIGJhY29fc3RhdGU7Cj4KPiAgICAgICAgIG11dGV4X2xvY2soJnNtdV9iYWNvLT5tdXRleCk7
Cj4gICAgICAgICBiYWNvX3N0YXRlID0gc211X2JhY28tPnN0YXRlOwo+IC0tCj4gMi4yMC4xCj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
