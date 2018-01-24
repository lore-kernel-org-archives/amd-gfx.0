From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [RFC] Per file OOM badness
Date: Wed, 24 Jan 2018 15:31:28 +0100
Message-ID: <0a320079-c08c-0762-6967-9e85f24c8e9d@daenzer.net>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180124115059.GC28465-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
Content-Language: en-CA
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
To: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Roman Gushchin <guro-b10kYP2dOMg@public.gmane.org>

T24gMjAxOC0wMS0yNCAxMjo1MCBQTSwgTWljaGFsIEhvY2tvIHdyb3RlOgo+IE9uIFdlZCAyNC0w
MS0xOCAxMjoyMzoxMCwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIwMTgtMDEtMjQgMTI6
MDEgUE0sIE1pY2hhbCBIb2NrbyB3cm90ZToKPj4+IE9uIFdlZCAyNC0wMS0xOCAxMToyNzoxNSwg
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gWy4uLl0KPj4+PiAyLiBJZiB0aGUgT09NIGtpbGxlciBr
aWxscyBhIHByb2Nlc3Mgd2hpY2ggaXMgc2hhcmluZyBCT3Mgd2l0aCBhbm90aGVyCj4+Pj4gcHJv
Y2VzcywgdGhpcyBzaG91bGQgcmVzdWx0IGluIHRoZSBvdGhlciBwcm9jZXNzIGRyb3BwaW5nIGl0
cyByZWZlcmVuY2VzCj4+Pj4gdG8gdGhlIEJPcyBhcyB3ZWxsLCBhdCB3aGljaCBwb2ludCB0aGUg
bWVtb3J5IGlzIHJlbGVhc2VkLgo+Pj4KPj4+IE9LLiBIb3cgZXhhY3RseSBhcmUgdGhvc2UgQk9z
IG1hcHBlZCB0byB0aGUgdXNlcnNwYWNlPwo+Pgo+PiBJJ20gbm90IHN1cmUgd2hhdCB5b3UncmUg
YXNraW5nLiBVc2Vyc3BhY2UgbW9zdGx5IHVzZXMgYSBHRU0gaGFuZGxlIHRvCj4+IHJlZmVyIHRv
IGEgQk8uIFRoZXJlIGNhbiBhbHNvIGJlIHVzZXJzcGFjZSBDUFUgbWFwcGluZ3Mgb2YgdGhlIEJP
J3MKPj4gbWVtb3J5LCBidXQgdXNlcnNwYWNlIGRvZXNuJ3QgbmVlZCBDUFUgbWFwcGluZ3MgZm9y
IGFsbCBCT3MgYW5kIG9ubHkKPj4gY3JlYXRlcyB0aGVtIGFzIG5lZWRlZC4KPiAKPiBPSywgSSBn
dWVzcyB5b3UgaGF2ZSB0byBiZWFyIHdpdGggbWUgc29tZSBtb3JlLiBUaGlzIHdob2xlIHN0YWNr
IGlzIGEKPiBjb21wbGV0ZSB1a25vbnduLiBJIGFtIG1vc3RseSBhZnRlciBmaW5kaW5nIGEgYm91
bmRhcnkgd2hlcmUgeW91IGNhbgo+IGNoYXJnZSB0aGUgYWxsb2NhdGVkIG1lbW9yeSB0byB0aGUg
cHJvY2VzcyBzbyB0aGF0IHRoZSBvb20ga2lsbGVyIGNhbgo+IGNvbnNpZGVyIGl0LiBJcyB0aGVy
ZSBhbnl0aGluZyBsaWtlIHRoYXQ/CgpJIHRoaW5rIHNvbWV0aGluZyBsaWtlIGNoYXJnaW5nIHRo
ZSBtZW1vcnkgb2YgYSBCTyB0byB0aGUgcHJvY2VzcyB3aGVuIGEKdXNlcnNwYWNlIGhhbmRsZSBp
cyBjcmVhdGVkIGZvciBpdCwgYW5kICJ1bmNoYXJnaW5nIiB3aGVuIGEgaGFuZGxlIGlzCmRlc3Ry
b3llZCwgY291bGQgYmUgYSBnb29kIHN0YXJ0LgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56
ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJl
IHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBY
IGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
