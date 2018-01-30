From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [RFC] Per file OOM badness
Date: Tue, 30 Jan 2018 10:29:10 +0100
Message-ID: <60e18da8-4d6e-dec9-7aef-ff003605d513@daenzer.net>
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
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180124115059.GC28465@dhcp22.suse.cz>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
List-Id: amd-gfx.lists.freedesktop.org

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
ZSBhbnl0aGluZyBsaWtlIHRoYXQ/IEV4Y2VwdCBmb3IgdGhlIHByb3Bvc2VkIGZpbGUKPiBoYW5k
bGUgaGFjaz8KCkhvdyBhYm91dCB0aGUgb3RoZXIgd2F5IGFyb3VuZDogd2hhdCBBUElzIGNhbiB3
ZSB1c2UgdG8gY2hhcmdlIC8KInVuY2hhcmdlIiBtZW1vcnkgdG8gYSBwcm9jZXNzPyBJZiB3ZSBo
YXZlIHRob3NlLCB3ZSBjYW4gZXhwZXJpbWVudCB3aXRoCmRpZmZlcmVudCBwbGFjZXMgdG8gY2Fs
bCB0aGVtLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3Qg
ICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
