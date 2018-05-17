From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 29/57] drm/amdgpu: Add vega20 to dc support check
Date: Thu, 17 May 2018 11:06:14 -0400
Message-ID: <CADnq5_Mz1YeVKy1aQqegzT8AA+hu+e-v0WEd9iozZfMV0rQaLA@mail.gmail.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
 <20180515145933.12063-30-alexander.deucher@amd.com>
 <CANOLnONH=Miqj-vgd3XTMjfsDGP2SAFgqyyA5Co1fUGwYTfzwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANOLnONH=Miqj-vgd3XTMjfsDGP2SAFgqyyA5Co1fUGwYTfzwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBNYXkgMTYsIDIwMTggYXQgNjo1NSBBTSwgR3JhenZ5ZGFzIElnbm90YXMgPG5vdGFz
YXNAZ21haWwuY29tPiB3cm90ZToKPiBPbiBUdWUsIE1heSAxNSwgMjAxOCBhdCA1OjU5IFBNLCBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEZyb206IEZlaWZl
aSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlaWZlaSBYdSA8
RmVpZmVpLlh1QGFtZC5jb20+Cj4+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4+IFJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgfCAxICsKPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IGluZGV4
IDljOWJlODc4YWViNS4uNWFhM2IxZDY5Y2ZlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IEBAIC0yMTcwLDYgKzIxNzAsNyBAQCBib29sIGFt
ZGdwdV9kZXZpY2VfYXNpY19oYXNfZGNfc3VwcG9ydChlbnVtIGFtZF9hc2ljX3R5cGUgYXNpY190
eXBlKQo+PiAgICAgICAgIGNhc2UgQ0hJUF9GSUpJOgo+PiAgICAgICAgIGNhc2UgQ0hJUF9WRUdB
MTA6Cj4+ICAgICAgICAgY2FzZSBDSElQX1ZFR0ExMjoKPj4gKyAgICBjYXNlIENISVBfVkVHQTIw
Ogo+Cj4gSW5jb25zaXN0ZW50IHN0eWxlICh0YWIgdnMgc3BhY2VzKS4KCkZpeGVkLiAgdGhhbmtz
LgoKQWxleApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
