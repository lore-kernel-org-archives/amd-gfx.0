From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: always steal the first 32MB of vram
 for fw hand-over
Date: Fri, 6 Apr 2018 15:34:07 +0200
Message-ID: <e38ac7a6-5c7d-8704-b7a9-6cb544eeaf05@daenzer.net>
References: <1522952800-32300-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MFUWDCDtcVXcnF27DAuE3L5kC9EqKFeCPs4V1AM5gL0A@mail.gmail.com>
 <87cc962a-8a35-36d6-6b48-85c156e68f04@daenzer.net>
 <1c6e6260-10cf-f189-45b3-74fd2d1c991c@gmail.com>
 <40be8e12-8f2e-449f-d09e-aa46aa396f4c@amd.com>
 <e201782f-0d93-0259-a425-0c0d8cf99ea4@gmail.com>
 <cabf944a-934a-f9c4-1e99-20a4e314442e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cabf944a-934a-f9c4-1e99-20a4e314442e-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wNC0wNiAwMjozOSBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+IEFtIDA2
LjA0LjIwMTggdW0gMTM6MjMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Cj4+PiBNZSBh
bmQgQWxleCB0YWxrZWQgdG8gYSBCSU9TIGd1eXMgeWVzdGVyZGF5IGV4YWN0bHkgYWJvdXQgdGhh
dCwgYQo+Pj4gZHluYW1pYyB3YXkgdG8gcXVlcnkgdGhpcyBpbmZvIGZyb20gQklPUywgaGUganVz
dCB0b2xkIHVzIHRvIHJlc2VydmUKPj4+IDMyTSB0byBjb3ZlciA0SyBkaXNwbGF5LgoKSG93IGFi
b3V0IHJlYWRpbmcgRENFIHJlZ2lzdGVycz8KCgo+IEF0IGxlYXN0IHRoZSBzZWNvbmQgcGF0Y2gg
c29tZWhvdyBhZGRyZXNzZXMgdGhlIG1lbW9yeSB3YXN0ZSBjb25jZXJuLAo+IHRoZSByZXNlcnZh
dGlvbiB3aWxsIGJlIHZlcnkgdHJhbnNpZW50LCBkdXJpbmcgbGF0ZSBpbml0IHRoZSBCTyB3aWxs
IGdldAo+IGZyZWVkLgpTdXJlLCBJIGRvbid0IHRoaW5rIGFueWJvZHkncyBjb25jZXJuZWQgYWJv
dXQgdGhhdC4gTXkgY29uY2VybnMgYXJlOgoKKiBJbiB0aGUgY2FzZXMgd2hlcmUgd2Ugc3RpbGwg
b25seSByZXNlcnZlIDI1NkssIHRoZXJlIHdpbGwgbGlrZWx5IHN0aWxsCiAgYmUgYXJ0aWZhY3Rz
IGR1cmluZyBkcml2ZXIgaW5pdGlhbGl6YXRpb24uCgoqIDMyTSBtaWdodCBzdGlsbCBub3QgYmUg
ZW5vdWdoIGluIHNvbWUgY2FzZXMsIGUuZy4gNUsgLyA4SyBkaXNwbGF5cy4KCgpQLlMuIFBsZWFz
ZSBkb24ndCB0b3AtcG9zdC4KCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
