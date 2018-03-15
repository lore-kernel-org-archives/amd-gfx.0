From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] drm/amdgpu: add new member in amdgpu_mc for zfb
 support
Date: Thu, 15 Mar 2018 09:10:18 +0100
Message-ID: <f0055825-1a33-6382-4739-35a6fbd9afb5@gmail.com>
References: <1521094324-23252-1-git-send-email-Feifei.Xu@amd.com>
 <1521094324-23252-2-git-send-email-Feifei.Xu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521094324-23252-2-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
To: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QW0gMTUuMDMuMjAxOCB1bSAwNzoxMSBzY2hyaWViIEZlaWZlaSBYdToKPiBDaGFuZ2UtSWQ6IEk4
MjUzYzhmZjgwZTBjYmQxZjEyZTVlZTgwMTYwMGU3NjE5ZTY3MThmCj4gU2lnbmVkLW9mZi1ieTog
SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEZl
aWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+Cj4gQWNrZWQtYnk6IEpvaG4gQnJpZGdtYW4gPGpv
aG4uYnJpZGdtYW5AYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oIHwgMyArKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiBpbmRleCA4OTNjMjQ5
Li44ZjM1ZjdlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+
IEBAIC0xMDcsNiArMTA3LDkgQEAgc3RydWN0IGFtZGdwdV9nbWMgewo+ICAgCWJvb2wJCQl0cmFu
c2xhdGVfZnVydGhlcjsKPiAgIAo+ICAgCWNvbnN0IHN0cnVjdCBhbWRncHVfZ21jX2Z1bmNzCSpn
bWNfZnVuY3M7Cj4gKyAgICAvKiB6ZXJvIGZyYW1lIGJ1ZmZlciAqLwo+ICsgICAgdTY0IHpmYl9w
aHlzX2FkZHI7Cj4gKyAgICB1NjQgemZiX3NpemU7CgpQbGVhc2UgdXNlIHRhYnMgaW5zdGVhZCBv
ZiBzcGFjZXMgZm9yIGluZGVudGF0aW9uLgoKQ2hyaXN0aWFuLgoKPiAgIH07Cj4gICAKPiAgICNl
bmRpZgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
