From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: change the max clock level to 16
Date: Mon, 21 Jan 2019 10:29:23 -0500
Message-ID: <CADnq5_Pj7HSZrUoUK4V-ObAAxoGBuL3yPFLdhejhotynsN6SSg@mail.gmail.com>
References: <20190121100216.29122-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190121100216.29122-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Cc: "Yeh, Eagle" <Eagle.Yeh-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgNTowMiBBTSBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPiB3cm90ZToKPgo+IEFzIHRoZSBnZnhjbGsgZm9yIFNNVTExIGNhbiBoYXZlIGF0IG1vc3Qg
MTYgZGlzY3JldGUgbGV2ZWxzLgo+Cj4gQ2hhbmdlLUlkOiBJMGM2YThkYjhmNDAyMDZhMjQwMjg2
NDcxYzZmN2IxZmZmZWYxNWVhMgo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFu
QGFtZC5jb20+CgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3NlcnZpY2Vz
X3R5cGVzLmggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
bV9zZXJ2aWNlc190eXBlcy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3Nl
cnZpY2VzX3R5cGVzLmgKPiBpbmRleCA5YWZkMzZhMDMxYTkuLjc3MjAwNzExYWJiZSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fc2VydmljZXNfdHlwZXMu
aAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlc190eXBl
cy5oCj4gQEAgLTkyLDcgKzkyLDcgQEAgZW51bSBkbV9wcF9jbG9ja190eXBlIHsKPiAgICAgICAg
IChjbGtfdHlwZSkgPT0gRE1fUFBfQ0xPQ0tfVFlQRV9GQ0xLID8gIkYiIDogXAo+ICAgICAgICAg
IkludmFsaWQiCj4KPiAtI2RlZmluZSBETV9QUF9NQVhfQ0xPQ0tfTEVWRUxTIDgKPiArI2RlZmlu
ZSBETV9QUF9NQVhfQ0xPQ0tfTEVWRUxTIDE2Cj4KPiAgc3RydWN0IGRtX3BwX2Nsb2NrX2xldmVs
cyB7Cj4gICAgICAgICB1aW50MzJfdCBudW1fbGV2ZWxzOwo+IC0tCj4gMi4yMC4xCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
