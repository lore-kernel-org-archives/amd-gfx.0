From: Mikita Lipski <mlipski@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned variable compared to less
 than zero
Date: Mon, 11 Nov 2019 12:46:32 -0500
Message-ID: <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
References: <20191111172543.GA31748@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191111172543.GA31748@embeddedor>
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
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mikita Lipski <mikita.lipski@amd.com>, Lyude Paul <lyude@redhat.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

ClRoYW5rcyBmb3IgY2F0Y2hpbmcgaXQhCgpSZXZpZXdlZC1ieTogTWlraXRhIExpcHNraSA8bWlr
aXRhLmxpcHNraUBhbWQuY29tPgoKCk9uIDExLjExLjIwMTkgMTI6MjUsIEd1c3Rhdm8gQS4gUi4g
U2lsdmEgd3JvdGU6Cj4gQ3VycmVubHksIHRoZSBlcnJvciBjaGVjayBiZWxvdyBvbiB2YXJpYWJs
ZSp2Y3BpX3Nsb3RzKiAgaXMgYWx3YXlzCj4gZmFsc2UgYmVjYXVzZSBpdCBpcyBhIHVpbnQ2NF90
IHR5cGUgdmFyaWFibGUsIGhlbmNlLCB0aGUgdmFsdWVzCj4gdGhpcyB2YXJpYWJsZSBjYW4gaG9s
ZCBhcmUgbmV2ZXIgbGVzcyB0aGFuIHplcm86Cj4gCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzoKPiA0ODcwICAgICAgICAgaWYgKGRtX25ld19jb25u
ZWN0b3Jfc3RhdGUtPnZjcGlfc2xvdHMgPCAwKSB7Cj4gNDg3MSAgICAgICAgICAgICAgICAgRFJN
X0RFQlVHX0FUT01JQygiZmFpbGVkIGZpbmRpbmcgdmNwaSBzbG90czogJWRcbiIsIChpbnQpZG1f
bmV3X2Nvbm5lY3Rvcl9zdGF0ICAgICBlLT52Y3BpX3Nsb3RzKTsKPiA0ODcyICAgICAgICAgICAg
ICAgICByZXR1cm4gZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90czsKPiA0ODczICAg
ICAgICAgfQo+IAo+IEZpeCB0aGlzIGJ5IG1ha2luZyp2Y3BpX3Nsb3RzKiAgb2YgaW50IHR5cGUK
PiAKPiBBZGRyZXNzZXMtQ292ZXJpdHk6IDE0ODc4MzggKCJVbnNpZ25lZCBjb21wYXJlZCBhZ2Fp
bnN0IDAiKQo+IEZpeGVzOiBiNGM1NzhmMDgzNzggKCJkcm0vYW1kL2Rpc3BsYXk6IEFkZCBNU1Qg
YXRvbWljIHJvdXRpbmVzIikKPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhPGd1
c3Rhdm9AZW1iZWRkZWRvci5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oCj4gaW5kZXggNmRiMDdlOWUzM2FiLi5hOGZj
OTBhOTI3ZDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmgKPiBAQCAtNDAzLDcgKzQwMyw3IEBAIHN0cnVjdCBkbV9jb25uZWN0
b3Jfc3RhdGUgewo+ICAgCWJvb2wgdW5kZXJzY2FuX2VuYWJsZTsKPiAgIAlib29sIGZyZWVzeW5j
X2NhcGFibGU7Cj4gICAJdWludDhfdCBhYm1fbGV2ZWw7Cj4gLQl1aW50NjRfdCB2Y3BpX3Nsb3Rz
Owo+ICsJaW50IHZjcGlfc2xvdHM7Cj4gICAJdWludDY0X3QgcGJuOwo+ICAgfTsKPiAgIAo+IC0t
IDIuMjMuMAoKLS0gClRoYW5rcywKTWlraXRhIExpcHNraQpTb2Z0d2FyZSBFbmdpbmVlciwgQU1E
Cm1pa2l0YS5saXBza2lAYW1kLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWw=
