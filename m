From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/6] amdgpu: psp update prep for S3 suspend/resume for vega10
Date: Sat, 1 Apr 2017 17:00:42 +0800
Message-ID: <1491037248-16146-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

SGkgYWxsLAoKVGhlc2UgcGF0Y2hlcyBhcmUgcHJlcGFyaW5nIGZvciBmaXJtd2FyZSBzYXZlL3Jl
c3RvcmUgY29tbWFuZCBhbmQKZGVidWdnaW5nIHJlbG9hZGluZy4gUGxlYXNlIHJldmlldy4KQWZ0
ZXIgdGhhdCwgSSB3aWxsIHNlbmQgdmVnYTEwIFMzIHBhdGNoZXMgbGF0ZXIuCgpUaGFua3MsClJ1
aQoKSHVhbmcgUnVpICg2KToKICBkcm0vYW1kZ3B1OiBzcGxpdCB0bXIgaW5pdCBmdW5jdGlvbgog
IGRybS9hbWRncHU6IGFkZCBmaXJtd2FyZSBwcml2YXRlIG1lbW9yeQogIGRybS9hbWRncHU6IHVz
ZSBwcml2YXRlIG1lbW9yeSB0byBzdG9yZSBwc3AgZmlybXdhcmUgZGF0YQogIGRybS9hbWRncHU6
IHNwbGl0IGFzZCBmdW5jdGlvbgogIGRybS9hbWRncHU6IHNwbGl0IHBzcCByaW5nIGluaXQgZnVu
Y3Rpb24KICBkcm0vYW1kZ3B1OiBhZGQgaHdfc3RhcnQgYW5kIG5vbi1wc3AgZmlybXdhcmUgbG9h
ZGluZyBpbnRvIHJlc3VtZQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyB8IDIwOCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oIHwgIDE1ICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvcHNwX3YzXzEuYyAgIHwgIDU5ICsrKy0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvcHNwX3YzXzEuaCAgIHwgICAyICsKIDQgZmlsZXMgY2hhbmdlZCwgMTYyIGluc2VydGlv
bnMoKyksIDEyMiBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
