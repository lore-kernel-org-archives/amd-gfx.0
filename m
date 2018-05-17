From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 30/57] drm/amd: Add dce-12.1 gpio aux registers
Date: Thu, 17 May 2018 11:05:55 -0400
Message-ID: <CADnq5_OtaoAqkKJ-OEbW5v0SkJOPKmZxjQ35yit527qBoq6KpQ@mail.gmail.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
 <20180515145933.12063-31-alexander.deucher@amd.com>
 <CANOLnOPyBNwdmZEeK+K_2b70PULzZoGDO_B4-a3bCY1569wWCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANOLnOPyBNwdmZEeK+K_2b70PULzZoGDO_B4-a3bCY1569wWCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBNYXkgMTYsIDIwMTggYXQgNjo1MSBBTSwgR3JhenZ5ZGFzIElnbm90YXMgPG5vdGFz
YXNAZ21haWwuY29tPiB3cm90ZToKPiBPbiBUdWUsIE1heSAxNSwgMjAxOCBhdCA1OjU5IFBNLCBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IEZyb206IFJvbWFu
IExpIDxSb21hbi5MaUBhbWQuY29tPgo+Pgo+PiBVcGRhdGluZyBkY2UxMiByZWdpc3RlciBoZWFk
ZXJzIGJ5IGFkZGluZyBkYyByZWdpc3RlcnMKPj4gcmVxdWlyZWQgZm9yIHBvdGVudGlhbCBEUCBM
VFRQUiBzdXBwb3J0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBMaSA8Um9tYW4uTGlAYW1k
LmNvbT4KPj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+PiAtLS0KPj4gIC4uLi9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV8xMl8w
X29mZnNldC5oIHwgIDEyICsrCj4+ICAuLi4vYW1kL2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV8x
Ml8wX3NoX21hc2suaCAgICB8IDE1MiArKysrKysrKysrKysrKysrKysrKysKPj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTY0IGluc2VydGlvbnMoKykKPj4gIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3
NTUgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2VfMTJfMF9vZmZz
ZXQuaAo+PiAgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvYXNpY19yZWcvZGNlL2RjZV8xMl8wX3NoX21hc2suaAo+Cj4gVW53YW50ZWQgbW9k
ZSBjaGFuZ2UuCgpGaXhlZC4gIHRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
