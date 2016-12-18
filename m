From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Don't save new cursor size before updating
 CUR_SIZE register.
Date: Sun, 18 Dec 2016 14:46:00 +0100
Message-ID: <20161218134600.267bktteitg4bsge@phenom.ffwll.local>
References: <20161216191118.2338-1-liviu@dudau.co.uk>
 <BN6PR12MB1652933B16CC5F67B00A60DDF79C0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20161217163508.GA1013@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161217163508.GA1013-hOhETlTuV5niMG9XS5x8Mg@public.gmane.org>
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
To: 'Liviu Dudau' <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Daenzer,
 Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU2F0LCBEZWMgMTcsIDIwMTYgYXQgMDQ6MzU6MDlQTSArMDAwMCwgJ0xpdml1IER1ZGF1JyB3
cm90ZToKPiBPbiBGcmksIERlYyAxNiwgMjAxNiBhdCAwNzoxNjoyNVBNICswMDAwLCBEZXVjaGVy
LCBBbGV4YW5kZXIgd3JvdGU6Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+
IEZyb206IExpdml1IER1ZGF1IFttYWlsdG86bGl2aXVAZHVkYXUuY28udWtdCj4gPiA+IFNlbnQ6
IEZyaWRheSwgRGVjZW1iZXIgMTYsIDIwMTYgMjoxMSBQTQo+ID4gPiBUbzogRGFlbnplciwgTWlj
aGVsOyBEZXVjaGVyLCBBbGV4YW5kZXIKPiA+ID4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuOyBEYXZp
ZCBBaXJsaWU7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGFtZC0KPiA+ID4gZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl2aXUgRHVkYXUKPiA+ID4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBEb24ndCBzYXZlIG5ldyBjdXJzb3Igc2l6ZSBiZWZvcmUgdXBkYXRpbmcK
PiA+ID4gQ1VSX1NJWkUgcmVnaXN0ZXIuCj4gPiA+IAo+ID4gPiBDb21taXQgN2M4M2Q3YWJjOTk5
ICgiZHJtL2FtZGdwdTogT25seSB1cGRhdGUgdGhlIENVUl9TSVpFIHJlZ2lzdGVyCj4gPiA+IHdo
ZW4KPiA+ID4gbmVjZXNzYXJ5IikgZGlkIG5vdCBjbGVhbnVwIGNvcnJlY3RseSB0aGUgb2xkIGNv
ZGUgZm9yIERDRSB2NiBhbmQgdjguCj4gPiA+IEFzIGEgY29uc2VxdWVuY2UsIGN1cnNvciB1cGRh
dGVzIHN0b3BwZWQgd29ya2luZyBmb3IgbXkgUmFkZW9uIFI5Cj4gPiA+IDEwMDI6NjdiMAo+ID4g
PiBkdWFsLW1vbml0b3Igc2V0dXAuCj4gPiA+IAo+ID4gPiBGaXhlczogN2M4M2Q3YWJjOTk5ICgi
ZHJtL2FtZGdwdTogT25seSB1cGRhdGUgdGhlIENVUl9TSVpFIHJlZ2lzdGVyCj4gPiA+IHdoZW4g
bmVjZXNzYXJ5IikKPiA+ID4gU2lnbmVkLW9mZi1ieTogTGl2aXUgRHVkYXUgPGxpdml1QGR1ZGF1
LmNvLnVrPgo+ID4gCj4gPiBBbHJlYWR5IGZpeGVkOgo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvYXJjaGl2ZXMvYW1kLWdmeC8yMDE2LURlY2VtYmVyLzAwMzk4NS5odG1sCj4gCj4g
U29ycnksIEkndmUgb25seSBjaGVja2VkIHRoZSBkcmktZGV2ZWwgbGlzdCwgSSd2ZSBvbmx5IG5v
dGljZWQgdGhlcmUgaXMgYW4KPiBhbWQtZ2Z4IG9uZSB3aGlsZSBwcmVwYXJpbmcgdGhlIHBhdGNo
IGZvciBzZW5kaW5nLgoKSG0geWVhaCwgTUFJTlRBSU5FUlMgaXMgbm90IHVwZGF0ZWQgdG8gaW5j
bHVkZSB0aGUgbmV3IGxpc3QuIEFsZXgsIGNhbiB5b3UKcGxzIGZpeCB0aGF0PwotRGFuaWVsCi0t
IApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRw
Oi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
