From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/3] GPU-DRM-Radeon: Fine-tuning for three function
 implementations
Date: Fri, 12 May 2017 14:38:38 +0300
Message-ID: <1587529.CdsjPgZMHu@avalon>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
 <8c4e7dde-06d5-3f13-2322-f661e9d3dbf4@daenzer.net>
 <66a88c64-cc8f-45ed-81c6-f7e2947f1f18@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <66a88c64-cc8f-45ed-81c6-f7e2947f1f18@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, SF Markus Elfring <elfring@users.sourceforge.net>, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgQ2hyaXN0aWFuLAoKT24gV2VkbmVzZGF5IDEwIE1heSAyMDE3IDEzOjMwOjM3IENocmlzdGlh
biBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTAuMDUuMjAxNyB1bSAwMjoyMyBzY2hyaWViIE1pY2hlbCBE
w6RuemVyOgo+ID4gT24gMDMvMDUvMTcgMDk6NDYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4gPj4gQW0gMDIuMDUuMjAxNyB1bSAyMjowNCBzY2hyaWViIFNGIE1hcmt1cyBFbGZyaW5nOgo+
ID4+PiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+
Cj4gPj4+IERhdGU6IFR1ZSwgMiBNYXkgMjAxNyAyMjowMDowMiArMDIwMAo+ID4+PiAKPiA+Pj4g
VGhyZWUgdXBkYXRlIHN1Z2dlc3Rpb25zIHdlcmUgdGFrZW4gaW50byBhY2NvdW50Cj4gPj4+IGZy
b20gc3RhdGljIHNvdXJjZSBjb2RlIGFuYWx5c2lzLgo+ID4+PiAKPiA+Pj4gTWFya3VzIEVsZnJp
bmcgKDMpOgo+ID4+PiAgICAgVXNlIHNlcV9wdXRjKCkgaW4gcmFkZW9uX3NhX2JvX2R1bXBfZGVi
dWdfaW5mbygpCj4gPj4+ICAgICBVc2Ugc2VxX3B1dHMoKSBpbiByYWRlb25fZGVidWdmc19wbV9p
bmZvKCkKPiA+Pj4gICAgIFVzZSBzZXFfcHV0cygpIGluIHIxMDBfZGVidWdmc19jcF9jc3FfZmlm
bygpCj4gPj4gCj4gPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiA+IAo+ID4gQmFzZWQgb24KPiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL2FyY2hpdmVzL2RyaS1kZXZlbC8yMDE3LU1heS8xNDA4MzcuaHRtbAo+ID4gYW5k
IGZvbGxvd3VwcywgSSdtIGFmcmFpZCB3ZSdsbCBoYXZlIHRvIG1ha2Ugc3VyZSBNYXJrdXMnIHBh
dGNoZXMgaGF2ZQo+ID4gYmVlbiB0ZXN0ZWQgYWRlcXVhdGVseSBiZWZvcmUgYXBwbHlpbmcgdGhl
bS4KPiAKPiBJIGNhbid0IGp1ZGdlIHRoZSBiYWNrZ3JvdW5kIG9mIHRoYXQgZGVjaXNpb24sIGJ1
dCBhdCBsZWFzdCB0aG9zZSB0cmVlCj4gcGF0Y2hlcyBmb3IgcmFkZW9uIGxvb2tlZCB0cml2aWFs
IHRvIG1lLgo+IAo+IEkgZG9uJ3Qgc2VlIG11Y2ggd2hhdCBjb3VsZCBnbyB3cm9uZyB3aGVuIG1l
cmdpbmcgdGhlbS4KCkZvciB3aGF0IGl0J3Mgd29ydGgsIEkndmUgb25jZSBhcHBsaWVkIGEgcGF0
Y2ggZnJvbSBNYXJrdXMgZm9yIHRoZSB1dmN2aWRlbyAKZHJpdmVyIHRoYXQgc2VlbWVkIHRyaXZp
YWwgYnV0IGVuZGVkIHVwIGludHJvZHVjaW5nIGEgYnJlYWthZ2UgdGhhdCBJIGhhZG4ndCAKY2F1
Z2h0IGR1cmluZyByZXZpZXcuIEkgcmVjb21tZW5kIHJlamVjdGluZyBNYXJrdXMnIHBhdGNoZXMg
dGhhdCBhcmUgbm90IGNsZWFyIAppbXByb3ZlbWVudHMsIGFuZCBjYXJlZnVsbHkgdGVzdGluZyB0
aGUgb3RoZXJzLgoKPiBPbiB0aGUgb3RoZXIgaGFuZCB5b3UgYXJlIHJpZ2h0IHRoYXQgdHJ5aW5n
IHRvIGZpbmQgaGFyZHdhcmUgdG8gdGVzdCB0aGF0Cj4gc3R1ZmYgY291bGQgYmUgY2hhbGxlbmdp
bmcuCgotLSAKUmVnYXJkcywKCkxhdXJlbnQgUGluY2hhcnQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
