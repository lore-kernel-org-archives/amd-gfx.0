From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Use GTT for dumb buffer if sg display
 enabled
Date: Tue, 22 May 2018 14:12:12 +0200
Message-ID: <bbf167e1-9053-3800-981f-b8cc9cc4bd22@amd.com>
References: <20180521232203.12086-1-Deepak.Sharma@amd.com>
 <f0e83630-9736-76b1-6489-265882b664d6@daenzer.net>
 <965c9ef7-44c7-86c7-d797-3bf0b767519f@gmail.com>
 <000f9d6a-af14-34d0-abfb-51fabad0c29d@daenzer.net>
 <0d1e4e69-a41f-5432-1d95-2c964051bd41@gmail.com>
 <cbceb91e-45b3-f998-8b16-c199e1906aab@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cbceb91e-45b3-f998-8b16-c199e1906aab-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Deepak Sharma <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

W1NOSVBdCj4+IElmIHRoZSBCTyBpcyBtb3ZlZCBmcm9tIFZSQU0gdG8gVlJBTSAodG8gbWFrZSBp
dCBsaW5lYXIpIG9yIGZyb20gVlJBTSB0bwo+PiBHVFQgZm9yIHNjYW5vdXQgZG9lc24ndCByZWFs
bHkgbWF0dGVyLgo+IE5vdCBzdXJlIHdoYXQgeW91IG1lYW4uIER1bWIgQk9zIGFyZSBvbmx5IHVz
ZWQgZm9yIENQVSBhY2Nlc3MgYW5kCj4gc2Nhbm91dCwgYW5kIHNob3VsZCBiZSBjcmVhdGVkIGFj
Y29yZGluZ2x5LgoKV2VsbCB3aGF0IEkgd2FudGVkIHRvIHNheSBpcyB0aGF0IGl0IGlzbid0IHdv
cnNlIHRoYW4gYmVmb3JlLgoKT24gdGhlIG90aGVyIGhhbmQgdGhpbmtpbmcgYWJvdXQgaXQgc29t
ZXRoaW5nIGxpa2UgNSBsaW5lcyBvZiBjb2RlIApzb3VuZHMgdG8gYXZvaWQgdGhlIGV4dHJhIGNv
cHkgc291bmRzIHJlYXNvbmFibGUgdG8gbWUuCgo+PiBBbmQgQlRXIEdUVCBCT3MgdXNlZCBmb3Ig
c2Nhbm91dCBzaG91bGQgYmUgY3JlYXRlZCBVU1dDLCBzbyB0aGUgYXJndW1lbnQKPj4gdGhhdCBp
dCBpcyBmYXN0ZXIgZm9yIENQVSBhY2Nlc3MgaXNuJ3QgcmVhbGx5IHRydWUgZWl0aGVyLgo+IFlv
dSdyZSBzYXlpbmcgc2Nhbm91dCBkb2Vzbid0IHdvcmsgZnJvbSBjYWNoZWFibGUgR1RUIEJPcz8g
SWYgaXQgZG9lcwo+IHdvcmssIGl0IHdvdWxkIGJlIHByZWZlcmFibGUgZm9yIGR1bWIgQk9zLgoK
V2VsbCwgc2Nhbm91dCBkb2VzIHNlZW0gdG8gd29yayBmcm9tIGNhY2hhYmxlIEdUVCBCT3MuIEJ1
dCBmcm9tIHRoZSAKZG9jdW1lbnRhdGlvbiBmcm9tIHRoZSBoYXJkd2FyZSB0ZWFtIEknbSBwcmV0
dHkgc3VyZSB0aGV5IG5ldmVyIAp2YWxpZGF0ZWQgdGhpcy4KCkFuZCBhcyB1c3VhbGx5IG5vYm9k
eSBmcm9tIHRoZSBoYXJkd2FyZSBndXlzIEkgYXNrZWQgc28gZmFyIGNvdWxkIGdpdmUgCm1lIGEg
Y2xlYXIgYW5zd2VyIGlmIGl0IHdvcmtzIG9yIG5vdC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
