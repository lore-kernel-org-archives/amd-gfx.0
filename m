From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle@gmail.com>
Subject: Re: [RFC] Per file OOM badness
Date: Tue, 30 Jan 2018 12:36:37 +0100
Message-ID: <82d5894f-f4ea-98cc-068a-5d470f5267df@gmail.com>
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
 <e511ba10-7032-36cc-f22c-2f6bb05f9f6e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e511ba10-7032-36cc-f22c-2f6bb05f9f6e@daenzer.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMzAuMDEuMjAxOCAxMjozNCwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0wMS0z
MCAxMjoyOCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMzAuMDEuMjAxOCB1bSAx
MjowMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4gT24gMjAxOC0wMS0zMCAxMTo0MCBBTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAzMC4wMS4yMDE4IHVtIDEwOjQzIHNjaHJp
ZWIgTWljaGVsIETDpG56ZXI6Cj4+Pj4+IFtTTklQXQo+Pj4+Pj4gV291bGQgaXQgYmUgb2sgdG8g
aGFuZyBvbnRvIHBvdGVudGlhbGx5IGFyYml0cmFyeSBtbWdldCByZWZlcmVuY2VzCj4+Pj4+PiBl
c3NlbnRpYWxseSBmb3JldmVyPyBJZiB0aGF0J3Mgb2sgSSB0aGluayB3ZSBjYW4gZG8geW91ciBw
cm9jZXNzIGJhc2VkCj4+Pj4+PiBhY2NvdW50IChtaW51cyBhIGZldyBtaW5vciBpbmFjY3VyYWNp
ZXMgZm9yIHNoYXJlZCBzdHVmZiBwZXJoYXBzLAo+Pj4+Pj4gYnV0IG5vCj4+Pj4+PiBvbmUgY2Fy
ZXMgYWJvdXQgdGhhdCkuCj4+Pj4+IEhvbmVzdGx5LCBJIHRoaW5rIHlvdSBhbmQgQ2hyaXN0aWFu
IGFyZSBvdmVydGhpbmtpbmcgdGhpcy4gTGV0J3MgdHJ5Cj4+Pj4+IGNoYXJnaW5nIHRoZSBtZW1v
cnkgdG8gZXZlcnkgcHJvY2VzcyB3aGljaCBzaGFyZXMgYSBidWZmZXIsIGFuZCBnbyBmcm9tCj4+
Pj4+IHRoZXJlLgo+Pj4+IE15IHByb2JsZW0gaXMgdGhhdCB0aGlzIG5lZWRzIHRvIGJlIGJ1bGxl
dCBwcm92ZS4KPj4+Pgo+Pj4+IEZvciBleGFtcGxlIGltYWdpbmUgYW4gYXBwbGljYXRpb24gd2hp
Y2ggYWxsb2NhdGVzIGEgbG90IG9mIEJPcywgdGhlbgo+Pj4+IGNhbGxzIGZvcmsoKSBhbmQgbGV0
IHRoZSBwYXJlbnQgcHJvY2VzcyBkaWUuIFRoZSBmaWxlIGRlc2NyaXB0b3IgbGl2ZXMKPj4+PiBv
biBpbiB0aGUgY2hpbGQgcHJvY2VzcywgYnV0IHRoZSBtZW1vcnkgaXMgbm90IGFjY291bnRlZCBh
Z2FpbnN0IHRoZQo+Pj4+IGNoaWxkLgo+Pj4gV2hhdCBleGFjdGx5IGFyZSB5b3UgcmVmZXJyaW5n
IHRvIGJ5ICJ0aGUgZmlsZSBkZXNjcmlwdG9yIiBoZXJlPwo+Pgo+PiBUaGUgZmlsZSBkZXNjcmlw
dG9yIHVzZWQgdG8gaWRlbnRpZnkgdGhlIGNvbm5lY3Rpb24gdG8gdGhlIGRyaXZlci4gSW4KPj4g
b3RoZXIgd29yZHMgb3VyIGRybV9maWxlIHN0cnVjdHVyZSBpbiB0aGUga2VybmVsLgo+Pgo+Pj4g
V2hhdCBoYXBwZW5zIHRvIEJPIGhhbmRsZXMgaW4gZ2VuZXJhbCBpbiB0aGlzIGNhc2U/IElmIGJv
dGggcGFyZW50IGFuZAo+Pj4gY2hpbGQgcHJvY2VzcyBrZWVwIHRoZSBzYW1lIGhhbmRsZSBmb3Ig
dGhlIHNhbWUgQk8sIG9uZSBvZiB0aGVtCj4+PiBkZXN0cm95aW5nIHRoZSBoYW5kbGUgd2lsbCBy
ZXN1bHQgaW4gdGhlIG90aGVyIG9uZSBub3QgYmVpbmcgYWJsZSB0byB1c2UKPj4+IGl0IGFueW1v
cmUgZWl0aGVyLCB3b24ndCBpdD8KPj4gQ29ycmVjdC4KPj4KPj4gVGhhdCB1c2FnZSBpcyBhY3R1
YWxseSBub3QgdXNlZnVsIGF0IGFsbCwgYnV0IHdlIGFscmVhZHkgaGFkCj4+IGFwcGxpY2F0aW9u
cyB3aGljaCBkaWQgZXhhY3RseSB0aGF0IGJ5IGFjY2lkZW50Lgo+Pgo+PiBOb3QgdG8gbWVudGlv
biB0aGF0IHNvbWVib2R5IGNvdWxkIGRvIGl0IG9uIHB1cnBvc2UuCj4gCj4gQ2FuIHdlIGp1c3Qg
cHJldmVudCBjaGlsZCBwcm9jZXNzZXMgZnJvbSB1c2luZyB0aGVpciBwYXJlbnQncyBEUk0gZmls
ZQo+IGRlc2NyaXB0b3JzIGFsdG9nZXRoZXI/IEFsbG93aW5nIGl0IHNlZW1zIGxpa2UgYSBiYWQg
aWRlYSBhbGwgYXJvdW5kLgoKRXhpc3RpbmcgcHJvdG9jb2xzIHBhc3MgRFJNIGZkcyBiZXR3ZWVu
IHByb2Nlc3NlcyB0aG91Z2gsIGRvbid0IHRoZXk/CgpOb3QgY2hpbGQgcHJvY2Vzc2VzIHBlcmhh
cHMsIGJ1dCBzcGVjaWFsLWNhc2luZyB0aGF0IHNlZW1zIGxpa2UgYXdmdWwgCmRlc2lnbi4KCkNo
ZWVycywKTmljb2xhaQotLSAKTGVybmUsIHdpZSBkaWUgV2VsdCB3aXJrbGljaCBpc3QsCkFiZXIg
dmVyZ2lzcyBuaWVtYWxzLCB3aWUgc2llIHNlaW4gc29sbHRlLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
