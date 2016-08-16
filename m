From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: For virtual_display feature, define a
 variable for vblank count of cpu vsync timer.
Date: Tue, 16 Aug 2016 13:00:31 +0900
Message-ID: <c43417fa-f177-e65c-76b2-2ed0296090d8@daenzer.net>
References: <1470887198-3465-1-git-send-email-Emily.Deng@amd.com>
 <6b517057-1e45-d040-a51b-a1b21cbfee99@daenzer.net>
 <DM5PR12MB165919E6217B9C49998009F08F120@DM5PR12MB1659.namprd12.prod.outlook.com>
 <6c149642-3e82-834a-9e8f-8a1affcc1ee7@daenzer.net>
 <DM5PR12MB16590BBC53DA15179AAA7DBD8F130@DM5PR12MB1659.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB16590BBC53DA15179AAA7DBD8F130-2J9CzHegvk/nc5151fM8tgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTYvMDgvMTYgMTI6NDkgUE0sIERlbmcsIEVtaWx5IHdyb3RlOgo+IEhpIE1pY2hlbCwgVGhh
bmtzLCBJIHN0aWxsIGNvdWxkbid0IHNlZSB0aGUgaXNzdWUgdGhhdCB1c2UgYSB2YXJpYWJsZQo+
IHRvIGNhbGN1bGF0ZSB0aGUgdmJsYW5rIGNvdW50IHdoZW4gdnN5bmMgdGltZXIgaW50ZXJydXB0
IG9jY3Vycy4gSQo+IGp1c3QgdGhpbmsgaXQgb25seSBlbXVsYXRlcyB0aGUgaGFyZHdhcmUgYmVo
YXZpb3IuIEFuZCB0aGUgY29kZQo+IGNoYW5nZSB3aWxsIG9ubHkgaW4gdmlydHVhbCBkaXNwbGF5
IGZpbGVzIHdoaWNoIHdvbid0IHRvdWNoIGRybQo+IGxheWVyLiBJIGluY2xpbmUgdG8gbm90IG1v
ZGlmeSB0aGUgY29kZSBpbiBkcm0gbGF5ZXIgb3IgYW1kZ3B1IG90aGVyCj4gY29kZXMsIGJlY2F1
c2UgaXQgbWF5IGxlYWQgdG8gb3RoZXIgaXNzdWVzIC4KCkkgc2VlIGl0IGJhc2ljYWxseSB0aGUg
b3RoZXIgd2F5IGFyb3VuZDogV2UgYXJlIGN1cnJlbnRseSBwcmV0ZW5kaW5nIHRvCnRoZSBEUk0g
Y29yZSBjb2RlIHRoYXQgd2UgaGF2ZSBhIHJlbGlhYmxlIGhhcmR3YXJlIHZibGFuayBjb3VudGVy
IGFuZAp0aW1pbmcgZXZlbiBpbiB0aGUgdmlydHVhbCBEQ0UgY2FzZSwgd2hlbiB3ZSByZWFsbHkg
ZG9uJ3QuIFdlIHNob3VsZApzdG9wIHByZXRlbmRpbmcgYW5kIGluc3RlYWQgY29tbXVuaWNhdGUg
dGhlIGxhY2sgb2YgdGhlc2UgaGFyZHdhcmUKZmFjaWxpdGllcyBpbiB0aGUgdmlydHVhbCBEQ0Ug
Y2FzZSBhcyBpbnRlbmRlZCwgb3RoZXJ3aXNlIHdlJ2xsIHByb2JhYmx5CnJ1biBpbnRvIGlzc3Vl
cyBzb29uZXIgb3IgbGF0ZXIuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
