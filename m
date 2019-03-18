From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdkfd: Fix unchecked return value
Date: Mon, 18 Mar 2019 13:49:27 -0500
Message-ID: <d4dbee0f-398d-28c4-8f57-9aabfd202722@embeddedor.com>
References: <20190318180525.GA13768@embeddedor>
 <20ac3fa8-0889-60ba-f2c9-52ba91982c22@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20ac3fa8-0889-60ba-f2c9-52ba91982c22@amd.com>
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
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAzLzE4LzE5IDE6MjUgUE0sIEt1ZWhsaW5nLCBGZWxpeCB3cm90ZToKPiBBbGV4IGFscmVh
ZHkgYXBwbGllZCBhbiBlcXVpdmFsZW50IHBhdGNoIGJ5IENvbGluIEtpbmcgKGF0dGFjaGVkIGZv
ciAKPiByZWZlcmVuY2UpLgo+IAoKT2gsIHRoYXQncyBncmVhdC4gIEdvb2QgdG8ga25vdy4KClRo
YW5rcywgRmVsaXguCi0tCkd1c3Rhdm8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
