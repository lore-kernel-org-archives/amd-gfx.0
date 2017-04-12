From: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v2.1)
Date: Wed, 12 Apr 2017 02:49:50 +0000
Message-ID: <BN4PR12MB0787177718627EC2282F9B0AEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-9-airlied@gmail.com>
 <BN4PR12MB0787C6D1CD93D0FCB6F2069DEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
 <CAPM=9txg84JzHVOpA7mfp4774gT_TLcEiya5fXu9cMTSFdWYWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9txg84JzHVOpA7mfp4774gT_TLcEiya5fXu9cMTSFdWYWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QnV0IGhvdyB0byBoYW5kbGUgdGhlIHNlbWFwaG9yZSB3YWl0IGluIHRoZSB2a1F1ZXVlUHJlc2Vu
dGtIUj8NCg0KVGhhbmtzLiANCkJlc3QgUmVnYXJkcywNCkRhdmlkDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZlIEFpcmxpZSBbbWFpbHRvOmFpcmxpZWRAZ21haWwuY29t
XSANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTIsIDIwMTcgMTA6NDQgQU0NClRvOiBNYW8sIERh
dmlkIDxEYXZpZC5NYW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCA4
LzhdIGFtZGdwdTogdXNlIHN5bmMgZmlsZSBmb3Igc2hhcmVkIHNlbWFwaG9yZXMgKHYyLjEpDQoN
Ck9uIDEyIEFwcmlsIDIwMTcgYXQgMTI6MzYsIE1hbywgRGF2aWQgPERhdmlkLk1hb0BhbWQuY29t
PiB3cm90ZToNCj4gRG9lcyBpdCBtZWFucyB3ZSBoYXZlIHRvIHN1Ym1pdCBjb21tYW5kIHRvIHRy
aWdnZXIgdGhlIHNlbWFwaG9yZSB3YWl0L3NpZ25hbD8NCg0KWWVzLCBidXQgSSB0aGluayB0aGF0
IHNob3VsZCBiZSBmaW5lLCB3ZSBuZWVkIHRvIHN1Ym1pdCBhIGpvYiB0byB0aGUgc2NoZWR1bGVy
IHRvIGdldCB0aGUgd2FpdHMgdG8gaGFwcGVuIG9yIHRvIGhhdmUgYSBmZW5jZSB0byBmaWxsIGlu
dG8gdGhlIHNpZ25hbHMuDQoNCkRhdmUuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
