From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 2/2] drm/amdgpu: Implement ttm_bo_driver.access_vram
 callback
Date: Fri, 14 Jul 2017 12:26:17 +0900
Message-ID: <4966fd06-a266-de25-c5fe-ccca16b3c062@daenzer.net>
References: <1499980105-7721-1-git-send-email-Felix.Kuehling@amd.com>
 <1499980105-7721-2-git-send-email-Felix.Kuehling@amd.com>
 <57fd2f8d-7e80-8661-1c57-741bd33a11d8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <57fd2f8d-7e80-8661-1c57-741bd33a11d8@amd.com>
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
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMTQvMDcvMTcgMDY6MjMgQU0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IE9uIDE3LTA3LTEz
IDA1OjA4IFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uaAo+PiBAQCAtNzgsNiArNzgsOCBAQCBpbnQgYW1kZ3B1X2ZpbGxfYnVm
ZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLAo+PiAgCQkJc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNl
KTsKPj4gIAo+PiAgaW50IGFtZGdwdV9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSk7Cj4+ICtpbnQgYW1kZ3B1X2JvX21tYXAoc3RydWN0IGZpbGUgKmZp
bHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+PiArCQkgICBzdHJ1Y3QgdHRtX2JvX2Rl
dmljZSAqYmRldik7Cj4+ICBib29sIGFtZGdwdV90dG1faXNfYm91bmQoc3RydWN0IHR0bV90dCAq
dHRtKTsKPj4gIGludCBhbWRncHVfdHRtX2JpbmQoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywgc3RydWN0IHR0bV9tZW1fcmVnICpib19tZW0pOwo+PiAgaW50IGFtZGdwdV90dG1fcmVjb3Zl
cl9nYXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiBPb3BzLCB0aGlzIGlzIGEgcmVt
bmFudCBmcm9tIHRoZSBvbGQgdmVyc2lvbiB0aGF0IGhhY2tlZCB0aGUgdHRtX3ZtX29wcwo+IGlu
IGFtZGdwdS4gSSdsbCByZW1vdmUgdGhpcyBiZWZvcmUgSSBzdWJtaXQuCgpXaXRoIHRoYXQgZml4
ZWQgKGFuZCBwb3NzaWJseSBleGNsdWRpbmcgZHJpdmVyLXByaXZhdGUgbWVtb3J5IHR5cGVzIGlm
Cm5lY2Vzc2FyeSwgcGVyIGRpc2N1c3Npb24gb2YgcGF0Y2ggMSksCgpSZXZpZXdlZC1ieTogTWlj
aGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGluZyBNaWNo
ZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5j
b20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1l
c2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
