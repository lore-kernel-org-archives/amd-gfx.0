From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: add independent DMA-buf export v7
Date: Mon, 28 Oct 2019 16:00:47 +0100
Message-ID: <6acd5e75-c565-ac87-6a74-7e6d42e98663@gmail.com>
References: <20191025121603.51204-1-christian.koenig@amd.com>
 <CADnq5_Mk2_1hOgrDTGLZOH7gh2Rb3LDtSL8buiVtwbum0=p+LQ@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mk2_1hOgrDTGLZOH7gh2Rb3LDtSL8buiVtwbum0=p+LQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjYuMTAuMTkgdW0gMDA6MzIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gRnJpLCBPY3Qg
MjUsIDIwMTkgYXQgODoxNiBBTSBDaHJpc3RpYW4gS8O2bmlnCj4gPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4gW1NOSVBdCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5kZXggNmYwYjc4OWEwYjQ5Li5iMzE5MjU0NTM3
YjggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
Pj4gQEAgLTMxLDYgKzMxLDcgQEAKPj4gICAgKi8KPj4gICAjaW5jbHVkZSA8bGludXgvbGlzdC5o
Pgo+PiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWJ1
Zi5oPgo+IElzIHRoaXMgY2hhbmdlIGludGVuZGVkPwoKTm9wZSwgdGhhdCBhY3R1YWxseSBiZWxv
bmdzIGludG8gYSBmb2xsb3cgdXAgcGF0Y2guCgpHaXZlIG1lIGEgc2Vjb25kIHRvIGZpeCB0aGF0
IHVwLCBhbnkgb3RoZXIgY29tbWVudCBvbiB0aGlzIHNlcmllcyA/CgpUaGFua3MsCkNocmlzdGlh
bi4KCj4KPiBBbGV4Cj4KPj4gICAjaW5jbHVkZSA8ZHJtL2FtZGdwdV9kcm0uaD4KPj4gICAjaW5j
bHVkZSA8ZHJtL2RybV9jYWNoZS5oPgo+PiAtLQo+PiAyLjE3LjEKPj4KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
