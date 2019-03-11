From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Fix lockdep warking more gracely
Date: Mon, 11 Mar 2019 16:03:11 +0000
Message-ID: <SN6PR12MB2800F6CE7C77376CD6E40BF287480@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <SN6PR12MB2800F0C5DAE738FA1F266E1987480@SN6PR12MB2800.namprd12.prod.outlook.com>
 <1a5f798c-39cb-1c9b-b198-86eb0d084370@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1a5f798c-39cb-1c9b-b198-86eb0d084370-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSBoYXZlIGZpeGVkIGl0IGFuZCBwdXNoZWQgaW4gdGhlIGludGVybmFsIGJyYW5jaC4gU29ycnkg
Zm9yIHR5cG8uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnpl
bCA8cG1lbnplbCthbWQtZ2Z4QG1vbGdlbi5tcGcuZGU+IA0KU2VudDogMjAxOeW5tDPmnIgxMuaX
pSAwOjAwDQpUbzogUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD47IFF1YW4s
IEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogRml4IGxvY2tkZXAgd2Fya2luZyBtb3JlIGdyYWNlbHkNCg0KRGVhciBYaW5odWksDQoNCg0K
VGhlcmUgaXMgYSB0eXBvIGluIHdhcipuKmluZyBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlIHN1bW1h
cnkuDQoNCg0KS2luZCByZWdhcmRzLA0KDQpQYXVsDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
