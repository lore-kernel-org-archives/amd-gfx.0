From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add a workaround for GDS ordered append hangs
 with compute queues
Date: Mon, 4 Feb 2019 12:08:29 -0500
Message-ID: <CADnq5_PS+xfYNrAtyst8nKxvY2nVQW5z7BxUNPYdO-9271LoBA@mail.gmail.com>
References: <20190122200546.1575-1-maraeo@gmail.com>
 <CAAxE2A7xs40YZvCQpMmv9X0Z98Sc7+ZEbFJDJLfmkMuWHzuprw@mail.gmail.com>
 <1b1294f7-1604-fe49-de7f-0e234656eecd@gmail.com>
 <CAAxE2A4vsMRL0FZYBknCTMEbDBNYJZOdOnR32EZqM5iaKX6j3g@mail.gmail.com>
 <44f785c1-16bf-289c-4502-0a7a3637aa30@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <44f785c1-16bf-289c-4502-0a7a3637aa30-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gTW9uLCBGZWIgNCwgMjAxOSBhdCAxMTowOSBBTSBLb2VuaWcsIENocmlzdGlhbgo8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDA0LjAyLjE5IHVtIDE2OjU1IHNjaHJp
ZWIgTWFyZWsgT2zFocOhazoKPgo+IE9uIE1vbiwgRmViIDQsIDIwMTkgYXQgNzo0MiBBTSBDaHJp
c3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
Cj4+IEF0IGxlYXN0IGZyb20gY29kaW5nIHN0eWxlLCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGV0
Yy4uIHRoaXMgbG9va3Mgc2FuZSB0byBtZSwgc28gZmVlbCBmcmVlIHRvIGFkZCBhbiBBY2tlZC1i
eS4KPj4KPj4gQnV0IEkgYWJzb2x1dGVseSBjYW4ndCBqdWRnZSBpZiB0aGF0IGlzIGNvcnJlY3Qg
ZnJvbSB0aGUgaGFyZHdhcmUgcG9pbnQgb2YgdmlldyBvciBub3QuCj4KPgo+IE91ciBHRFMgZG9j
cyBzYXkgdGhhdCB3cml0aW5nIHRoZSByZWdpc3RlciByZXNldHMgdGhlIHdhdmUgY291bnRlci4K
Pgo+Pgo+Pgo+PiBBbmQgSSB0aGluayB0aGF0IHNvbWVib2R5IGVsc2UgbG9va2luZyBhdCB0aGlz
IGlzIG1hbmRhdG9yeSBmb3IgaXQgdG8gYmUgY29tbWl0dGVkLgo+Cj4KPiBUaGVyZSB3b24ndCBi
ZSBhbnlib2R5IGVsc2UuIE5vYm9keSBoZXJlIHJlYWxseSB1bmRlcnN0YW5kcyBHRFMsIG5vYm9k
eSBoZXJlIHJlYWxseSBjYXJlcyBhYm91dCBHRFMsIGFuZCBodyBndXlzIHdlcmVuJ3QgaGVscGZ1
bCB3aXRoIHRoZSBoYW5ncy4gSWYgSSBkaWRuJ3QgZGlzY292ZXIgdGhpcyBieSBsdWNrLCBHRFMg
T0Egd291bGQgYmUgdW51c2FibGUgb24gTGludXguCj4KPgo+IEdyZWF0LCBhcyBsb25nIGFzIEFs
ZXggaXMgb2sgd2l0aCB0aGlzIGZlZWwgZnJlZSB0byBnbyBhaGVhZC4KCkFja2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4K
PiBNYXJlawo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
