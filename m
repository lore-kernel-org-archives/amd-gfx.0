From: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Subject: Re: [PATCH libdrm 3/4] libdrm/amdgpu: add new vram type (GDDR6) for
 navi10
Date: Wed, 19 Jun 2019 01:33:30 +0200
Message-ID: <CAP+8YyGNZzpT5L=PqbtVoqUgxVbNFheUCtZbDT1A+o-RW0qFXA@mail.gmail.com>
References: <1560858033-1499-1-git-send-email-Hawking.Zhang@amd.com>
 <1560858033-1499-3-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1560858033-1499-3-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBKdW4gMTgsIDIwMTkgYXQgMTo0MSBQTSBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4gRnJvbTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29t
Pgo+Cj4gQU1ER1BVX1ZSQU1fVFlQRV9HRERSNiBpcyBhIG5ldyB2cmFtIHR5cGUgZm9yIG5hdmkx
MAo+Cj4gQ2hhbmdlLUlkOiBJNjc4OTIzMGY4ZjdmNWJkY2IwYWVjODJjYzc2NGQxMGQ3MmM0Y2Jh
OAoKQ2FuIHlvdSByZW1vdmUgdGhlIENoYW5nZS1JZCBmcm9tIHRoZXNlIHBhdGNoZXM/CgpPdGhl
cndpc2UsCgpSZXZpZXdlZC1ieTogQmFzIE5pZXV3ZW5odWl6ZW4gPGJhc0BiYXNuaWV1d2VuaHVp
emVuLm5sPgoKZm9yIHBhdGNoZXMgMS0zLiAod2lsbCBub3QgcmV2aWV3IDQgZHVlIHRvIGxhY2sg
b2Yga25vd2xlZGdlKQoKPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4K
PiAtLS0KPiAgaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0u
aCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+IGluZGV4IGIwYzc1NTUuLjAxNWJkOWYgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4gKysrIGIvaW5jbHVkZS9kcm0v
YW1kZ3B1X2RybS5oCj4gQEAgLTkxMyw2ICs5MTMsNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZv
X2Zpcm13YXJlIHsKPiAgI2RlZmluZSBBTURHUFVfVlJBTV9UWVBFX0hCTSAgIDYKPiAgI2RlZmlu
ZSBBTURHUFVfVlJBTV9UWVBFX0REUjMgIDcKPiAgI2RlZmluZSBBTURHUFVfVlJBTV9UWVBFX0RE
UjQgIDgKPiArI2RlZmluZSBBTURHUFVfVlJBTV9UWVBFX0dERFI2IDkKPgo+ICBzdHJ1Y3QgZHJt
X2FtZGdwdV9pbmZvX2RldmljZSB7Cj4gICAgICAgICAvKiogUENJIERldmljZSBJRCAqLwo+IC0t
Cj4gMi43LjQKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
