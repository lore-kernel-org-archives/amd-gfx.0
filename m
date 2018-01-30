From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [RFC] Per file OOM badness
Date: Tue, 30 Jan 2018 12:34:18 +0100
Message-ID: <e511ba10-7032-36cc-f22c-2f6bb05f9f6e@daenzer.net>
References: <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
 <381a868c-78fd-d0d1-029e-a2cf4ab06d37@gmail.com>
 <20180130093145.GE25930@phenom.ffwll.local>
 <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
 <3026d8c5-9313-cb8b-91ef-09c02baf27db@amd.com>
 <445628d3-677c-a9f8-171f-7d74a603c61d@daenzer.net>
 <dce6d244-36c7-7452-97f5-7437bd78cfcc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <dce6d244-36c7-7452-97f5-7437bd78cfcc@gmail.com>
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
To: christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wMS0zMCAxMjoyOCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAzMC4w
MS4yMDE4IHVtIDEyOjAyIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDEtMzAg
MTE6NDAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAzMC4wMS4yMDE4IHVtIDEw
OjQzIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4gW1NOSVBdCj4+Pj4+IFdvdWxkIGl0IGJl
IG9rIHRvIGhhbmcgb250byBwb3RlbnRpYWxseSBhcmJpdHJhcnkgbW1nZXQgcmVmZXJlbmNlcwo+
Pj4+PiBlc3NlbnRpYWxseSBmb3JldmVyPyBJZiB0aGF0J3Mgb2sgSSB0aGluayB3ZSBjYW4gZG8g
eW91ciBwcm9jZXNzIGJhc2VkCj4+Pj4+IGFjY291bnQgKG1pbnVzIGEgZmV3IG1pbm9yIGluYWNj
dXJhY2llcyBmb3Igc2hhcmVkIHN0dWZmIHBlcmhhcHMsCj4+Pj4+IGJ1dCBubwo+Pj4+PiBvbmUg
Y2FyZXMgYWJvdXQgdGhhdCkuCj4+Pj4gSG9uZXN0bHksIEkgdGhpbmsgeW91IGFuZCBDaHJpc3Rp
YW4gYXJlIG92ZXJ0aGlua2luZyB0aGlzLiBMZXQncyB0cnkKPj4+PiBjaGFyZ2luZyB0aGUgbWVt
b3J5IHRvIGV2ZXJ5IHByb2Nlc3Mgd2hpY2ggc2hhcmVzIGEgYnVmZmVyLCBhbmQgZ28gZnJvbQo+
Pj4+IHRoZXJlLgo+Pj4gTXkgcHJvYmxlbSBpcyB0aGF0IHRoaXMgbmVlZHMgdG8gYmUgYnVsbGV0
IHByb3ZlLgo+Pj4KPj4+IEZvciBleGFtcGxlIGltYWdpbmUgYW4gYXBwbGljYXRpb24gd2hpY2gg
YWxsb2NhdGVzIGEgbG90IG9mIEJPcywgdGhlbgo+Pj4gY2FsbHMgZm9yaygpIGFuZCBsZXQgdGhl
IHBhcmVudCBwcm9jZXNzIGRpZS4gVGhlIGZpbGUgZGVzY3JpcHRvciBsaXZlcwo+Pj4gb24gaW4g
dGhlIGNoaWxkIHByb2Nlc3MsIGJ1dCB0aGUgbWVtb3J5IGlzIG5vdCBhY2NvdW50ZWQgYWdhaW5z
dCB0aGUKPj4+IGNoaWxkLgo+PiBXaGF0IGV4YWN0bHkgYXJlIHlvdSByZWZlcnJpbmcgdG8gYnkg
InRoZSBmaWxlIGRlc2NyaXB0b3IiIGhlcmU/Cj4gCj4gVGhlIGZpbGUgZGVzY3JpcHRvciB1c2Vk
IHRvIGlkZW50aWZ5IHRoZSBjb25uZWN0aW9uIHRvIHRoZSBkcml2ZXIuIEluCj4gb3RoZXIgd29y
ZHMgb3VyIGRybV9maWxlIHN0cnVjdHVyZSBpbiB0aGUga2VybmVsLgo+IAo+PiBXaGF0IGhhcHBl
bnMgdG8gQk8gaGFuZGxlcyBpbiBnZW5lcmFsIGluIHRoaXMgY2FzZT8gSWYgYm90aCBwYXJlbnQg
YW5kCj4+IGNoaWxkIHByb2Nlc3Mga2VlcCB0aGUgc2FtZSBoYW5kbGUgZm9yIHRoZSBzYW1lIEJP
LCBvbmUgb2YgdGhlbQo+PiBkZXN0cm95aW5nIHRoZSBoYW5kbGUgd2lsbCByZXN1bHQgaW4gdGhl
IG90aGVyIG9uZSBub3QgYmVpbmcgYWJsZSB0byB1c2UKPj4gaXQgYW55bW9yZSBlaXRoZXIsIHdv
bid0IGl0Pwo+IENvcnJlY3QuCj4gCj4gVGhhdCB1c2FnZSBpcyBhY3R1YWxseSBub3QgdXNlZnVs
IGF0IGFsbCwgYnV0IHdlIGFscmVhZHkgaGFkCj4gYXBwbGljYXRpb25zIHdoaWNoIGRpZCBleGFj
dGx5IHRoYXQgYnkgYWNjaWRlbnQuCj4gCj4gTm90IHRvIG1lbnRpb24gdGhhdCBzb21lYm9keSBj
b3VsZCBkbyBpdCBvbiBwdXJwb3NlLgoKQ2FuIHdlIGp1c3QgcHJldmVudCBjaGlsZCBwcm9jZXNz
ZXMgZnJvbSB1c2luZyB0aGVpciBwYXJlbnQncyBEUk0gZmlsZQpkZXNjcmlwdG9ycyBhbHRvZ2V0
aGVyPyBBbGxvd2luZyBpdCBzZWVtcyBsaWtlIGEgYmFkIGlkZWEgYWxsIGFyb3VuZC4KCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0
dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
