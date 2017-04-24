From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH 0/6] drm: tackle byteorder issues, take two
Date: Mon, 24 Apr 2017 18:06:27 +0100
Message-ID: <CAPj87rP4gRoKCEVmxbkS5CdyO1OKj_5tFRNCkqjoTitohmduRA@mail.gmail.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <484f319e-c2b7-adc8-4ecf-537803cc2eee@daenzer.net>
 <1493019360.19018.21.camel@redhat.com>
 <f6555947-598f-0dfe-b15d-cda291778e8e@daenzer.net>
 <20170424142603.GX30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170424142603.GX30290@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Gerd Hoffmann <kraxel@redhat.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpPbiAyNCBBcHJpbCAyMDE3IGF0IDE1OjI2LCBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5
cmphbGFAbGludXguaW50ZWwuY29tPiB3cm90ZToKPiBPbiBNb24sIEFwciAyNCwgMjAxNyBhdCAw
NDo1NDoyNVBNICswOTAwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMjQvMDQvMTcgMDQ6
MzYgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4+ID4gV2hlbiBydW5uaW5nIGluIG9wZW5nbCBt
b2RlIHRoZXJlIHdpbGwgYmUgYSBoYXJkd2FyZS1zcGVjaWZpYyBtZXNhCj4+ID4gZHJpdmVyIGlu
IHVzZXJzcGFjZSwgd2hpY2ggd2lsbCBlaXRoZXIga25vdyB3aGF0IHRoZSBncHUgdmlldyBpcyAo
Zm9yCj4+ID4gZXhhbXBsZSBiZWNhdXNlIHRoZXJlIGlzIG9ubHkgb25lIHdheSB0byBpbXBsZW1l
bnQgdGhpcyBpbiBoYXJkd2FyZSkgb3IKPj4gPiBpdCBjYW4gdXNlIGhhcmR3YXJlLXNwZWNpZmlj
IGlvY3RscyB0byBhc2sgdGhlIGtlcm5lbCBkcml2ZXIgd2hhdCB0aGUKPj4gPiBncHUgdmlldyBp
cy4KPj4KPj4gTm90IHN1cmUgdGhpcyBjYW4gYmUgaGlkZGVuIGluIHRoZSBPcGVuR0wgZHJpdmVy
LiBIb3cgd291bGQgZS5nLiBhCj4+IFdheWxhbmQgY29tcG9zaXRvciBvciB0aGUgWG9yZyBtb2Rl
c2V0dGluZyBkcml2ZXIga25vdyB3aGljaCBPcGVuR0wKPj4gZm9ybWF0IGNvcnJlc3BvbmRzIHRv
IGEgZ2l2ZW4gRFJNX0ZPUk1BVD8KPgo+IEhvdyBhcmUgR0wgZm9ybWF0cyBkZWZpbmVkPyAvbWUg
bmVlZHMgdG8gZ28gcmVhZCB0aGUgc3BlYyBhZ2Fpbi4KClRoZXkgYXJlbid0LCBwZXIgc2UuIE9u
bHkgcmVsYXRpdmUgdG8gJ25hdGl2ZSBmb3JtYXRzJywgd2hpY2ggZm9yIHRoaXMKZGlzY3Vzc2lv
biBpcyB0aGUgc2V0IG9mIEdCTSBmb3JtYXRzLCB3aGljaCBpcyBpbiB0dXJuIGp1c3QKZHJtX2Zv
dXJjYy5oLgoKQ2hlZXJzLApEYW5pZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
