From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related code
Date: Fri, 1 Jun 2018 15:56:23 +0200
Message-ID: <494c2768-4ac8-7282-80dd-122add15b2bb@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net>
 <20180531161708.5894-3-michel@daenzer.net>
 <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com>
 <b458561f-b4e5-58bb-eee0-e3451312ae41@daenzer.net>
 <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_M-kS58ScgOBVQG7Mxxepae9b9gqUdMdFgaPaaxQ4NkjQ@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-doc@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wNi0wMSAwMzo0NCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIEZyaSwgSnVu
IDEsIDIwMTggYXQgOTo0MCBBTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4g
d3JvdGU6Cj4+IE9uIDIwMTgtMDYtMDEgMDI6NTggUE0sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4+
IE9uIFRodSwgTWF5IDMxLCAyMDE4IGF0IDEyOjE3IFBNLCBNaWNoZWwgRMOkbnplciA8bWljaGVs
QGRhZW56ZXIubmV0PiB3cm90ZToKPj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRh
ZW56ZXJAYW1kLmNvbT4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+IFNlcmllcyBpczoKPj4+IFJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Cj4+IFRoYW5rcy4g
SXMgaXQgb2theSB0byBtZXJnZSBhbGwgb2YgdGhlc2UgdmlhIHRoZSBhbWRncHUgdHJlZSwgb3Ig
c2hvdWxkCj4+IEkgd2FpdCBmb3IgYW4gYWNrIGZyb20gSm9uIGFuZC9vciBjb3JlIERSTSBtYWlu
dGFpbmVycyBmb3IgdGhhdD8KPiAKPiBHUFUgZG9jdW1lbnRhdGlvbiB1c3VhbGx5IGdvZXMgdGhy
b3VnaCB0aGUgZHJtIHRyZWVzLiAgWW91IG1pZ2h0IHdhbnQKPiB0byBwdXNoIHBhdGNoIDEgKGRy
bV9tbS5yc3QgZml4KSB2aWEgZHJtX21pc2MsIGJ1dCB0aGUgcmVzdCBhcmUgY2FuIGdvCj4gaW4g
dmlhIHRoZSBhbWRncHUgdHJlZSBzaW5jZSB0aGV5IGFyZSBhbWRncHUgc3BlY2lmaWMuCgpJJ2Qg
cHJlZmVyIG1lcmdpbmcgYWxsIHRocmVlIHBhdGNoZXMgdG9nZXRoZXIsIHNpbmNlIHdpdGhvdXQg
cGF0Y2ggMSwKcGF0Y2ggMyBnZW5lcmF0ZXMgdGhlIHdhcm5pbmcgYmVsb3cgd2hpbGUgZ2VuZXJh
dGluZyBkb2N1bWVudGF0aW9uLCBhbmQKdGhlIHJlZmVyZW5jZSB0byB0aGUgUFJJTUUgQnVmZmVy
IFNoYXJpbmcgc2VjdGlvbiBkb2Vzbid0IHdvcmsuCgouLi4vbGludXgvRG9jdW1lbnRhdGlvbi9n
cHUvYW1kZ3B1LnJzdDoyOiBXQVJOSU5HOiB1bmRlZmluZWQgbGFiZWw6CnByaW1lX2J1ZmZlcl9z
aGFyaW5nIChpZiB0aGUgbGluayBoYXMgbm8gY2FwdGlvbiB0aGUgbGFiZWwgbXVzdCBwcmVjZWRl
CmEgc2VjdGlvbiBoZWFkZXIpCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
