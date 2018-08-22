From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: KFD co-maintainership and branch model
Date: Wed, 22 Aug 2018 18:25:44 -0400
Message-ID: <705cc9da-7ccb-bafd-0dd8-86630b37a8ca@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgYWxsLAoKT2RlZCBoYXMgb2ZmZXJlZCB0byBtYWtlIG1lIGNvLW1haW50YWluZXIgb2YgS0ZE
LCBhcyBoZSdzIHN1cGVyIGJ1c3kgYXQKd29yayBhbmQgbGVzcyByZXNwb25zaXZlIHRoYW4gaGUg
dXNlZCB0byBiZS4KCkF0IHRoZSBzYW1lIHRpbWUgd2UncmUgYWJvdXQgdG8gc2VuZCBvdXQgdGhl
IGZpcnN0IHBhdGNoZXMgdG8gbWVyZ2UgS0ZECmFuZCBBTURHUFUgaW50byBhIHNpbmdsZSBrZXJu
ZWwgbW9kdWxlLgoKV2l0aCB0aGF0IGluIG1pbmQgSSdkIGxpa2UgdG8gcHJvcG9zZSB0byB1cHN0
cmVhbSBLRkQgdGhyb3VnaCBBbGV4J3MKYnJhbmNoIGluIHRoZSBmdXR1cmUuIEl0IHdvdWxkIGF2
b2lkIGNvbmZsaWN0cyBpbiBzaGFyZWQgY29kZQooYW1kZ3B1X3ZtLmMgaXMgbW9zdCBhY3RpdmUg
YXQgdGhlIG1vbWVudCkgd2hlbiBtZXJnaW5nIGJyYW5jaGVzLCBhbmQKbWFrZSB0aGUgY29kZSBm
bG93IGFuZCB0ZXN0aW5nIGVhc2llci4KClBsZWFzZSBsZXQgbWUga25vdyB3aGF0IHlvdSB0aGlu
az8KClJlZ2FyZHMsCsKgIEZlbGl4CgotLSAKRiBlIGwgaSB4ICAgSyB1IGUgaCBsIGkgbiBnClBN
VFMgU29mdHdhcmUgRGV2ZWxvcG1lbnQgRW5naW5lZXIgfCBMaW51eCBDb21wdXRlIEtlcm5lbAox
IENvbW1lcmNlIFZhbGxleSBEci4gRWFzdCwgTWFya2hhbSwgT04gTDNUIDdYNiBDYW5hZGEKKE8p
ICsxKDI4OSk2OTUtMTU5NwogICBfICAgICBfICAgXyAgIF9fX19fICAgX19fX18KICAvIFwgICB8
IFwgLyB8IHwgIF8gIFwgIFwgXyAgfAogLyBBIFwgIHwgXE0vIHwgfCB8RCkgKSAgL3xffCB8Ci9f
LyBcX1wgfF98IHxffCB8X19fX18vIHxfXy8gXHwgICBmYWNlYm9vay5jb20vQU1EIHwgYW1kLmNv
bQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
