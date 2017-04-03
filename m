From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] amdgpu: psp update prep for S3 suspend/resume for
 vega10
Date: Mon, 3 Apr 2017 14:39:15 -0400
Message-ID: <CADnq5_OSX3XS_TsAWP2wK8=AGhf-aad0--ZC=NbGmJPNgffnCw@mail.gmail.com>
References: <1491037248-16146-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491037248-16146-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gU2F0LCBBcHIgMSwgMjAxNyBhdCA1OjAwIEFNLCBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQu
Y29tPiB3cm90ZToKPiBIaSBhbGwsCj4KPiBUaGVzZSBwYXRjaGVzIGFyZSBwcmVwYXJpbmcgZm9y
IGZpcm13YXJlIHNhdmUvcmVzdG9yZSBjb21tYW5kIGFuZAo+IGRlYnVnZ2luZyByZWxvYWRpbmcu
IFBsZWFzZSByZXZpZXcuCj4gQWZ0ZXIgdGhhdCwgSSB3aWxsIHNlbmQgdmVnYTEwIFMzIHBhdGNo
ZXMgbGF0ZXIuCgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKPgo+IFRoYW5rcywKPiBSdWkKPgo+IEh1YW5nIFJ1aSAoNik6Cj4gICBkcm0vYW1k
Z3B1OiBzcGxpdCB0bXIgaW5pdCBmdW5jdGlvbgo+ICAgZHJtL2FtZGdwdTogYWRkIGZpcm13YXJl
IHByaXZhdGUgbWVtb3J5Cj4gICBkcm0vYW1kZ3B1OiB1c2UgcHJpdmF0ZSBtZW1vcnkgdG8gc3Rv
cmUgcHNwIGZpcm13YXJlIGRhdGEKPiAgIGRybS9hbWRncHU6IHNwbGl0IGFzZCBmdW5jdGlvbgo+
ICAgZHJtL2FtZGdwdTogc3BsaXQgcHNwIHJpbmcgaW5pdCBmdW5jdGlvbgo+ICAgZHJtL2FtZGdw
dTogYWRkIGh3X3N0YXJ0IGFuZCBub24tcHNwIGZpcm13YXJlIGxvYWRpbmcgaW50byByZXN1bWUK
Pgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAyMDggKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5oIHwgIDE1ICsrLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3Bf
djNfMS5jICAgfCAgNTkgKysrLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Bz
cF92M18xLmggICB8ICAgMiArCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTYyIGluc2VydGlvbnMoKyks
IDEyMiBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMi43LjQKPgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
