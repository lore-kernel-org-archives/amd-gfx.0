From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdkfd: Adding new IOCTL for scratch memory
Date: Tue, 15 Aug 2017 10:33:44 -0400
Message-ID: <CADnq5_NxwYjKK6+2Kwt7zWD4LH5a5ySdz2YD_kn7H7-RLzHMEQ@mail.gmail.com>
References: <1502513265-14281-1-git-send-email-Felix.Kuehling@amd.com>
 <1502513265-14281-3-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf11z1Uo9jd82XAGrapXA44KpY+KrV69nbXLkoX6v10_gig@mail.gmail.com>
 <22ab982e-a1b1-5d61-9eaa-f9c149cf3d5e@amd.com>
 <c310b952-116b-376c-0794-232e69f88592@vodafone.de>
 <33308ac3-bdf2-21ac-2122-b43702fdd95f@amd.com>
 <b114b316-1142-11b8-6393-5f903bb2d663@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b114b316-1142-11b8-6393-5f903bb2d663-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBBdWcgMTUsIDIwMTcgYXQgNDoyNCBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDE0LjA4LjIwMTcgdW0gMTc6MzEgc2Nocmll
YiBGZWxpeCBLdWVobGluZzoKPj4KPj4gW1NOSVBdCj4+IFJlcGVhdGluZyB0aGUgc2FtZSBhcmd1
bWVudCBJIG1hZGUgb24gYW5vdGhlciBlbWFpbDoKPgo+Cj4gQ29tbWVudGVkIG9uIHRoYXQgaW4g
dGhlIG90aGVyIG1haWwsIGxldCdzIGtlZXAgdGhlIGRpc2N1c3Npb24gb24gdGhpcyB0b3BpYwo+
IHRoZXJlLgo+Cj4+PiBCVFc6IFdoYXQgZXhhY3RseSB0aGlzIHRoaXMgZ29vZCBmb3I/Cj4+Cj4+
IFNjcmF0Y2ggbWVtb3J5IGlzIHByaXZhdGUgbWVtb3J5IHBlciB3b3JrLWl0ZW0uIEl0J3MgdXNl
ZCB3aGVuIGEgc2hhZGVyCj4+IHByb2dyYW0gaGFzIHRvbyBmZXcgcmVnaXN0ZXJzIGF2YWlsYWJs
ZS4gV2l0aCBIU0Egd2UgdXNlIGZsYXQgc2NyYXRjaAo+PiBhZGRyZXNzaW5nLCB3aGVyZSBzaGFk
ZXJzIGNhbiBhY2Nlc3MgcHJpdmF0ZSBtZW1vcnkgaW4gYSBzcGVjaWFsIHNjcmF0Y2gKPj4gYXBl
cnR1cmUgdXNpbmcgbm9ybWFsIG1lbW9yeSBpbnN0cnVjdGlvbnMuIFVzaW5nIHRoZSBzYW1lIHZp
cnR1YWwKPj4gYWRkcmVzcywgZWFjaCB3b3JrIGl0ZW0gZ2V0cyBpdHMgb3duIHByaXZhdGUgcGll
Y2Ugb2YgbWVtb3J5LiBUaGUKPj4gaGFyZHdhcmUgZG9lcyB0aGUgYWRkcmVzcyB0cmFuc2xhdGlv
biBmcm9tIHRoZSBWQSBpbiB0aGUgcHJpdmF0ZQo+PiBhcGVydHVyZSB0byBhIHNjcmF0Y2gtYmFj
a2luZyBWQS4gVGhlIGFwcGxpY2F0aW9uIGlzIHJlc3BvbnNpYmxlIGZvcgo+PiBhbGxvY2F0aW5n
IHRoZSBtZW1vcnkgdG8gYmFjayB0aGF0IHNjcmF0Y2ggYXJlYSwgYW5kIHRvIG1hcCBpdCBzb21l
d2hlcmUKPj4gaW4gaXRzIHZpcnR1YWwgYWRkcmVzcyBzcGFjZS4KPj4KPj4gVGhpcyBpb2N0bCB0
ZWxscyB0aGUgaGFyZHdhcmUgKG9yIEhXUyBmaXJtd2FyZSkgdGhlIFZBIG9mIHRoZSBzY3JhdGNo
Cj4+IGJhY2tpbmcgbWVtb3J5Lgo+Cj4KPiBPaywgeW91J3ZlIGdvdCBtZSBsb3N0IGhlcmUuIE5v
dCB0aGF0IEknbSBkZWVwbHkgaW50byB0aGF0IHN0dWZmLCBidXQgbXkKPiBsYXN0IHN0YXR1cyBp
cyB0aGF0IHRob3NlIGFwZXJ0dXJlcyBhcmUgZ2xvYmFsIGFuZCBub3QgcGVyL3Byb2Nlc3Mgb3Ig
Vk1JRC4KPgo+IFRoYXQgd291bGQgbWVhbiB0aGF0IHdoZW4gdHdvIHByb2Nlc3NlcyB0cnkgdG8g
c2V0IHR3byBkaWZmZXJlbnQgYWRkcmVzc2VzCj4gd2UgYXJlIGNvbXBsZXRlbHkgbG9zdCBoZXJl
Lgo+CgpUaGUgc2NyYXRjaCBhbmQgbGRzIGFwZXJ0dXJlcyBhcmUgcGVyIHZtaWQuICBTZWUgZ2Z4
X3Y4XzBfaW5pdF9jb21wdXRlX3ZtaWQoKQoKQWxleApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
