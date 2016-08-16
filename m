From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/radeon: Provide page_flip_target hook
Date: Tue, 16 Aug 2016 10:49:13 +0900
Message-ID: <71aaa221-ad52-25db-f6dc-18c368d57efa@daenzer.net>
References: <1470281981-18172-1-git-send-email-michel@daenzer.net>
 <1470281981-18172-5-git-send-email-michel@daenzer.net>
 <dccd9347-afc4-83a6-8014-20692e71fd03@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dccd9347-afc4-83a6-8014-20692e71fd03-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTYvMDgvMTYgMDk6MzUgQU0sIE1hcmlvIEtsZWluZXIgd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IHNvcnJ5IGZvciB0aGUgc3VwZXItbGF0ZSByZXBseSwgaSB3YXMganVzdCBjYXRjaGluZyB1
cCB3aXRoIGFsbCB0aGUKPiBtYWlscyBhbmQgZGlzY3Vzc2lvbnMsIHN0YXJ0aW5nIGluIEp1bmUs
IGxlYWRpbmcgdG8gdGhpcyBwYXRjaCBzZXQuCj4gCj4gTG9va3MgYWxsIHByZXR0eSBnb29kLgo+
IAo+IEknbGwgbG9vayBhdCB0aGlzIHJhZGVvbiBwYXRjaCBhbmQgMi82IGZvciBhbWRncHUgbGF0
ZXIgdGhpcyB3ZWVrIHdoZW4gaQo+IGhhdmUgYSBmcmVzaCBicmFpbiBhbmQgZW5vdWdoICJvYnNl
c3NpdmUgY29tcHVsc2l2ZSB0aW1lIiwgdG8gbWFrZSBzdXJlCj4gYWxsIHRoZSBtYWdpYyB3cnQu
ICJ2aXJ0dWFsbHkgZXh0ZW5kZWQgdmJsYW5rIiBhbmQgdGhlIGZ1ZGdpbmcgbG9naWMgaXMKPiBm
aW5lLgoKRXhjZWxsZW50IQoKCj4gSSdsbCB0aGVuIGFsc28gcnVuIGl0IHRocm91Z2ggbXkgdGlt
aW5nIHRlc3RzLiBJIGFzc3VtZSB0aGUKPiBhdGkvYW1kZ3B1LWRkeCBwYXRjaGVzIGFuZCBsaWJk
cm0gcGF0Y2hlcyBpbiB5b3VyIGZyZWVkZXNrdG9wIGhvbWUgYXJlCj4gYWxsIGkgbmVlZCBmb3Ig
dGVzdGluZz8KClllcywgYWx0aG91Z2ggaXQgd291bGQgYWxzbyBiZSBuaWNlIHRvIHRlc3Qgd2l0
aCB1bm1vZGlmaWVkIHVzZXJzcGFjZQphbmQgbWFrZSBzdXJlIHRoZXJlIGFyZSBubyByZWdyZXNz
aW9ucyB3aXRoIHRoYXQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
