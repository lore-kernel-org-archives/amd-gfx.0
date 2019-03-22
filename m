From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix vm_cpu_update hit NULL pointer
Date: Fri, 22 Mar 2019 16:42:54 +0100
Message-ID: <583e1755-3c2a-8677-dda0-2f10ed8fc09a@gmail.com>
References: <1553232632-27710-1-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1553232632-27710-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org

QW0gMjIuMDMuMTkgdW0gMDY6MzAgc2NocmllYiBNb25rIExpdToKPiBzaG91bGQgdXNlIGFtZGdw
dV9ib19tYXAsIG90aGVyd2lzZSB5b3UnbGwgaGl0IE5VTEwKPiBwb2ludGVyIGJ1ZyBpZiB3aXRo
IGFtZGdwdV9ib19rcHRyCgpZZWFoIHRoYXQgaXMgYSBrbm93biBwcm9ibGVtLiBOQUsgdG8gdGhp
cyBvbmUgY2F1c2UgdGhhdCB3b3VsZCBtYXAgdGhlIApCTyBhdCB0aGUgd3JvbmcgdGltZS4KCkJ1
dCBpbiBnZW5lcmFsIEkgaGF2ZSBhIHByb3BlciBmaXggZm9yIHRoaXMgaW4gdGhlIHBpcGVsaW5l
LgoKQ2hyaXN0aWFuLgoKPgo+IFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5j
IHwgNCArKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
X2NwdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCj4gaW5k
ZXggOWQ1Mzk4Mi4uMWZiNjI5NWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtX2NwdS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtX2NwdS5jCj4gQEAgLTc2LDggKzc2LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zt
X2NwdV91cGRhdGUoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAo+ICAgewo+ICAg
CXVuc2lnbmVkIGludCBpOwo+ICAgCXVpbnQ2NF90IHZhbHVlOwo+ICsJdm9pZCAqcHRyOwo+ICAg
Cj4gLQlwZSArPSAodW5zaWduZWQgbG9uZylhbWRncHVfYm9fa3B0cihibyk7Cj4gKwlhbWRncHVf
Ym9fa21hcChibywgJnB0cik7Cj4gKwlwZSArPSAodW5zaWduZWQgbG9uZylwdHI7Cj4gICAKPiAg
IAl0cmFjZV9hbWRncHVfdm1fc2V0X3B0ZXMocGUsIGFkZHIsIGNvdW50LCBpbmNyLCBmbGFncyk7
Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
