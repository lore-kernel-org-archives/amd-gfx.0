From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drm/amdgpu/display: make various arrays static, makes
 object smaller
Date: Tue, 08 Oct 2019 07:00:13 -0700
Message-ID: <05e9cf0254790321433fd7d2c19129ec952bb3ac.camel@perches.com>
References: <20191007215857.14720-1-colin.king@canonical.com>
 <9579bfae-1db5-d282-79ea-df1966f4c123@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <9579bfae-1db5-d282-79ea-df1966f4c123@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <hwentlan@amd.com>, Colin King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDEzOjU2ICswMDAwLCBIYXJyeSBXZW50bGFuZCB3cm90ZToK
W10KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9i
aW9zX3BhcnNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19w
YXJzZXIuYwo+IFtdCj4gPiBAQCAtMjc0NSw3ICsyNzQ1LDcgQEAgc3RhdGljIGVudW0gYnBfcmVz
dWx0IGJpb3NfZ2V0X2JvYXJkX2xheW91dF9pbmZvKAo+ID4gIAlzdHJ1Y3QgYmlvc19wYXJzZXIg
KmJwOwo+ID4gIAllbnVtIGJwX3Jlc3VsdCByZWNvcmRfcmVzdWx0Owo+ID4gIAo+ID4gLQljb25z
dCB1bnNpZ25lZCBpbnQgc2xvdF9pbmRleF90b192Ymlvc19pZFtNQVhfQk9BUkRfU0xPVFNdID0g
ewo+ID4gKwlzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IHNsb3RfaW5kZXhfdG9fdmJpb3NfaWRb
TUFYX0JPQVJEX1NMT1RTXSA9IHsKPiAKPiBXb24ndCB0aGlzIGJyZWFrIHRoZSBtdWx0aS1HUFUg
Y2FzZSB3aGVyZSB5b3UnbGwgaGF2ZSBtdWx0aXBsZSBkcml2ZXIKPiBpbnN0YW5jZXMgd2l0aCBk
aWZmZXJlbnQgbGF5b3V0PwoKQXMgdGhlIGFycmF5IGlzIHJlYWQtb25seSwgaG93IGNvdWxkIHRo
YXQgaGFwcGVuPwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
