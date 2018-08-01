From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return bo itself if userptr is cpu addr
 of bo (v3)
Date: Wed, 1 Aug 2018 13:59:51 -0400
Message-ID: <CAAxE2A4=k5_20jaPcM9awxQ69MhXY2wtEX9NFxZU9=43_SsRug@mail.gmail.com>
References: <1532944950-28619-1-git-send-email-Jerry.Zhang@amd.com>
 <3d423f44-e47a-e70c-dfd9-80c1ff843e45@gmail.com> <5B6008A1.5050401@amd.com>
 <c6b11c1f-b32a-4ab8-6a78-aa7886eed60a@gmail.com> <5B601844.3010405@amd.com>
 <5e8f2a76-6cbd-1f80-ec94-fcd79c0fa55c@gmail.com> <5B60249D.7030503@amd.com>
 <9dc68d5d-561c-242a-b3ba-1c8078ab670f@gmail.com> <5B6031CA.4050102@amd.com>
 <3ffb8b8c-fae3-92d9-80e1-bd7d0498b4c7@gmail.com>
 <CAAxE2A6uLe_ZMTGQ2dqFbY--Mf15qRrP+tX6pbicokpe8Wo=qQ@mail.gmail.com>
 <53eb686a-0747-394a-b0c3-4cd53ab836e2@amd.com>
 <CAAxE2A6C0mmr2vogcAQL+XNQuPU=BqHUGjqAMVnS3pK37XJa0A@mail.gmail.com>
 <edbcf817-75ea-6e6a-d64a-6274a78308e7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <edbcf817-75ea-6e6a-d64a-6274a78308e7-5C7GfCeVMHo@public.gmane.org>
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

T24gV2VkLCBBdWcgMSwgMjAxOCBhdCAxOjUyIFBNLCBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+IEFtIDAxLjA4LjIwMTggdW0gMTk6Mzkgc2Nocmll
YiBNYXJlayBPbMWhw6FrOgo+Pgo+PiBPbiBXZWQsIEF1ZyAxLCAyMDE4IGF0IDI6MzIgQU0sIENo
cmlzdGlhbiBLw7ZuaWcKPj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4+Pgo+
Pj4gQW0gMDEuMDguMjAxOCB1bSAwMDowNyBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4+Pj4KPj4+
PiBDYW4gdGhpcyBiZSBpbXBsZW1lbnRlZCBhcyBhIHdyYXBwZXIgb24gdG9wIG9mIGxpYmRybT8g
U28gdGhhdCB0aGUKPj4+PiB0cmVlIChvciBoYXNoIHRhYmxlKSBpc24ndCBjcmVhdGVkIGZvciBV
TURzIHRoYXQgZG9uJ3QgbmVlZCBpdC4KPj4+Cj4+Pgo+Pj4gTm8sIHRoZSBwcm9ibGVtIGlzIHRo
YXQgYW4gYXBwbGljYXRpb24gZ2V0cyBhIENQVSBwb2ludGVyIGZyb20gb25lIEFQSQo+Pj4gYW5k
Cj4+PiB0cmllcyB0byBpbXBvcnQgdGhhdCBwb2ludGVyIGludG8gYW5vdGhlciBvbmUuCj4+Pgo+
Pj4gSW4gb3RoZXIgd29yZHMgd2UgbmVlZCB0byBpbXBsZW1lbnQgdGhpcyBpbmRlcGVuZGVudCBv
ZiB0aGUgVU1EIHdobwo+Pj4gbWFwcGVkCj4+PiB0aGUgQk8uCj4+Cj4+IFllYWgsIGl0IGNvdWxk
IGJlIGFuIG9wdGlvbmFsIGZlYXR1cmUgb2YgbGliZHJtLCBhbmQgb3RoZXIgY29tcG9uZW50cwo+
PiBzaG91bGQgYmUgYWJsZSB0byBkaXNhYmxlIGl0IHRvIHJlbW92ZSB0aGUgb3ZlcmhlYWQuCj4K
Pgo+IFRoZSBvdmVyaGVhZCBpcyBuZWdsaWdpYmxlLCB0aGUgcmVhbCBwcm9ibGVtIGlzIHRoZSBt
ZW1vcnkgZm9vdHByaW50Lgo+Cj4gQSBicmllZiBsb29rIGF0IHRoZSBoYXNoIGltcGxlbWVudGF0
aW9uIGluIGxpYmRybSBzaG93ZWQgdGhhdCB0aGlzIGlzCj4gYWN0dWFsbHkgcmVhbGx5IGluZWZm
aWNpZW50Lgo+Cj4gSSB0aGluayB3ZSBoYXZlIHRoZSBjaG9pY2Ugb2YgaW1wbGVtZW50aW5nIGEg
ci9iIHRyZWUgdG8gbWFwIHRoZSBDUFUgcG9pbnRlcgo+IGFkZHJlc3NlcyBvciBpbXBsZW1lbnQg
YSBxdWFkcmF0aWMgdHJlZSB0byBtYXAgdGhlIGhhbmRsZXMuCj4KPiBUaGUgbGF0ZXIgaXMgZWFz
eSB0byBkbyBhbmQgd291bGQgYWxzbyBhbGxvdyB0byBnZXQgcmlkIG9mIHRoZSBoYXNoIHRhYmxl
IGFzCj4gd2VsbC4KCldlIGNhbiBhbHNvIHVzZSB0aGUgaGFzaCB0YWJsZSBmcm9tIG1lc2Evc3Jj
L3V0aWwuCgpJIGRvbid0IHRoaW5rIHRoZSBvdmVyaGVhZCB3b3VsZCBiZSBuZWdsaWdpYmxlLiBJ
dCB3b3VsZCBiZSBhIGxvZyhuKQppbnNlcnRpb24gaW4gYm9fbWFwIGFuZCBhIGxvZyhuKSBkZWxl
dGlvbiBpbiBib191bm1hcC4gSWYgeW91IGRpZApib19tYXArYm9fdW5tYXAgMTAwMDAgdGltZXMs
IHdvdWxkIGl0IGJlIG5lZ2xpZ2libGU/CgpNYXJlawpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
