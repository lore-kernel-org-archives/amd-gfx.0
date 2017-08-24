From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/gfx9: adjust mqd allocation size
Date: Thu, 24 Aug 2017 17:37:55 -0400
Message-ID: <CADnq5_Mz3kN5R5JaZi0vu-hS-On=isK2P+XjcOmdbn9DhvirpA@mail.gmail.com>
References: <1503608405-16772-1-git-send-email-alexander.deucher@amd.com>
 <1503608405-16772-4-git-send-email-alexander.deucher@amd.com>
 <284b0a36-7e2c-a757-8233-0aee7b816664@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <284b0a36-7e2c-a757-8233-0aee7b816664-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBBdWcgMjQsIDIwMTcgYXQgNToxNCBQTSwgRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+IE9uIDIwMTctMDgtMjQgMDU6MDAgUE0sIEFsZXggRGV1
Y2hlciB3cm90ZToKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL3Y5X3N0cnVj
dHMuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvdjlfc3RydWN0cy5oCj4+
IEBAIC02NzIsNiArNjcyLDE0IEBAIHN0cnVjdCB2OV9tcWQgewo+PiAgICAgICB1aW50MzJfdCBy
ZXNlcnZlZF81MTE7Cj4+ICB9Owo+Pgo+PiArc3RydWN0IHY5X21xZF9hbGxvY2F0aW9uIHsKPj4g
KyAgICAgc3RydWN0IHY5X21xZCBtcWQ7Cj4+ICsgICAgIHVpbnQzMl90IHdwdHJfcG9sbF9tZW07
Cj4+ICsgICAgIHVpbnQzMl90IHJwdHJfcmVwb3J0X21lbTsKPgo+IExvb2tzIGxpa2Ugd3B0cl9w
b2xsX21lbSBhbmQgcnB0cl9yZXBvcnRfbWVtIGFyZSB1bnVzZWQgZm9yIG5vdy4KPgo+IElmIHRo
YXQncyBpbnRlbnRpb25hbCwgdGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcKPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClllcywgaW50ZW50aW9uYWwuICBJdCB3YXMg
Y29waWVkIGZyb20gZ2Z4OC4gIFdlIGRvbid0IGN1cnJlbnRseSBlbmFibGUKdGhvc2UgKG9uIDgg
b3IgOSkgc28gdGhleSBhcmUgdW51c2VkLgoKQWxleAoKPgo+IFJlZ2FyZHMsCj4gICBGZWxpeAo+
Cj4+ICsgICAgIHVpbnQzMl90IGR5bmFtaWNfY3VfbWFzazsKPj4gKyAgICAgdWludDMyX3QgZHlu
YW1pY19yYl9tYXNrOwo+PiArfTsKPj4gKwo+PiAgLyogZnJvbSB2ZWdhMTAgYWxsIENTQSBmb3Jt
YXQgaXMgc2hpZnRlZCB0byBjaGFpbiBpYiBjb21wYXRpYmxlIG1vZGUgKi8KPj4gIHN0cnVjdCB2
OV9jZV9pYl9zdGF0ZSB7Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
