From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
Date: Tue, 24 Apr 2018 12:53:21 +0300
Message-ID: <CAFCwf10WSwMUXyvK3-W4qFXak94nrvCQbdJSA4A80yGHpTmzBw@mail.gmail.com>
References: <20180328155340.2253343-1-arnd@arndb.de>
 <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
 <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
 <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhhbmtzLCBidXQgSSB0b29rIFJhbmR5J3MgcGF0Y2ggYXMgaXQgd2FzIGVhcmxpZXIgaW4gbXkg
ZW1haWwgcXVldWUuCgpPZGVkCgpPbiBUaHUsIEFwciAxOSwgMjAxOCBhdCA4OjQ3IFBNLCBGZWxp
eCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6Cj4gT24gMjAxOC0wNC0x
OSAwNjo1NiBBTSwgQW5kZXJzIFJveGVsbCB3cm90ZToKPj4gT24gMjggTWFyY2ggMjAxOCBhdCAx
ODowNCwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToK
Pj4+IEFtIDI4LjAzLjIwMTggdW0gMTc6NTMgc2NocmllYiBBcm5kIEJlcmdtYW5uOgo+Pj4+IEJ1
aWxkaW5nIGFtZGtmZCB3aXRob3V0IE1NVSBub3RpZmllcnMgaXMgYnJva2VuOgo+Pj4+Cj4+Pj4g
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92aS5jOjI4Ogo+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2
Lmg6NTg0OjIyOiBlcnJvcjogZmllbGQgJ21tdV9ub3RpZmllcicKPj4+PiBoYXMgaW5jb21wbGV0
ZSB0eXBlCj4+Pj4KPj4+PiBUaGlzIGFkZHMgdGhlIG1pc3NpbmcgJ3NlbGVjdCBNTVVfTk9USUZJ
RVInIGxpbmUgdG8gbWFrZSBpdCBidWlsZAo+Pj4+IGNsZWFubHkgYWxsIHRoZSB0aW1lLgo+Pj4+
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4+Cj4+
PiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiwg
YnV0IEkgd291bGQgd2FpdCBvbgo+Pj4gd2hhdCBGZWxpeCBzYXlzIHRvIHRoYXQuCj4+IFRlc3Rl
ZC1ieTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPgo+Pgo+PiBSYW5k
eSBzZW50IHRoZSBzYW1lIHBhdGNoIFsxXSBhbmQgaXRzIHN0aWxsIHJlcXVpcmVkLgo+Pgo+PiBD
aGVlcnMsCj4+IEFuZGVycwo+PiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDM0MDg4NS8KPiBZZXMsIGxvb2tzIGdvb2QuIEkgdGhpbmsgdGhpcyBwcm9iYWJseSBicm9r
ZSB3aGVuIHdlIHJlbGF4ZWQgdGhlCj4gZGVwZW5kZW5jeSBvbiBpb21tdXYyLgo+Cj4gUmV2aWV3
ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Cj4gUmVnYXJk
cywKPiAgIEZlbGl4Cj4KPgo+Pgo+Pj4KPj4+PiAtLS0KPj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL0tjb25maWcgfCAxICsKPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tj
b25maWcKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4+PiBpbmRl
eCBlZDJmMDZjOWYzNDYuLjVhMjZhY2I5MGUxOSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQvS2NvbmZpZwo+Pj4+IEBAIC00LDYgKzQsNyBAQAo+Pj4+ICAgICBjb25maWcgSFNBX0FN
RAo+Pj4+ICAgICAgICAgdHJpc3RhdGUgIkhTQSBrZXJuZWwgZHJpdmVyIGZvciBBTUQgR1BVIGRl
dmljZXMiCj4+Pj4gKyAgICAgICBzZWxlY3QgTU1VX05PVElGSUVSCj4+Pj4gICAgICAgICBkZXBl
bmRzIG9uIERSTV9BTURHUFUgJiYgWDg2XzY0Cj4+Pj4gICAgICAgICBpbXBseSBBTURfSU9NTVVf
VjIKPj4+PiAgICAgICAgIGhlbHAKPj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
