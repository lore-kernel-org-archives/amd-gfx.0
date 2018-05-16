From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/scheduler: Remove obsolete spinlock.
Date: Wed, 16 May 2018 15:00:00 +0200
Message-ID: <1526475600.10230.3.camel@pengutronix.de>
References: <1526412674-15913-1-git-send-email-andrey.grodzovsky@amd.com>
 <1526412674-15913-2-git-send-email-andrey.grodzovsky@amd.com>
 <dda4fb88-e228-e10b-46a5-27ba9888b78d@amd.com>
 <MWHPR12MB14530840CD7DB545DD286827EA920@MWHPR12MB1453.namprd12.prod.outlook.com>
 <3a54ce0c-6821-9c94-a67f-2b1a3c74959d@amd.com>
 <8f358856-f16d-3622-d28b-32fed49ba4aa@amd.com>
 <0d936838-8a88-9bd7-d4ff-053cd73f41cc@gmail.com>
 <72266649-c75c-15d3-41b6-59f2dd10235d@amd.com>
 <0be3bb9a-004a-7390-469c-3f974ed44055@amd.com>
 <1526473713.10230.1.camel@pengutronix.de>
 <755d0607-4191-55d2-a21a-9a87305499ad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <755d0607-4191-55d2-a21a-9a87305499ad@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gTWl0dHdvY2gsIGRlbiAxNi4wNS4yMDE4LCAxNDozMiArMDIwMCBzY2hyaWViIENocmlzdGlh
biBLw7ZuaWc6Cj4gQW0gMTYuMDUuMjAxOCB1bSAxNDoyOCBzY2hyaWViIEx1Y2FzIFN0YWNoOgo+
ID4gQW0gTWl0dHdvY2gsIGRlbiAxNi4wNS4yMDE4LCAxNDowOCArMDIwMCBzY2hyaWViIENocmlz
dGlhbiBLw7ZuaWc6Cj4gPiA+IFllcywgZXhhY3RseS4KPiA+ID4gCj4gPiA+IEZvciBub3JtYWwg
dXNlciBzcGFjZSBjb21tYW5kIHN1Ym1pc3Npb24gd2Ugc2hvdWxkIGhhdmUgdG9ucyBvZgo+ID4g
PiBsb2Nrcwo+ID4gPiBndWFyYW50ZWVpbmcgdGhhdCAoZS5nLiBqdXN0IHRoZSBWTSBsb2NrIHNo
b3VsZCBkbykuCj4gPiA+IAo+ID4gPiBGb3Iga2VybmVsIG1vdmVzIHdlIGhhdmUgdGhlIG11dGV4
IGZvciB0aGUgR1RUIHdpbmRvd3Mgd2hpY2gKPiA+ID4gcHJvdGVjdHMKPiA+ID4gaXQuCj4gPiA+
IAo+ID4gPiBUaGUgY291bGQgYmUgcHJvYmxlbXMgd2l0aCB0aGUgVVZEL1ZDRSBxdWV1ZXMgdG8g
Y2xlYW51cCB0aGUKPiA+ID4gaGFuZGxlcwo+ID4gPiB3aGVuIGFuIGFwcGxpY2F0aW9uIGNyYXNo
ZXMuCj4gPiAKPiA+IEZXSVcsIGV0bmF2aXYgaXMgY3VycmVudGx5IGNvbXBsZXRlbHkgdW5sb2Nr
ZWQgaW4gdGhpcyBwYXRoLCBidXQgSQo+ID4gYmVsaWV2ZSB0aGF0IHRoaXMgaXNuJ3QgYW4gaXNz
dWUgYXMgdGhlIHNjaGVkIGZlbmNlIHNlcSBudW1iZXJzIGFyZQo+ID4gcGVyCj4gPiBlbnRpdHku
IFNvIHRvIGFjdHVhbGx5IGVuZCB1cCB3aXRoIHJldmVyc2VkIHNlcW5vcyBvbmUgY29udGV4dCBo
YXMKPiA+IHRvCj4gPiBwcmVlbXB0IGl0c2VsZiB0byBkbyBhbm90aGVyIHN1Ym1pdCwgd2hpbGUg
dGhlIGN1cnJlbnQgb25lIGhhc24ndAo+ID4gcmV0dXJuZWQgZnJvbSBrZXJuZWwgc3BhY2UsIHdo
aWNoIEkgYmVsaWV2ZSBpcyBhIGZhaXJseSB0aGVvcmV0aWNhbAo+ID4gaXNzdWUuIElzIG15IHVu
ZGVyc3RhbmRpbmcgY29ycmVjdD8KPiAKPiBZZXMuIFRoZSBwcm9ibGVtIGlzIHdpdGggdGhlIHJp
Z2h0IHRpbWluZyB0aGlzIGNhbiBiZSB1c2VkIHRvIGFjY2Vzc8KgCj4gZnJlZWQgdXAgbWVtb3J5
Lgo+IAo+IElmIHlvdSB0aGVuIG1hbmFnZSB0byBwbGFjZSBhIHBhZ2UgdGFibGUgaW4gdGhhdCBm
cmVlZCB1cCBtZW1vcnkKPiB0YWtpbmfCoAo+IG92ZXIgdGhlIHN5c3RlbSBpcyBqdXN0IGEgdHlw
aW5nIGV4ZXJjaXNlLgoKVGhhbmtzLiBJIGJlbGlldmUgd2UgZG9uJ3QgaGF2ZSB0aGlzIHByb2Js
ZW0gaW4gZXRuYXZpdiwgYXMgbWVtb3J5CnJlZmVyZW5jaW5nIGlzIHRpZWQgdG8gdGhlIGpvYiBh
bmQgd2lsbCBvbmx5IGJlIHVucmVmZXJlbmNlZCBvbgpmcmVlX2pvYiwgYnV0IEknbGwgcmUtY2hl
Y2sgdGhpcyB3aGVuIEkndmUgZ290IHNvbWUgdGltZS4KClJlZ2FyZHMsCkx1Y2FzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
