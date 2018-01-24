From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] Per file OOM badness
Date: Wed, 24 Jan 2018 12:50:59 +0100
Message-ID: <20180124115059.GC28465@dhcp22.suse.cz>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <36b49523-792d-45f9-8617-32b6d9d77418-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Roman Gushchin <guro-b10kYP2dOMg@public.gmane.org>

T24gV2VkIDI0LTAxLTE4IDEyOjIzOjEwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTAxLTI0IDEyOjAxIFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6Cj4gPiBPbiBXZWQgMjQtMDEtMTgg
MTE6Mjc6MTUsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgpbLi4uXQo+ID4+IDIuIElmIHRoZSBPT00g
a2lsbGVyIGtpbGxzIGEgcHJvY2VzcyB3aGljaCBpcyBzaGFyaW5nIEJPcyB3aXRoIGFub3RoZXIK
PiA+PiBwcm9jZXNzLCB0aGlzIHNob3VsZCByZXN1bHQgaW4gdGhlIG90aGVyIHByb2Nlc3MgZHJv
cHBpbmcgaXRzIHJlZmVyZW5jZXMKPiA+PiB0byB0aGUgQk9zIGFzIHdlbGwsIGF0IHdoaWNoIHBv
aW50IHRoZSBtZW1vcnkgaXMgcmVsZWFzZWQuCj4gPiAKPiA+IE9LLiBIb3cgZXhhY3RseSBhcmUg
dGhvc2UgQk9zIG1hcHBlZCB0byB0aGUgdXNlcnNwYWNlPwo+IAo+IEknbSBub3Qgc3VyZSB3aGF0
IHlvdSdyZSBhc2tpbmcuIFVzZXJzcGFjZSBtb3N0bHkgdXNlcyBhIEdFTSBoYW5kbGUgdG8KPiBy
ZWZlciB0byBhIEJPLiBUaGVyZSBjYW4gYWxzbyBiZSB1c2Vyc3BhY2UgQ1BVIG1hcHBpbmdzIG9m
IHRoZSBCTydzCj4gbWVtb3J5LCBidXQgdXNlcnNwYWNlIGRvZXNuJ3QgbmVlZCBDUFUgbWFwcGlu
Z3MgZm9yIGFsbCBCT3MgYW5kIG9ubHkKPiBjcmVhdGVzIHRoZW0gYXMgbmVlZGVkLgoKT0ssIEkg
Z3Vlc3MgeW91IGhhdmUgdG8gYmVhciB3aXRoIG1lIHNvbWUgbW9yZS4gVGhpcyB3aG9sZSBzdGFj
ayBpcyBhCmNvbXBsZXRlIHVrbm9ud24uIEkgYW0gbW9zdGx5IGFmdGVyIGZpbmRpbmcgYSBib3Vu
ZGFyeSB3aGVyZSB5b3UgY2FuCmNoYXJnZSB0aGUgYWxsb2NhdGVkIG1lbW9yeSB0byB0aGUgcHJv
Y2VzcyBzbyB0aGF0IHRoZSBvb20ga2lsbGVyIGNhbgpjb25zaWRlciBpdC4gSXMgdGhlcmUgYW55
dGhpbmcgbGlrZSB0aGF0PyBFeGNlcHQgZm9yIHRoZSBwcm9wb3NlZCBmaWxlCmhhbmRsZSBoYWNr
PwotLSAKTWljaGFsIEhvY2tvClNVU0UgTGFicwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
