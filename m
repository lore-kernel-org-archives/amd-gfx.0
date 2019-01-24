From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 09:25:35 +0000
Message-ID: <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190124091316.GA22796-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-US
Content-ID: <AF3B4EBF3CBDD3479AB379D417D317C6-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

QW0gMjQuMDEuMTkgdW0gMTA6MTMgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gT24gV2Vk
LCBKYW4gMjMsIDIwMTkgYXQgMDU6NTI6NTBQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6
DQo+PiBCdXQgbXkgY29uY2VybiBpcyB0aGF0IGl0IHNlZW1zIGxpa2VseSB0aGF0IG5vbi1jYWNo
ZSBjb2hlcmVudA0KPj4gaW1wbGVtZW50YXRpb25zIGFyZSByZWx5aW5nIG9uIHRoaXMgaGFjayBh
cyB3ZWxsLiBUaGVyZSBtdXN0IGJlIGENCj4+IHJlYXNvbiB0aGF0IHRoaXMgaGFjayBpcyBvbmx5
IGRpc2FibGVkIGZvciBQb3dlclBDIHBsYXRmb3JtcyBpZiB0aGV5DQo+PiBhcmUgY2FjaGUgY29o
ZXJlbnQsIGZvciBpbnN0YW5jZSwgYW5kIEkgc3VzcGVjdCB0aGF0IHRoYXQgcmVhc29uIGlzDQo+
PiB0aGF0IHRoZSBoYWNrIGlzIHRoZSBvbmx5IHRoaW5nIGVuc3VyaW5nIHRoYXQgdGhlIENQVSBt
YXBwaW5nDQo+PiBhdHRyaWJ1dGVzIG1hdGNoIHRoZSBkZXZpY2Ugb25lcyB1c2VkIGZvciB0aGVz
ZSBidWZmZXJzICh0aGUgdm1hcCgpZWQNCj4+IG9uZXMpLCB3aGVyZWFzIHRoZSByaW5ncyBhbmQg
b3RoZXIgY29uc2lzdGVudCBkYXRhIHN0cnVjdHVyZXMgYXJlDQo+PiB1c2luZyB0aGUgRE1BIEFQ
SSBhcyBpbnRlbmRlZCwgYW5kIHRodXMgZ2V0dGluZyB1bmNhY2hlZCBhdHRyaWJ1dGVzIGluDQo+
PiB0aGUgY29ycmVjdCB3YXkuDQo+IERhdmUsIHdobyBhZGRlZCB0aGF0IGNvbW1pdCBpcyBvbiBD
YyB0b2dldGhlciB3aXRoIGp1c3QgYWJvdXQgZXZlcnlvbmUNCj4gaW52b2x2ZWQgaW4gdGhlIHJl
dmlldyBjaGFpbi4gIEJhc2VkIG9uIHRoZSBwcmV2aW91cyBleHBsYW5hdGlvbg0KPiB0aGF0IGlk
ZWEgd2hhdCB3ZSBtaWdodCB3YW50IGFuIHVuY2FjaGVkIG1hcHBpbmcgZm9yIHNvbWUgbm9uLWNv
aGVyZW50DQo+IGFyY2hpdGVjdHVyZXMgZm9yIHRoaXMgdG8gd29yayBhdCBhbGwgbWFrZXMgc2Vu
c2UsIGJ1dCB0aGVuIGFnYWluDQo+IHRoZSB3YXkgdG8gY3JlYXRlIHRob3NlIG1hcHBpbmdzIGlz
IGVudGlyZWx5IGFyY2hpdGVjdHVyZSBzcGVjaWZpYywNCj4gYW5kIGFsc28gbmVlZCBhIGNhY2hl
IGZsdXNoaW5nIGJlZm9yZSBjcmVhdGluZyB0aGUgbWFwcGluZyB0byB3b3JrDQo+IHByb3Blcmx5
LiAgU28gbXkgd29ya2luZyB0aGVvcnkgaXMgdGhhdCB0aGlzIGNvZGUgbmV2ZXIgcHJvcGVybHkN
Cj4gd29ya2VkIG9uIGFyY2hpdGVjdHVyZXMgd2l0aG91dCBETUEgY29oZXJlbnQgZm9yIFBDSWUg
YXQgYWxsLCBidXQNCj4gSSdkIGxvdmUgdG8gYmUgY29ycmVjdGVkIGJ5IGNvbmNyZXRlIGV4YW1w
bGVzIGluY2x1ZGluZyBhbiBleHBsYW5hdGlvbg0KPiBvZiBob3cgaXQgYWN0dWFsbHkgZW5kcyB1
cCB3b3JraW5nLg0KDQpDYWNoZSBjb2hlcmVuY3kgaXMgbWFuZGF0b3J5IGZvciBtb2Rlcm4gR1BV
IG9wZXJhdGlvbi4NCg0KT3RoZXJ3aXNlIHlvdSBjYW4ndCBpbXBsZW1lbnQgYSBidW5jaCBvZiB0
aGUgcmVxdWlyZW1lbnRzIG9mIHRoZSANCnVzZXJzcGFjZSBBUElzLg0KDQpJbiBvdGhlciB3b3Jk
cyB0aGUgYXBwbGljYXRpb25zIGRvZXNuJ3QgaW5mb3JtIHRoZSBkcml2ZXIgdGhhdCB0aGUgR1BV
IA0Kb3IgdGhlIENQVSBpcyBhY2Nlc3NpbmcgZGF0YSwgaXQganVzdCBkb2VzIGl0IGFuZCBhc3N1
bWVzIHRoYXQgaXQgd29ya3MuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
