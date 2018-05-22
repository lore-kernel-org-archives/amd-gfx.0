From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: consider user preference when pinning for SG
 display
Date: Tue, 22 May 2018 12:04:28 +0200
Message-ID: <8dbfc2bf-6d87-bc07-68bf-d5a7ba2645ee@gmail.com>
References: <20180517165521.8581-1-alexander.deucher@amd.com>
 <4dc6cde7-fb5c-81c2-6678-8e90e1beb78e@daenzer.net>
 <2672d966-febd-6132-a785-01cdd04fea15@amd.com>
 <CADnq5_O+y23n9wKdWNbTk8phx34Tt3Cj3NRQ2AqN=qAmYrxppQ@mail.gmail.com>
 <7d9abb21-8cd9-c860-8fd1-5e8a74278a01@gmail.com>
 <261e78e9-99d7-ce99-9866-701bce2e639a@daenzer.net>
 <666cebe0-1878-bbbb-e9f9-9fdb645a1cbc@amd.com>
 <c695e7bd-ea92-3249-dbc4-38ef2cbb3199@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c695e7bd-ea92-3249-dbc4-38ef2cbb3199-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

W1NOSVBdCj4+PiBJdCdzIG5vdCB0aGF0IGxvdyByZXNvbHV0aW9uIHRoZXNlIGRheXMgKG5vcm1h
bGx5IHRoZSBzbWFsbGVzdCBuYXRpdmUKPj4+IHJlc29sdXRpb24gb2YgYWxsIGNvbm5lY3RlZCBk
aXNwbGF5cywgaS5lLiBnZW5lcmFsbHkgPj0gMTkyMHgxMDgwKSwgaS5lLgo+Pj4gb24gdGhlIG9y
ZGVyIG9mIH4xMCBNQiBvZiBWUkFNIHRoYXQgY2FuJ3QgYmUgdXNlZCBmb3IgYW55dGhpbmcgZWxz
ZS4KPj4gSHVpLCB3aGF0PyBJc24ndCB0aGUgZmIgZnJlZWQgYWZ0ZXIgWCB0YWtlcyBvdmVyPwo+
IE5vcGUsIHRoYXQgaXNuJ3QgcG9zc2libGUgKG5vdCBldmVuIHVuLXBpbm5pbmcgaXQgZnJvbSBW
UkFNKSwgYmVjYXVzZQo+IHRoZSBjb25zb2xlIGxheWVyIGNhbiB0cnkgYWNjZXNzaW5nIHRoZSBi
dWZmZXIgYXQgYW55IHRpbWUgZnJvbSBhbnkgY29udGV4dC4KCk9rLCB0aGF0IGF0IGxlYXN0IGV4
cGxhaW5zIHdoeSBwZW9wbGUgYXJlIHdhbnRpbmcgdG8gZ2V0IHJpZCBvZiBpdCBzbyAKZGVzcGVy
YXRlbHkgOikKClRoYW5rcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
