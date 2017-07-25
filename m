From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/gmc9: disable legacy vga features in gmc
 init
Date: Tue, 25 Jul 2017 17:05:48 +0800
Message-ID: <20170725090547.GA8260@hr-amur2>
References: <1500953449-19470-1-git-send-email-alexander.deucher@amd.com>
 <1500953449-19470-4-git-send-email-alexander.deucher@amd.com>
 <BN6PR12MB16521CF9048567F549713682F7B80@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170725050642.GA5930@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170725050642.GA5930@hr-amur2>
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
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBKdWwgMjUsIDIwMTcgYXQgMDE6MDY6NDJQTSArMDgwMCwgSHVhbmcgUnVpIHdyb3Rl
Ogo+IE9uIFR1ZSwgSnVsIDI1LCAyMDE3IGF0IDA0OjA2OjAwQU0gKzAwMDAsIERldWNoZXIsIEFs
ZXhhbmRlciB3cm90ZToKPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gRnJv
bTogQWxleCBEZXVjaGVyIFttYWlsdG86YWxleGRldWNoZXJAZ21haWwuY29tXQo+ID4gPiBTZW50
OiBNb25kYXksIEp1bHkgMjQsIDIwMTcgMTE6MzEgUE0KPiA+ID4gVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIKPiA+ID4gU3ViamVj
dDogW1BBVENIIDQvNF0gZHJtL2FtZGdwdS9nbWM5OiBkaXNhYmxlIGxlZ2FjeSB2Z2EgZmVhdHVy
ZXMgaW4gZ21jCj4gPiA+IGluaXQKPiA+ID4gCj4gPiA+IE5lZWRzIHRvIGJlIGRvbmUgd2hlbiB0
aGUgTUMgaXMgc2V0IHVwLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gCj4gPiBDYW4gc29tZW9uZSBzZWUgaWYg
dGhpcyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSB3aXRoIHRoZSBsb3dlciA4IE1CIG9mIHZyYW0g
b24gdmVnYTEwPyAgSSB0aGluayB0aGlzIG1heSBleHBsYWluIHdoYXQgd2FzIG1lc3Npbmcgd2l0
aCB2cmFtIG9uIHJlc3VtZSB0aGF0IGNhdXNlZCB1cyB0byByZXNlcnZlIHRoZSBmaXJzdCA4IE1C
IG9mIHZyYW0uCj4gPiAKPiAKPiBMZXQgbWUgaGF2ZSBhIHRyeS4gVGhlIHN0YXJ0IG9mIHZyYW0g
b3ZlcndyaXRlIGlzIHByb2JhYmx5IHN0aWxsIGNhdXNlZCBieQo+IFZHQSBtb2RlLiBTbywgaGVy
ZSwgeW91IGRpc2FibGUgaXQgYXQgZmlyc3QuCj4gCgpUaGlzIHBhdGNoIGRvZXNuJ3QgZml4IHRo
ZSBzdGFydCA4IE1CIG9mIHZyYW0gY29ycnVwdGlvbi4KQnV0IEkganVzdCBmb3VuZCB0aGUgOE0g
Y29ycnVwdGlvbiBpc3N1ZSBvbmx5IGVuY291bnRlcmVkIHdoZW4gREMgaXMgZGlzYWJsZWQuCgpU
aGFua3MsClJheQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
