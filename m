From: "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: Re: release exclusive mode after hw init if no kfd
Date: Wed, 1 Nov 2017 07:54:18 +0000
Message-ID: <71F7EF30-381C-4359-BBC8-13AD4C5DC448@amd.com>
References: <1509515636-13709-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509515636-13709-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <20EA9D92AD253E48ADB58EDBFBFAC426-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgT2RlZCwNCg0KUGxlYXNlIGlnbm9yZSB0aGVtIHNvIGZhci4gSSBuZWVkIHRvIGNvbnNpZGVy
IG1vcmUgbGlrZSB0aGF0IHRoZSBwcm9iZSBpcyBpbmNsdWRlZCBpbiByZXRyeSBpbml0IGxvZ2lj
cy4NCuKAlCANClNpbmNlcmVseSBZb3VycywNClBpeGVsDQoNCg0KDQoNCg0KDQoNCg0KT24gMDEv
MTEvMjAxNywgMTo1MyBQTSwgImFtZC1nZnggb24gYmVoYWxmIG9mIFBpeGVsIERpbmciIDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIG9uIGJlaGFsZiBvZiBQaXhlbC5EaW5n
QGFtZC5jb20+IHdyb3RlOg0KDQo+SGkgT2RlZCwNCj4NCj5QbGVhc2UgcmV2aWV3Lg0KPg0KPltQ
QVRDSCAxLzJdIGRybS9hbWRrZmQ6IGluaXRpYWxpc2Uga2dkIGZpZWxkIGluc2lkZSBrZmQgZGV2
aWNlX2luaXQNCj5BcyB5b3Ugc3VnZ2VzdGVkLCBtb3ZlIGtnZCBhc3NpZ25tZW50IHRvIGRldmlj
ZV9pbml0DQo+DQo+W1BBVENIIDIvMl0gZHJtL2FtZGdwdTogcmVsZWFzZSBleGNsdXNpdmUgbW9k
ZSBhZnRlciBod19pbml0IGlmIG5vDQo+V2Ugc3RpbGwgbmVlZCB0aGlzIGNoYW5nZSBiZWNhdXNl
IHBkZXYgaXMgcGFzc2VkIGluLg0KPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+YW1kLWdmeCBtYWlsaW5nIGxpc3QNCj5hbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
