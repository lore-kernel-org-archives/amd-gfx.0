From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/14] amdgpu: powerplay: Remove unused function
Date: Wed, 26 Jul 2017 15:47:51 +0200
Message-ID: <CAPybu_3EBnHk3x1nRXTvZT1tuk5CmJidiA9BupaTbgjP6pADOg@mail.gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
 <20170724133540.32200-2-ricardo.ribalda@gmail.com>
 <40ac5a58-9e02-0240-ae87-0b1c9375873b@amd.com>
 <CAPybu_2eqTsFzrP=o8u-m-sCi-VDx6Bep2AqT7KGH4p6LstHcA@mail.gmail.com>
 <a059f078-b364-e0b7-6532-99fa4d36514e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a059f078-b364-e0b7-6532-99fa4d36514e-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

SGkgSGFycnkKCk9uIE1vbiwgSnVsIDI0LCAyMDE3IGF0IDU6NDUgUE0sIEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPiB3cm90ZToKPiBPbiAyMDE3LTA3LTI0IDEwOjA2IEFN
LCBSaWNhcmRvIFJpYmFsZGEgRGVsZ2FkbyB3cm90ZToKPj4gSGkgSGFycnkKPj4gT24gTW9uLCBK
dWwgMjQsIDIwMTcgYXQgNDowMSBQTSwgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+IHdyb3RlOgo+Pgo+Pj4KPj4+IFRoaXMgaXMgdXNlZCBhbmQgbmVlZGVkIGJ5IHRoZSBE
QyBkaXNwbGF5IGRyaXZlci4gU2VlCj4+PiBkaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fc2Vy
dmljZXMuYzoxOTMgaW4gQWxleCdzIGFtZC1zdGFnaW5nLTQuMTEgdHJlZToKPj4+Cj4+PiBodHRw
czovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC90cmVlL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3NlcnZpY2VzLmM/aD1hbWQtc3RhZ2lu
Zy00LjExCj4+Pgo+Pgo+PiBJIGNvdWxkIG5vdCBmaW5kIGFueSByZWZlcmVuY2UgdG8gdGhlIGZ1
bmN0aW9uIGluIGxpbnV4LW5leHQgKD40LjEyKQo+Pgo+PiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvZHJpdmVy
cy9ncHUvZHJtL2FtZAo+Pgo+PiBJcyB0aGVyZSBhbnkgcGxhbiB0byBtZXJnZSBBbGV4J3MgYW1k
LXN0YWdpbiB0cmVlPwo+Cj4gVGhlIHBsYW4gaXMgdG8gbWVyZ2UvdXBzdHJlYW0gdGhlIGFtZC9k
aXNwbGF5IHBvcnRpb24gb2YgQWxleCdzCj4gYW1kLXN0YWdpbmcgdHJlZS4gV2UncmUgY3VycmVu
dGx5IHdvcmtpbmcgb24gdGhlIGNvbW11bml0eSBmZWVkYmFjayB3ZQo+IHJlY2VpdmVkIHRvIGdl
dCBpdCBpbnRvIHNoYXBlLgoKSXMgdGhlcmUgYW55IHRpbWVmcmFtZSBmb3IgdGhpcz8KCiBBdCBs
ZWFzdCB3ZSBzaG91bGQgcmVtb3ZlIHRoZSAgIHByX2luZm8oIm1pbl9jb3JlX3NldF9jbG9jayBu
b3QKc2V0XG4iKTsgbWVzc2FnZS4KCml0IGlzICh2ZXJ5KSBtaXNsZWFkaW5nIHJpZ2h0IG5vdy4K
ClJlZ2FyZHMhCgo+Cj4gSGFycnkKPgo+Pgo+PiBTb3JyeSwgSSBhbSBub3QgdmVyeSBmYW1pbGlh
ciB3aXRoIHRoaXMgc3Vic3lzdGVtLgo+Pgo+PiBSZWdhcmRzIQo+PgoKCgotLSAKUmljYXJkbyBS
aWJhbGRhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
