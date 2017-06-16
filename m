From: Arkadiusz Hiler <arkadiusz.hiler@intel.com>
Subject: Re: [PATCH i-g-t] tests: Rename I915_MAX_PIPES to
 IGT_MAX_PIPES
Date: Fri, 16 Jun 2017 13:56:24 +0300
Message-ID: <20170616105624.GE18562@ahiler-desk1.ger.corp.intel.com>
References: <1497042784-22210-1-git-send-email-sunpeng.li@amd.com>
 <06254a1a-31ba-1372-a17b-280ae7fc1e21@amd.com>
 <20170612115415.GB2999@ahiler-desk1.ger.corp.intel.com>
 <f8d21da3-d638-3180-10da-f05441c3d34a@amd.com>
 <87vao0ibll.fsf@intel.com>
 <20170613124114.GA16239@ahiler-desk1.ger.corp.intel.com>
 <20170613125531.GA18562@ahiler-desk1.ger.corp.intel.com>
 <72db08ac-e7e5-3e2c-deec-0d6d0ac0220e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <72db08ac-e7e5-3e2c-deec-0d6d0ac0220e@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Leo <sunpeng.li@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdW4gMTUsIDIwMTcgYXQgMTA6MTE6MzZBTSAtMDQwMCwgTGVvIHdyb3RlOgo+IAo+
IAo+IE9uIDIwMTctMDYtMTMgMDg6NTUgQU0sIEFya2FkaXVzeiBIaWxlciB3cm90ZToKPiA+IE9u
IFR1ZSwgSnVuIDEzLCAyMDE3IGF0IDAzOjQxOjE0UE0gKzAzMDAsIEFya2FkaXVzeiBIaWxlciB3
cm90ZToKPiA+ID4gT24gVHVlLCBKdW4gMTMsIDIwMTcgYXQgMTA6MzU6MzRBTSArMDMwMCwgSmFu
aSBOaWt1bGEgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCAxMiBKdW4gMjAxNywgSGFycnkgV2VudGxh
bmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gVGhlIGVtYWlsIHdh
cyBzZW50IGJ1dCBtaWdodCBiZSBzdHVjayBpbiB0aGUgbW9kZXJhdGlvbiBxdWV1ZSBzaW5jZSBM
ZW8KPiA+ID4gPiA+IChTdW4gcGVuZykgaXMgZmFpcmx5IG5ldyBvbiB0aGUgRkRPIG1haWxpbmcg
bGlzdHMuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEphbmksIERhbmllbCwgY2FuIHlvdSBjaGVjayBp
ZiBMZW8ncyBJR1QgZW1haWxzIGFyZSBzdHVjayBpbiB0aGUKPiA+ID4gPiA+IG1vZGVyYXRpb24g
cXVldWU/Cj4gPiA+ID4gCj4gPiA+ID4gRG9uZS4gSSd2ZSB3aGl0ZWxpc3RlZCBoaXMgZW1haWwg
YWRkcmVzcyBvbiBpbnRlbC1nZngsIGJ1dCBJIHN1Z2dlc3QKPiA+ID4gPiBzdWJzY3JpYmluZyB0
b28uCj4gPiA+ID4gCj4gPiA+ID4gQlIsCj4gPiA+ID4gSmFuaS4KPiA+ID4gCj4gPiA+IFRoYW5r
cyBKYW5pLgo+ID4gPiAKPiA+ID4gSSdsbCB3YWl0IHdpdGggcHVzaGluZyB0aGlzIHVudGlsbCB3
ZSBydW4gaXQgdGhvdWdoIENJIHN5c3RlbSB0byBtYWtlCj4gPiA+IHN1cmUgbm90aGluZyBicmVh
a3MsIGFzIHN1Z2dlc3RlZCBieSBQZXRyaS4KPiA+IAo+ID4gVG8gY2xhcmlmeSAtIHRoaXMgZGVw
ZW5kcyBvbiB0aGUgc2VyaWVzIHRoYXQgY2hhbmdlcyB0aGUgbnVtYmVyIHRvIHNpeCwKPiA+IGFu
ZCB0aGF0J3MgdGhlIG9uZSB0aGF0IHNob3VsZCB1c2Ugc29tZSB0ZXN0aW5nLgo+ID4gCj4gPiA+
IFRoYW5rcyBmb3IgdGhlIHBhdGNoIQo+ID4gPiAKPiA+ID4gLS0gCj4gPiA+IENoZWVycywKPiA+
ID4gQXJlawo+IAo+IFRoYW5rcyBKYW5pLgo+IAo+IEFyZWssIHJlZ2FyZGluZyBDSSAtIGFyZSB0
aGVyZSBhbnkgdXBkYXRlcyBvbiB0aGUgdGVzdCByZXN1bHRzPwo+IAo+IFRoYW5rcywKPiBMZW8K
ClNvcnJ5IGZvciB0aGUgZGVsYXksIHdlIHdlcmUgcHJlb2NjdXBpZWQgd2l0aCBvdGhlciB0aGlu
Z3MuIFRoZSBydW4Kc2hvdWxkIGhhcHBlbiBhZnRlciB0aGUgY3VycmVudCBpbi1mbGlnaHQgb25l
LgoKSSdsbCBub3RpZnkgeW91IG9mIHRoZSByZXN1bHRzIG9uY2Ugd2UndmUgZ290IHRoZW0uCgpU
aGFua3MgZm9yIHlvdXIgcGF0aWVuY2UuCgotLSAKQ2hlZXJzLApBcmVrCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QK
SW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
