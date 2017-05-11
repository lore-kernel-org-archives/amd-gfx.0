From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 0/3] GPU-DRM-Radeon: Fine-tuning for three function
 implementations
Date: Thu, 11 May 2017 11:40:15 +0900
Message-ID: <366447c1-003c-71fe-98e4-ce66890e17ea@daenzer.net>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
 <799fb921-f620-9054-680d-90b14e4c517c@amd.com>
 <8c4e7dde-06d5-3f13-2322-f661e9d3dbf4@daenzer.net>
 <66a88c64-cc8f-45ed-81c6-f7e2947f1f18@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <66a88c64-cc8f-45ed-81c6-f7e2947f1f18@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, SF Markus Elfring <elfring@users.sourceforge.net>, Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTAvMDUvMTcgMDg6MzAgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTAuMDUu
MjAxNyB1bSAwMjoyMyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAwMy8wNS8xNyAwOTo0
NiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDAyLjA1LjIwMTcgdW0gMjI6MDQg
c2NocmllYiBTRiBNYXJrdXMgRWxmcmluZzoKPj4+PiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxm
cmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Cj4+Pj4gRGF0ZTogVHVlLCAyIE1heSAyMDE3IDIy
OjAwOjAyICswMjAwCj4+Pj4KPj4+PiBUaHJlZSB1cGRhdGUgc3VnZ2VzdGlvbnMgd2VyZSB0YWtl
biBpbnRvIGFjY291bnQKPj4+PiBmcm9tIHN0YXRpYyBzb3VyY2UgY29kZSBhbmFseXNpcy4KPj4+
Pgo+Pj4+IE1hcmt1cyBFbGZyaW5nICgzKToKPj4+PiAgICAgVXNlIHNlcV9wdXRjKCkgaW4gcmFk
ZW9uX3NhX2JvX2R1bXBfZGVidWdfaW5mbygpCj4+Pj4gICAgIFVzZSBzZXFfcHV0cygpIGluIHJh
ZGVvbl9kZWJ1Z2ZzX3BtX2luZm8oKQo+Pj4+ICAgICBVc2Ugc2VxX3B1dHMoKSBpbiByMTAwX2Rl
YnVnZnNfY3BfY3NxX2ZpZm8oKQo+Pj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gQmFzZWQgb24KPj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvYXJjaGl2ZXMvZHJpLWRldmVsLzIwMTctTWF5LzE0MDgzNy5odG1sCj4+IGFu
ZCBmb2xsb3d1cHMsIEknbSBhZnJhaWQgd2UnbGwgaGF2ZSB0byBtYWtlIHN1cmUgTWFya3VzJyBw
YXRjaGVzIGhhdmUKPj4gYmVlbiB0ZXN0ZWQgYWRlcXVhdGVseSBiZWZvcmUgYXBwbHlpbmcgdGhl
bS4KPiAKPiBJIGNhbid0IGp1ZGdlIHRoZSBiYWNrZ3JvdW5kIG9mIHRoYXQgZGVjaXNpb24sIGJ1
dCBhdCBsZWFzdCB0aG9zZSB0cmVlCj4gcGF0Y2hlcyBmb3IgcmFkZW9uIGxvb2tlZCB0cml2aWFs
IHRvIG1lLgoKV2hpY2ggaXMgcGFydCBvZiB0aGUgaXNzdWUsIHNlZSBhbHNvCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE3LU1heS8xNDA2OTQuaHRt
bAphbmQgb3RoZXIgcG9zdHMgaW4gdGhhdCB0aHJlYWQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20K
TGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2Eg
YW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
