From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdgpu:PTE flag should be 64 bit width
Date: Mon, 1 May 2017 16:55:42 +0200
Message-ID: <689c0896-ddf2-777b-f68a-48240242a693@vodafone.de>
References: <1493620480-22002-1-git-send-email-Monk.Liu@amd.com>
 <1493620480-22002-6-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493620480-22002-6-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDEuMDUuMjAxNyB1bSAwODozNCBzY2hyaWViIE1vbmsgTGl1Ogo+IG90aGVyd2lzZSB3ZSds
bCBsb3N0IHRoZSBoaWdoIDMyIGJpdCBmb3IgcHRlLCB3aGljaCBsZWFkCj4gdG8gaW5jb3JyZWN0
IE1UWVBFIGZvciB2ZWdhMTAuCj4KPiBDaGFuZ2UtSWQ6IEkxYjBjN2I4ZGYxNGUzNDBhMzZkNGQy
YTcyYzZjMDNmNDY5ZmRjMjljCj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFt
ZC5jb20+CgpOaWNlIGNhdGNoLCBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwo+IGluZGV4IDExYzZjNDQuLmMzZmIyZjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTc2NSw3ICs3NjUsNyBAQCBpbnQgYW1kZ3B1X3R0
bV9yZWNvdmVyX2dhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAJc3Ry
dWN0IGFtZGdwdV90dG1fdHQgKmd0dCwgKnRtcDsKPiAgIAlzdHJ1Y3QgdHRtX21lbV9yZWcgYm9f
bWVtOwo+IC0JdWludDMyX3QgZmxhZ3M7Cj4gKwl1aW50NjRfdCBmbGFnczsKPiAgIAlpbnQgcjsK
PiAgIAo+ICAgCWJvX21lbS5tZW1fdHlwZSA9IFRUTV9QTF9UVDsKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
