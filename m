From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Don't save new cursor size before updating
 CUR_SIZE register.
Date: Mon, 19 Dec 2016 13:31:35 -0500
Message-ID: <CADnq5_M_EXdfdBYv4RmUdboQ6OpPA=5-yhkUF+LBs1REgNmO5w@mail.gmail.com>
References: <20161216191118.2338-1-liviu@dudau.co.uk>
 <BN6PR12MB1652933B16CC5F67B00A60DDF79C0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20161217163508.GA1013@bart.dudau.co.uk>
 <20161218134600.267bktteitg4bsge@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161218134600.267bktteitg4bsge-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gU3VuLCBEZWMgMTgsIDIwMTYgYXQgODo0NiBBTSwgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPiB3cm90ZToKPiBPbiBTYXQsIERlYyAxNywgMjAxNiBhdCAwNDozNTowOVBNICswMDAw
LCAnTGl2aXUgRHVkYXUnIHdyb3RlOgo+PiBPbiBGcmksIERlYyAxNiwgMjAxNiBhdCAwNzoxNjoy
NVBNICswMDAwLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6Cj4+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+PiA+ID4gRnJvbTogTGl2aXUgRHVkYXUgW21haWx0bzpsaXZpdUBkdWRh
dS5jby51a10KPj4gPiA+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTYsIDIwMTYgMjoxMSBQTQo+
PiA+ID4gVG86IERhZW56ZXIsIE1pY2hlbDsgRGV1Y2hlciwgQWxleGFuZGVyCj4+ID4gPiBDYzog
S29lbmlnLCBDaHJpc3RpYW47IERhdmlkIEFpcmxpZTsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgYW1kLQo+PiA+ID4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl2aXUgRHVk
YXUKPj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRG9uJ3Qgc2F2ZSBuZXcgY3Vy
c29yIHNpemUgYmVmb3JlIHVwZGF0aW5nCj4+ID4gPiBDVVJfU0laRSByZWdpc3Rlci4KPj4gPiA+
Cj4+ID4gPiBDb21taXQgN2M4M2Q3YWJjOTk5ICgiZHJtL2FtZGdwdTogT25seSB1cGRhdGUgdGhl
IENVUl9TSVpFIHJlZ2lzdGVyCj4+ID4gPiB3aGVuCj4+ID4gPiBuZWNlc3NhcnkiKSBkaWQgbm90
IGNsZWFudXAgY29ycmVjdGx5IHRoZSBvbGQgY29kZSBmb3IgRENFIHY2IGFuZCB2OC4KPj4gPiA+
IEFzIGEgY29uc2VxdWVuY2UsIGN1cnNvciB1cGRhdGVzIHN0b3BwZWQgd29ya2luZyBmb3IgbXkg
UmFkZW9uIFI5Cj4+ID4gPiAxMDAyOjY3YjAKPj4gPiA+IGR1YWwtbW9uaXRvciBzZXR1cC4KPj4g
PiA+Cj4+ID4gPiBGaXhlczogN2M4M2Q3YWJjOTk5ICgiZHJtL2FtZGdwdTogT25seSB1cGRhdGUg
dGhlIENVUl9TSVpFIHJlZ2lzdGVyCj4+ID4gPiB3aGVuIG5lY2Vzc2FyeSIpCj4+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMaXZpdSBEdWRhdSA8bGl2aXVAZHVkYXUuY28udWs+Cj4+ID4KPj4gPiBBbHJl
YWR5IGZpeGVkOgo+PiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2Ft
ZC1nZngvMjAxNi1EZWNlbWJlci8wMDM5ODUuaHRtbAo+Pgo+PiBTb3JyeSwgSSd2ZSBvbmx5IGNo
ZWNrZWQgdGhlIGRyaS1kZXZlbCBsaXN0LCBJJ3ZlIG9ubHkgbm90aWNlZCB0aGVyZSBpcyBhbgo+
PiBhbWQtZ2Z4IG9uZSB3aGlsZSBwcmVwYXJpbmcgdGhlIHBhdGNoIGZvciBzZW5kaW5nLgo+Cj4g
SG0geWVhaCwgTUFJTlRBSU5FUlMgaXMgbm90IHVwZGF0ZWQgdG8gaW5jbHVkZSB0aGUgbmV3IGxp
c3QuIEFsZXgsIGNhbiB5b3UKPiBwbHMgZml4IHRoYXQ/CgpQYXRjaCBvbiB0aGUgd2F5LgoKQWxl
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
