From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs for large
 BOs
Date: Wed, 29 Mar 2017 11:42:36 -0400
Message-ID: <6efad1b9-14c5-5510-e3fd-48618735e05b@amd.com>
References: <1490749231-16157-1-git-send-email-Felix.Kuehling@amd.com>
 <1490749231-16157-4-git-send-email-Felix.Kuehling@amd.com>
 <58DB21CB.4090800@amd.com>
 <DM5PR1201MB0235AB2363725D0D8320265292350@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <58DB4D02.7020903@amd.com> <8acdbd65-f99d-3e0e-b61b-318cf27d7a3b@vodafone.de>
 <bdbacee3-2c61-ebcb-1421-5c0a77dc27e0@amd.com>
 <a2d6c20e-d35f-e135-342b-47f86683c3e3@daenzer.net>
 <d7279f4d-023e-a8fb-c08f-4e85fec87bd6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d7279f4d-023e-a8fb-c08f-4e85fec87bd6-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhang, Jerry
 (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTctMDMtMjkgMTE6MjIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjkuMDMu
MjAxNyB1bSAxNjo0NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAyOS8wMy8xNyAxMToz
MiBQTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4+PiBPbiAxNy0wMy0yOSAwMjo1MiBBTSwgQ2hy
aXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBQbGVhc2UgY2xlYW4gdGhhdCB1cCBhbmQgYWxzbyBy
ZW1vdmUgYWxsIHRob3NlIFdBUk5fT04oKSwgd2UgZG9uJ3QKPj4+PiB3YW50IHRvIHNwYW0gdGhl
IHN5c3RlbSBsb2cgd2l0aCBiYWNrdHJhY2VzIGxpa2UgdGhpcy4KPj4+IEkgZGlzYWdyZWUuIFdo
ZW4geW91IHNlZSB0aGUgYmFja3RyYWNlcyBmcm9tIFdBUk5fT05zIGluCj4+PiBhbWRncHVfdm1f
Z2V0X3B0LCBpdCBtZWFucyB0aGUgZHJpdmVyIGlzIHRyeWluZyB0byB1cGRhdGUgYSBwYWdlIHRh
YmxlCj4+PiB0aGF0IGhhc24ndCBiZWVuIGFsbG9jYXRlZC4gV2l0aG91dCB0aG9zZSBXQVJOX09O
cyB0aGVyZSBpcyBhYnNvbHV0ZWx5Cj4+PiBubyB3YXJuaW5nIG9mIGFueSBraW5kIC0gYW1kZ3B1
X3ZtX3VwZGF0ZV9wdGUganVzdCBmYWlscyBzaWxlbnRseSAoaXQncwo+Pj4gYSB2b2lkIGZ1bmN0
aW9uKS4KPj4+Cj4+PiBUaGVyZWZvcmUgSSB3b3VsZG4ndCBjYWxsIHRob3NlIHdhcm5pbmdzIHNw
YW0uIEdpdmVuIHRoYXQgdGhlIFZNIFBUCj4+PiBhbGxvY2F0aW9uIGNvZGUgZm9yIG11bHRpLWxl
dmVscyBpcyBub24tdHJpdmlhbCwgSSB0aGluayB0aGF0J3MgYSBnb29kCj4+PiBzYW5pdHkgY2hl
Y2sgdG8gaGF2ZSBhbmQgcmVhbGx5IGhlbHBmdWwgdG8gc2VlIGluIGEgbG9nIHdoZW4gdXNlcgo+
Pj4gcmVwb3J0Cj4+PiByYW5kb20gVk0gZmF1bHRzLgo+PiBXQVJOX09OX09OQ0UgbWlnaHQgYmUg
YSBjb21wcm9taXNlLiBXZSdsbCBzdGlsbCBnZXQgYSBiYWNrdHJhY2UsIGJ1dCBpdAo+PiB3b24n
dCBjYXVzZSBjcmF6eSBsb2cgc3BhbSBpZiB0aGUgYmFkIGNvbmRpdGlvbiBpcyBjb25zaXN0ZW50
bHkgaGl0Lgo+IEdvb2QgaWRlYS4gV2Ugc2hvdWxkIGFsc28gb25seSBhZGQgb25lIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgdGhlCj4gZnVuY3Rpb24gYW5kIG5vdCBtdWx0aXBsZSBjYXRjaGVzIGZvciBl
YWNoIGRlcGVuZGVudCB2YXJpYWJsZS4KCkkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFu
IGhlcmUuIEFyZSB3ZSBzdGlsbCB0YWxraW5nIGFib3V0CmFtZGdwdV92bV91cGRhdGVfcHRlPyBZ
b3UnbGwgaGF2ZSB0byB3YWxrIHRoZSBwYWdlIHRhYmxlIGJlZm9yZSB5b3Uga25vdwp3aGV0aGVy
IGEgUFQgQk8gYWN0dWFsbHkgZXhpc3RzLiBTbyBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCBjaGVj
ayB3b3VsZAptYWtlIHNlbnNlIGF0IHRoZSBzdGFydCAoYmVmb3JlIHRoZSBwYWdlIHRhYmxlIHdh
bGspLgoKSSByZW1vdmVkIHRoZSBXQVJOX09OIGZyb20gYW1kZ3B1X3ZtX2FsbG9jX2xldmVscyBh
bmQgaW5zdGVhZCByZXR1cm4gYW4KZXJyb3IgaWYgImZyb20iIG9yICJ0byIgYXJlIG91dCBvZiBy
YW5nZS4gSSdsbCBzZW5kIG91dCB2MiBvZiBteSBwYXRjaAppbiBhIG1pbnV0ZS4KClJlZ2FyZHMs
CiAgRmVsaXgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
