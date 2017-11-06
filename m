From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH umr] Skip ahead if PDE entry is actually a PTE entry. (v2)
Date: Mon, 6 Nov 2017 13:28:32 -0500
Message-ID: <33d2fd4b-6645-e4f4-629a-40f48a339477@amd.com>
References: <20171104171535.6620-1-tom.stdenis@amd.com>
 <0b642f55-e810-c1a4-f6b5-4644eba2f967@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0b642f55-e810-c1a4-f6b5-4644eba2f967-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDYvMTEvMTcgMDU6MDEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDQuMTEu
MjAxNyB1bSAxODoxNSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gU2lnbmVkLW9mZi1ieTogVG9t
IFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+IAo+IFN0aWxsIG5vdCBwZXJmZWN0LCBi
dXQgZ29vZCBlbm91Z2ggZm9yIG5vdy4gUGF0Y2ggaXMgVGVzdGVkLWJ5OiAKPiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+IAo+IEkgdGhpbmsgeW91IG5lZWQg
dG8gcmV3b3JrIHRoZSBWTSB3YWxraW5nIGEgYml0LCBjYXVzZSB3ZSBuZWVkIHRvIAo+IHN1cHBv
cnQgdGhlIFQgYml0IGFzIHdlbGwgaW4gdGhlIGZ1dHVyZSBhbmQgeW91ciBjb2RlIG1ha2UgYSBm
ZXcgCj4gYXNzdW1wdGlvbnMgd2hpY2ggZG9lc24ndCBhbGxvdyB0aGF0LgoKRG9lc24ndCB0aGUg
VCBiaXQgaW1wbHkgVj0wIHdoaWNoIG1lYW5zIHRoZSBwYWdlIGlzbid0IGJhY2tlZCBieSBtZW1v
cnkuIAogIE5vdCBtdWNoIHVtciBjb3VsZCBkbyBhYm91dCB0aGF0IG90aGVyIHRoYW4gdG8gcHJp
bnQgb3V0IHRoZSBUIGJpdC4KClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
