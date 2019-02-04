From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Mon, 4 Feb 2019 16:21:16 +0000
Message-ID: <20190204162116.GA840@freedom>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
 <20190201200830.GA7069@freedom> <20190201204706.GA8286@freedom>
 <058665e8-0241-8fc1-8a2a-9f1d7484b29e@amd.com>
 <20190201225559.GA1064@freedom>
 <e7211c67-8ea3-e8f5-8f91-d7af94c1a603@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e7211c67-8ea3-e8f5-8f91-d7af94c1a603-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBGZWIgMDQsIDIwMTkgYXQgMDM6NDM6MzZQTSArMDAwMCwgV2VudGxhbmQsIEhhcnJ5
IHdyb3RlOgo+IERSTSBhY3R1YWxseSBidW1wZWQgdGhpcyB0byAzMiBkdWUgdG8gYW4gaXNzdWUg
d2l0aCBhIERlbGwgNGsgZGlzcGxheS4KCkFzIEkgZmVhcmVkIHRoZXJlIGlzIGEgcmV0cnkgY291
bnRlciBoaWdoZXIgaW4gdGhlIGNvZGUuIE15IGJhZC4KCj4gSXQgZGVwZW5kcy4gSSB3b3VsZG4n
dCBjYWxsIG9uZSBvciB0aGUgb3RoZXIgbW9yZSBjb3JyZWN0LiBJIHNlZW0gdG8gcmVtZW1iZXIK
PiB0aGF0IHRoZSBEUCBzcGVjIGlzIHF1aXRlIHZhZ3VlIG9uIHRoZXNlIHJldHJpZXMgYnV0IEkg
Y291bGQgYmUgbWlzdGFrZW4uCj4gU2luY2Ugb3VyIGRyaXZlciBoYXNuJ3Qgc2hvdyBhbnkgcHJv
YmxlbXMgd2l0aCB0aGUgRFJNIGNvZGUgYW5kIEkgYmVsaWV2ZQo+IG90aGVycyAoc3VjaCBhcyBp
OTE1KSBhbHNvIHBhc3MgRFAgY29tcGxpYW5jZSB3aXRob3V0IGlzc3VlcyBJIHdvdWxkbid0Cj4g
cHJvYWN0aXZlbHkgY2hhbmdlIHRoaXMuCgpJIHJlYWN0ZWQgdG8gdGhpcyBtYXR0ZXIgc2luY2Ug
bXkgRFAgbW9uaXRvciBoYWQgdHJvdWJsZXMgZ2V0dGluZyBvdXQgb2YgRFAgb2ZmCnN0YXRlIChp
aXlhbWEpIHdpdGggbG9ncyB3aGljaCBkaWQgc2VlbSB0byBwb2ludCB0b3dhcmRzIGEgZmFpbHVy
ZSBvZiBnZXR0aW5nCnRoZSBFRElELiBJdCBoYXBwZW5zIHJhcmVseSwgYW5kIEkgY291bGQgbm90
IGZpZ3VyZSBvdXQgYSBjb250ZXh0IHRvIHJlcHJvZHVjZQpmb3Igc3VyZS4gQ291bGQgYmUgZ29u
ZSBmb3IgZ29vZCB3aXRoIHRoZSBsYXRlc3QgZml4ZXMuCgpJIGd1ZXNzIGZpeGVzIGZvciBwb3B1
bGFyIGFuZCBkZWZlY3RpdmUgaGFyZHdhcmUgKGZvciBpbnN0YW5jZSB0aGF0IGRlbGwgNGspCmZy
b20gYSBjb21wbGlhbmNlIHN0YW5kIHBvaW50IGhhdmUgdG8gZ28gaW4gdGhlIGNvZGUgdW5mb3J0
dW5hdGVseS4KCnJlZ2FyZHMsCgotLSAKU3lsdmFpbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
