From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix amd_powerplay_reset()
Date: Tue, 24 Oct 2017 13:11:07 +0300
Message-ID: <87k1zkj1ok.fsf@intel.com>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Eric Huang <JinHuiEric.Huang@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCAyNCBPY3QgMjAxNywgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUu
Y29tPiB3cm90ZToKPiBXZSBhY2NpZGVudGFsbHkgaW52ZXJ0ZWQgYW4gaWYgc3RhdGVtZW50IGFu
ZCB0dXJuZWQgYW1kX3Bvd2VycGxheV9yZXNldCgpCj4gaW50byBhIG5vLW9wLgo+Cj4gRml4ZXM6
IGFlOTc5ODhmYzg5ZSAoImRybS9hbWQvcG93ZXJwbGF5OiB0aWR5IHVwIHJldCBjaGVja3MgaW4g
YW1kX3Bvd2VycGxheS5jICh2MykiKQoKRm9yIHNvbWUgcmVhc29uIEkgbG9va2VkIHVwIHRoYXQg
Y29tbWl0LCBhbmQgaXQgaGFzICp0d28qIGNhc2VzIHdoZXJlCiJyZXQgIT0gMCIgZ2V0cyBjaGFu
Z2VkIHRvICIhcmV0Ii4KCkJSLApKYW5pLgoKCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+IC0tLQo+IElNSE8sIHRpZHlpbmcgdW5yZWFk
YWJsZSBkb3VibGUgbmVnYXRpdmVzIGlzIHRyaWNreSBhbmQgZXJyb3IgcHJvbmUgYnV0Cj4gc3Rp
bGwgd29ydGggaXQgaW4gdGhlIGxvbmcgcnVuLgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwo+IGluZGV4IDNjOGVmNGJmYzIwNS4uMGY4YjZkYzg1
M2E1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dl
cnBsYXkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBs
YXkuYwo+IEBAIC0xMTg0LDcgKzExODQsNyBAQCBpbnQgYW1kX3Bvd2VycGxheV9yZXNldCh2b2lk
ICpoYW5kbGUpCj4gIAlpbnQgcmV0Owo+ICAKPiAgCXJldCA9IHBwX2NoZWNrKGluc3RhbmNlKTsK
PiAtCWlmICghcmV0KQo+ICsJaWYgKHJldCkKPiAgCQlyZXR1cm4gcmV0Owo+ICAKPiAgCXJldCA9
IHBwX2h3X2ZpbmkoaW5zdGFuY2UpOwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAoKLS0gCkphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNvdXJjZSBU
ZWNobm9sb2d5IENlbnRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
