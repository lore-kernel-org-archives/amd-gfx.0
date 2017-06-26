From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/8] drm/amdgpu: move priority decay logic into
 amd_sched_priority_ctr
Date: Mon, 26 Jun 2017 12:41:09 -0400
Message-ID: <da56f289-58d2-28f7-106e-19e40f54da54@gmail.com>
References: <20170608220623.9002-1-andresx7@gmail.com>
 <20170608220623.9002-6-andresx7@gmail.com>
 <71de1089-f4c1-47c4-c82f-da15ac43506e@vodafone.de>
 <ea42b3d8-cc3f-88f7-7c3d-46cf6dacf0a7@gmail.com>
 <5bbec90f-4746-c314-cca4-d33f4701615f@gmail.com>
 <b86706a7-cdcd-8eaa-197a-9e78b2f16515@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b86706a7-cdcd-8eaa-197a-9e78b2f16515-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE3LTA2LTI2IDA5OjMyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFNvcnJ5
IGZvciB0aGUgZGVsYXksIGJhY2sgZnJvbSBhIHJhdGhlciBsb25nIHNpY2sgbGVhdmUgdG9kYXkg
YW5kIHRyeWluZyAKPiB0byBjYXRjaCB1cCB3aXRoIG15IHdvcmsuCj4gCgpEb24ndCB3b3JyeSB0
b28gbXVjaC4gR2V0IHdlbGwgc29vbiEKCj4+IFF1aWNrIHBpbmcgb24gdGhlIHF1ZXJ5IGFib3Zl
LiBUaGUgcXVlcnkgY2FuIGJlIHN1bW1hcml6ZWQgYXM6IHdoaWNoIAo+PiBpb2N0bCBpbnRlcmZh
Y2UgZG8gd2UgcHJlZmVyIGZvciB0aGUgb3ZlcnJpZGU/Cj4+Cj4+ICAgKiBBTURHUFVfU0NIRURf
T1BfUFJPQ0VTU19QUklPUklUWV9HRVQvUFVUIC0gcmVmY291bnRlZCBvdmVycmlkZQo+Pgo+PiBv
cgo+Pgo+PiAgICogQU1ER1BVX1NDSEVEX09QX1BST0NFU1NfUFJJT1JJVFlfU0VUIC0gc2ltcGxl
IHNldAo+IAo+IFBsZWFzZSBrZWVwIGl0IHNpbXBsZSBhbmQgc3R1cGlkLiBObyBleHRyYSBmaWRk
bGluZyBoZXJlLCB0aGF0IHN0dWZmIGlzIAo+IGNvbXBsaWNhdGVkIGVub3VnaC4KPiAKPiBTbyBJ
IHdvdWxkIHN0cm9uZ2x5IHN1Z2dlc3QgdG8gaGF2ZSBhIHNpbXBsZSBzZXQgaW50ZXJmYWNlIHdo
aWNoIHRoZSBEUk0gCj4gbWFzdGVyIGNhbiB1c2UgdG8gc2V0IHRoZSBwcmlvcml0eS4KPiAKPiBJ
ZiB3ZSBoYXZlIG11bHRpcGxlIERSTSBtYXN0ZXJzIHdoaWNoIGZlZWwgcmVzcG9uc2libGUgZm9y
IHRoaXMgdGhleSAKPiBzaG91bGQgdG8gc3luYyB1cCBpbiB1c2Vyc3BhY2Ugd2hhdCB0byBkby4K
ClNvdW5kcyBnb29kIHRvIG1lLiBJJ2xsIHNlbmQgb3V0IGEgX1NFVCB2ZXJzaW9uIG9mIHRoaXMg
c2VyaWVzLgoKUmVnYXJkcywKQW5kcmVzCgo+IAo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
