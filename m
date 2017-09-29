From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu/dm: constify yuv_formats.
Date: Thu, 28 Sep 2017 20:45:59 -0400
Message-ID: <8b3cb52f-f17e-bcf4-cd68-3fe5b12a4fca@amd.com>
References: <20170929002741.30172-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170929002741.30172-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wOS0yOCAwODoyNyBQTSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4gRnJvbTogRGF2ZSBB
aXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIEFpcmxp
ZSA8YWlybGllZEByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGRiYTU0YzAuLjg5NDQy
Y2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPiBAQCAtMzA3Myw3ICszMDczLDcgQEAgc3RhdGljIHVpbnQzMl90IHJnYl9m
b3JtYXRzW10gPSB7Cj4gIAlEUk1fRk9STUFUX0FCR1IyMTAxMDEwLAo+ICB9Owo+ICAKPiAtc3Rh
dGljIHVpbnQzMl90IHl1dl9mb3JtYXRzW10gPSB7Cj4gK3N0YXRpYyBjb25zdCB1aW50MzJfdCB5
dXZfZm9ybWF0c1tdID0gewo+ICAJRFJNX0ZPUk1BVF9OVjEyLAo+ICAJRFJNX0ZPUk1BVF9OVjIx
LAo+ICB9Owo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
