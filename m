From: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add the checking to avoid  NULL pointer
 dereference
Date: Thu, 22 Nov 2018 06:56:05 +0000
Message-ID: <20181122065523.5510-1-Deepak.Sharma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>

d2hlbiByZXR1cm5lZCBmZW5jZSBpcyBub3QgdmFsaWQgbW9zdGx5IGR1ZSB0byB1c2Vyc3BhY2Ug
aWdub3JlZApwcmV2aW91cyBlcnJvciBjYXVzZXMgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLgoK
U2lnbmVkLW9mZi1ieTogRGVlcGFrIFNoYXJtYSA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMKaW5kZXggMDI0ZGZiZDg3ZjExLi4xNDE2NmNkOGExMmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC0xNDAzLDYgKzE0MDMsOCBAQCBzdGF0aWMgc3RydWN0IGRt
YV9mZW5jZSAqYW1kZ3B1X2NzX2dldF9mZW5jZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
IAogCWZlbmNlID0gYW1kZ3B1X2N0eF9nZXRfZmVuY2UoY3R4LCBlbnRpdHksIHVzZXItPnNlcV9u
byk7CiAJYW1kZ3B1X2N0eF9wdXQoY3R4KTsKKwlpZighZmVuY2UpCisJCXJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOwogCiAJcmV0dXJuIGZlbmNlOwogfQotLSAKMi4xNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
