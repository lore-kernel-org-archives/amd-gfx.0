From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu:new method to sync ce&de
Date: Mon, 5 Sep 2016 21:13:28 +0200
Message-ID: <CAAxE2A6s0ephQBxb=b8XU01wNbQ3aCX51thv4DrLCs6VckLxzw@mail.gmail.com>
References: <1472439337-8002-1-git-send-email-Monk.Liu@amd.com>
 <1472439337-8002-2-git-send-email-Monk.Liu@amd.com>
 <283cbf94-05bf-4d30-c03f-731dd34ac653@vodafone.de>
 <MWHPR12MB1182364E8ADFBB9B2AAFD47A84E10@MWHPR12MB1182.namprd12.prod.outlook.com>
 <1c8cab37-70cb-3e17-b651-b3b6b2b5b8e0@vodafone.de>
 <MWHPR12MB16948C33AC82C6566DBA5C5EF7E10@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16948C33AC82C6566DBA5C5EF7E10-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Liu,
 Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBBdWcgMjksIDIwMTYgYXQgMzozNyBQTSwgRGV1Y2hlciwgQWxleGFuZGVyCjxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gRnJvbTogYW1kLWdmeCBbbWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmddIE9uIEJlaGFsZgo+PiBPZiBDaHJpc3RpYW4gS8O2bmlnCj4+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDI5LCAyMDE2IDQ6MjUgQU0KPj4gVG86IExpdSwgTW9uazsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIGRybS9hbWRncHU6
bmV3IG1ldGhvZCB0byBzeW5jIGNlJmRlCj4+Cj4+IEh1aSB3aGF0Pwo+Pgo+PiBJdCBmZWVscyBs
aWtlIGEgaHVuZHJlZCB0aW1lcyBJIGFza2VkIGlmIHRoZSBjb21wdXRlIGVuZ2luZSBoYXMgYSBD
RSBhcwo+PiB3ZWxsLCBidXQgc28gZmFyIHRoZSBhbnN3ZXIgd2FzIGFsd2F5cyBOby4gVGhhdCB3
b3VsZCBleHBsYWluIGEgd2hvbGUKPj4gYnVuY2ggb2YgcHJvYmxlbXMgd2UgaGFkIHdpdGggdGhl
IGNvbXB1dGUgcmluZ3MgYXMgd2VsbC4KPgo+IENhbiB3ZSBnZXQgc29tZSBjbGFyaWZpY2F0aW9u
PyAgSSBkb2Vzbid0IGhhdmUgYSBkZWRpY2F0ZWQgQ0UgYXMgZmFyIGFzIEkga25vdy4gIENhbiB0
aGUgQ0UgYmUgdXNlZCBpbiBjb25qdW5jdGlvbiB3aXRoIE1FQyBhcyB3ZWxsIGFzIHRoZSBQRlAv
TUU/CgpGcm9tIHRoZSBDUCBwcm9ncmFtIHNwZWMsIENFIGNhbiBvbmx5IGJlIHVzZWQgd2l0aCBE
RSBhbmQgREUgPSBDUC5NRS4KQWxzbywgQ0UgaXMgZGVzY3JpYmVkIGluIHRoZSBLZXJuZWwgR3Jh
cGhpY3MgUXVldWUgc2VjdGlvbi4gVGhlcmUgaXMKbm8gbWVudGlvbiBvZiBDRSBpbiB0aGUgY29t
cHV0ZSBzZWN0aW9ucy4KClRodXMsIGNvbXB1dGUgSUJzIGNhbid0IGJlIHBhaXJlZCB3aXRoIENF
IElCcy4KCk1hcmVrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
