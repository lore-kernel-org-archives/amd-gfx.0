From: William Lewis <minutemaidpark-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 16/21] drm/amdgpu: implement lru amdgpu_queue_mgr policy
 for compute v3
Date: Fri, 3 Mar 2017 16:38:00 +0000
Message-ID: <BN6PR17MB0913C00705171B7DF3A390B7C82B0@BN6PR17MB0913.namprd17.prod.outlook.com>
References: <20170302214448.4146-1-andresx7@gmail.com>
 <20170302214448.4146-17-andresx7@gmail.com>
 <6532497e-050d-42f2-808c-f398c4af2dc6@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6532497e-050d-42f2-808c-f398c4af2dc6-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
Content-ID: <2A69C73111BB234CB8E9ED399BBCF6CB-D2/8MP7PhqWcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

TWlub3Igc3BlbGxpbmcgbml0cGljay4NCj4+ICAgKy8qKg0KPj4gKyAqIGFtZGdwdV9yaW5nX2xy
dV9nZXQgLSBnZXQgdGhlIGxlYXN0IHJlY2VudGx5IHVzZWQgcmluZyBmb3IgYSBIVyANCj4+IElQ
IGJsb2NrDQo+PiArICoNCj4+ICsgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyDQo+PiAr
ICogQHR5cGU6IGFtZGdwdV9yaW5nX3R5cGUgZW51bQ0KPj4gKyAqIEByaW5nOiBvdXRwdXQgcmlu
Zw0KPj4gKyAqDQo+PiArICogUmV0cmVpdmUgdGhlIGFtZGdwdV9yaW5nIHN0cnVjdHVyZSBmb3Ig
dGhlIGxlYXN0IHJlY2VudGx5IHVzZWQgDQo+PiByaW5nIG9mDQpzL1JldHJlaXZlL1JldHJpZXZl
Lw0KPj4NCj4+ICsgKiBhIHNwZWNpZmljIElQIGJsb2NrIChhbGwgYXNpY3MpLg0KPj4gKyAqIFJl
dHVybnMgMCBvbiBzdWNjZXNzLCBlcnJvciBvbiBmYWlsdXJlLg0KPj4gKyAqLw0KPj4gK2ludCBh
bWRncHVfcmluZ19scnVfZ2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgdHlwZSwN
Cj4+ICsgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKipyaW5nKQ0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
