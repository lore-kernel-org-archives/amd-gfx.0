From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: improve GTT BO alloc speed in OGL
Date: Tue, 13 Sep 2016 10:17:23 +0900
Message-ID: <ad77d18c-b74b-a73e-b412-2ce1bc06f9ff@daenzer.net>
References: <1473698681-28637-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1473698681-28637-1-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, "monk.liu" <Monk.Liu@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMTMvMDkvMTYgMDE6NDQgQU0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBGcm9tOiAibW9uay5s
aXUiIDxtb25rLmxpdUBhbWQuY29tPgo+IAo+IG9yaWdpbmFsIHdlIHVzZSB0dG1fZG1hIHBhdGgg
dG8gYWxsb2NhdGUgR1RUIGJvLCB3aGljaCBpcyB0b28gbXVjaAo+IHNsb3dlciB0aGFuIHRoZSBw
YXRoIG9mIHR0bV9wb29sLCBpbiBtb3N0IGNhc2VzLgo+IAo+IFRoZSBzd2lvdGxiIGNoZWNrcyBk
b24ndCBzZWVtIHRvIHdvcmsgYW5kIHdlIGFsd2F5cyBlbmQgdXAgaW4gdGhlCj4gc2xvdyBwYXRo
IGV2ZW4gd2hlbiBhbiBJT01NVSBpcyBhdmFpbGFibGUuCgpUaGlzIGNoYW5nZSB3aWxsIGJyZWFr
IGFueSBjYXNlcyB3aGVyZSBTV0lPVExCIGlzIGFjdHVhbGx5IG5lY2Vzc2FyeQp0aG91Z2gsIHdv
bid0IGl0PwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
