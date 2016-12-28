From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [V2 1/1] drm/amdgpu/gfx8: add support kernel interface queue(KIQ)
Date: Wed, 28 Dec 2016 02:59:13 +0000
Message-ID: <CY4PR12MB1701E0582B28FDC9AF4A1CF7EB680@CY4PR12MB1701.namprd12.prod.outlook.com>
References: <1482476904-21674-1-git-send-email-Xiangliang.Yu@amd.com>
 <CY4PR12MB1701D664FEB2EF8FCFD4EBDBEB680@CY4PR12MB1701.namprd12.prod.outlook.com>
 <58632418.5040408@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58632418.5040408-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggW21haWx0bzph
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBCZWhhbGYNCj4gT2Ygemhv
dWNtMQ0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDI4LCAyMDE2IDEwOjMyIEFNDQo+IFRv
OiBZdSwgWGlhbmdsaWFuZyA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbVjIgMS8xXSBkcm0vYW1kZ3B1L2dmeDg6IGFkZCBzdXBwb3J0IGtlcm5l
bCBpbnRlcmZhY2UNCj4gcXVldWUoS0lRKQ0KPiANCj4gDQo+IA0KPiBPbiAyMDE25bm0MTLmnIgy
OOaXpSAxMDoyNywgWXUsIFhpYW5nbGlhbmcgd3JvdGU6DQo+ID4gKw0KPiA+ID4rCWFtZGdwdV9i
b19rdW5tYXAoa2lxLT5lb3Bfb2JqKTsNCj4gPiA+Kw0KPiBJIHNlZSBpdCBpcyBpbiBtYW55IHBs
YWNlcywgd2hpY2ggaXMgZG9uJ3QgbmVlZCBJIHRoaW5rLA0KPiBhbWRncHVfYm9fZnJlZV9rZXJu
ZWwgd2lsbCBoYW5kbGUgaXQgaWYgSSdtIGNvcnJlY3QuDQoNCk1lbW9yeSBrbWFwIHNob3VsZCBi
ZSBmcmVlIEFTQVAgZnJvbSBtZW1vcnkgbWFuYWdlbWVudCBwb2ludC4NCg0KPiANCj4gUmVnYXJk
cywNCj4gRGF2aWQgemhvdQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
