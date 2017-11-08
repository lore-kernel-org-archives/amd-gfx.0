From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 2/4] drm/ttm: consistently use reservation_object_unlock
Date: Wed, 8 Nov 2017 17:36:01 +0100
Message-ID: <ebffaae6-675a-1a7b-9a48-b816c1c5bf40@daenzer.net>
References: <20171108145936.27071-1-christian.koenig@amd.com>
 <20171108145936.27071-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171108145936.27071-2-christian.koenig@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, Hongbo.He@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMDgvMTEvMTcgMDM6NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gSW5zdGVhZCBv
ZiBoYXZpbmcgYSBwb2ludGxlc3Mgd3JhcHBlciBvciBjYWxsIHRoZSB1bmRlcmx5aW5nIHd3X211
dGV4Cj4gZnVuY3Rpb24gZGlyZWN0bHkuCgpOb3Qgc3VyZSBJIGNhbiBhZ3JlZSBpdCdzIHBvaW50
bGVzcywgc2luY2UgaXQgcmVjZW50bHkgdG9vayBtZSBhIHdoaWxlCnRvIHJlYWxpemUgdGhhdCB1
bmxvY2tpbmcgYm8tPnJlc3YgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgYXMKdW5yZXNlcnZpbmcg
dGhlIEJPLgoKCkFueXdheSwgdGhpcyBicmVha3MgdGhlIHF4bCBkcml2ZXI6Cgpkcml2ZXJzL2dw
dS9kcm0vL3F4bC9xeGxfcmVsZWFzZS5jOiBJbiBmdW5jdGlvbiDigJhxeGxfcmVsZWFzZV9mZW5j
ZV9idWZmZXJfb2JqZWN0c+KAmToKZHJpdmVycy9ncHUvZHJtLy9xeGwvcXhsX3JlbGVhc2UuYzo0
NzI6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmF9fdHRtX2Jv
X3VucmVzZXJ2ZeKAmTsgZGlkIHlvdSBtZWFuIOKAmHR0bV9ib191bnJlc2VydmXigJk/IFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICBfX3R0bV9ib191bnJlc2VydmUo
Ym8pOwogICBefn5+fn5+fn5+fn5+fn5+fn4KICAgdHRtX2JvX3VucmVzZXJ2ZQoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
