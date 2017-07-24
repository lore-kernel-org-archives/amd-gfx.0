From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/14] amdgpu: powerplay: Remove unused function
Date: Mon, 24 Jul 2017 11:45:39 -0400
Message-ID: <a059f078-b364-e0b7-6532-99fa4d36514e@amd.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
 <20170724133540.32200-2-ricardo.ribalda@gmail.com>
 <40ac5a58-9e02-0240-ae87-0b1c9375873b@amd.com>
 <CAPybu_2eqTsFzrP=o8u-m-sCi-VDx6Bep2AqT7KGH4p6LstHcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPybu_2eqTsFzrP=o8u-m-sCi-VDx6Bep2AqT7KGH4p6LstHcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nils_Wallm=c3=a9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

T24gMjAxNy0wNy0yNCAxMDowNiBBTSwgUmljYXJkbyBSaWJhbGRhIERlbGdhZG8gd3JvdGU6Cj4g
SGkgSGFycnkKPiBPbiBNb24sIEp1bCAyNCwgMjAxNyBhdCA0OjAxIFBNLCBIYXJyeSBXZW50bGFu
ZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4gd3JvdGU6Cj4gCj4+Cj4+IFRoaXMgaXMgdXNlZCBh
bmQgbmVlZGVkIGJ5IHRoZSBEQyBkaXNwbGF5IGRyaXZlci4gU2VlCj4+IGRpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbV9zZXJ2aWNlcy5jOjE5MyBpbiBBbGV4J3MgYW1kLXN0YWdpbmctNC4xMSB0
cmVlOgo+Pgo+PiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC90cmVl
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3NlcnZpY2Vz
LmM/aD1hbWQtc3RhZ2luZy00LjExCj4+Cj4gCj4gSSBjb3VsZCBub3QgZmluZCBhbnkgcmVmZXJl
bmNlIHRvIHRoZSBmdW5jdGlvbiBpbiBsaW51eC1uZXh0ICg+NC4xMikKPiAKPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0
L3RyZWUvZHJpdmVycy9ncHUvZHJtL2FtZAo+IAo+IElzIHRoZXJlIGFueSBwbGFuIHRvIG1lcmdl
IEFsZXgncyBhbWQtc3RhZ2luIHRyZWU/CgpUaGUgcGxhbiBpcyB0byBtZXJnZS91cHN0cmVhbSB0
aGUgYW1kL2Rpc3BsYXkgcG9ydGlvbiBvZiBBbGV4J3MKYW1kLXN0YWdpbmcgdHJlZS4gV2UncmUg
Y3VycmVudGx5IHdvcmtpbmcgb24gdGhlIGNvbW11bml0eSBmZWVkYmFjayB3ZQpyZWNlaXZlZCB0
byBnZXQgaXQgaW50byBzaGFwZS4KCkhhcnJ5Cgo+IAo+IFNvcnJ5LCBJIGFtIG5vdCB2ZXJ5IGZh
bWlsaWFyIHdpdGggdGhpcyBzdWJzeXN0ZW0uCj4gCj4gUmVnYXJkcyEKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
