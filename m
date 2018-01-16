From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Tue, 16 Jan 2018 15:47:14 +0100
Message-ID: <CAK8P3a3Khufo1SrGV1rYDyr6U85btz8AApprOB0kp9P9GQ1_vA@mail.gmail.com>
References: <20171204131031.1418828-1-arnd@arndb.de>
 <7a8f0af3-89cf-81d2-cedc-3d80905b9458@amd.com>
 <CAK8P3a0N27-_LyVrP5G=JmSw0mTHoGv+a7jwkEf_HivfKzGVww@mail.gmail.com>
 <bdc5c955-0cd4-f2c7-596b-8b3ccc39ef26@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <bdc5c955-0cd4-f2c7-596b-8b3ccc39ef26@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBEZWMgNSwgMjAxNyBhdCA2OjAxIFBNLCBIYXJyeSBXZW50bGFuZCA8aGFycnkud2Vu
dGxhbmRAYW1kLmNvbT4gd3JvdGU6Cj4+Cj4KPiBUaGFua3MsIEFybmQuIFRoaXMgaXMgd2hhdCBJ
IHdhcyBtaXNzaW5nLiBJJ2xsIHRha2UgYW5vdGhlciBsb29rLgo+Cj4gSXQgd291bGQgc3RpbGwg
d29yayB3aXRob3V0IEtDT1YsIGFsdGhvdWdoIEkgYWdyZWUgdGhhdCdzIG5vdCBpZGVhbCBieSBh
bnkgbWVhbnMuCgpBbnkgdXBkYXRlIG9uIHRoaXM/IEkgc2VlIGJ1aWxkaW5nIERDTjEuMCB3aXRo
IEtDT1YgdXNpbmcgZ2NjLTggaXMgc3RpbGwgYnJva2VuLgoKICAgICAgIEFybmQKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
