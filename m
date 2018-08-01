From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return bo itself if userptr is cpu addr
 of bo (v3)
Date: Wed, 1 Aug 2018 19:52:05 +0200
Message-ID: <edbcf817-75ea-6e6a-d64a-6274a78308e7@amd.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
 <3d423f44-e47a-e70c-dfd9-80c1ff843e45@gmail.com> <5B6008A1.5050401@amd.com>
 <c6b11c1f-b32a-4ab8-6a78-aa7886eed60a@gmail.com> <5B601844.3010405@amd.com>
 <5e8f2a76-6cbd-1f80-ec94-fcd79c0fa55c@gmail.com> <5B60249D.7030503@amd.com>
 <9dc68d5d-561c-242a-b3ba-1c8078ab670f@gmail.com> <5B6031CA.4050102@amd.com>
 <3ffb8b8c-fae3-92d9-80e1-bd7d0498b4c7@gmail.com>
 <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ@mail.gmail.com>
 <53eb686a-0747-394a-b0c3-4cd53ab836e2@amd.com>
 <CAAxE2A6C0mmr2vogcAQL+XNQuPU=BqHUGjqAMVnS3pK37XJa0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6C0mmr2vogcAQL+XNQuPU=BqHUGjqAMVnS3pK37XJa0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

QW0gMDEuMDguMjAxOCB1bSAxOTozOSBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4gT24gV2VkLCBB
dWcgMSwgMjAxOCBhdCAyOjMyIEFNLCBDaHJpc3RpYW4gS8O2bmlnCj4gPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4+IEFtIDAxLjA4LjIwMTggdW0gMDA6MDcgc2NocmllYiBNYXJl
ayBPbMWhw6FrOgo+Pj4gQ2FuIHRoaXMgYmUgaW1wbGVtZW50ZWQgYXMgYSB3cmFwcGVyIG9uIHRv
cCBvZiBsaWJkcm0/IFNvIHRoYXQgdGhlCj4+PiB0cmVlIChvciBoYXNoIHRhYmxlKSBpc24ndCBj
cmVhdGVkIGZvciBVTURzIHRoYXQgZG9uJ3QgbmVlZCBpdC4KPj4KPj4gTm8sIHRoZSBwcm9ibGVt
IGlzIHRoYXQgYW4gYXBwbGljYXRpb24gZ2V0cyBhIENQVSBwb2ludGVyIGZyb20gb25lIEFQSSBh
bmQKPj4gdHJpZXMgdG8gaW1wb3J0IHRoYXQgcG9pbnRlciBpbnRvIGFub3RoZXIgb25lLgo+Pgo+
PiBJbiBvdGhlciB3b3JkcyB3ZSBuZWVkIHRvIGltcGxlbWVudCB0aGlzIGluZGVwZW5kZW50IG9m
IHRoZSBVTUQgd2hvIG1hcHBlZAo+PiB0aGUgQk8uCj4gWWVhaCwgaXQgY291bGQgYmUgYW4gb3B0
aW9uYWwgZmVhdHVyZSBvZiBsaWJkcm0sIGFuZCBvdGhlciBjb21wb25lbnRzCj4gc2hvdWxkIGJl
IGFibGUgdG8gZGlzYWJsZSBpdCB0byByZW1vdmUgdGhlIG92ZXJoZWFkLgoKVGhlIG92ZXJoZWFk
IGlzIG5lZ2xpZ2libGUsIHRoZSByZWFsIHByb2JsZW0gaXMgdGhlIG1lbW9yeSBmb290cHJpbnQu
CgpBIGJyaWVmIGxvb2sgYXQgdGhlIGhhc2ggaW1wbGVtZW50YXRpb24gaW4gbGliZHJtIHNob3dl
ZCB0aGF0IHRoaXMgaXMgCmFjdHVhbGx5IHJlYWxseSBpbmVmZmljaWVudC4KCkkgdGhpbmsgd2Ug
aGF2ZSB0aGUgY2hvaWNlIG9mIGltcGxlbWVudGluZyBhIHIvYiB0cmVlIHRvIG1hcCB0aGUgQ1BV
IApwb2ludGVyIGFkZHJlc3NlcyBvciBpbXBsZW1lbnQgYSBxdWFkcmF0aWMgdHJlZSB0byBtYXAg
dGhlIGhhbmRsZXMuCgpUaGUgbGF0ZXIgaXMgZWFzeSB0byBkbyBhbmQgd291bGQgYWxzbyBhbGxv
dyB0byBnZXQgcmlkIG9mIHRoZSBoYXNoIAp0YWJsZSBhcyB3ZWxsLgoKQ2hyaXN0aWFuLgoKPgo+
IE1hcmVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
