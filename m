From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: assign fb_location only if bo is pinned
Date: Wed, 25 Oct 2017 12:23:36 +0200
Message-ID: <328522dd-6f96-60bb-58ad-e91103dd6aef@daenzer.net>
References: <1508852848-17713-1-git-send-email-shirish.s12@gmail.com>
 <BN6PR12MB18268EA378DD476F38B2FED7F2470@BN6PR12MB1826.namprd12.prod.outlook.com>
 <44152644-4a1f-23b5-3b3a-81fc9bb90007@amd.com>
 <59f795cf-f25c-2b7b-9775-0f685131d7d8@amd.com>
 <41ca6c61-1ade-8bf3-cc45-c1adf8606976@amd.com>
 <21693e67-aa36-a4a9-12ac-18e6c5a32e63@daenzer.net>
 <1c36babd-69ee-e701-d857-c6eb8ebab2c3@amd.com>
 <efda8b1f-763c-939a-a1e6-5dd1ad5d3e81@daenzer.net>
 <3437290b-97c3-9c2a-a800-45321c10e0f3@amd.com>
 <d41c9d08-000d-44f4-43d5-e4cda19bc728@amd.com>
 <c270f341-c59b-7f56-eb1a-94c765673b89@daenzer.net>
 <BN6PR12MB182689AA79CD6FA9AF0E2B51F2440@BN6PR12MB1826.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB182689AA79CD6FA9AF0E2B51F2440-/b2+HYfkarSCndJ3FSsNdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjUvMTAvMTcgMTI6MDUgUE0sIFMsIFNoaXJpc2ggd3JvdGU6Cj4gSGkgQWxleCwgTWljaGVs
ICYgQW5kcmV5LAo+IAo+ICBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogYXNzaWduIGZiX2xvY2F0
aW9uIG9ubHkgaWYgYm8gaXMgcGlubmVkCj4gIFtQQVRDSCAyLzJdIGRybS9hbWQvZGlzcGxheTog
Y2xlYW51cCBhZGRSZXEgYW5kIGZpeCBmYl9sb2NhdGlvbgo+IAo+IHNob3VsZCBiZSBkcm9wcGVk
IGFuZCBpbnN0ZWFkOgoKU2luY2UgeW91IHB1c2hlZCB0aGUgbGF0dGVyIHRvIGFtZC1zdGFnaW5n
LWRybS1uZXh0LCBwbGVhc2UgcmV2ZXJ0IGl0CnRoZXJlLCBvciBtYXliZSBzdWJtaXQgYW5vdGhl
ciBwYXRjaCByZW1vdmluZyBhbGwgZmJfbG9jYXRpb24gcmVsYXRlZApjb2RlIGZyb20gZ2V0X2Zi
X2luZm8gYW5kIGZpbGxfcGxhbmVfYXR0cmlidXRlc19mcm9tX2ZiLgoKCj4gW1BBVENIXSBkcm0v
YW1kL2Rpc3BsYXk6IGZpeCBoaWdoIHBhcnQgYWRkcmVzcyBpbiBkbV9wbGFuZV9oZWxwZXJfcHJl
cGFyZV9mYigpCj4gCj4gc2hvdWxkIGJlIHJldmlld2VkIC4KClJldmlld2VkLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCkJ1dCBwbGVhc2Ugd2FpdCBmb3IgcmV2
aWV3IGZyb20gREMgZm9sa3MuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
