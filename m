From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/syncobj: add sync_file interaction. (v1.2)
Date: Thu, 1 Jun 2017 11:58:45 +0100
Message-ID: <20170601105845.GI11742@nuc-i3427.alporthouse.com>
References: <20170601010643.28616-1-airlied@gmail.com>
 <20170601010643.28616-4-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170601010643.28616-4-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVGh1LCBKdW4gMDEsIDIwMTcgYXQgMTE6MDY6NDFBTSArMTAwMCwgRGF2ZSBBaXJsaWUgd3Jv
dGU6Cj4gRnJvbTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPiAKPiBUaGlzIGlu
dGVyZmFjZSBhbGxvd3MgaW1wb3J0aW5nIHRoZSBmZW5jZSBmcm9tIGEgc3luY19maWxlIGludG8K
PiBhbiBleGlzdGluZyBkcm0gc3luYyBvYmplY3QsIG9yIGV4cG9ydGluZyB0aGUgZmVuY2UgYXR0
YWNoZWQgdG8KPiBhbiBleGlzdGluZyBkcm0gc3luYyBvYmplY3QgaW50byBhIG5ldyBzeW5jIGZp
bGUgb2JqZWN0Lgo+IAo+IFRoaXMgc2hvdWxkIG9ubHkgYmUgdXNlZCB0byBpbnRlcmFjdCB3aXRo
IHN5bmMgZmlsZXMgd2hlcmUgbmVjZXNzYXJ5Lgo+IAo+IHYxLjE6IGZlbmNlIHB1dCBmaXhlcyAo
Q2hyaXMpLCBkcm9wIGZlbmNlIGZyb20gaW9jdGwgbmFtZXMgKENocmlzKQo+IGZpeHVwIGZvciBu
ZXcgZmVuY2UgcmVwbGFjZSBBUEkuCj4gCj4gUmV2aWV3ZWQtYnk6IFNlYW4gUGF1bCA8c2VhbnBh
dWxAY2hyb21pdW0ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJl
ZGhhdC5jb20+ClJldmlld2VkLWJ5OiBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5j
by51az4KLUNocmlzCgotLSAKQ2hyaXMgV2lsc29uLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9s
b2d5IENlbnRyZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
