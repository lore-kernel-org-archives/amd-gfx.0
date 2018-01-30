From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC] Per file OOM badness
Date: Tue, 30 Jan 2018 11:40:06 +0100
Message-ID: <3026d8c5-9313-cb8b-91ef-09c02baf27db@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <3db43c1a-59b8-af86-2b87-c783c629f512@daenzer.net>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Michal Hocko <mhocko@kernel.org>, dri-devel@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMzAuMDEuMjAxOCB1bSAxMDo0MyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IFtTTklQXQo+
PiBXb3VsZCBpdCBiZSBvayB0byBoYW5nIG9udG8gcG90ZW50aWFsbHkgYXJiaXRyYXJ5IG1tZ2V0
IHJlZmVyZW5jZXMKPj4gZXNzZW50aWFsbHkgZm9yZXZlcj8gSWYgdGhhdCdzIG9rIEkgdGhpbmsg
d2UgY2FuIGRvIHlvdXIgcHJvY2VzcyBiYXNlZAo+PiBhY2NvdW50IChtaW51cyBhIGZldyBtaW5v
ciBpbmFjY3VyYWNpZXMgZm9yIHNoYXJlZCBzdHVmZiBwZXJoYXBzLCBidXQgbm8KPj4gb25lIGNh
cmVzIGFib3V0IHRoYXQpLgo+IEhvbmVzdGx5LCBJIHRoaW5rIHlvdSBhbmQgQ2hyaXN0aWFuIGFy
ZSBvdmVydGhpbmtpbmcgdGhpcy4gTGV0J3MgdHJ5Cj4gY2hhcmdpbmcgdGhlIG1lbW9yeSB0byBl
dmVyeSBwcm9jZXNzIHdoaWNoIHNoYXJlcyBhIGJ1ZmZlciwgYW5kIGdvIGZyb20KPiB0aGVyZS4K
Ck15IHByb2JsZW0gaXMgdGhhdCB0aGlzIG5lZWRzIHRvIGJlIGJ1bGxldCBwcm92ZS4KCkZvciBl
eGFtcGxlIGltYWdpbmUgYW4gYXBwbGljYXRpb24gd2hpY2ggYWxsb2NhdGVzIGEgbG90IG9mIEJP
cywgdGhlbiAKY2FsbHMgZm9yaygpIGFuZCBsZXQgdGhlIHBhcmVudCBwcm9jZXNzIGRpZS4gVGhl
IGZpbGUgZGVzY3JpcHRvciBsaXZlcyAKb24gaW4gdGhlIGNoaWxkIHByb2Nlc3MsIGJ1dCB0aGUg
bWVtb3J5IGlzIG5vdCBhY2NvdW50ZWQgYWdhaW5zdCB0aGUgY2hpbGQuCgpPdGhlcndpc2Ugd2Ug
d291bGQgYWxsb3cgZWFzeSBjb25zdHJ1Y3Rpb24gb2YgZGVueSBvZiBzZXJ2aWNlIHByb2JsZW1z
LgoKVG8gYXZvaWQgdGhhdCBJIHRoaW5rIHdlIG5lZWQgdG8gYWRkIHNvbWV0aGluZyBsaWtlIG5l
dyBmaWxlX29wZXJhdGlvbnMgCmNhbGxiYWNrcyB3aGljaCBpbmZvcm1zIGEgZmlsZSBkZXNjcmlw
dG9yIHRoYXQgaXQgaXMgZ29pbmcgdG8gYmUgdXNlZCBpbiAKYSBuZXcgcHJvY2VzcyBvciBzdG9w
cGVkIHRvIGJlIHVzZWQgaW4gYSBwcm9jZXNzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
