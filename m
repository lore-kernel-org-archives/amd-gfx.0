From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu: WIP add IOCTL interface for per VM BOs
Date: Mon, 28 Aug 2017 13:55:02 +0200
Message-ID: <0006623b-f042-dda0-b6a2-425dc568ff03@vodafone.de>
References: <1503653899-1781-1-git-send-email-deathsimple@vodafone.de>
 <1503653899-1781-9-git-send-email-deathsimple@vodafone.de>
 <19c04fac-1fdd-1436-e85c-95dd4ac02b1b@amd.com>
 <9304342a-def2-187e-4e9c-d872c58cdc17@vodafone.de>
 <CAAxE2A5dSR-PY+zZ3VeaT7iiCmj5jfty0hv7XZjz4HgOrApQHw@mail.gmail.com>
 <e7d5f9d9-ed3e-2654-9acd-c7339976006f@vodafone.de>
 <fba30bfa-aa7c-d342-b4b6-85058f5db5bf@vodafone.de>
 <a897738d-ab23-8b43-9b9e-c64f7da5e065@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a897738d-ab23-8b43-9b9e-c64f7da5e065-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjguMDguMjAxNyB1bSAwNjoyMSBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTflubQw
OOaciDI35pelIDE4OjAzLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyNS4wOC4yMDE3
IHVtIDIxOjE5IHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IEFtIDI1LjA4LjIwMTcgdW0g
MTg6MjIgc2NocmllYiBNYXJlayBPbMWhw6FrOgo+Pj4+IE9uIEZyaSwgQXVnIDI1LCAyMDE3IGF0
IDM6MDAgUE0sIENocmlzdGlhbiBLw7ZuaWcKPj4+PiA8ZGVhdGhzaW1wbGVAdm9kYWZvbmUuZGU+
IHdyb3RlOgo+Pj4+PiBBbSAyNS4wOC4yMDE3IHVtIDEyOjMyIHNjaHJpZWIgemhvdWNtMToKPj4+
Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT24gMjAxN+W5tDA45pyIMjXml6UgMTc6MzgsIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4+Pj4+Pj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWRkIHRoZSBJT0NUTCBpbnRlcmZhY2Ugc28g
dGhhdCBhcHBsaWNhdGlvbnMgY2FuIGFsbG9jYXRlIHBlciBWTSAKPj4+Pj4+PiBCT3MuCj4+Pj4+
Pj4KPj4+Pj4+PiBTdGlsbCBXSVAgc2luY2Ugbm90IGFsbCBjb3JuZXIgY2FzZXMgYXJlIHRlc3Rl
ZCB5ZXQsIGJ1dCB0aGlzIAo+Pj4+Pj4+IHJlZHVjZXMKPj4+Pj4+PiBhdmVyYWdlCj4+Pj4+Pj4g
Q1Mgb3ZlcmhlYWQgZm9yIDEwSyBCT3MgZnJvbSAyMW1zIGRvd24gdG8gNDh1cy4KPj4+Pj4+IFdv
dywgY2hlZXJzLCBldmVudHVhbGx5IHlvdSBnZXQgcGVyIHZtIGJvIHRvIHNhbWUgcmVzZXJ2YXRp
b24gCj4+Pj4+PiB3aXRoIFBEL3B0cywKPj4+Pj4+IGluZGVlZCBzYXZlIGEgbG90IG9mIGJvIGxp
c3QuCj4+Pj4+Cj4+Pj4+IERvbid0IGNoZWVyIHRvIGxvdWQgeWV0LCB0aGF0IGlzIGEgY29tcGxl
dGVseSBjb25zdHJ1Y3RlZCB0ZXN0IGNhc2UuCj4+Pj4+Cj4+Pj4+IFNvIGZhciBJIHdhc24ndCBh
YmxlIHRvIGFyY2hpdmUgYW55IGltcHJvdmVtZW50cyB3aXRoIGFueSByZWFsIAo+Pj4+PiBnYW1l
IG9uIHRoaXMKPj4+Pj4gd2l0aCBNZXNhLgo+IFdpdGggdGhpbmtpbmcgbW9yZSwgdG9vIG1hbnkg
Qk9zIHNoYXJlIG9uZSByZXNlcnZhdGlvbiwgd2hpY2ggY291bGQgCj4gcmVzdWx0IGluIHJlc2Vy
dmF0aW9uIGxvY2sgb2Z0ZW4gaXMgYnVzeSwgaWYgZXZpY3Rpb24gb3IgZGVzdHJveSBhbHNvIAo+
IGhhcHBlbnMgb2Z0ZW4gaW4gdGhlIG1lYW5pbmcgdGltZSwgdGhlbiB3aGljaCBjb3VsZCBlZmZl
Y3QgVk0gdXBkYXRlIAo+IGFuZCBDUyBzdWJtaXNzaW9uIGFzIHdlbGwuCgpUaGF0J3MgZXhhY3Rs
eSB0aGUgcmVhc29uIHdoeSBJJ3ZlIGFkZGVkIGNvZGUgdG8gdGhlIEJPIGRlc3Ryb3kgcGF0aCB0
byAKYXZvaWQgYXQgbGVhc3Qgc29tZSBvZiB0aGUgcHJvYmxlbXMuIEJ1dCB5ZWFoLCB0aGF0J3Mg
b25seSB0aGUgdGlwIG9mIAp0aGUgaWNlYmVyZyBvZiBwcm9ibGVtcyB3aXRoIHRoYXQgYXBwcm9h
Y2guCgo+IEFueXdheSwgdGhpcyBpcyB2ZXJ5IGdvb2Qgc3RhcnQgYW5kIHRyeSB0aGF0IHdlIHJl
ZHVjZSBDUyBvdmVyaGVhZCwgCj4gZXNwZWNpYWxseSB3ZSd2ZSBzZWVuICJyZWR1Y2VzIGF2ZXJh
Z2UgQ1Mgb3ZlcmhlYWQgZm9yIDEwSyBCT3MgZnJvbSAKPiAyMW1zIGRvd24gdG8gNDh1cy4gIi4K
CkFjdHVhbGx5LCBpdCdzIG5vdCB0aGF0IGdvb2QuIFNlZSB0aGlzIGlzIGEgY29tcGxldGVseSBi
dWlsZCB1cCB0ZXN0IApjYXNlIG9uIGEga2VybmVsIHdpdGggbG9ja2RlcCBhbmQgS0FTQU4gZW5h
YmxlZC4KCkluIHJlYWxpdHkgd2UgdXN1YWxseSBkb24ndCBoYXZlIHNvIG1hbnkgQk9zIGFuZCBz
byBmYXIgSSB3YXNuJ3QgYWJsZSB0byAKZmluZCBtdWNoIG9mIGFuIGltcHJvdmVtZW50IGluIGFu
eSByZWFsIHdvcmxkIHRlc3RpbmcuCgpSZWdhcmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
