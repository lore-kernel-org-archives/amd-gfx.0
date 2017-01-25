From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: header should be defining
 _SMU7_CLOCK_POWER_GATING_H_
Date: Wed, 25 Jan 2017 09:26:50 -0500
Message-ID: <CADnq5_OGEHWv63poYszvz+BryRbtQpmh1iivRYMODpktbhWcVA@mail.gmail.com>
References: <20170125120732.25126-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170125120732.25126-1-colin.king@canonical.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBKYW4gMjUsIDIwMTcgYXQgNzowNyBBTSwgQ29saW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPiB3cm90ZToKPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPgo+Cj4gX1NNVTdfQ0xPQ0tfUE9XRVJfR0FUSU5HX0hfIGlzIGJlaW5nIHVz
ZWQgYXMgYSBoZWFkZXIgZ3VhcmQsIGZvbGxvd2VkIGJ5Cj4gYSAjZGVmaW5lIG9mIGEgZGlmZmVy
ZW50IG1hY3JvLiAgRGVmaW5lIF9TTVU3X0NMT0NLX1BPV0VSX0dBVElOR19IXyBpbnN0ZWFkCj4g
dG8gZml4IHRoaXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPgoKVGhhbmtzIGZvciB0aGUgcGF0Y2guICBOaWNvbGFzIGJlYXQgeW91
IHRvIGl0OgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9kcmktZGV2ZWwv
MjAxNy1KYW51YXJ5LzEzMDQ3Ny5odG1sCgoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19jbG9ja3Bvd2VyZ2F0aW5nLmggfCAyICstCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdh
dGluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19jbG9ja3Bv
d2VyZ2F0aW5nLmgKPiBpbmRleCBkNTJhMjhjLi5jOTZlZDllIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5oCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19jbG9ja3Bvd2Vy
Z2F0aW5nLmgKPiBAQCAtMjIsNyArMjIsNyBAQAo+ICAgKi8KPgo+ICAjaWZuZGVmIF9TTVU3X0NM
T0NLX1BPV0VSX0dBVElOR19IXwo+IC0jZGVmaW5lIF9TTVU3X0NMT0NLX19QT1dFUl9HQVRJTkdf
SF8KPiArI2RlZmluZSBfU01VN19DTE9DS19QT1dFUl9HQVRJTkdfSF8KPgo+ICAjaW5jbHVkZSAi
c211N19od21nci5oIgo+ICAjaW5jbHVkZSAicHBfYXNpY2Jsb2Nrcy5oIgo+IC0tCj4gMi4xMC4y
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
