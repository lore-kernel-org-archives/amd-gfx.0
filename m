From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/sched: signal and free remaining fences in
 amd_sched_entity_fini
Date: Thu, 12 Oct 2017 15:42:14 +0200
Message-ID: <bc0e87da-a632-07ce-6934-86aee099b916@daenzer.net>
References: <20170928145530.12844-1-nhaehnle@gmail.com>
 <20170928145530.12844-5-nhaehnle@gmail.com>
 <7cb63e4c-9b65-b9b9-14dc-26368ca7126a@daenzer.net>
 <c67d1bd8-81a0-4133-c3df-dd2a1b1a8c11@gmail.com>
 <51ec8d88-32eb-ef4a-b34b-d2fd8e23281e@daenzer.net>
 <4c750ed5-98be-eafa-e684-940ecb2787f0@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4c750ed5-98be-eafa-e684-940ecb2787f0-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTIvMTAvMTcgMDE6NDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTIuMTAu
MjAxNyB1bSAxMzowMCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IAo+PiBBbnl3YXksIHVubGVz
cyBhbnlvbmUga25vd3Mgd2hpY2ggY29tbWl0cyBmcm9tIGFtZC1zdGFnaW5nLWRybS1uZXh0IGFy
ZQo+PiBuZWVkZWQgdG8gbWFrZSAxZDAwNDAyYjRkYTIgc3RhYmxlIGluIDQuMTQsIHRoZSBzYWZl
IGNvdXJzZSBvZiBhY3Rpb24KPj4gc2VlbXMgdG8gYmUgcmV2ZXJ0aW5nIGl0IChhbmQgYWM3YWZl
NmIzY2YzLCB3aGljaCBkZXBlbmRzIG9uIGl0KT8KPiAKPiBUaGUgYW1kZ3B1X3R0bV9iaW5kIGNo
YW5nZSBzaG91bGQgYmUgZml4ZWQgYnkgIjcwYTljNmIgZHJtL2FtZGdwdTogZml4Cj4gcGxhY2Vt
ZW50IGZsYWdzIGluIGFtZGdwdV90dG1fYmluZCIuCgpJbmRlZWQsIHRoYXQgZml4ZXMgaXQgZm9y
IG1lLgoKPiBCdXQgSSd2ZSBhc3N1bWVkIHRoZXkgd2VudCBib3RoIGludG8gNC4xNC4KClVuZm9y
dHVuYXRlbHksIGl0IGxvb2tzIGxpa2Ugb25seSAxZDAwNDAyYjRkYTIgbWFkZSBpdCBpbnRvIDQu
MTQuIEFsZXgsCnBsZWFzZSBzZW5kIGEgZml4ZXMgcHVsbCBmb3IgNC4xNCB3aXRoIGEgYmFja3Bv
cnQgb2YgNzBhOWM2Yi4KCkZvciB0aGUgb3RoZXIgaXNzdWUsIGRvIHdlIHdhbnQgdG8gYmFja3Bv
cnQgTmljb2xhaSdzIGNvbW1pdHMKNmIzN2QwMzI4MGE0Li4zMThkODVkZTljMjAgb3IgcmV2ZXJ0
IDZhZjA4ODNlZDk3Nz8KCkNocmlzdGlhbiwgY2FuIHlvdSBjaGVjayB0aGF0IHRoZXJlIGFyZSBu
byBvdGhlciBmaXhlcyBtaXNzaW5nIGZyb20gNC4xND8KCgpCVFcsIHRoaXMgcmFpc2VzIGFuIGlz
c3VlOiBTaW5jZSB3ZSBwdXNoIGJvdGggZml4ZXMgYW5kIG5ldyBkZXZlbG9wbWVudAp3b3JrIHRv
IHRoZSBzYW1lIGludGVybmFsIGJyYW5jaCwgc29tZXRpbWVzIGl0IGlzbid0IGNsZWFyIHdoaWNo
IGNoYW5nZXMKc2hvdWxkIGdvIHVwc3RyZWFtIHZpYSAtZml4ZXMgb3IgLW5leHQuIEFueSBpZGVh
cyBmb3IgbWl0aWdhdGluZyB0aGUKcmlzayBvZiBtaXNzaW5nIGFuIGltcG9ydGFudCBmaXg/CgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
