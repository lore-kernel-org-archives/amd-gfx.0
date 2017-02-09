From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: shut up #warning for compile testing
Date: Thu, 9 Feb 2017 00:20:49 -0500
Message-ID: <CADnq5_PA2+jkwOZ=pgWuyJ6fZs8yFDmmjff_sFDUDBtdQ5mcyg@mail.gmail.com>
References: <20170201155943.1740947-1-arnd@arndb.de>
 <145f62b4-13da-a796-9c10-7f839224b549@daenzer.net>
 <cd20742b-01c6-612b-6cf2-bcdf19aac0d5@amd.com>
 <9dce4ee4-22af-7ea8-4ce7-4468eee22362@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <9dce4ee4-22af-7ea8-4ce7-4468eee22362@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Junwei Zhang <Jerry.Zhang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Flora Cui <Flora.Cui@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBGZWIgMywgMjAxNyBhdCA1OjE1IEFNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPiBPbiAwMi8wMi8xNyAwNjozNiBQTSwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPj4gQW0gMDIuMDIuMjAxNyB1bSAwNzowOSBzY2hyaWViIE1pY2hlbCBEw6RuemVy
Ogo+Pj4gW1NOSVBdCj4+PiBPVE9IIHRoZSBwZW9wbGUgcnVubmluZyB0aGUga2VybmVsIGFyZW4n
dCBhbHdheXMgdGhlIHNhbWUgcGVvcGxlCj4+PiBidWlsZGluZyBpdCwgc28gdGhlIGRvd25zaWRl
IGlzIHRoYXQgdGhpcyB3b3VsZCBwb3RlbnRpYWxseSBkZWxheQo+Pj4gZ2V0dGluZyBYODZfUEFU
IGVuYWJsZWQuCj4+Cj4+IEFuZCBleGFjdGx5IGZvciB0aGlzIHJlYXNvbiBJIHdvdWxkIHJhdGhl
ciBsaWtlIHRvIGtlZXAgdGhlIHdhcm5pbmcuCj4KPiBSaWdodCwgc28gbGV0J3MgdGFrZSB0aGUg
cGF0Y2ggYXMgaXM6Cj4KPiBSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVu
emVyQGFtZC5jb20+Cj4KCkFwcGxpZWQuICB0aGFua3MhCgpBbGV4Cgo+Cj4gQXJuZCwgY2FuIHlv
dSBtYWtlIHRoZSBjb3JyZXNwb25kaW5nIHBhdGNoIGZvciByYWRlb24gYXMgd2VsbD8gT3RoZXJ3
aXNlCj4gSSBjYW4gcHJvYmFibHkgZG8gaXQgbmV4dCB3ZWVrLgo+Cj4KPiAtLQo+IEVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3
LmFtZC5jb20KPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
