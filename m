From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: fix VA hole handling on Vega10
Date: Thu, 9 Nov 2017 15:59:01 +0100
Message-ID: <ebc6ec8d-4ea5-9080-fb27-a18e46f3740f@daenzer.net>
References: <20171109144925.2913-1-christian.koenig@amd.com>
 <20171109144925.2913-4-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109144925.2913-4-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMTEvMTcgMDM6NDkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gU2ltaWxhciB0
byB0aGUgQ1BVIGFkZHJlc3Mgc3BhY2UgdGhlIFZBIG9uIFZlZ2ExMCBoYXMgYSBob2xlIGluIGl0
LgoKWy4uLl0KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4
IDQ3MTBlNTEwOTljMi4uODFjMzQxMzJmYmQ1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYwo+IEBAIC01NjEsNiArNTYxLDE3IEBAIGludCBhbWRncHVfZ2VtX3Zh
X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4gIAkJcmV0dXJuIC1F
SU5WQUw7Cj4gIAl9Cj4gIAo+ICsJaWYgKGFyZ3MtPnZhX2FkZHJlc3MgPj0gQU1ER1BVX1ZBX0hP
TEVfU1RBUlQgJiYKPiArCSAgICBhcmdzLT52YV9hZGRyZXNzIDwgQU1ER1BVX1ZBX0hPTEVfRU5E
KSB7Cj4gKwkJZGV2X2VycigmZGV2LT5wZGV2LT5kZXYsCj4gKwkJCSJ2YV9hZGRyZXNzIDB4JUxY
IGlzIGluIFZBIGhvbGUgMHglTFgtMHglTFhcbiIsCj4gKwkJCWFyZ3MtPnZhX2FkZHJlc3MsIEFN
REdQVV9WQV9IT0xFX1NUQVJULAo+ICsJCQlBTURHUFVfVkFfSE9MRV9FTkQpOwo+ICsJCXJldHVy
biAtRUlOVkFMOwo+ICsJfQoKVGhpcyBzaG91bGQgcHJvYmFibHkgYmUgZGV2X2RiZyBpbnN0ZWFk
IG9mIGRldl9lcnIsIHRvIHByZXZlbnQgYnVnZ3kgKG9yCm1hbGljaW91cykgdXNlcnNwYWNlIGZy
b20gc3BhbW1pbmcgZG1lc2cuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUg
ZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
