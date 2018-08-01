From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return bo itself if userptr is cpu addr
 of bo (v3)
Date: Wed, 1 Aug 2018 08:32:50 +0200
Message-ID: <53eb686a-0747-394a-b0c3-4cd53ab836e2@amd.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
 <3d423f44-e47a-e70c-dfd9-80c1ff843e45@gmail.com> <5B6008A1.5050401@amd.com>
 <c6b11c1f-b32a-4ab8-6a78-aa7886eed60a@gmail.com> <5B601844.3010405@amd.com>
 <5e8f2a76-6cbd-1f80-ec94-fcd79c0fa55c@gmail.com> <5B60249D.7030503@amd.com>
 <9dc68d5d-561c-242a-b3ba-1c8078ab670f@gmail.com> <5B6031CA.4050102@amd.com>
 <3ffb8b8c-fae3-92d9-80e1-bd7d0498b4c7@gmail.com>
 <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDEuMDguMjAxOCB1bSAwMDowNyBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4gQ2FuIHRoaXMg
YmUgaW1wbGVtZW50ZWQgYXMgYSB3cmFwcGVyIG9uIHRvcCBvZiBsaWJkcm0/IFNvIHRoYXQgdGhl
Cj4gdHJlZSAob3IgaGFzaCB0YWJsZSkgaXNuJ3QgY3JlYXRlZCBmb3IgVU1EcyB0aGF0IGRvbid0
IG5lZWQgaXQuCgpObywgdGhlIHByb2JsZW0gaXMgdGhhdCBhbiBhcHBsaWNhdGlvbiBnZXRzIGEg
Q1BVIHBvaW50ZXIgZnJvbSBvbmUgQVBJIAphbmQgdHJpZXMgdG8gaW1wb3J0IHRoYXQgcG9pbnRl
ciBpbnRvIGFub3RoZXIgb25lLgoKSW4gb3RoZXIgd29yZHMgd2UgbmVlZCB0byBpbXBsZW1lbnQg
dGhpcyBpbmRlcGVuZGVudCBvZiB0aGUgVU1EIHdobyAKbWFwcGVkIHRoZSBCTy4KCkNocmlzdGlh
bi4KCj4KPiBNYXJlawo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
