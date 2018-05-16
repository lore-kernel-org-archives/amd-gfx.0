From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 30/57] drm/amd: Add dce-12.1 gpio aux registers
Date: Wed, 16 May 2018 13:51:55 +0300
Message-ID: <CANOLnOPyBNwdmZEeK+K_2b70PULzZoGDO_B4-a3bCY1569wWCg@mail.gmail.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
 <20180515145933.12063-31-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180515145933.12063-31-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVHVlLCBNYXkgMTUsIDIwMTggYXQgNTo1OSBQTSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IHdyb3RlOgo+IEZyb206IFJvbWFuIExpIDxSb21hbi5MaUBhbWQuY29tPgo+
Cj4gVXBkYXRpbmcgZGNlMTIgcmVnaXN0ZXIgaGVhZGVycyBieSBhZGRpbmcgZGMgcmVnaXN0ZXJz
Cj4gcmVxdWlyZWQgZm9yIHBvdGVudGlhbCBEUCBMVFRQUiBzdXBwb3J0Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogUm9tYW4gTGkgPFJvbWFuLkxpQGFtZC5jb20+Cj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIC4uLi9kcm0vYW1kL2luY2x1
ZGUvYXNpY19yZWcvZGNlL2RjZV8xMl8wX29mZnNldC5oIHwgIDEyICsrCj4gIC4uLi9hbWQvaW5j
bHVkZS9hc2ljX3JlZy9kY2UvZGNlXzEyXzBfc2hfbWFzay5oICAgIHwgMTUyICsrKysrKysrKysr
KysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDE2NCBpbnNlcnRpb25zKCspCj4gIG1vZGUg
Y2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNf
cmVnL2RjZS9kY2VfMTJfMF9vZmZzZXQuaAo+ICBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAwNzU1
IGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzEyXzBfc2hfbWFz
ay5oCgpVbndhbnRlZCBtb2RlIGNoYW5nZS4KCkdyYcW+dnlkYXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
