From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] Per file OOM badness
Date: Tue, 30 Jan 2018 11:28:55 +0100
Message-ID: <20180130102855.GY21609@dhcp22.suse.cz>
References: <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
 <60e18da8-4d6e-dec9-7aef-ff003605d513@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <60e18da8-4d6e-dec9-7aef-ff003605d513@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlIDMwLTAxLTE4IDEwOjI5OjEwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTAxLTI0IDEyOjUwIFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6Cj4gPiBPbiBXZWQgMjQtMDEtMTgg
MTI6MjM6MTAsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+ID4+IE9uIDIwMTgtMDEtMjQgMTI6MDEg
UE0sIE1pY2hhbCBIb2NrbyB3cm90ZToKPiA+Pj4gT24gV2VkIDI0LTAxLTE4IDExOjI3OjE1LCBN
aWNoZWwgRMOkbnplciB3cm90ZToKPiA+IFsuLi5dCj4gPj4+PiAyLiBJZiB0aGUgT09NIGtpbGxl
ciBraWxscyBhIHByb2Nlc3Mgd2hpY2ggaXMgc2hhcmluZyBCT3Mgd2l0aCBhbm90aGVyCj4gPj4+
PiBwcm9jZXNzLCB0aGlzIHNob3VsZCByZXN1bHQgaW4gdGhlIG90aGVyIHByb2Nlc3MgZHJvcHBp
bmcgaXRzIHJlZmVyZW5jZXMKPiA+Pj4+IHRvIHRoZSBCT3MgYXMgd2VsbCwgYXQgd2hpY2ggcG9p
bnQgdGhlIG1lbW9yeSBpcyByZWxlYXNlZC4KPiA+Pj4KPiA+Pj4gT0suIEhvdyBleGFjdGx5IGFy
ZSB0aG9zZSBCT3MgbWFwcGVkIHRvIHRoZSB1c2Vyc3BhY2U/Cj4gPj4KPiA+PiBJJ20gbm90IHN1
cmUgd2hhdCB5b3UncmUgYXNraW5nLiBVc2Vyc3BhY2UgbW9zdGx5IHVzZXMgYSBHRU0gaGFuZGxl
IHRvCj4gPj4gcmVmZXIgdG8gYSBCTy4gVGhlcmUgY2FuIGFsc28gYmUgdXNlcnNwYWNlIENQVSBt
YXBwaW5ncyBvZiB0aGUgQk8ncwo+ID4+IG1lbW9yeSwgYnV0IHVzZXJzcGFjZSBkb2Vzbid0IG5l
ZWQgQ1BVIG1hcHBpbmdzIGZvciBhbGwgQk9zIGFuZCBvbmx5Cj4gPj4gY3JlYXRlcyB0aGVtIGFz
IG5lZWRlZC4KPiA+IAo+ID4gT0ssIEkgZ3Vlc3MgeW91IGhhdmUgdG8gYmVhciB3aXRoIG1lIHNv
bWUgbW9yZS4gVGhpcyB3aG9sZSBzdGFjayBpcyBhCj4gPiBjb21wbGV0ZSB1a25vbnduLiBJIGFt
IG1vc3RseSBhZnRlciBmaW5kaW5nIGEgYm91bmRhcnkgd2hlcmUgeW91IGNhbgo+ID4gY2hhcmdl
IHRoZSBhbGxvY2F0ZWQgbWVtb3J5IHRvIHRoZSBwcm9jZXNzIHNvIHRoYXQgdGhlIG9vbSBraWxs
ZXIgY2FuCj4gPiBjb25zaWRlciBpdC4gSXMgdGhlcmUgYW55dGhpbmcgbGlrZSB0aGF0PyBFeGNl
cHQgZm9yIHRoZSBwcm9wb3NlZCBmaWxlCj4gPiBoYW5kbGUgaGFjaz8KPiAKPiBIb3cgYWJvdXQg
dGhlIG90aGVyIHdheSBhcm91bmQ6IHdoYXQgQVBJcyBjYW4gd2UgdXNlIHRvIGNoYXJnZSAvCj4g
InVuY2hhcmdlIiBtZW1vcnkgdG8gYSBwcm9jZXNzPyBJZiB3ZSBoYXZlIHRob3NlLCB3ZSBjYW4g
ZXhwZXJpbWVudCB3aXRoCj4gZGlmZmVyZW50IHBsYWNlcyB0byBjYWxsIHRoZW0uCgphZGRfbW1f
Y291bnRlcigpIGFuZCBJIHdvdWxkIGFkZCBhIG5ldyBjb3VudGVyIGUuZy4gTU1fS0VSTkVMX1BB
R0VTLgoKLS0gCk1pY2hhbCBIb2NrbwpTVVNFIExhYnMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
