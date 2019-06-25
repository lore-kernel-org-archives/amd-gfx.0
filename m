From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/24] drm/amd/display: add audio related regs
Date: Tue, 25 Jun 2019 14:15:56 +1000
Message-ID: <CAPM=9tw86HPHdDN9dAGLtL5RbRyxH69DmWq_0sH5C30xXnx7_w@mail.gmail.com>
References: <20190606205501.16505-1-Bhawanpreet.Lakha@amd.com>
 <20190606205501.16505-9-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190606205501.16505-9-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCA3IEp1biAyMDE5IGF0IDA2OjU1LCBCaGF3YW5wcmVldCBMYWtoYQo8Qmhhd2FucHJl
ZXQuTGFraGFAYW1kLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBDaGFybGVuZSBMaXUgPGNoYXJsZW5l
LmxpdUBhbWQuY29tPgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5s
aXVAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQ2hyaXMgUGFyayA8Q2hyaXMuUGFya0BhbWQuY29t
Pgo+IEFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXVkaW8u
YyB8IDQgKy0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdWRp
by5oIHwgNyArKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UvZGNlX2F1ZGlvLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9hdWRpby5jCj4gaW5kZXggN2Y2ZDcyNDY4NmYxLi5kNDNkNWQ5MjRjMTkgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXVkaW8uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmMKPiBAQCAtMjIs
NyArMjIsNyBAQAo+ICAgKiBBdXRob3JzOiBBTUQKPiAgICoKPiAgICovCj4gLQo+ICsjaW5jbHVk
ZSAiLi4vZGMuaCIKCklzIHRoaXMgaW5jbHVkZSBuZWVkZWQ/IGp1c3Qgc2VlbXMgd2llcmQgdG8g
aGF2ZSBhZGRlZCBpdCB3aXRoIG5vIG1lbnRpb24uCgpEYXZlLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
