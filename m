From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/dm/mst: Use
 drm_dp_mst_connector_atomic_check()
Date: Thu, 20 Sep 2018 19:36:06 -0400
Message-ID: <98b1d4d5-023b-b630-d5d2-94cfeade2404@amd.com>
References: <20180918230637.20700-1-lyude@redhat.com>
 <20180918230637.20700-7-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180918230637.20700-7-lyude@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Leo Li <sunpeng.li@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Roman Li <Roman.Li@amd.com>, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wOS0xOCAwNzowNiBQTSwgTHl1ZGUgUGF1bCB3cm90ZToKPiBIb29rIHRoaXMgaW50
byBhbWRncHUncyBhdG9taWMgY2hlY2sgZm9yIHRoZWlyIGNvbm5lY3RvcnMgc28gdGhleSBuZXZl
cgo+IGdldCBtb2Rlc2V0cyBvbiBuby1sb25nZXItcHJlc2VudCBNU1QgY29ubmVjdG9ycy4gV2Un
bGwgYWxzbyBleHBhbmQgb24KPiB0aGlzIGxhdGVyIG9uY2Ugd2UgYWRkIERQIE1TVCBmYWxsYmFj
ayByZXRyYWluaW5nIHN1cHBvcnQuCj4gCj4gQXMgd2VsbCwgdHVybnMgb3V0IHRoYXQgdGhlIG9u
bHkgYXRvbWljIERSTSBkcml2ZXIgd2l0aG91dCB0aGUKPiAtPmJlc3RfZW5jb2RlcigpIGJ1ZyBp
cyBhbWRncHUuIENvbmdyYXRzIEFNRCEKPiAKPiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxs
eXVkZUByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYyAgfCAxMiArKysrKysrKysrKysKPiAgMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYwo+IGluZGV4
IDlhMzAwNzMyYmEzNy4uZDAxMWEzOWYxN2IyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMK
PiBAQCAtMjk0LDEwICsyOTQsMjIgQEAgc3RhdGljIHN0cnVjdCBkcm1fZW5jb2RlciAqZG1fbXN0
X2Jlc3RfZW5jb2RlcihzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yKQo+ICAJcmV0dXJu
ICZhbWRncHVfZG1fY29ubmVjdG9yLT5tc3RfZW5jb2Rlci0+YmFzZTsKPiAgfQo+ICAKPiArc3Rh
dGljIGludAo+ICthbWRncHVfZG1fbXN0X2Nvbm5lY3Rvcl9hdG9taWNfY2hlY2soc3RydWN0IGRy
bV9jb25uZWN0b3IgKmNvbm5lY3RvciwKPiArCQkJCSAgICAgc3RydWN0IGRybV9jb25uZWN0b3Jf
c3RhdGUgKm5ld19jc3RhdGUpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICph
Y29ubmVjdG9yID0KPiArCQl0b19hbWRncHVfZG1fY29ubmVjdG9yKGNvbm5lY3Rvcik7Cj4gKwo+
ICsJcmV0dXJuIGRybV9kcF9tc3RfY29ubmVjdG9yX2F0b21pY19jaGVjayhjb25uZWN0b3IsIG5l
d19jc3RhdGUsCj4gKwkJCQkJCSAmYWNvbm5lY3Rvci0+bXN0X21ncik7Cj4gK30KPiArCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9oZWxwZXJfZnVuY3MgZG1fZHBfbXN0X2Nv
bm5lY3Rvcl9oZWxwZXJfZnVuY3MgPSB7Cj4gIAkuZ2V0X21vZGVzID0gZG1fZHBfbXN0X2dldF9t
b2RlcywKPiAgCS5tb2RlX3ZhbGlkID0gYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9tb2RlX3ZhbGlkLAo+
ICAJLmJlc3RfZW5jb2RlciA9IGRtX21zdF9iZXN0X2VuY29kZXIsCj4gKwkuYXRvbWljX2NoZWNr
ID0gYW1kZ3B1X2RtX21zdF9jb25uZWN0b3JfYXRvbWljX2NoZWNrLAo+ICB9Owo+ICAKPiAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2RtX2VuY29kZXJfZGVzdHJveShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVu
Y29kZXIpCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
