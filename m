From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Thu, 22 Sep 2016 00:13:13 +0900
Message-ID: <f0e034f9-db22-6577-97c7-dd8d3e851226@daenzer.net>
References: <1473293683-6247-1-git-send-email-mario.kleiner.de@gmail.com>
 <20160908063038.GB28919@nuc-i3427.alporthouse.com>
 <9e28ae2e-ed2f-ef0e-8690-1f78f5aed18b@gmail.com>
 <20160908162346.GA5479@nuc-i3427.alporthouse.com>
 <abccc8ac-10c6-ab22-c59d-f43ee48ba78d@daenzer.net>
 <bdd0653d-e4d6-fbbe-89f1-b1104682bf02@vodafone.de>
 <20160913093945.GA25204@nuc-i3427.alporthouse.com>
 <9c0f86d0-eb23-7110-c663-01859132ac83@vodafone.de>
 <7aafce92-8bcf-1c5c-45de-9e8ecda85239@daenzer.net>
 <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, Chris Wilson <chris@chris-wilson.co.uk>, Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjEvMDkvMTYgMDc6MzAgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjEuMDku
MjAxNiB1bSAxMTo1NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pgo+PiBGV0lXLCB3ZSBzZWVt
IHRvIGhhdmUgdGhlIHNhbWUgaXNzdWUgd2l0aCByYWRlb24gdnMuIGFtZGdwdTogcmFkZW9uIG9u
bHkKPj4gc2VlbXMgdG8gd2FpdCBmb3IgZXhjbHVzaXZlIGZlbmNlcywgc28gZS5nLiBydW5uaW5n
IFhvcmcgb24gYW1kZ3B1IGFuZAo+PiB1c2luZyBQUklNRSBzbGF2ZSBzY2Fub3V0IG9uIHJhZGVv
biBsZWF2ZXMgYXJ0aWZhY3RzLgo+IAo+IFllYWgsIEkga25vdy4gU2VlIHJhZGVvbl9kaXNwbGF5
LmMgcmFkZW9uX2ZsaXBfd29ya19mdW5jKCkuCj4gCj4gV2UgcHJldHR5IG11Y2ggbmVlZCB0aGUg
c2FtZSBwYXRjaCBoZXJlIEkndmUgZG9uZSBmb3IgYW1kZ3B1IGFzIHdlbGwuCgpBY3R1YWxseSwg
dGhlIFBSSU1FIHNsYXZlIGNhbid0IHNjYW4gb3V0IGZyb20gdGhlIHNoYXJlZCBCT3MgZGlyZWN0
bHkKKHJlY2FsbCB0aGUgcmVjZW50IGRpc2N1c3Npb24gd2UgaGFkIGFib3V0IHRoYXQgd2l0aCBN
YXJpbyksIGJ1dCBoYXMgdG8KY29weSBmcm9tIHRoZSBzaGFyZWQgQk8gdG8gYSBkZWRpY2F0ZWQg
c2Nhbm91dCBCTy4gVGhlc2UgY29waWVzIG5lZWQgdG8KYmUgc3luY2hyb25pemVkIHdpdGggdGhl
IHByaW1hcnkgR1BVJ3MgY29waWVzIHRvIHRoZSBzaGFyZWQgQk8uCgoKLS0gCkVhcnRobGluZyBN
aWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFt
ZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAg
IE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
