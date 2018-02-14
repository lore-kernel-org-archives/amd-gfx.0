From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 14/25] drm/amdkfd: Populate DRM render device minor
Date: Wed, 14 Feb 2018 11:39:23 -0500
Message-ID: <da55c3c7-68e3-dc1b-a0f5-77bea917449b@amd.com>
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
 <255915a6-f101-554a-9087-1fd792ee1de3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <255915a6-f101-554a-9087-1fd792ee1de3-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDIwMTgtMDItMTQgMDM6NTAgQU0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwMTgt
MDItMTMgMDg6MTggUE0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBPbiAyMDE4LTAyLTEzIDAx
OjE1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTMuMDIuMjAxOCB1bSAxODox
OCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4KPj4+PiBJIGRvbid0IHNlZSBob3cgeW91IGNh
biBoYXZlIHNlcGFyYXRlIFRUTSBvYmplY3RzIHJlZmVycmluZyB0byB0aGUKPj4+PiBzYW1lIG1l
bW9yeS4KPj4+IFdlbGwgdGhhdCBpcyB0cml2aWFsLCB3ZSBkbyB0aGlzIGFsbCB0aGUgdGltZSB3
aXRoIHByaW1lIGFuZCBJK0EgbGFwdG9wcy4KPj4gQXMgSSB1bmRlcnN0YW5kIGl0LCB5b3UgdXNl
IERNQUJ1ZiB0byBleHBvcnQvaW1wb3J0IGJ1ZmZlcnMgb24gbXVsdGlwbGUKPj4gZGV2aWNlcy4g
SSBiZWxpZXZlIGFsbCBkZXZpY2VzIHNoYXJlIGEgc2luZ2xlIGFtZGdwdV9ibywgd2hpY2ggY29u
dGFpbnMKPj4gdGhlIHR0bV9idWZmZXJfb2JqZWN0Lgo+IFRoZSBkbWEtYnVmIGV4cG9ydGVyIGFu
ZCBpbXBvcnRlciBjYW4gYmUgZGlmZmVyZW50IGRyaXZlcnMsIHNvIHRoaXMgaXMKPiBub3QgcG9z
c2libGUuCgpZZXMuIEluIHRoZSBnZW5lcmFsIGNhc2UgdGhpcyBpcyBoYW5kbGVkIGJ5IFNHIHRh
Ymxlcy4gSG93ZXZlciwgR0VNIGFuZApBTURHUFUgaGF2ZSBzb21lIHNwZWNpYWwgY2FzZXMgZm9y
IGltcG9ydGluZyBidWZmZXJzIGZyb20gdGhlIHNhbWUgZHJpdmVyLgoKVGhlIGRpc2N1c3Npb24g
aGVyZSBpcyBhYm91dCBzaGFyaW5nIEJPcyBiZXR3ZWVuIGRpZmZlcmVudCBBTURHUFUKZGV2aWNl
cyAod2l0aCBvciB3aXRob3V0IGludm9sdmluZyBETUFCdWZzKS4gSSdtIG5vdCB0YWxraW5nIGFi
b3V0CnNoYXJpbmcgQk9zIHdpdGggZGlmZmVyZW50IGRyaXZlcnMuCgpSZWdhcmRzCsKgIEZlbGl4
Cgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
