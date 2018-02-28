From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: fix "add AMDGPU_VA_RANGE_HIGH"
Date: Wed, 28 Feb 2018 16:47:13 +0100
Message-ID: <3b3d865d-f749-f263-53d1-15d957277268@amd.com>
References: <20180228144111.1651-1-christian.koenig@amd.com>
 <2450a93d-fbf0-0a6c-e0b8-2432a401d531@daenzer.net>
 <42d3a34d-2df5-2f9f-95b7-525957297cab@gmail.com>
 <b0b39019-e085-ea73-703b-fd41705d9c01@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b0b39019-e085-ea73-703b-fd41705d9c01-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

QW0gMjguMDIuMjAxOCB1bSAxNjo0MCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDItMjggMDQ6MjUgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI4LjAyLjIwMTgg
dW0gMTY6MjEgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMDItMjggMDM6NDEg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gVGhlIDMyYml0IGFkZHJlc3MgcmFuZ2Ug
ZW5kIGlzIGV4Y2x1c2l2ZSwgbm90IGluY2x1c2l2ZS4KPj4+IFRoZSBvdGhlciB3YXkgYXJvdW5k
LiA6KSBJbmNsdXNpdmUgbWVhbnMgW2EsYl0sIGkuZS4gYW4gaW50ZXJ2YWwKPj4+IGluY2x1ZGlu
ZyB0aGUgZW5kcG9pbnRzLCB3aGVyZWFzIGV4Y2x1c2l2ZSBtZWFucyBdYSxiWywgaS5lLiBhbiBp
bnRlcnZhbAo+Pj4gbm90IGluY2x1ZGluZyB0aGUgZW5kcG9pbnRzLiBUaGUgcGF0Y2ggY2hhbmdl
cyB0aGUgMzItYml0IGFkZHJlc3MgcmFuZ2UKPj4+IGVuZHBvaW50IGZyb20gZXhjbHVzaXZlIHRv
IGluY2x1c2l2ZS4KPj4gQWN0dWFsbHkgdGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuIEhvdyBhYm91
dCB0aGlzOgo+Pgo+PiAiVGhlIHJhbmdlIGlzIHN0b3JlZCBhcyBleGNsdXNpdmUsIG5vdCBpbmNs
dXNpdmUuIFN1YnRyYWN0cyBvbmUgdG8gZ2V0Cj4+IHRoZSBpbmNsdXNpdmUgaW50ZXJ2YWwgZm9y
IHRoZSBjYWxjdWxhdGlvbi4iCj4gU291bmRzIGdvb2QgdG8gbWUsIGJ1dCBJJ2xsIGRlZmVyIHRv
IG5hdGl2ZSBFbmdsaXNoIHNwZWFrZXJzIGZvciB0aGUKPiBmaW5hbCB2ZXJkaWN0LgoKU2luY2Ug
dGhpcyBpcyBhbiBpbXBvcnRhbnQgYnVnIGZpeCBJJ20gZ29pbmcgdG8gY29tbWl0IGl0IGFzIGxv
bmcgYXMgCm5vYm9keSBzcGVha3MgdXAgaW4gdGhlIG5leHQgdHdvIGhvdXJzIG9yIHNvLgoKQ2hy
aXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
