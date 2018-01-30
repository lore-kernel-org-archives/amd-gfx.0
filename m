From: mikhail <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: LLVM 7.0 + Wayland = broken mouse control
Date: Tue, 30 Jan 2018 08:43:07 +0500
Message-ID: <1517283787.3374.7.camel@gmail.com>
References: <CABXGCsMKWxAxDas=s2UxwydOYQ8TyEOCfR=0Mz0zGfgXxsnxcw@mail.gmail.com>
 <188aeb48-741c-0658-32f5-b12d6389b10c@amd.com>
 <BN4PR12MB08811DCADDC96DEDCAF61659F9E20@BN4PR12MB0881.namprd12.prod.outlook.com>
 <1517255915.3374.5.camel@gmail.com>
 <CAAxE2A7FfYcLRdbrhJ_sWJ=JzKCjNrGO9bkELUUYJZemOAT2zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7FfYcLRdbrhJ_sWJ=JzKCjNrGO9bkELUUYJZemOAT2zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Marek =?UTF-8?Q?Ol=C5=A1=C3=A1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Q2FuIHlvdSBpbnN0YWxsIEZlZG9yYSAyNyAgKyBsbHZtIGFuZCBtZXNhIGZyb20gdGhpcyByZXBv
CiJodHRwczovL2NvcHIuZmVkb3JhaW5mcmFjbG91ZC5vcmcvY29wcnMvY2hlL21lc2EvIiArIHVz
ZSBrZXJuZWwgZnJvbSBoZXJlICJnaXQgY2xvbmUgLWIgYW1kLXN0YWdpbmctZHJtLW5leHQKZ2l0
Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXgiIGFuZCBjaGVjayB3aHkgbm90
IHdvcmtlZAptb3VzZSBob3ZlciArIGNsaWNrIGFuZCBjcmFzaGVzIFVuaXR5IGdhbWVzPwoKQXQg
bGVhc3QgaWRlbnRpZnkgdGhlIGNhdXNlIG9mIHRoZSB0d28gcHJvYmxlbXMuCgoKT24gTW9uLCAy
MDE4LTAxLTI5IGF0IDIzOjEwICswMTAwLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+IE9uIE1vbiwg
SmFuIDI5LCAyMDE4IGF0IDg6NTggUE0sIG1pa2hhaWwgPG1pa2hhaWwudi5nYXZyaWxvdkBnbWFp
bC5jbwo+IG0+IHdyb3RlOgo+ID4gCj4gPiBPbiBNb24sIDIwMTgtMDEtMjkgYXQgMTk6MTggKzAx
MDAsIE1hcmVrIE9sxaHDoWsgd3JvdGU6Cj4gPiA+IFBsZWFzZSByZXBvcnQgdGhpcyBpc3N1ZSB0
byB0aGUgZ25vbWUtc2hlbGwgdGVhbS4gZ25vbWUtc2hlbGwgaGFzCj4gPiA+IGEKPiA+ID4gYnVn
IGluIGhvdyB0aGV5IGhhbmRsZSAob3IgaWdub3JlKSAxMC1iaXRzLXBlci1jaGFubmVsIHZpc3Vh
bHMuCj4gPiAKPiA+IEkgYWxyZWFkeSByZXBvcnRlZCBoZXJlOgo+ID4gaHR0cHM6Ly9naXRsYWIu
Z25vbWUub3JnL0dOT01FL211dHRlci9pc3N1ZXMvMgo+ID4gCj4gPiA+IFRoZSB3b3JrYXJvdW5k
IGlzIHRvIHNldCB0aGUgZW52aXJvbm1lbnQgdmFyaWFibGUKPiA+ID4gImFsbG93X3JnYjEwX2Nv
bmZpZ3M9ZmFsc2UiIGZvciBnbm9tZS1zaGVsbC4KPiA+IAo+ID4gSSBhZGRlZCBlbnZpcm9ubWVu
dCB2YXJpYWJsZSBhcyB5b3Ugc2FpZDoKPiA+ICMgZWNobyAiYWxsb3dfcmdiMTBfY29uZmlncz1m
YWxzZSIgPiAvZXRjL3Byb2ZpbGUuZC9nbm9tZS0KPiA+IHdvcmthcm91bmQuc2gKPiA+IEJ1dCBp
dCBub3QgaGVscHMgd29ya2Fyb3VuZCBwcm9ibGVtLgo+ID4gTWF5YmUgd2UgbWFkZSBhIG1pc3Rh
a2UgaW4gdGhlIGRpYWdub3Npcz8KPiAKPiBJdCdzIHBvc3NpYmxlLgo+IAo+IE1hcmVrCj4gCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
