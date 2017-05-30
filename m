From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Really leave SI support disabled by
 default
Date: Tue, 30 May 2017 09:57:38 +0200
Message-ID: <ac10edba-6dad-3d8f-22ae-ce0a1280d2fa@vodafone.de>
References: <20170529092026.5567-1-michel@daenzer.net>
 <b0db57f8-ccdf-4af7-c9fd-0a5cd3545099@vodafone.de>
 <3f76e24c-d27c-62af-dd81-02080d058753@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3f76e24c-d27c-62af-dd81-02080d058753-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzAuMDUuMjAxNyB1bSAwNToyNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDMwLzA1
LzE3IDAyOjE4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyOS4wNS4yMDE3IHVt
IDExOjIwIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8
bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4+Cj4+PiBUaGUgZGVmYXVsdCBvcHRpb24gdmFsdWUg
ZGlkbid0IG1hdGNoIHRoZSBoZWxwIHRleHQgYW5kIGludGVudGlvbi4KPj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4gSSdtIHN0
aWxsIHVuc3VyZSBhYm91dCB0aGUgbGFzdCBvbmUuIFRoZSBmZWF0dXJlIHBhcml0eSBpcyBhIGdv
b2QKPj4gYXJndW1lbnQgYnV0IG9uIHRoZSBvdGhlciBoYW5kIHdlIHdhbnQgcGVvcGxlIHRvIHVz
ZSBhbWRncHUgZm9yIENJSwo+PiB0aGVzZSBkYXlzLCBkb24ndCB3ZT8KPiBXZSB3YW50IHRvIG1h
a2UgaXQgZWFzeSBmb3IgcGVvcGxlIHRvIHRlc3QgYW1kZ3B1IG9uIENJSywgd2hpY2ggaXMgd2hh
dAo+IHRoZSBvcHRpb25zIGFkZGVkIGJ5IEZlbGl4IGFyZSBmb3IuIElNTyB3ZSBzaG91bGQgbm90
IGZsaXAgdGhlIGRlZmF1bHQKPiAodXBzdHJlYW0pIGJlZm9yZSB0aGVyZSBpcyBmZWF0dXJlIHBh
cml0eS4KPgo+Cj4+IEFueXdheSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiBUaGFua3MsIEkgYXNzdW1lIHRoYXQgYXBwbGllcyB0byB0
aGUgd2hvbGUgc2VyaWVzPwoKV2l0aCB0aGUgU0kgdHlwbyBhbmQgdGhlIEhETUkvRFAgYXVkaW8g
dGhpbmcgcG9pbnRlZCBvdXQgYnkgS2FpIGZpeGVkLCAKdGhhbiB5ZXMgdGhhdCByYiBhcHBsaWVz
IHRvIHRoZSB3aG9sZSBzZXJpZXMuCgpDaHJpc3RpYW4uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
