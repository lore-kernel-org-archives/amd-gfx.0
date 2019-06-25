From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 08/24] drm/amd/display: add audio related regs
Date: Tue, 25 Jun 2019 14:56:06 +0000
Message-ID: <81482b83-5fbf-9a45-a373-b04c44bc81a9@amd.com>
References: <20190606205501.16505-1-Bhawanpreet.Lakha@amd.com>
 <20190606205501.16505-9-Bhawanpreet.Lakha@amd.com>
 <CAPM=9tw86HPHdDN9dAGLtL5RbRyxH69DmWq_0sH5C30xXnx7_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tw86HPHdDN9dAGLtL5RbRyxH69DmWq_0sH5C30xXnx7_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <F172D0EAA835DE46888569C2D54C0441-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
Cc: "Liu, Charlene" <Charlene.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhhbmtzIGZvciBjYXRjaGluZyB0aGF0LCBpdCB3YXMgbGVmdCBpbiBieSBtaXN0YWtlIHdoZW4g
dHJ5aW5nIHRvIGZpeCANCnNvbWUgY29tcGlsZSBpc3N1ZXMuIEkgd2lsbCBwdXNoIGEgcGF0Y2gg
dG8gcmVtb3ZlIGl0DQoNCg0KQmhhd2FuDQoNCk9uIDIwMTktMDYtMjUgMTI6MTUgYS5tLiwgRGF2
ZSBBaXJsaWUgd3JvdGU6DQo+IE9uIEZyaSwgNyBKdW4gMjAxOSBhdCAwNjo1NSwgQmhhd2FucHJl
ZXQgTGFraGENCj4gPEJoYXdhbnByZWV0Lkxha2hhQGFtZC5jb20+IHdyb3RlOg0KPj4gRnJvbTog
Q2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDaGFybGVuZSBMaXUgPGNoYXJsZW5lLmxpdUBhbWQuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENo
cmlzIFBhcmsgPENocmlzLlBhcmtAYW1kLmNvbT4NCj4+IEFja2VkLWJ5OiBCaGF3YW5wcmVldCBM
YWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdWRpby5jIHwgNCArLS0tDQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmggfCA3ICsrKysrKysNCj4+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1
ZGlvLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdWRpby5jDQo+
PiBpbmRleCA3ZjZkNzI0Njg2ZjEuLmQ0M2Q1ZDkyNGMxOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmMNCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmMNCj4+IEBAIC0yMiw3ICsy
Miw3IEBADQo+PiAgICAqIEF1dGhvcnM6IEFNRA0KPj4gICAgKg0KPj4gICAgKi8NCj4+IC0NCj4+
ICsjaW5jbHVkZSAiLi4vZGMuaCINCj4gSXMgdGhpcyBpbmNsdWRlIG5lZWRlZD8ganVzdCBzZWVt
cyB3aWVyZCB0byBoYXZlIGFkZGVkIGl0IHdpdGggbm8gbWVudGlvbi4NCj4NCj4gRGF2ZS4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
