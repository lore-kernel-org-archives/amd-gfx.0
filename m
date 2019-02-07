From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: BUG - unable to handle null pointer, bisected - drm/amd/display:
 add gpio lock/unlock
Date: Thu, 7 Feb 2019 10:37:28 -0500
Message-ID: <CADnq5_NZMMGdPvzFt1y0XU1GX7KNTtqOwY9GZg7xKSqJCK2X9w@mail.gmail.com>
References: <10341067.RRd0raRtKH@eclipse>
 <7284b267-cbcb-988f-f688-078f75f87a3d@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7284b267-cbcb-988f-f688-078f75f87a3d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

T24gVGh1LCBGZWIgNywgMjAxOSBhdCAxMDozMyBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMTktMDItMDYgMTA6NDggYS5tLiwgUHJ6ZW1layBT
b2NoYSB3cm90ZToKPiA+IEdvb2QgbW9ybmluZywKPiA+Cj4gPiBvbiBteSBMZW5vdm8gRzUwLTQ1
IGE2MzEwIEFQVSB3aXRoIFI0IE11bGxpbnMgY29tbWl0Cj4gPiBlMjYxNTY4Zjk0ZDZjMzdlYmI5
NGQzYzRiM2Y4YTMwODUzNzVkZDlkIGlzIGNhdXNpbmcga2VybmVsIE9vcHMgKHVuYWJsZSB0bwo+
ID4gaGFuZGxlIE5VTEwgcG9pbnRlcikuCj4gPiBDcm9zcy1jaGVja2VkIGJ5IHJldmVydGluZyB0
cm91Ymxlc29tZSBjb21taXQgYW5kIG1hY2hpbmUgd2l0aG91dCBpdCBpcwo+ID4gd29ya2luZyBm
aW5lLgo+Cj4gU2FtZSBmb3IgbWUgd2l0aCBUb25nYS4KPgoKV2VpcmQuICBJJ20gbm90IHNlZWlu
ZyB0aGlzIG9uIG15IFRvbmdhLiAgV2hhdCBkaXNwbGF5cyBhcmUgeW91IHVzaW5nPwogRFZJIGhl
cmUuCgpBbGV4Cgo+Cj4gQ2hpYXdlbiAvIFRvbnkgLyBvdGhlciBEQyBkZXZlbG9wZXJzLCBhbnkg
aWRlYXM/IElmIGl0IGNhbm5vdCBiZSBmaXhlZAo+IHF1aWNrbHksIGxldCdzIHJldmVydCB0aGlz
IGNoYW5nZSBmb3Igbm93Lgo+Cj4KPiAtLQo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KPiBMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
