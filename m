From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] amdgpu clang warning fixes on next-20190703
Date: Mon, 8 Jul 2019 11:55:50 -0400
Message-ID: <CADnq5_MGzLLMNPSQXpdxwrBpvsp7Fd1KdExS-K4yNeDBQYEGMg@mail.gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190704055217.45860-1-natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZCB0aGUgc2VyaWVzLiAgdGhhbmtzIQoKQWxleAoKT24gVGh1LCBKdWwgNCwgMjAxOSBh
dCAzOjI2IEFNIE5hdGhhbiBDaGFuY2VsbG9yCjxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+IHdy
b3RlOgo+Cj4gSGkgYWxsLAo+Cj4gSSBkb24ndCBkbyB0aHJlYWRlZCBwYXRjaGVzIHZlcnkgb2Z0
ZW4gc28gaWYgSSBoYXZlIG1lc3NlZCBzb21ldGhpbmcgdXAsCj4gcGxlYXNlIGZvcmdpdmUgbWUg
OikKPgo+IFRoaXMgc2VyaWVzIGZpeGVzIGFsbCBvZiB0aGUgY2xhbmcgd2FybmluZ3MgdGhhdCBJ
IHNhdyBhZGRlZCBpbgo+IG5leHQtMjAxOTA3MDMuIFRoZSBmdWxsIGxpc3QgaXMgdmlzaWJsZSBp
biB0aGUgZ2lzdCBsaW5rZWQgYmVsb3cgYW5kCj4gZWFjaCBmdWxsIGluZGl2aWR1YWwgd2Fybmlu
ZyBjYW4gYmUgc2VlbiBpbiB0aGUgR2l0SHViIGxpbmsgaW4gZWFjaAo+IHBhdGNoLgo+Cj4gaHR0
cHM6Ly9naXN0LmdpdGh1Yi5jb20vNTQxMWFmMDhiOTZjOTliMTRlNjBjNjA4MDBlOTlhNDcKPgo+
IEFsbCBvZiB0aGUgd2FybmluZ3MgYXJlIGZpeGVkIGluIHdoYXQgSSBiZWxpZXZlIGlzIHRoZSBv
cHRpbWFsIHdheSBidXQKPiB0aGUgZW51bSBjb252ZXJzaW9uIHdhcm5pbmdzIHdlcmUgdGhlIHRy
aWNraWVzdDsgcGxlYXNlIHJldmlldyBjYXJlZnVsbHkKPiBhcyB0aGUgY29kZSBwYXRocyBmb3Ig
c29tZSBvZiB0aGVtIGhhdmUgY2hhbmdlZCAoZXNwZWNpYWxseSBpbiBwYXRjaCAzCj4gYW5kIDYp
Lgo+Cj4gVGhhbmsgeW91IQo+IE5hdGhhbgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
