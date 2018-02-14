From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 14/25] drm/amdkfd: Populate DRM render device minor
Date: Wed, 14 Feb 2018 17:50:05 +0100
Message-ID: <ef95f1a4-7b30-47c8-8f33-4e6379d0694b@daenzer.net>
References: <1517967174-21709-1-git-send-email-Felix.Kuehling@amd.com>
 <1517967174-21709-15-git-send-email-Felix.Kuehling@amd.com>
 <16aa5300-7ddc-518a-2080-70cb31b6ad56@gmail.com>
 <5f1c33b3-b3ed-f627-9b5c-347b2399d90f@amd.com>
 <dd476550-9a48-3adc-30e6-8a94bd04833b@gmail.com>
 <d11c598a-b51f-b957-7dae-485025a1ad34@amd.com>
 <ce14b4cd-2bb7-8f19-b464-ddf9f68f45ad@amd.com>
 <cbd18308-c464-125e-ef9f-180c12a9926a@amd.com>
 <a2e39184-8db8-407d-6608-6ae211563459@amd.com>
 <8424282f-d196-3cb6-9a6e-a26f8be7d198@amd.com>
 <ebf4d6d7-2424-764f-0bc0-615240c82483@amd.com>
 <9f078a60-0cca-ba43-3e1c-c67c2b758988@amd.com>
 <c991529e-2489-169c-cc34-96ed5bb94a12@amd.com>
 <b28b0e4c-f16b-0751-7957-45196c26da82@amd.com>
 <ca973468-f1af-b510-a6db-af29e279f5ca@amd.com>
 <50befcd2-6a1a-534e-1699-8556c4977b76@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <50befcd2-6a1a-534e-1699-8556c4977b76-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMi0xNCAwNTozNSBQTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gT24gMjAxOC0w
Mi0xNCAwMjo0MiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTQuMDIuMjAxOCB1
bSAwMDoxNyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gT24gMjAxOC0wMi0xMyAwMjoxOCBQ
TSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4+Pj4gT24gMjAxOC0wMi0xMyAwMToxNSBQTSwgQ2hy
aXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQW0gMTMuMDIuMjAxOCB1bSAxODoxOCBzY2hyaWVi
IEZlbGl4IEt1ZWhsaW5nOgo+Pj4+Pj4KPj4+Pj4+IEkgZG9uJ3Qgc2VlIGhvdyB5b3UgY2FuIGhh
dmUgc2VwYXJhdGUgVFRNIG9iamVjdHMgcmVmZXJyaW5nIHRvIHRoZQo+Pj4+Pj4gc2FtZSBtZW1v
cnkuCj4+Pj4+IFdlbGwgdGhhdCBpcyB0cml2aWFsLCB3ZSBkbyB0aGlzIGFsbCB0aGUgdGltZSB3
aXRoIHByaW1lIGFuZCBJK0EKPj4+Pj4gbGFwdG9wcy4KPj4+PiBBcyBJIHVuZGVyc3RhbmQgaXQs
IHlvdSB1c2UgRE1BQnVmIHRvIGV4cG9ydC9pbXBvcnQgYnVmZmVycyBvbiBtdWx0aXBsZQo+Pj4+
IGRldmljZXMuIEkgYmVsaWV2ZSBhbGwgZGV2aWNlcyBzaGFyZSBhIHNpbmdsZSBhbWRncHVfYm8s
IHdoaWNoIGNvbnRhaW5zCj4+Pj4gdGhlIHR0bV9idWZmZXJfb2JqZWN0Lgo+Pgo+PiBUaGF0J3Mg
aW5jb3JyZWN0IGFzIHdlbGwuIE5vcm1hbGx5IG11bHRpcGxlIGRldmljZXMgaGF2ZSBtdWx0aXBs
ZQo+PiB0dG1fYnVmZmVyX29iamVjdCwgb25lIGZvciBlYWNoIGRldmljZS4KPj4gR29pbmcgYSBi
aXQgaGlnaGVyIHRoYXQgYWN0dWFsbHkgbWFrZXMgc2Vuc2UgYmVjYXVzZSB0aGUgc3RhdHVzIG9m
Cj4+IGVhY2ggQk8gaXMgZGVmZXJlbnQgZm9yIGVhY2ggZGV2aWNlLiBFLmcuIG9uZSBkZXZpY2Ug
Y291bGQgaGF2ZSB0aGUgQk8KPj4gaW4gYWNjZXNzIHdoaWxlIGl0IGNvdWxkIGJlIGlkbGUgb24g
YW5vdGhlciBkZXZpY2UuCj4gCj4gQ2FuIHlvdSBwb2ludCBtZSB3aGVyZSB0aGlzIGlzIGRvbmU/
IEknbSBsb29raW5nIGF0Cj4gYW1kZ3B1X2dlbV9wcmltZV9mb3JlaWduX2JvLiBJdCBpcyB1c2Vk
IGlmIGFuIEFNREdQVSBCTyBpcyBpbXBvcnRlZCBpbnRvCj4gYSBkaWZmZXJlbnQgQU1ER1BVIGRl
dmljZS4gSXQgY3JlYXRlcyBhIG5ldyBHRU0gb2JqZWN0LCB3aXRoIGEgcmVmZXJlbmNlCj4gdG8g
dGhlIHNhbWUgYW1kZ3B1IEJPIChnb2JqLT5ibyA9IGFtZGdwdV9ib19yZWYoYm8pKS4gVG8gbWUg
dGhpcyBsb29rcwo+IHZlcnkgbXVjaCBsaWtlIHRoZSBzYW1lIGFtZGdwdV9ibywgYW5kIGNvc2Vx
dWVudGx5IHRoZSBzYW1lIFRUTSBCTyBiZWluZwo+IHNoYXJlZCBieSB0d28gR0VNIG9iamVjdHMg
YW5kIHR3byBkZXZpY2VzLgoKYW1kZ3B1X2dlbV9wcmltZV9mb3JlaWduX2JvIGRvZXNuJ3QgZXhp
c3QgaW4gYW1kLXN0YWdpbmctZHJtLW5leHQsIGxldAphbG9uZSB1cHN0cmVhbS4gRXZlbiBvbiBj
dXJyZW50IGludGVybmFsIGJyYW5jaGVzLCBpdCdzIG5vIGxvbmdlciB1c2VkCmZvciBkbWEtYnVm
IGltcG9ydCBBRkFJQ1QuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
