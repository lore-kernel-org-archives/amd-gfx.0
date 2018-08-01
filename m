From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return bo itself if userptr is cpu addr
 of bo (v3)
Date: Wed, 1 Aug 2018 13:39:54 -0400
Message-ID: <CAAxE2A6C0mmr2vogcAQL+XNQuPU=BqHUGjqAMVnS3pK37XJa0A@mail.gmail.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
 <3d423f44-e47a-e70c-dfd9-80c1ff843e45@gmail.com> <5B6008A1.5050401@amd.com>
 <c6b11c1f-b32a-4ab8-6a78-aa7886eed60a@gmail.com> <5B601844.3010405@amd.com>
 <5e8f2a76-6cbd-1f80-ec94-fcd79c0fa55c@gmail.com> <5B60249D.7030503@amd.com>
 <9dc68d5d-561c-242a-b3ba-1c8078ab670f@gmail.com> <5B6031CA.4050102@amd.com>
 <3ffb8b8c-fae3-92d9-80e1-bd7d0498b4c7@gmail.com>
 <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ@mail.gmail.com>
 <53eb686a-0747-394a-b0c3-4cd53ab836e2@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <53eb686a-0747-394a-b0c3-4cd53ab836e2-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBBdWcgMSwgMjAxOCBhdCAyOjMyIEFNLCBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+IEFtIDAxLjA4LjIwMTggdW0gMDA6MDcgc2Nocmll
YiBNYXJlayBPbMWhw6FrOgo+Pgo+PiBDYW4gdGhpcyBiZSBpbXBsZW1lbnRlZCBhcyBhIHdyYXBw
ZXIgb24gdG9wIG9mIGxpYmRybT8gU28gdGhhdCB0aGUKPj4gdHJlZSAob3IgaGFzaCB0YWJsZSkg
aXNuJ3QgY3JlYXRlZCBmb3IgVU1EcyB0aGF0IGRvbid0IG5lZWQgaXQuCj4KPgo+IE5vLCB0aGUg
cHJvYmxlbSBpcyB0aGF0IGFuIGFwcGxpY2F0aW9uIGdldHMgYSBDUFUgcG9pbnRlciBmcm9tIG9u
ZSBBUEkgYW5kCj4gdHJpZXMgdG8gaW1wb3J0IHRoYXQgcG9pbnRlciBpbnRvIGFub3RoZXIgb25l
Lgo+Cj4gSW4gb3RoZXIgd29yZHMgd2UgbmVlZCB0byBpbXBsZW1lbnQgdGhpcyBpbmRlcGVuZGVu
dCBvZiB0aGUgVU1EIHdobyBtYXBwZWQKPiB0aGUgQk8uCgpZZWFoLCBpdCBjb3VsZCBiZSBhbiBv
cHRpb25hbCBmZWF0dXJlIG9mIGxpYmRybSwgYW5kIG90aGVyIGNvbXBvbmVudHMKc2hvdWxkIGJl
IGFibGUgdG8gZGlzYWJsZSBpdCB0byByZW1vdmUgdGhlIG92ZXJoZWFkLgoKTWFyZWsKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
