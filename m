From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: always steal the first 32MB of vram
 for fw hand-over
Date: Fri, 6 Apr 2018 09:44:54 -0400
Message-ID: <4f97770f-0977-01ad-1b10-6c0e91b4919d@amd.com>
References: <1522952800-32300-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MFUWDCDtcVXcnF27DAuE3L5kC9EqKFeCPs4V1AM5gL0A@mail.gmail.com>
 <87cc962a-8a35-36d6-6b48-85c156e68f04@daenzer.net>
 <1c6e6260-10cf-f189-45b3-74fd2d1c991c@gmail.com>
 <40be8e12-8f2e-449f-d09e-aa46aa396f4c@amd.com>
 <e201782f-0d93-0259-a425-0c0d8cf99ea4@gmail.com>
 <cabf944a-934a-f9c4-1e99-20a4e314442e@amd.com>
 <e38ac7a6-5c7d-8704-b7a9-6cb544eeaf05@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e38ac7a6-5c7d-8704-b7a9-6cb544eeaf05-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CgpPbiAwNC8wNi8yMDE4IDA5OjM0IEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTA0LTA2IDAyOjM5IFBNLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+IEFtIDA2LjA0LjIw
MTggdW0gMTM6MjMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+PiBNZSBhbmQgQWxleCB0
YWxrZWQgdG8gYSBCSU9TIGd1eXMgeWVzdGVyZGF5IGV4YWN0bHkgYWJvdXQgdGhhdCwgYQo+Pj4+
IGR5bmFtaWMgd2F5IHRvIHF1ZXJ5IHRoaXMgaW5mbyBmcm9tIEJJT1MsIGhlIGp1c3QgdG9sZCB1
cyB0byByZXNlcnZlCj4+Pj4gMzJNIHRvIGNvdmVyIDRLIGRpc3BsYXkuCj4gSG93IGFib3V0IHJl
YWRpbmcgRENFIHJlZ2lzdGVycz8KCkkgY2FuIHRyeSBhbmQgY29uc3VsdCB3aXRoIERBTCBvbiB0
aGlzLgoKPgo+Cj4+IEF0IGxlYXN0IHRoZSBzZWNvbmQgcGF0Y2ggc29tZWhvdyBhZGRyZXNzZXMg
dGhlIG1lbW9yeSB3YXN0ZSBjb25jZXJuLAo+PiB0aGUgcmVzZXJ2YXRpb24gd2lsbCBiZSB2ZXJ5
IHRyYW5zaWVudCwgZHVyaW5nIGxhdGUgaW5pdCB0aGUgQk8gd2lsbCBnZXQKPj4gZnJlZWQuCj4g
U3VyZSwgSSBkb24ndCB0aGluayBhbnlib2R5J3MgY29uY2VybmVkIGFib3V0IHRoYXQuIE15IGNv
bmNlcm5zIGFyZToKPgo+ICogSW4gdGhlIGNhc2VzIHdoZXJlIHdlIHN0aWxsIG9ubHkgcmVzZXJ2
ZSAyNTZLLCB0aGVyZSB3aWxsIGxpa2VseSBzdGlsbAo+ICAgIGJlIGFydGlmYWN0cyBkdXJpbmcg
ZHJpdmVyIGluaXRpYWxpemF0aW9uLgo+Cj4gKiAzMk0gbWlnaHQgc3RpbGwgbm90IGJlIGVub3Vn
aCBpbiBzb21lIGNhc2VzLCBlLmcuIDVLIC8gOEsgZGlzcGxheXMuCgpJIHNlZSB5b3VyIHBvaW50
LCBhcyBJIHNhaWQgYWJvdmUsIHdpbGwgYWdhaW4gdHJ5IHRvIGZpbmQgb3V0IGlmIHRoZXJlIApp
cyBzdGlsbCBhIHdheSB0byBrbm93IHRoZSBCSU9TIEZCIHNpemUuCgpBbmRyZXkKCj4KPgo+IFAu
Uy4gUGxlYXNlIGRvbid0IHRvcC1wb3N0Lgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
