From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 18/22] drm/amdgpu: add flag for high priority contexts v4
Date: Wed, 1 Mar 2017 11:51:31 +0000
Message-ID: <CACvgo50QS9HM0K1Te781kteDawoFSnWB-VmVQ-j_ekY-Kt0oGg@mail.gmail.com>
References: <1488320089-22035-1-git-send-email-andresx7@gmail.com>
 <1488320089-22035-19-git-send-email-andresx7@gmail.com>
 <58B66FB8.8050300@amd.com> <58B673C0.4070006@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58B673C0.4070006-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgRGF2aWQsCgpPbiAxIE1hcmNoIDIwMTcgYXQgMDc6MDksIHpob3VjbTEgPGRhdmlkMS56aG91
QGFtZC5jb20+IHdyb3RlOgoKPj4+ICsgICAgY3R4LT5wcmlvcml0eSA9IHByaW9yaXR5Owo+Pgo+
PiBzZWVtcyBub3QgdXNlZC4KPgo+IEkgc2VlIGN0eC0+cHJpb3JpdHkgaXMgdXNlZCBpbiBmb2xs
b3dpbmcgcGF0Y2hlcywgc28gcGxzIHJlbW92ZSBpdCB0aGVyZS4KPgpGd2l3LCBJIGRvbid0IHRo
aW5rIHRoYXQncyBhIGdvb2QgaWRlYS4KCk1vc3QgcGxhY2VzIGluIHRoZSBrZXJuZWwgYXJlIE9L
IGlmIHlvdSBhZGQgcGx1bWJpbmcgd2l0aCBwYXRjaCBYIGFuZAp1c2UgaXQgd2l0aCBYKzEuIE1v
dmluZyB0aGluZ3MgdGhlcmUgd2lsbCBtYWtlIGZvciBhIGJpZyBwYXRjaCB0aGF0IGlzCmhhcmRl
ci9tb3JlIGFubm95aW5nIHRvIHJldmlldyBwcm9wZXJseS4KSU1ITyBpdCdzIHBlcmZlY3RseSBm
aW5lIHRvIGFkZCBhIG5vdGUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIC0KImN1cnJlbnRseSBwcmlv
IGlzIHByb3BhZ2F0ZWQgdGhyb3VnaCB0aGUgZHJpdmVyIGFuZCB0aGUgbmV4dApjb21taXQocykg
d2lsbCBtYWtlIHVzZSBvZiBpdCIsIHJpZ2h0ID8KCi1FbWlsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
