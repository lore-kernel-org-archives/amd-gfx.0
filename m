From: Hans de Goede via dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Fri, 15 Feb 2019 16:25:37 +0100
Message-ID: <0185f2a8-da60-f88f-1a45-5d20ab1b241a@redhat.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
Reply-To: Hans de Goede <hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190207085931.29569-1-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@redhat.com, kraxel@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, bskeggs@redhat.com, thellstrom@vmware.com, linux-graphics-maintainer@vmware.com, daniel@ffwll.ch, arnd@arndb.de, gregkh@linuxfoundation.org, ray.huang@amd.com, Jerry.Zhang@amd.com
Cc: spice-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpPbiAyLzcvMTkgOTo1OSBBTSwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6Cj4gQWxtb3N0
IGFsbCBUVE0tYmFzZWQgZHJpdmVycyB1c2UgdGhlIHNhbWUgdmFsdWVzIGZvciB0aGUgbW1hcC1h
YmxlCj4gcmFuZ2Ugb2YgQk8gYWRkcmVzc2VzLiBFYWNoIGRyaXZlciB0aGVyZWZvcmUgZHVwbGlj
YXRlcyB0aGUKPiBEUk1fRklMRV9QQUdFX09GRlNFVCBjb25zdGFudC4gT1RPSCwgdGhlIG1tYXAg
cmFuZ2UncyBzaXplIGlzIG5vdAo+IGNvbmZpZ3VyYWJsZSBieSBkcml2ZXJzLgo+IAo+IFRoaXMg
cGF0Y2ggc2V0IHJlcGxhY2VzIGRyaXZlci1zcGVjaWZpYyBjb25maWd1cmF0aW9uIHdpdGggYSBz
aW5nbGUKPiBzZXR1cC4gQWxsIGNvZGUgaXMgbG9jYXRlZCB3aXRoaW4gVFRNLiBUVE0gYW5kIEdF
TSBzaGFyZSB0aGUgc2FtZQo+IHJhbmdlIGZvciBtbWFwLWFibGUgQk9zLgo+IAo+IFRob21hcyBa
aW1tZXJtYW5uICg1KToKPiAgICBzdGFnaW5nL3Zib3h2aWRlbzogVXNlIHNhbWUgQk8gbW1hcCBv
ZmZzZXQgYXMgb3RoZXIgZHJpdmVycwo+ICAgIGRybS90dG06IERlZmluZSBhIHNpbmdsZSBEUk1f
RklMRV9QQUdFX09GRlNFVCBjb25zdGFudAo+ICAgIGRybS90dG06IFJlbW92ZSBmaWxlX3BhZ2Vf
b2Zmc2V0IHBhcmFtZXRlciBmcm9tIHR0bV9ib19kZXZpY2VfaW5pdCgpCj4gICAgZHJtL3R0bTog
UXVpY2stdGVzdCBtbWFwIG9mZnNldCBpbiB0dG1fYm9fbW1hcCgpCj4gICAgZHJtOiBVc2UgdGhl
IHNhbWUgbW1hcC1yYW5nZSBvZmZzZXQgYW5kIHNpemUgZm9yIEdFTSBhbmQgVFRNCgpUaGUgZmly
c3QgcGF0Y2ggbG9va3MgZ29vZCB0byBtZToKClJldmlld2VkLWJ5OiBIYW5zIGRlIEdvZWRlIDxo
ZGVnb2VkZUByZWRoYXQuY29tPgoKVGhlIHZib3h2aWRlbyBiaXRzIGluIHRoZSBvdGhlciBwYXRj
aGVzIGxvb2sgZ29vZCB0byBtZSB0bzoKCkFja2VkLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPgoKRm9yIHRoZSBvdGhlciBwYXRjaGVzIGluIHRoZSBzZXJpZXMuCgpSZWdh
cmRzLAoKSGFucwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
