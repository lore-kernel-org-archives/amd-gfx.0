From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Mon, 27 Mar 2017 09:59:19 +0900
Message-ID: <1565fdaf-d8f4-29a8-6287-a91aac8b3698@daenzer.net>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAGCDoEGuMVnv6rA-y5XDbc6hiNWiTg6nt4e4u2dZObeY8roKXA@mail.gmail.com>
 <8020e778-c9c8-e67b-428a-436f2f1c0d7b@daenzer.net>
 <CAHWPjbXbAo8CVSJDK1GzN=M4pMobMw9XVQVfVeGVM4H=n36vuQ@mail.gmail.com>
 <219c6e11-09d9-d2aa-a04d-20074b4a409b@daenzer.net>
 <CAHWPjbXf1Js+gVWUKSKsereimmi3nduKsn3qEVC3YC=4dqNCzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHWPjbXf1Js+gVWUKSKsereimmi3nduKsn3qEVC3YC=4dqNCzw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Julien Isorce <julien.isorce@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Zachary Michaels <zmichaels@oblong.com>, Julien Isorce <jisorce@oblong.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjUvMDMvMTcgMDM6NTkgQU0sIEp1bGllbiBJc29yY2Ugd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IEkgZG91YmxlIGNoZWNrZWQgYW5kIHlvdSBhcmUgcmlnaHQsIHRoZSBjaGFuZ2UgMCAtPiBp
IHdvcmtzLiAKClRoYW5rcyBmb3IgdGVzdGluZywgZml4IHN1Ym1pdHRlZCBmb3IgcmV2aWV3LgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
