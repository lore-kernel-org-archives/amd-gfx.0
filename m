From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 15 Oct 2018 12:45:49 +0000
Message-ID: <20181015124549.GA579@freedom>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
 <20181008120423.GA300@freedom>
 <CAEQFVGahx4U+52uKu20_q0iCPrdzeW8G+viS7p2LJtgF61bf6Q@mail.gmail.com>
 <20181008201706.GA351@freedom> <20181008212236.GA338@freedom>
 <CAEQFVGaErupy3y+sKA+uqQPn7x0oL1T9BKWj6y8EC12Ap2-YDw@mail.gmail.com>
 <20181015012533.GA21702@freedom>
 <CAEQFVGbB_ezGSGwPu2Ka-4rY9RjB_rJvPL8ZCEG-_rfXxOEN-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEQFVGbB_ezGSGwPu2Ka-4rY9RjB_rJvPL8ZCEG-_rfXxOEN-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gTW9uLCBPY3QgMTUsIDIwMTggYXQgMDc6Mjg6NTdBTSArMDIwMCwgTWF1cm8gUm9zc2kgd3Jv
dGU6Cj4gZHBtIGZvciBTSSBpcyBhdmFpbGFibGUsIHdoaWxlIHBvd2VycGxheSBmb3IgU0kgaXMg
bm90LCBidXQKPiBkaXNwbGF5L2FtZGdwdV9kbSB1c2VzIHNvbWUgcG93ZXJwbGF5IGNhbGxzLCB3
aGVyZSBnZXRfc3RhdGljX2Nsb2NrCj4gZnVuY3Rpb25zIG5vdCBhdmFpbGFibGUgYW5kIHRoZSAq
RVJST1IqIERNX1BQTElCIGlzIGR1ZSB0byBtaXNzaW5nIGhhbmRsaW5nCj4gaW4gcG93ZXJwbGF5
CgpJIHRob3VnaCBwb3dlcnBsYXkgd2FzIGp1c3QgbW9yZSBwb3dlciBzdGF0ZXMgZm9yIHRoZSBk
cG0gc3RhdGUgbWFjaGluZXMgdG8KcGxheSB3aXRoLiBJIHJlY2FsbCBwYXJzaW5nIEFUT01CSU9T
IHBwbGF5IHRhYmxlcyBmb3IgcmVjb3JkcyBvZiAodm9sdGFnZXMvY2xvY2tzCmZyZXF1ZW5jaWVz
KS4KCk1heWJlIHRoZSBmdXR1cmUgaXMgdG8gdHJ1c3QgdGhlIE9TIGtlcm5lbCBhbmQgcGVyZm9y
bSBhbGwgImxvdyBzcGVlZCIgM0QgYXNpYwpmdW5jdGlvbnMgdGhlcmUgYW5kIGtlZXAgb25seSBo
aWdoIHNwZWVkIDNEIG9wZXJhdGlvbnMgaW4gdGhlIGFzaWMuCgotLSAKU3lsdmFpbgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
