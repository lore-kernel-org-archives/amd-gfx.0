From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu: Enable KFD initialization on dGPUs
Date: Wed, 31 Jan 2018 17:25:31 +0200
Message-ID: <CAFCwf11WWuHydSRBu3Pk8-jFLgoxJ7k0GDfuO-HWRjpvSRm5xQ@mail.gmail.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-10-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515104268-25087-10-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBKYW4gNSwgMjAxOCBhdCAxMjoxNyBBTSwgRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkLmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBp
bmRleCAzMzVlNDU0Li43ZWJlNDMwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYwo+IEBAIC03OCwxMCArNzgsMTUgQEAgdm9pZCBhbWRncHVfYW1ka2Zk
X2RldmljZV9wcm9iZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICAgICAgIHN3aXRj
aCAoYWRldi0+YXNpY190eXBlKSB7Cj4gICNpZmRlZiBDT05GSUdfRFJNX0FNREdQVV9DSUsKPiAg
ICAgICAgIGNhc2UgQ0hJUF9LQVZFUkk6Cj4gKyAgICAgICBjYXNlIENISVBfSEFXQUlJOgo+ICAg
ICAgICAgICAgICAgICBrZmQya2dkID0gYW1kZ3B1X2FtZGtmZF9nZnhfN19nZXRfZnVuY3Rpb25z
KCk7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAjZW5kaWYKPiAgICAgICAgIGNhc2UgQ0hJ
UF9DQVJSSVpPOgo+ICsgICAgICAgY2FzZSBDSElQX1RPTkdBOgo+ICsgICAgICAgY2FzZSBDSElQ
X0ZJSkk6Cj4gKyAgICAgICBjYXNlIENISVBfUE9MQVJJUzEwOgo+ICsgICAgICAgY2FzZSBDSElQ
X1BPTEFSSVMxMToKUG9sYXJpcyBpc24ndCBnZnggOSA/Cm9yIGlzIGl0IGNhbGxlZCBkaWZmZXJl
bnRseSA/Cgo+ICAgICAgICAgICAgICAgICBrZmQya2dkID0gYW1kZ3B1X2FtZGtmZF9nZnhfOF8w
X2dldF9mdW5jdGlvbnMoKTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZh
dWx0Ogo+IC0tCj4gMi43LjQKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
