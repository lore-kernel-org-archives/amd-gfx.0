From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/17] drm/amd/display: add disconnect_delay to dc_panel_patch
Date: Thu, 30 Aug 2018 17:33:14 -0400
Message-ID: <20180830213323.31745-9-Bhawanpreet.Lakha@amd.com>
References: <20180830213323.31745-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180830213323.31745-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Derek Lai <Derek.Lai-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRGVyZWsgTGFpIDxEZXJlay5MYWlAYW1kLmNvbT4KClNvbWUgZGlzcGxheSBuZWVkIGRp
c2Nvbm5lY3QgZGVsYXkuIEFkZGluZyB0aGlzIHBhcmFtZXRlciBmb3IgZnV0dXJlIHVzZQoKQ2hh
bmdlLUlkOiBJMDA3NWNmMmJlMGZlNjU4ZjA3NDI1ZjgwZDIzYzU5MjcyNjkyOWE3NgpTaWduZWQt
b2ZmLWJ5OiBEZXJlayBMYWkgPERlcmVrLkxhaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hhcmxl
bmUgTGl1IDxDaGFybGVuZS5MaXVAYW1kLmNvbT4KQWNrZWQtYnk6IEJoYXdhbnByZWV0IExha2hh
IDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY190eXBlcy5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190eXBlcy5oCmluZGV4IDU4YTZlZjgw
YTYwZS4uNGZiNjI3ODBhNjk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfdHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNf
dHlwZXMuaApAQCAtMTkxLDYgKzE5MSw3IEBAIHVuaW9uIGRpc3BsYXlfY29udGVudF9zdXBwb3J0
IHsKIH07CiAKIHN0cnVjdCBkY19wYW5lbF9wYXRjaCB7CisJdW5zaWduZWQgaW50IGRpc2Nvbm5l
Y3RfZGVsYXk7CiAJdW5zaWduZWQgaW50IGRwcG93ZXJ1cF9kZWxheTsKIAl1bnNpZ25lZCBpbnQg
ZXh0cmFfdDEyX21zOwogfTsKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
