From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: Remove superfluous void * cast in
 debugfs_create_file() call
Date: Mon, 28 Oct 2019 13:56:26 -0400
Message-ID: <CADnq5_Mcs1EzvETV=+XjWZcbJff-bfLycYZ3N+SVE9-KA7U-Sw@mail.gmail.com>
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191021145149.31657-4-geert+renesas@glider.be>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nishanth Menon <nm@ti.com>, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>, David@rox.of.borg, Herbert Xu <herbert@gondor.apana.org.au>, Kevin Hilman <khilman@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Casey Leedom <leedom@chelsio.com>, Linux PM <linux-pm@vger.kernel.org>, Pensando Drivers <drivers@pensando.io>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, Network Development <netdev@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Paul Mackerras <paulus@samba.org>, Shannon Nelson <snelson@pensando.io>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgNjoyMyBQTSBHZWVydCBVeXR0ZXJob2V2ZW4KPGdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlPiB3cm90ZToKPgo+IFRoZXJlIGlzIG5vIG5lZWQgdG8gY2FzdCBh
IHR5cGVkIHBvaW50ZXIgdG8gYSB2b2lkIHBvaW50ZXIgd2hlbiBjYWxsaW5nCj4gYSBmdW5jdGlv
biB0aGF0IGFjY2VwdHMgdGhlIGxhdHRlci4gIFJlbW92ZSBpdCwgYXMgdGhlIGNhc3QgcHJldmVu
dHMKPiBmdXJ0aGVyIGNvbXBpbGVyIGNoZWNrcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+CgpBcHBsaWVkLiAgVGhhbmtzIQoK
QWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
YyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4g
aW5kZXggNTY1MmNjNzJlZDNhOWIzYS4uYjk3YTM4YjFlMDg5YjNkNiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+IEBAIC0xMDkwLDggKzEwOTAs
OCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgewo+ICAgICAgICAgYWRldi0+ZGVidWdmc19wcmVlbXB0ID0KPiAgICAgICAgICAgICAgICAg
ZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X3ByZWVtcHRfaWIiLCAwNjAwLAo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmRkZXYtPnByaW1hcnktPmRlYnVnZnNf
cm9vdCwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodm9pZCAqKWFkZXYs
ICZmb3BzX2liX3ByZWVtcHQpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFkZXYtPmRkZXYtPnByaW1hcnktPmRlYnVnZnNfcm9vdCwgYWRldiwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZm9wc19pYl9wcmVlbXB0KTsKPiAgICAgICAgIGlmICgh
KGFkZXYtPmRlYnVnZnNfcHJlZW1wdCkpIHsKPiAgICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJ1
bmFibGUgdG8gY3JlYXRlIGFtZGdwdV9wcmVlbXB0X2liIGRlYnVnc2ZzIGZpbGVcbiIpOwo+ICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiAtLQo+IDIuMTcuMQo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBs
aXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
