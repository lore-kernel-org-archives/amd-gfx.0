From: "Cui, Flora" <fcui-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] tests/amdgpu: fix for dispatch/draw test
Date: Fri, 19 Jul 2019 08:34:43 +0000
Message-ID: <0a3b4a91-b679-6de3-f02c-5f5a6dfcb82d@amd.com>
References: <1563437433-4157-1-git-send-email-flora.cui@amd.com>
 <1c9de651-bbb2-6802-e729-182cab5ca427@gmail.com>
 <febeaec7-db65-e18d-d073-d7e19f972edb@amd.com>
 <39c1c37e-89d8-bb00-2cc6-aa048aed77c8@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <39c1c37e-89d8-bb00-2cc6-aa048aed77c8-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4FF7A922FF46CF4D81F262A672C0BB57-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

dGhlIENoYW5nZS1JZCB0YWdzIGFyZSBhZGRlZCBhdXRvbWF0aWNhbGx5LiBkbyB5b3Uga25vdyBo
b3cgdG8gZ2V0IHJpZCBvZiBpdD8NCg0K5ZyoIDcvMTkvMjAxOSAzOjQwIFBNLCBNaWNoZWwgRMOk
bnplciDlhpnpgZM6DQo+IE9uIDIwMTktMDctMTkgODowMCBhLm0uLCBDdWksIEZsb3JhIHdyb3Rl
Og0KPj4gSGkgTWljaGVsLA0KPj4NCj4+IFRoZXNlIDIgY29tbWl0cyBpcyBwdXNoZWQgdG8gaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2ZjdWkvZHJtLg0KPj4gQ291bGQgeW91IGhlbHAg
dG8gbWVyZ2UgdG8gbWVzYS9kcm0/DQo+IFBsZWFzZSByZW1vdmUgdGhlIENoYW5nZS1JZCB0YWdz
Lg0KPg0KPg0KPiBQLlMuIFdoZW4gYSBjb21taXQgbG9nIGxpc3RzIG11bHRpcGxlIHNlcGFyYXRl
IGNoYW5nZXMsIGl0J3MgYSBnb29kDQo+IGluZGljYXRpb24gdGhhdCB0aGUgY2hhbmdlIHNob3Vs
ZCBiZSBzcGxpdCB1cC4NCj4NCj4gUC5QLlMuIFdlJ2xsIG5lZWQgdG8gZmlndXJlIG91dCBhIGJl
dHRlciB3YXkgdG8gaGFuZGxlIG1lcmdpbmcgbGliZHJtDQo+IGNoYW5nZXMuIE15IHBlcnNvbmFs
IHByZWZlcmVuY2Ugd291bGQgYmUgdG8gZW5hYmxlIEdpdExhYiBtZXJnZSByZXF1ZXN0cw0KPiBm
b3IgaXQuDQo+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
