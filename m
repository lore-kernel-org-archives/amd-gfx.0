From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/2] dma-buf: keep only not signaled fence in
 reservation_object_add_shared_replace
Date: Tue, 31 Oct 2017 09:45:50 +0100
Message-ID: <3e3c448a-5712-642b-f66b-a0ead4580190@daenzer.net>
References: <20171024135552.2139-1-deathsimple@vodafone.de>
 <5985440d-0928-31c1-4044-0e4ce3385f91@amd.com>
 <e068c538-7c88-8223-3c95-03f3a0edcd2d@gmail.com>
 <ef041966-340b-1ac0-a658-c4e2693a03c2@amd.com>
 <46541d00-cf43-d15f-7f1d-12cfb2612fe9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <46541d00-cf43-d15f-7f1d-12cfb2612fe9@gmail.com>
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
To: christian.koenig@amd.com, Chunming Zhou <zhoucm1@amd.com>, sumit.semwal@linaro.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMzEvMTAvMTcgMDk6NDIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gTG9va3MgbGlr
ZSB2MiBuZXZlciBtYWRlIGl0IHRvIHRoZSBsaXN0LiBJJ3ZlIGp1c3Qgc2VuZCB0aGUgVjIgcGF0
Y2hlcwo+IG9uY2UgbW9yZS4KCkZXSVcsIEkgcmVjZWl2ZWQgeW91ciB2MiBwYXRjaGVzIHllc3Rl
cmRheSwgYW5kIG5vdyB0d2ljZSB0b2RheS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
