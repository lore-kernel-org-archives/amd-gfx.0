From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove duplicate evict_vram in suspend path
Date: Sun, 9 Oct 2016 17:12:54 +0200
Message-ID: <5f17b1d4-b088-4ed7-06b7-86b4c85bd4f0@vodafone.de>
References: <1475696538-24754-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475696538-24754-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMDUuMTAuMjAxNiB1bSAyMTo0MiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBMb29rcyBsaWtl
IGZhbGxvdXQgZnJvbSBhIHJlYmFzZSBvciBtZXJnZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCk5BSywgdGhpcyBpcyBkb25lIG9u
IHB1cnBvc2UgYW5kIGlzIGZvciBldmljdGluZyB0aGUgR0FSVCB0YWJsZSB1c2luZyAKbWVtY3B5
LgoKVG9tIHdhbnRlZCB0byByZW1vdmUgdGhhdCBhcyB3ZWxsIGFuZCBpdCBtYWtlcyByZXN1bWUg
dGhlbiBmYWlsIGhvcnJpYmxlIApvbiBkR1BVcy4KCldlIHNob3VsZCBwcm9iYWJseSBhZGQgYSBj
b21tZW50IHdoeSB0aGlzIGlzIG5lY2Vzc2FyeS4KCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzIC0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCj4gaW5kZXggNDUyNTliNS4uYzJmNzBiZSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMTk1Niw5ICsxOTU2LDYg
QEAgaW50IGFtZGdwdV9kZXZpY2Vfc3VzcGVuZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29s
IHN1c3BlbmQsIGJvb2wgZmJjb24pCj4gICAKPiAgIAlyID0gYW1kZ3B1X3N1c3BlbmQoYWRldik7
Cj4gICAKPiAtCS8qIGV2aWN0IHJlbWFpbmluZyB2cmFtIG1lbW9yeSAqLwo+IC0JYW1kZ3B1X2Jv
X2V2aWN0X3ZyYW0oYWRldik7Cj4gLQo+ICAgCXBjaV9zYXZlX3N0YXRlKGRldi0+cGRldik7Cj4g
ICAJaWYgKHN1c3BlbmQpIHsKPiAgIAkJLyogU2h1dCBkb3duIHRoZSBkZXZpY2UgKi8KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
