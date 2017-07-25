From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/gmc9: disable legacy vga features in gmc
 init
Date: Tue, 25 Jul 2017 13:06:43 +0800
Message-ID: <20170725050642.GA5930@hr-amur2>
References: <1500953449-19470-1-git-send-email-alexander.deucher@amd.com>
 <1500953449-19470-4-git-send-email-alexander.deucher@amd.com>
 <BN6PR12MB16521CF9048567F549713682F7B80@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN6PR12MB16521CF9048567F549713682F7B80-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBKdWwgMjUsIDIwMTcgYXQgMDQ6MDY6MDBBTSArMDAwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IEFsZXgg
RGV1Y2hlciBbbWFpbHRvOmFsZXhkZXVjaGVyQGdtYWlsLmNvbV0KPiA+IFNlbnQ6IE1vbmRheSwg
SnVseSAyNCwgMjAxNyAxMTozMSBQTQo+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyCj4gPiBTdWJqZWN0OiBbUEFUQ0ggNC80XSBk
cm0vYW1kZ3B1L2dtYzk6IGRpc2FibGUgbGVnYWN5IHZnYSBmZWF0dXJlcyBpbiBnbWMKPiA+IGlu
aXQKPiA+IAo+ID4gTmVlZHMgdG8gYmUgZG9uZSB3aGVuIHRoZSBNQyBpcyBzZXQgdXAuCj4gPiAK
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiAKPiBDYW4gc29tZW9uZSBzZWUgaWYgdGhpcyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSB3
aXRoIHRoZSBsb3dlciA4IE1CIG9mIHZyYW0gb24gdmVnYTEwPyAgSSB0aGluayB0aGlzIG1heSBl
eHBsYWluIHdoYXQgd2FzIG1lc3Npbmcgd2l0aCB2cmFtIG9uIHJlc3VtZSB0aGF0IGNhdXNlZCB1
cyB0byByZXNlcnZlIHRoZSBmaXJzdCA4IE1CIG9mIHZyYW0uCj4gCgpMZXQgbWUgaGF2ZSBhIHRy
eS4gVGhlIHN0YXJ0IG9mIHZyYW0gb3ZlcndyaXRlIGlzIHByb2JhYmx5IHN0aWxsIGNhdXNlZCBi
eQpWR0EgbW9kZS4gU28sIGhlcmUsIHlvdSBkaXNhYmxlIGl0IGF0IGZpcnN0LgoKVGhhbmtzLApS
dWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
