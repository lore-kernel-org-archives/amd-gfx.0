From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Mon, 12 Dec 2016 10:29:45 +0100
Message-ID: <20161212092945.jby6n2j62kz2s6wu@phenom.ffwll.local>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>
 <20161212072243.ah6sy3q57z4gimka@phenom.ffwll.local>
 <BN6PR12MB13484DA35697DBD0CA815CFFE8980@BN6PR12MB1348.namprd12.prod.outlook.com>
 <20161212092727.6jgsgzlrdsha6zsl@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161212092727.6jgsgzlrdsha6zsl-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Cheng,
 Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBEZWMgMTIsIDIwMTYgYXQgMTA6Mjc6MjdBTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBNb24sIERlYyAxMiwgMjAxNiBhdCAwNzo1NDo1NEFNICswMDAwLCBCcmlkZ21h
biwgSm9obiB3cm90ZToKPiA+IFllcCwgZ29vZCBwb2ludC4gV2UgaGF2ZSB0ZW5kZWQgdG8gc3Rh
eSBhIGJpdCBiZWhpbmQgYmxlZWRpbmcgZWRnZSBiZWNhdXNlIG91ciBwcmltYXJ5IHRhc2tzIHNv
IGZhciBoYXZlIGJlZW46Cj4gPiAKPiA+IAo+ID4gMS4gU3VwcG9ydCBlbnRlcnByaXNlIGRpc3Ry
b3MgKHdpdGggb2xkIGtlcm5lbHMpIHZpYSB0aGUgaHlicmlkIGRyaXZlcgo+ID4gKEFNREdQVS1Q
Uk8pLCB3aGVyZSB0aGUgY2xvc2VyIHRvIHVwc3RyZWFtIHdlIGdldCB0aGUgbW9yZSBvZiBhIGdh
cCB3ZQo+ID4gaGF2ZSB0byBwYXBlciBvdmVyIHdpdGggS0NMIGNvZGUKPiAKPiBIbSwgSSB0aG91
Z2h0IHJlc29uYWJsZSBlbnRlcnByaXNlIGRpc3Ryb3Mgcm9sbCB0aGVpciBkcm0gY29yZSBmb3J3
YXJkIHRvCj4gdGhlIHZlcnkgbGF0ZXN0IHVwc3RyZWFtIGZhaXJseSBvZnRlbiwgc28gaXQgc2hv
dWxkbid0IGJlIHRvbyBiYWQ/IEZpeGluZwo+IHRoaXMgY29tcGxldGVseSByZXF1aXJlcyB0aGF0
IHlvdSB1cHN0cmVhbSB5b3VyIHByZS1wcm9kdWN0aW9uIGh3IHN1cHBvcnQKPiBlYXJseSBlbm91
Z2ggdGhhdCBieSB0aGUgdGltZSBpdCBzaGlwcyBpdHMgdGhlIGJhY2twb3J0IGlzIGFscmVhZHkg
aW4gYQo+IHJlYWxlYXNlZCBlbnRlcnByaXNlIGRpc3RybyB1cGdyYWRlLiBCdXQgdGhlbiBhZGRp
bmcgYnVnZml4ZXMgb24gdG9wCj4gc2hvdWxkIGJlIGRvYWJsZS4KCk9yIGp1c3QgcHV0IGFuIGVu
dGlyZSBzdGF0aWNhbGx5IGxpbmtlZCBjb3B5IG9mIHRoZSBjb3JyZXNwb25kaW5nIGRybSBjb3Jl
CmludG8geW91ciBka21zLiBBIGJpdCBob3JyaWJsZSwgYnV0IGlpcmMgaXQncyBiZWVuIGRvbmUg
YmVmb3JlLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRl
bCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
