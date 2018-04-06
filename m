From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: always steal the first 32MB of vram
 for fw hand-over
Date: Fri, 6 Apr 2018 11:50:13 -0400
Message-ID: <8953c465-a6a7-998d-a854-246d349d2a9f@amd.com>
References: <1522952800-32300-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MFUWDCDtcVXcnF27DAuE3L5kC9EqKFeCPs4V1AM5gL0A@mail.gmail.com>
 <87cc962a-8a35-36d6-6b48-85c156e68f04@daenzer.net>
 <1c6e6260-10cf-f189-45b3-74fd2d1c991c@gmail.com>
 <40be8e12-8f2e-449f-d09e-aa46aa396f4c@amd.com>
 <e201782f-0d93-0259-a425-0c0d8cf99ea4@gmail.com>
 <cabf944a-934a-f9c4-1e99-20a4e314442e@amd.com>
 <e38ac7a6-5c7d-8704-b7a9-6cb544eeaf05@daenzer.net>
 <4f97770f-0977-01ad-1b10-6c0e91b4919d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4f97770f-0977-01ad-1b10-6c0e91b4919d-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNC0wNiAwOTo0NCBBTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gCj4gCj4g
T24gMDQvMDYvMjAxOCAwOTozNCBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIwMTgt
MDQtMDYgMDI6MzkgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pj4+IEFtIDA2LjA0LjIw
MTggdW0gMTM6MjMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4gTWUgYW5kIEFsZXgg
dGFsa2VkIHRvIGEgQklPUyBndXlzIHllc3RlcmRheSBleGFjdGx5IGFib3V0IHRoYXQsIGEKPj4+
Pj4gZHluYW1pYyB3YXkgdG8gcXVlcnkgdGhpcyBpbmZvIGZyb20gQklPUywgaGUganVzdCB0b2xk
IHVzIHRvIHJlc2VydmUKPj4+Pj4gMzJNIHRvIGNvdmVyIDRLIGRpc3BsYXkuCj4+IEhvdyBhYm91
dCByZWFkaW5nIERDRSByZWdpc3RlcnM/Cj4gCj4gSSBjYW4gdHJ5IGFuZCBjb25zdWx0IHdpdGgg
REFMIG9uIHRoaXMuCj4gCgpBcHBhcmVudGx5IHdlIGNhbiByZWFkIFZCSU9TIGFsbG9jYXRpb25z
IGZyb20gVlJBTV9Vc2FnZUJ5RmlybXdhcmUuIEFuZHJleSBpcyBnb2luZyB0byB0YWtlIGEgbG9v
ayBhdCBpdC4gQ2FydmluZyBvdXQgdGhvc2UgYWxsb2NhdGlvbnMgaXMgcHJvYmFibHkgYmV0dGVy
IHRoYW4gdXNpbmcgR1JQSCByZWdpc3RlcnMgdG8gZ3Vlc3MgVkJJT1MgYWxsb2NhdGlvbnMuCgpI
YXJyeQoKPj4KPj4KPj4+IEF0IGxlYXN0IHRoZSBzZWNvbmQgcGF0Y2ggc29tZWhvdyBhZGRyZXNz
ZXMgdGhlIG1lbW9yeSB3YXN0ZSBjb25jZXJuLAo+Pj4gdGhlIHJlc2VydmF0aW9uIHdpbGwgYmUg
dmVyeSB0cmFuc2llbnQsIGR1cmluZyBsYXRlIGluaXQgdGhlIEJPIHdpbGwgZ2V0Cj4+PiBmcmVl
ZC4KPj4gU3VyZSwgSSBkb24ndCB0aGluayBhbnlib2R5J3MgY29uY2VybmVkIGFib3V0IHRoYXQu
IE15IGNvbmNlcm5zIGFyZToKPj4KPj4gKiBJbiB0aGUgY2FzZXMgd2hlcmUgd2Ugc3RpbGwgb25s
eSByZXNlcnZlIDI1NkssIHRoZXJlIHdpbGwgbGlrZWx5IHN0aWxsCj4+IMKgwqAgYmUgYXJ0aWZh
Y3RzIGR1cmluZyBkcml2ZXIgaW5pdGlhbGl6YXRpb24uCj4+Cj4+ICogMzJNIG1pZ2h0IHN0aWxs
IG5vdCBiZSBlbm91Z2ggaW4gc29tZSBjYXNlcywgZS5nLiA1SyAvIDhLIGRpc3BsYXlzCj4gCj4g
SSBzZWUgeW91ciBwb2ludCwgYXMgSSBzYWlkIGFib3ZlLCB3aWxsIGFnYWluIHRyeSB0byBmaW5k
IG91dCBpZiB0aGVyZSBpcyBzdGlsbCBhIHdheSB0byBrbm93IHRoZSBCSU9TIEZCIHNpemUuCj4g
Cj4gQW5kcmV5Cj4gCj4+Cj4+Cj4+IFAuUy4gUGxlYXNlIGRvbid0IHRvcC1wb3N0Lgo+Pgo+IAo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
