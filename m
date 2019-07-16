From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix offset for vmid selection in debugfs
 interface
Date: Tue, 16 Jul 2019 13:30:56 +0200
Message-ID: <e6bc6d43-d4ac-467f-22b3-2be79619b93e@gmail.com>
References: <20190716112434.29017-1-tom.stdenis@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190716112434.29017-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTYuMDcuMTkgdW0gMTM6MjQgc2NocmllYiBTdERlbmlzLCBUb206Cj4gVGhlIHJlZ2lzdGVy
IGRlYnVnZnMgaW50ZXJmYWNlIHdhcyB1c2luZyB0aGUgd3JvbmcgYml0bWFzayBmb3Igdm1pZAo+
IHNlbGVjdGlvbiBmb3IgR0ZYX0NOVEwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMg
PHRvbS5zdGRlbmlzQGFtZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZWJ1Z2ZzLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYwo+IGluZGV4IDg3YjMyODczMDQ2Zi4uNTk4NDllZDk3OTdkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4gQEAgLTEzMiw3ICsx
MzIsNyBAQCBzdGF0aWMgaW50ICBhbWRncHVfZGVidWdmc19wcm9jZXNzX3JlZ19vcChib29sIHJl
YWQsIHN0cnVjdCBmaWxlICpmLAo+ICAgCQltZSA9ICgqcG9zICYgR0VOTUFTS19VTEwoMzMsIDI0
KSkgPj4gMjQ7Cj4gICAJCXBpcGUgPSAoKnBvcyAmIEdFTk1BU0tfVUxMKDQzLCAzNCkpID4+IDM0
Owo+ICAgCQlxdWV1ZSA9ICgqcG9zICYgR0VOTUFTS19VTEwoNTMsIDQ0KSkgPj4gNDQ7Cj4gLQkJ
dm1pZCA9ICgqcG9zICYgR0VOTUFTS19VTEwoNDgsIDQ1KSkgPj4gNTQ7Cj4gKwkJdm1pZCA9ICgq
cG9zICYgR0VOTUFTS19VTEwoNTgsIDU0KSkgPj4gNTQ7Cj4gICAKPiAgIAkJdXNlX3JpbmcgPSAx
Owo+ICAgCX0gZWxzZSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
