From: Leo <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH i-g-t] tests: Rename I915_MAX_PIPES to
 IGT_MAX_PIPES
Date: Thu, 15 Jun 2017 10:11:36 -0400
Message-ID: <72db08ac-e7e5-3e2c-deec-0d6d0ac0220e@amd.com>
References: <1497042784-22210-1-git-send-email-sunpeng.li@amd.com>
 <06254a1a-31ba-1372-a17b-280ae7fc1e21@amd.com>
 <20170612115415.GB2999@ahiler-desk1.ger.corp.intel.com>
 <f8d21da3-d638-3180-10da-f05441c3d34a@amd.com> <87vao0ibll.fsf@intel.com>
 <20170613124114.GA16239@ahiler-desk1.ger.corp.intel.com>
 <20170613125531.GA18562@ahiler-desk1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170613125531.GA18562-vmkuTAUGE3v8HXaCWoL7+7KMmGWinSIL2HeeBUIffwg@public.gmane.org>
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
To: Arkadiusz Hiler <arkadiusz.hiler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE3LTA2LTEzIDA4OjU1IEFNLCBBcmthZGl1c3ogSGlsZXIgd3JvdGU6Cj4gT24gVHVl
LCBKdW4gMTMsIDIwMTcgYXQgMDM6NDE6MTRQTSArMDMwMCwgQXJrYWRpdXN6IEhpbGVyIHdyb3Rl
Ogo+PiBPbiBUdWUsIEp1biAxMywgMjAxNyBhdCAxMDozNTozNEFNICswMzAwLCBKYW5pIE5pa3Vs
YSB3cm90ZToKPj4+IE9uIE1vbiwgMTIgSnVuIDIwMTcsIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53
ZW50bGFuZEBhbWQuY29tPiB3cm90ZToKPj4+PiBUaGUgZW1haWwgd2FzIHNlbnQgYnV0IG1pZ2h0
IGJlIHN0dWNrIGluIHRoZSBtb2RlcmF0aW9uIHF1ZXVlIHNpbmNlIExlbwo+Pj4+IChTdW4gcGVu
ZykgaXMgZmFpcmx5IG5ldyBvbiB0aGUgRkRPIG1haWxpbmcgbGlzdHMuCj4+Pj4KPj4+PiBKYW5p
LCBEYW5pZWwsIGNhbiB5b3UgY2hlY2sgaWYgTGVvJ3MgSUdUIGVtYWlscyBhcmUgc3R1Y2sgaW4g
dGhlCj4+Pj4gbW9kZXJhdGlvbiBxdWV1ZT8KPj4+Cj4+PiBEb25lLiBJJ3ZlIHdoaXRlbGlzdGVk
IGhpcyBlbWFpbCBhZGRyZXNzIG9uIGludGVsLWdmeCwgYnV0IEkgc3VnZ2VzdAo+Pj4gc3Vic2Ny
aWJpbmcgdG9vLgo+Pj4KPj4+IEJSLAo+Pj4gSmFuaS4KPj4KPj4gVGhhbmtzIEphbmkuCj4+Cj4+
IEknbGwgd2FpdCB3aXRoIHB1c2hpbmcgdGhpcyB1bnRpbGwgd2UgcnVuIGl0IHRob3VnaCBDSSBz
eXN0ZW0gdG8gbWFrZQo+PiBzdXJlIG5vdGhpbmcgYnJlYWtzLCBhcyBzdWdnZXN0ZWQgYnkgUGV0
cmkuCj4gCj4gVG8gY2xhcmlmeSAtIHRoaXMgZGVwZW5kcyBvbiB0aGUgc2VyaWVzIHRoYXQgY2hh
bmdlcyB0aGUgbnVtYmVyIHRvIHNpeCwKPiBhbmQgdGhhdCdzIHRoZSBvbmUgdGhhdCBzaG91bGQg
dXNlIHNvbWUgdGVzdGluZy4KPiAKPj4gVGhhbmtzIGZvciB0aGUgcGF0Y2ghCj4+Cj4+IC0tIAo+
PiBDaGVlcnMsCj4+IEFyZWsKClRoYW5rcyBKYW5pLgoKQXJlaywgcmVnYXJkaW5nIENJIC0gYXJl
IHRoZXJlIGFueSB1cGRhdGVzIG9uIHRoZSB0ZXN0IHJlc3VsdHM/CgpUaGFua3MsCkxlbwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
