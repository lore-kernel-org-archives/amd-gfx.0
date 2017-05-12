From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Fri, 12 May 2017 15:21:23 +0000
Message-ID: <CY1PR1201MB103331794AEFCBCD27AB5FFCF5E20@CY1PR1201MB1033.namprd12.prod.outlook.com>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1bdcfa4a-6840-796e-1623-2949358a0364-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

TXkgdW5kZXJzdGFuZGluZyBpcyB0aGlzIGlzIGFjdHVhbGx5IGEgZGF0YSBmaWxlLiBTaW1pbGFy
IHRvIGFtZGdwdSBmaXJtd2FyZSwgd2hpY2ggaXMgYWxzbyBzZXBhcmF0ZSBmcm9tIHRoZSBrZXJu
ZWwgc291cmNlIGNvZGUuDQoNClNhbQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBNaWNoZWwgRMOkbnplciBbbWFpbHRvOm1pY2hlbEBkYWVuemVyLm5ldF0gDQpTZW50OiBU
aHVyc2RheSwgTWF5IDExLCAyMDE3IDg6NTAgUE0NClRvOiBMaSwgU2FtdWVsIDxTYW11ZWwuTGlA
YW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWXVhbiwgWGlhb2pp
ZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gYW1kZ3B1
OiBtb3ZlIGFzaWMgaWQgdGFibGUgdG8gYSBzZXBhcmF0ZSBmaWxlDQoNCk9uIDEyLzA1LzE3IDA2
OjEzIEFNLCBMaSwgU2FtdWVsIHdyb3RlOg0KPiBTdWJtaXR0ZWQgYSByZXF1ZXN0IHRvIGNyZWF0
ZSBhIG5ldyByZXBvIG9uIGZyZWVkZXNrdG9wLg0KDQpXaGF0J3MgdGhlIHBvaW50IG9mIGhhdmlu
ZyBhIHNlcGFyYXRlIHJlcG9zaXRvcnkgdXBzdHJlYW0/IENhbid0IHdlIGp1c3Qga2VlcCBpdCBp
biB0aGUgbGliZHJtIHJlcG9zaXRvcnk/DQoNCg0KLS0gDQpFYXJ0aGxpbmcgTWljaGVsIETDpG56
ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
