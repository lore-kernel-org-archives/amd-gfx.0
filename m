From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH i-g-t] tests: Rename I915_MAX_PIPES to
 IGT_MAX_PIPES
Date: Fri, 16 Jun 2017 09:25:09 -0400
Message-ID: <b20a0493-8ac5-e04d-f7ae-aa71f8f62e64@amd.com>
References: <1497042784-22210-1-git-send-email-sunpeng.li@amd.com>
 <06254a1a-31ba-1372-a17b-280ae7fc1e21@amd.com>
 <20170612115415.GB2999@ahiler-desk1.ger.corp.intel.com>
 <f8d21da3-d638-3180-10da-f05441c3d34a@amd.com> <87vao0ibll.fsf@intel.com>
 <20170613124114.GA16239@ahiler-desk1.ger.corp.intel.com>
 <20170613125531.GA18562@ahiler-desk1.ger.corp.intel.com>
 <72db08ac-e7e5-3e2c-deec-0d6d0ac0220e@amd.com>
 <20170616105624.GE18562@ahiler-desk1.ger.corp.intel.com>
 <20170616131026.GG18562@ahiler-desk1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170616131026.GG18562-vmkuTAUGE3v8HXaCWoL7+7KMmGWinSIL2HeeBUIffwg@public.gmane.org>
Content-Language: en-US
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
To: Arkadiusz Hiler <arkadiusz.hiler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Leo <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wNi0xNiAwOToxMCBBTSwgQXJrYWRpdXN6IEhpbGVyIHdyb3RlOgo+IE9uIEZyaSwg
SnVuIDE2LCAyMDE3IGF0IDAxOjU2OjI0UE0gKzAzMDAsIEFya2FkaXVzeiBIaWxlciB3cm90ZToK
Pj4gT24gVGh1LCBKdW4gMTUsIDIwMTcgYXQgMTA6MTE6MzZBTSAtMDQwMCwgTGVvIHdyb3RlOgo+
Pj4KPj4+Cj4+PiBPbiAyMDE3LTA2LTEzIDA4OjU1IEFNLCBBcmthZGl1c3ogSGlsZXIgd3JvdGU6
Cj4+Pj4gT24gVHVlLCBKdW4gMTMsIDIwMTcgYXQgMDM6NDE6MTRQTSArMDMwMCwgQXJrYWRpdXN6
IEhpbGVyIHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEp1biAxMywgMjAxNyBhdCAxMDozNTozNEFNICsw
MzAwLCBKYW5pIE5pa3VsYSB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgMTIgSnVuIDIwMTcsIEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPiB3cm90ZToKPj4+Pj4+PiBUaGUgZW1h
aWwgd2FzIHNlbnQgYnV0IG1pZ2h0IGJlIHN0dWNrIGluIHRoZSBtb2RlcmF0aW9uIHF1ZXVlIHNp
bmNlIExlbwo+Pj4+Pj4+IChTdW4gcGVuZykgaXMgZmFpcmx5IG5ldyBvbiB0aGUgRkRPIG1haWxp
bmcgbGlzdHMuCj4+Pj4+Pj4KPj4+Pj4+PiBKYW5pLCBEYW5pZWwsIGNhbiB5b3UgY2hlY2sgaWYg
TGVvJ3MgSUdUIGVtYWlscyBhcmUgc3R1Y2sgaW4gdGhlCj4+Pj4+Pj4gbW9kZXJhdGlvbiBxdWV1
ZT8KPj4+Pj4+Cj4+Pj4+PiBEb25lLiBJJ3ZlIHdoaXRlbGlzdGVkIGhpcyBlbWFpbCBhZGRyZXNz
IG9uIGludGVsLWdmeCwgYnV0IEkgc3VnZ2VzdAo+Pj4+Pj4gc3Vic2NyaWJpbmcgdG9vLgo+Pj4+
Pj4KPj4+Pj4+IEJSLAo+Pj4+Pj4gSmFuaS4KPj4+Pj4KPj4+Pj4gVGhhbmtzIEphbmkuCj4+Pj4+
Cj4+Pj4+IEknbGwgd2FpdCB3aXRoIHB1c2hpbmcgdGhpcyB1bnRpbGwgd2UgcnVuIGl0IHRob3Vn
aCBDSSBzeXN0ZW0gdG8gbWFrZQo+Pj4+PiBzdXJlIG5vdGhpbmcgYnJlYWtzLCBhcyBzdWdnZXN0
ZWQgYnkgUGV0cmkuCj4+Pj4KPj4+PiBUbyBjbGFyaWZ5IC0gdGhpcyBkZXBlbmRzIG9uIHRoZSBz
ZXJpZXMgdGhhdCBjaGFuZ2VzIHRoZSBudW1iZXIgdG8gc2l4LAo+Pj4+IGFuZCB0aGF0J3MgdGhl
IG9uZSB0aGF0IHNob3VsZCB1c2Ugc29tZSB0ZXN0aW5nLgo+Pj4+Cj4+Pj4+IFRoYW5rcyBmb3Ig
dGhlIHBhdGNoIQo+Pj4+Pgo+Pj4+PiAtLSAKPj4+Pj4gQ2hlZXJzLAo+Pj4+PiBBcmVrCj4+Pgo+
Pj4gVGhhbmtzIEphbmkuCj4+Pgo+Pj4gQXJlaywgcmVnYXJkaW5nIENJIC0gYXJlIHRoZXJlIGFu
eSB1cGRhdGVzIG9uIHRoZSB0ZXN0IHJlc3VsdHM/Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gTGVvCj4+
Cj4+IFNvcnJ5IGZvciB0aGUgZGVsYXksIHdlIHdlcmUgcHJlb2NjdXBpZWQgd2l0aCBvdGhlciB0
aGluZ3MuIFRoZSBydW4KPj4gc2hvdWxkIGhhcHBlbiBhZnRlciB0aGUgY3VycmVudCBpbi1mbGln
aHQgb25lLgo+Pgo+PiBJJ2xsIG5vdGlmeSB5b3Ugb2YgdGhlIHJlc3VsdHMgb25jZSB3ZSd2ZSBn
b3QgdGhlbS4KPj4KPj4gVGhhbmtzIGZvciB5b3VyIHBhdGllbmNlLgo+IAo+IFRoZSBwYXRjaCB3
YXMgcmFuIHRocm91Z2ggb3VyIENJIGFuZCBkb2VzIG5vdCBjYXVzZSBhbnkgcmVncmVzc2lvbi4g
SSdsbAo+IHB1c2ggYm90aCBpbiBhIG1vbWVudCAoaW5jcmVhc2luZyB0aGUgbnVtYmVyIHRvIDYg
YW5kIHJlbmFtZSkuCj4gCgpUaGFua3MsIEFyZWsuCgpIYXJyeQoKPiBUaGFua3MhCj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
