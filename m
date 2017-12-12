From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/7] drm/ttm:fix incorrect calculate on shrink_pages
Date: Tue, 12 Dec 2017 11:21:58 +0100
Message-ID: <985d5e15-a056-9905-bfd3-36b5e465909d@gmail.com>
References: <1513072005-3477-1-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513072005-3477-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGF0Y2ggIzEtIzMgYW5kICM1IGFyZSBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpQYXRjaCAjNiBhbmQgIzcgYXJlIEFja2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKUmVnYXJkcywKQ2hy
aXN0aWFuLgoKQW0gMTIuMTIuMjAxNyB1bSAxMDo0NiBzY2hyaWViIE1vbmsgTGl1Ogo+IHNocmlu
a19wYWdlcyBpcyBpbiB1bml0IG9mIE9yZGVyIGFmdGVyIHR0bV9wYWdlX3Bvb2xfZnJlZSwKPiBi
dXQgaXQgaXMgdXNlZCBieSBucl9mcmVlIGluIG5leHQgcm91bmQgc28gbmVlZCBjaGFuZ2UKPiBp
dCBpbnRvIG5hdGl2ZSBwYWdlIHVuaXQKPgo+IENoYW5nZS1JZDogSTMzYjc3YWMxNjE2ZTI0YjFi
ODgxZWVlNTRjM2JkNzM0MmNmYTlhYjgKPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5M
aXVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
YyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fcGFnZV9hbGxvYy5jCj4gaW5kZXggNDQzNDNhMi4uNzE5NDVjYyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPiBAQCAtNDU1LDYgKzQ1NSw3IEBAIHR0bV9w
b29sX3Nocmlua19zY2FuKHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hyaW5rX2Nv
bnRyb2wgKnNjKQo+ICAgCQlmcmVlZCArPSAobnJfZnJlZV9wb29sIC0gc2hyaW5rX3BhZ2VzKSA8
PCBwb29sLT5vcmRlcjsKPiAgIAkJaWYgKGZyZWVkID49IHNjLT5ucl90b19zY2FuKQo+ICAgCQkJ
YnJlYWs7Cj4gKwkJc2hyaW5rX3BhZ2VzIDw8PSBwb29sLT5vcmRlcjsKPiAgIAl9Cj4gICAJbXV0
ZXhfdW5sb2NrKCZsb2NrKTsKPiAgIAlyZXR1cm4gZnJlZWQ7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
