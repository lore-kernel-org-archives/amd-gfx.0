From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Bail out of BO node creation if not
 enough VRAM (v2)
Date: Wed, 12 Jun 2019 09:26:00 +0200
Message-ID: <fd4c5152-2670-8ac5-e6cc-fff6f260f3ed@daenzer.net>
References: <20190611165444.17841-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190611165444.17841-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNi0xMSA2OjU0IHAubS4sIFN0RGVuaXMsIFRvbSB3cm90ZToKPiAodjIpOiBSZXR1
cm4gMCBhbmQgc2V0IG1lbS0+bW1fbm9kZSB0byBOVUxMLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRv
bSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgfCAxOCArKysrKysrKysrKysrLS0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gWy4u
Ll0KPiAgCj4gQEAgLTI4NCw2ICsyODQsMTQgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3Jf
bmV3KHN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciAqbWFuLAo+ICAJaWYgKCFscGZuKQo+ICAJ
CWxwZm4gPSBtYW4tPnNpemU7Cj4gIAo+ICsJLyogYmFpbCBvdXQgcXVpY2tseSBpZiB0aGVyZSdz
IGxpa2VseSBub3QgZW5vdWdoIFZSQU0gZm9yIHRoaXMgQk8gKi8KPiArCWF0b21pYzY0X2FkZCht
ZW0tPm51bV9wYWdlcyA8PCBQQUdFX1NISUZULCAmbWdyLT51c2FnZSk7Cj4gKwlpZiAoYXRvbWlj
NjRfcmVhZCgmbWdyLT51c2FnZSkgPiBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSB7CgpTaG91bGQg
cHJvYmFibHkgdXNlIGF0b21pYzY0X2FkZF9yZXR1cm4gaW5zdGVhZCBvZiBhdG9taWM2NF9hZGQg
KwphdG9taWM2NF9yZWFkLgoKQWxzbywgQUZBSUNUIHRoaXMgZG9lc24ndCBhbGxvdyBhbnkgVlJB
TSBvdmVyY29tbWl0LCB3aGljaCBzZWVtcyBhIGJpdApjb25zZXJ2YXRpdmU/CgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIGh0dHBzOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
