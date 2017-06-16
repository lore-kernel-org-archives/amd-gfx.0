From: Arkadiusz Hiler <arkadiusz.hiler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH i-g-t] tests: Rename I915_MAX_PIPES to
 IGT_MAX_PIPES
Date: Fri, 16 Jun 2017 16:10:26 +0300
Message-ID: <20170616131026.GG18562@ahiler-desk1.ger.corp.intel.com>
References: <1497042784-22210-1-git-send-email-sunpeng.li@amd.com>
 <06254a1a-31ba-1372-a17b-280ae7fc1e21@amd.com>
 <20170612115415.GB2999@ahiler-desk1.ger.corp.intel.com>
 <f8d21da3-d638-3180-10da-f05441c3d34a@amd.com>
 <87vao0ibll.fsf@intel.com>
 <20170613124114.GA16239@ahiler-desk1.ger.corp.intel.com>
 <20170613125531.GA18562@ahiler-desk1.ger.corp.intel.com>
 <72db08ac-e7e5-3e2c-deec-0d6d0ac0220e@amd.com>
 <20170616105624.GE18562@ahiler-desk1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170616105624.GE18562-vmkuTAUGE3v8HXaCWoL7+7KMmGWinSIL2HeeBUIffwg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Leo <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRnJpLCBKdW4gMTYsIDIwMTcgYXQgMDE6NTY6MjRQTSArMDMwMCwgQXJrYWRpdXN6IEhpbGVy
IHdyb3RlOgo+IE9uIFRodSwgSnVuIDE1LCAyMDE3IGF0IDEwOjExOjM2QU0gLTA0MDAsIExlbyB3
cm90ZToKPiA+IAo+ID4gCj4gPiBPbiAyMDE3LTA2LTEzIDA4OjU1IEFNLCBBcmthZGl1c3ogSGls
ZXIgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgSnVuIDEzLCAyMDE3IGF0IDAzOjQxOjE0UE0gKzAzMDAs
IEFya2FkaXVzeiBIaWxlciB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIEp1biAxMywgMjAxNyBhdCAx
MDozNTozNEFNICswMzAwLCBKYW5pIE5pa3VsYSB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgMTIg
SnVuIDIwMTcsIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPiB3cm90ZToK
PiA+ID4gPiA+ID4gVGhlIGVtYWlsIHdhcyBzZW50IGJ1dCBtaWdodCBiZSBzdHVjayBpbiB0aGUg
bW9kZXJhdGlvbiBxdWV1ZSBzaW5jZSBMZW8KPiA+ID4gPiA+ID4gKFN1biBwZW5nKSBpcyBmYWly
bHkgbmV3IG9uIHRoZSBGRE8gbWFpbGluZyBsaXN0cy4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IEphbmksIERhbmllbCwgY2FuIHlvdSBjaGVjayBpZiBMZW8ncyBJR1QgZW1haWxzIGFyZSBzdHVj
ayBpbiB0aGUKPiA+ID4gPiA+ID4gbW9kZXJhdGlvbiBxdWV1ZT8KPiA+ID4gPiA+IAo+ID4gPiA+
ID4gRG9uZS4gSSd2ZSB3aGl0ZWxpc3RlZCBoaXMgZW1haWwgYWRkcmVzcyBvbiBpbnRlbC1nZngs
IGJ1dCBJIHN1Z2dlc3QKPiA+ID4gPiA+IHN1YnNjcmliaW5nIHRvby4KPiA+ID4gPiA+IAo+ID4g
PiA+ID4gQlIsCj4gPiA+ID4gPiBKYW5pLgo+ID4gPiA+IAo+ID4gPiA+IFRoYW5rcyBKYW5pLgo+
ID4gPiA+IAo+ID4gPiA+IEknbGwgd2FpdCB3aXRoIHB1c2hpbmcgdGhpcyB1bnRpbGwgd2UgcnVu
IGl0IHRob3VnaCBDSSBzeXN0ZW0gdG8gbWFrZQo+ID4gPiA+IHN1cmUgbm90aGluZyBicmVha3Ms
IGFzIHN1Z2dlc3RlZCBieSBQZXRyaS4KPiA+ID4gCj4gPiA+IFRvIGNsYXJpZnkgLSB0aGlzIGRl
cGVuZHMgb24gdGhlIHNlcmllcyB0aGF0IGNoYW5nZXMgdGhlIG51bWJlciB0byBzaXgsCj4gPiA+
IGFuZCB0aGF0J3MgdGhlIG9uZSB0aGF0IHNob3VsZCB1c2Ugc29tZSB0ZXN0aW5nLgo+ID4gPiAK
PiA+ID4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaCEKPiA+ID4gPiAKPiA+ID4gPiAtLSAKPiA+ID4g
PiBDaGVlcnMsCj4gPiA+ID4gQXJlawo+ID4gCj4gPiBUaGFua3MgSmFuaS4KPiA+IAo+ID4gQXJl
aywgcmVnYXJkaW5nIENJIC0gYXJlIHRoZXJlIGFueSB1cGRhdGVzIG9uIHRoZSB0ZXN0IHJlc3Vs
dHM/Cj4gPiAKPiA+IFRoYW5rcywKPiA+IExlbwo+IAo+IFNvcnJ5IGZvciB0aGUgZGVsYXksIHdl
IHdlcmUgcHJlb2NjdXBpZWQgd2l0aCBvdGhlciB0aGluZ3MuIFRoZSBydW4KPiBzaG91bGQgaGFw
cGVuIGFmdGVyIHRoZSBjdXJyZW50IGluLWZsaWdodCBvbmUuCj4gCj4gSSdsbCBub3RpZnkgeW91
IG9mIHRoZSByZXN1bHRzIG9uY2Ugd2UndmUgZ290IHRoZW0uCj4gCj4gVGhhbmtzIGZvciB5b3Vy
IHBhdGllbmNlLgoKVGhlIHBhdGNoIHdhcyByYW4gdGhyb3VnaCBvdXIgQ0kgYW5kIGRvZXMgbm90
IGNhdXNlIGFueSByZWdyZXNzaW9uLiBJJ2xsCnB1c2ggYm90aCBpbiBhIG1vbWVudCAoaW5jcmVh
c2luZyB0aGUgbnVtYmVyIHRvIDYgYW5kIHJlbmFtZSkuCgpUaGFua3MhCgotLSAKQ2hlZXJzLApB
cmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
