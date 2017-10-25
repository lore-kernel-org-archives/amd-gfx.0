From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix amd_powerplay_reset()
Date: Wed, 25 Oct 2017 18:28:37 -0400
Message-ID: <CADnq5_O-xxxbvUaxHZwbYpQSP2zWDwXJD3cvhZZNzegHW2i_UA@mail.gmail.com>
References: <20171024094418.za4qacxapyrud2m4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171024094418.za4qacxapyrud2m4@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBPY3QgMjQsIDIwMTcgYXQgNTo0NCBBTSwgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPiB3cm90ZToKPiBXZSBhY2NpZGVudGFsbHkgaW52ZXJ0ZWQgYW4gaWYg
c3RhdGVtZW50IGFuZCB0dXJuZWQgYW1kX3Bvd2VycGxheV9yZXNldCgpCj4gaW50byBhIG5vLW9w
Lgo+Cj4gRml4ZXM6IGFlOTc5ODhmYzg5ZSAoImRybS9hbWQvcG93ZXJwbGF5OiB0aWR5IHVwIHJl
dCBjaGVja3MgaW4gYW1kX3Bvd2VycGxheS5jICh2MykiKQo+IFNpZ25lZC1vZmYtYnk6IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KCkFwcGxpZWQuICB0aGFua3MhCgpB
bGV4Cgo+IC0tLQo+IElNSE8sIHRpZHlpbmcgdW5yZWFkYWJsZSBkb3VibGUgbmVnYXRpdmVzIGlz
IHRyaWNreSBhbmQgZXJyb3IgcHJvbmUgYnV0Cj4gc3RpbGwgd29ydGggaXQgaW4gdGhlIGxvbmcg
cnVuLgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9w
b3dlcnBsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXku
Ywo+IGluZGV4IDNjOGVmNGJmYzIwNS4uMGY4YjZkYzg1M2E1IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwo+IEBAIC0xMTg0LDcgKzExODQs
NyBAQCBpbnQgYW1kX3Bvd2VycGxheV9yZXNldCh2b2lkICpoYW5kbGUpCj4gICAgICAgICBpbnQg
cmV0Owo+Cj4gICAgICAgICByZXQgPSBwcF9jaGVjayhpbnN0YW5jZSk7Cj4gLSAgICAgICBpZiAo
IXJldCkKPiArICAgICAgIGlmIChyZXQpCj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4K
PiAgICAgICAgIHJldCA9IHBwX2h3X2ZpbmkoaW5zdGFuY2UpOwo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
