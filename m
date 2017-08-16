From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 16/19] drm/amdkfd: Update PM4 packet headers
Date: Wed, 16 Aug 2017 18:33:48 -0400
Message-ID: <0a2aee42-c1ad-c356-dbdd-812633e570bf@amd.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
 <1502488589-30272-17-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf12mAxpYF0-AWA=4hJiEe093KkakUYO28-+VxV=Uo+X4Tw@mail.gmail.com>
 <DM5PR1201MB023536CBDE40370D9703EBD6928E0@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <BN6PR12MB13489181F8A90932135C1CBBE88E0@BN6PR12MB1348.namprd12.prod.outlook.com>
 <CAFCwf12edu4VXLP8UTTJk+x9uu9D1bkgO23FpiJbuz3BEreYzg@mail.gmail.com>
 <6137eb72-cb41-d65a-7863-71adf31a3506@amd.com>
 <BN6PR12MB16521615E13EE720D7D5FE51F7820@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16521615E13EE720D7D5FE51F7820-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOC0xNiAxMjoxMCBQTSwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3RlOgo+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBLdWVobGluZywgRmVsaXgKPj4gU2VudDog
VHVlc2RheSwgQXVndXN0IDE1LCAyMDE3IDk6MjAgUE0KPj4gVG86IE9kZWQgR2FiYmF5OyBCcmlk
Z21hbiwgSm9objsgRGV1Y2hlciwgQWxleGFuZGVyCj4+IENjOiBhbWQtZ2Z4IGxpc3QKPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxNi8xOV0gZHJtL2FtZGtmZDogVXBkYXRlIFBNNCBwYWNrZXQgaGVh
ZGVycwo+Pgo+PiBIaSBBbGV4LAo+Pgo+PiBIb3cgZG9lcyBmaXJtd2FyZSBnZXQgcHVibGlzaGVk
IGZvciB0aGUgdXBzdHJlYW0gZHJpdmVyPyBXaGVyZSBjYW4gSQo+PiBjaGVjayB0aGUgY3VycmVu
dGx5IHB1Ymxpc2hlZCB2ZXJzaW9uIG9mIGJvdGggQ1ogYW5kIEtWIGZpcm13YXJlIGZvcgo+PiB1
cHN0cmVhbT8KPj4KPj4gRG8geW91IHB1Ymxpc2ggZmlybXdhcmUgdXBkYXRlcyBhdCB0aGUgc2Ft
ZSB0aW1lIGFzIHBhdGNoZXMgdGhhdCBkZXBlbmQKPj4gb24gdGhlbT8KPiBJIHN1Ym1pdCBwYXRj
aGVzIHRvIHRoZSBsaW51eC1maXJtd2FyZSB0cmVlIHBlcmlvZGljYWxseS4gIEp1c3QgbGV0IG1l
IGtub3cgd2hhdCBmaXJtd2FyZXMgeW91IHdhbnQgdG8gdXBkYXRlIGFuZCBJIGNhbiBzdWJtaXQg
cGF0Y2hlcy4KCkkgbm90aWNlZCB0aGF0IGxpbnV4LWZpcm13YXJlIGN1cnJlbnRseSBkb2Vzbid0
IGhhdmUgZmlybXdhcmUgZm9yIENJSwphbmQgU0kgaW4gdGhlIGFtZGdwdSBmb2xkZXIuIFNob3Vs
ZCB3ZSBhZGQgYXQgbGVhc3QgQ0lLIGlmIHdlIGV4cGVjdApwZW9wbGUgdG8gc3RhcnQgdXNpbmcg
YW1kZ3B1IG9uIENJSyBoYXJkd2FyZT8KClJlZ2FyZHMsCiAgRmVsaXgKCj4KPiBBbGV4Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
