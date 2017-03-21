From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] amdgpu: add REPLACE and CLEAR checking for VA op
Date: Tue, 21 Mar 2017 14:31:27 +0100
Message-ID: <f697cff5-4d48-0c5f-e4b5-3c9fa203fce3@gmail.com>
References: <1489730362-31095-1-git-send-email-Jerry.Zhang@amd.com>
 <1489730362-31095-3-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489730362-31095-3-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

T24gMTcuMDMuMjAxNyAwNjo1OSwgSnVud2VpIFpoYW5nIHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6
IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPiAtLS0KPiAgYW1kZ3B1L2FtZGdw
dV9iby5jIHwgNSArKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2Ft
ZGdwdV9iby5jCj4gaW5kZXggNzFjZDY2Ni4uOGZlM2NmZCAxMDA2NDQKPiAtLS0gYS9hbWRncHUv
YW1kZ3B1X2JvLmMKPiArKysgYi9hbWRncHUvYW1kZ3B1X2JvLmMKPiBAQCAtOTUyLDcgKzk1Miwx
MCBAQCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3JhdyhhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCj4g
IAlzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgdmE7Cj4gIAlpbnQgcjsKPgo+IC0JaWYgKG9wcyAh
PSBBTURHUFVfVkFfT1BfTUFQICYmIG9wcyAhPSBBTURHUFVfVkFfT1BfVU5NQVApCj4gKwlpZiAo
b3BzICE9IEFNREdQVV9WQV9PUF9NQVAgJiYgb3BzICE9IEFNREdQVV9WQV9PUF9VTk1BUCAmJgo+
ICsJCQlvcHMgIT0gQU1ER1BVX1ZBX09QX1JFUExBQ0UgJiYKPiArCQkJb3BzICE9IEFNREdQVV9W
QV9PUF9DTEVBUikKClRoZSBpbmRlbnRhdGlvbiBsb29rcyB3cm9uZy4gSSBiZWxpZXZlIHRoZSBz
dHlsZSBpcyB0byB1c2Ugc3BhY2VzIHNvIAp0aGF0IHRoZSBmaXJzdCAnb3BzJyBpbiBlYWNoIHJv
dyBsaW5lcyB1cC4KCkNoZWVycywKTmljb2xhaQoKPiArCj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4K
PiAgCW1lbXNldCgmdmEsIDAsIHNpemVvZih2YSkpOwo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
