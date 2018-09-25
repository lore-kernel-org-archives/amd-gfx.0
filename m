From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] drm/amdgpu:Add DPG support flag
Date: Tue, 25 Sep 2018 16:06:38 -0400
Message-ID: <CADnq5_O2gG_jJTRXF-RTvybZYAgtt8eOH1sqsv4xpOuO4fd6xQ@mail.gmail.com>
References: <1537905323-27071-1-git-send-email-James.Zhu@amd.com>
 <1537905323-27071-3-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537905323-27071-3-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: James Zhu <james.zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBTZXAgMjUsIDIwMTggYXQgNDowNCBQTSBKYW1lcyBaaHUgPGp6aHVtc0BnbWFpbC5j
b20+IHdyb3RlOgo+Cj4gQWRkIERQRyBzdXBwb3J0IGZsYWcgZm9yIFZDTiBEUEcgbW9kZS4KPgo+
IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggfCAyICsrCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Ft
ZF9zaGFyZWQuaAo+IGluZGV4IDg2YjE2N2UuLjJmNmJkZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKPiBAQCAtMTEwLDYgKzExMCw4IEBAIGVudW0gYW1k
X3Bvd2VyZ2F0aW5nX3N0YXRlIHsKPiAgI2RlZmluZSBBTURfUEdfU1VQUE9SVF9NTUhVQiAgICAg
ICAgICAgICAgICAgICAoMSA8PCAxMykKPiAgI2RlZmluZSBBTURfUEdfU1VQUE9SVF9WQ04gICAg
ICAgICAgICAgICAgICAgICAoMSA8PCAxNCkKPgo+ICsjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0RQ
RyAgICAgICAgICAgICAgICAgICAgICgxIDw8IDE1KQoKUGxlYXNlIGRyb3AgdGhlIG5ldyBsaW5l
IGJlZm9yZSB0aGlzIGRlZmluZS4gIEFsc28sIHJlbmFtZSBpdCBWQ05fRFBHCnNvIGl0J3MgY2xl
YXIgaXQncyBhIFZDTiBmZWF0dXJlLgoKQWxleAoKPiArCj4gIGVudW0gUFBfRkVBVFVSRV9NQVNL
IHsKPiAgICAgICAgIFBQX1NDTEtfRFBNX01BU0sgPSAweDEsCj4gICAgICAgICBQUF9NQ0xLX0RQ
TV9NQVNLID0gMHgyLAo+IC0tCj4gMi43LjQKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
