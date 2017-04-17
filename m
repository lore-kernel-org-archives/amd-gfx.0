From: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/7] sync_file: get rid of internal reference count.
Date: Mon, 17 Apr 2017 10:13:11 -0300
Message-ID: <20170417131311.GA15339@joana>
References: <20170413014144.637-1-airlied@gmail.com>
 <20170413014144.637-2-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170413014144.637-2-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

MjAxNy0wNC0xMyBEYXZlIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+OgoKPiBGcm9tOiBEYXZl
IEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+IAo+IHN5bmNfZmlsZSB1c2VzIHRoZSByZWZl
cmVuY2UgY291bnQgb2YgdGhlIGZpbGUsIHRoZSBpbnRlcm5hbAo+IGtyZWYgd2FzIG5ldmVyIGdl
dHRpbmcgbW92ZWQgcGFzdCAxLgo+IAo+IFdlIGNhbiByZWludHJvZHVjZSB0aGlzIGlmIHdlIGRl
Y2lkZSB3ZSBuZWVkIGl0IGxhdGVyLgo+IAo+IFthaXJsaWVkOiBmaXggYnVpbGRib3Qgd2Fybmlu
Z3NdCj4gCj4gUmV2aWV3ZWQtYnk6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNv
LnVrPgo+IFNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvZG1hLWJ1Zi9zeW5jX2ZpbGUuYyB8IDEzICsrLS0tLS0tLS0tLS0KPiAg
aW5jbHVkZS9saW51eC9zeW5jX2ZpbGUuaCAgIHwgIDMgLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBHdXN0YXZvIFBh
ZG92YW4gPGd1c3Rhdm8ucGFkb3ZhbkBjb2xsYWJvcmEuY29tPgoKT3Igc2hvdWxkIEkganVzdCBw
dXNoIHRoaXMgb25lPwoKR3VzdGF2bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
