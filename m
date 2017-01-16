From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: Remove flip_flag from amdgpu_crtc
Date: Tue, 17 Jan 2017 00:15:02 +0200
Message-ID: <4263487.dgH0XJJ2RW@avalon>
References: <1484581498-32309-1-git-send-email-Andrey.Grodzovsky@amd.com>
 <1484581498-32309-3-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1484581498-32309-3-git-send-email-Andrey.Grodzovsky@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, daniel.vetter@intel.com, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgQW5kcmV5LAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgpPbiBNb25kYXkgMTYgSmFuIDIw
MTcgMTA6NDQ6NTYgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gRm9sbHdpbmcgaW50cm9kdWN0
aW9uIG9mIHBmbGlwX2ZsYWdzIGluIGRybV9wbGFuZV9zdGF0ZQo+IHRoaXMgaXMgbm90IG5lZWRl
ZCBhbnltb3JlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXku
R3JvZHpvdnNreUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfbW9kZS5oIHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmggaW5kZXggNGMwYTg2ZS4u
M2ZmM2MxNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
bW9kZS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaAo+
IEBAIC00NDMsNyArNDQzLDYgQEAgc3RydWN0IGFtZGdwdV9jcnRjIHsKPiAgCWVudW0gYW1kZ3B1
X2ludGVycnVwdF9zdGF0ZSB2c3luY190aW1lcl9lbmFibGVkOwo+IAo+ICAJaW50IG90Z19pbnN0
Owo+IC0JdWludDMyX3QgZmxpcF9mbGFnczsKClRoaXMgYnJlYWtzIGNvbXBpbGF0aW9uIG9mIHRo
ZSBhbWRncHUgZHJpdmVyLiBZb3Ugc2hvdWxkIHNxdWFzaCB0aGlzIHBhdGNoIAp3aXRoIDMvNC4K
Cj4gIAkvKiBBZnRlciBTZXQgTW9kZSB0YXJnZXQgd2lsbCBiZSBub24tTlVMTCAqLwo+ICAJc3Ry
dWN0IGRjX3RhcmdldCAqdGFyZ2V0Owo+ICB9OwoKLS0gClJlZ2FyZHMsCgpMYXVyZW50IFBpbmNo
YXJ0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
