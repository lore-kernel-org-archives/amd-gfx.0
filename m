From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] radeon: use asic id table to get chipset name
Date: Thu, 6 Jul 2017 10:20:59 +0100
Message-ID: <CACvgo514x_TAaaESizA10eUQFhUQr6DuWOB_B84i363Pqvk5Xg@mail.gmail.com>
References: <1498850702-13331-1-git-send-email-Samuel.Li@amd.com>
 <CACvgo51CUmbNr9LoFww2Kq4kkHoVDJN-g=knKWKFCx27JoGzLA@mail.gmail.com>
 <BLUPR12MB0628623A3972B7F2BB1F69A7F5D40@BLUPR12MB0628.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0628623A3972B7F2BB1F69A7F5D40-7LeqcoF/hwrL9O90+oShTwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gNSBKdWx5IDIwMTcgYXQgMjI6MzEsIExpLCBTYW11ZWwgPFNhbXVlbC5MaUBhbWQuY29tPiB3
cm90ZToKPj4gIC0gYWJvdmUgYWxsLCBhcy1pcyBtYWtlIGNoZWNrIHdpbGwgZmFpbAo+IFJpZ2h0
LCBJIGRpZCBub3QgY2hlY2sgdGhhdC4KPgo+PiAgLSBrZWVwaW5nIHRoZSByYWRlb24gQVBJIHN5
bW1ldHJpY2FsIHRvIHRoZSBhbWRncHUgb25lIHdvdWxkIGEgZ29vZCBpZGVhCj4gVGhlIGlzc3Vl
IGlzIFJhZGVvbiBkb2VzIG5vdCBoYXZlIGEgc3RydWN0IHNpbWlsYXIgdG8gYW1kZ3B1X2Rldmlj
ZV9oYW5kbGUuCkF0dGFjaCBpdCB0byBhbmFsb2dvdXMgcHJpbWl0aXZlPwoKPiBJIHRoaW5rIHRo
ZSBjdXJyZW50IHJhZGVvbiBBUEkgaXMgc2ltcGxlci4gTWF5YmUgYSBmb2xsb3cgdXAgY2hhbmdl
IGNhbiBjaGFuZ2UgYW1kZ3B1J3MgQVBJIHNpbWlsYXIgdG8gcmFkZW9uLgo+CkV4cG9zaW5nIDMg
ZW50cnkgcG9pbnRzIGluc3RlYWQgb2YgMSBpcyBfbm90X3NpbXBsZXIuIEFsc28geW91IGNhbm5v
dApjaGFuZ2UgdGhlIGV4aXN0aW5nIEFQSSwgc2luY2UgaXQgYWxzbyBicmVha3MgdGhlIEFCSS4K
TGVhZGluZyB0byBjcmFzaC9jYXVzZSBtZW1vcnkgY29ycnVwdGlvbiB3aGVuIHVzaW5nIGV4aXN0
aW5nIGJpbmFyaWVzLgoKPj4gIC0gaXMgYWRkaW5nIHlldCBhbm90aGVyIGhlYWRlciByZWFsbHkg
anVzdGlmaWVkPwo+IHJhZGVvbl9hc2ljX2lkLmg/IFRoYXQgaXMgZ29pbmcgdG8gYmUgdXNlZCBi
eSBkZHgvbWVzYS4KPgpXaGVyZSBpdCdzIHVzZWQgaXMgb3J0aG9nb25hbC4gWW91IGRvbid0IG5l
ZWQgYSBzZXBhcmF0ZSBfcHVibGljXwpoZWFkZXIgZm9yIG5lYXJseSBldmVyeSBlbnRyeSBwb2lu
dCA7LSkKClRoYW5rcwpFbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
