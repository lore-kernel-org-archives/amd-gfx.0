From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 0/4] amdgpu: new approach for ras inject test
Date: Thu, 29 Aug 2019 16:59:13 +0800
Message-ID: <20190829085917.20439-1-guchun.chen@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Candice.Li-5C7GfCeVMHo@public.gmane.org, Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

VGhlc2UgcGF0Y2hlcyBhcmUgdG8gcmVtb3ZlIGFkZGl0aW9uYWwgZXh0ZXJuYWwgbGliLWpzb25j
CmRlcGVuZGVuY2UsIGFuZCB0byBwdXQgYWxsIHRlc3QgY29uZmlndXJhdGlvbnMgaW50byBDIGNv
ZGUuCgpHdWNodW4gQ2hlbiAoNCk6CiAgYW1kZ3B1OiByZW1vdmUganNvbiBwYWNrYWdlIGRlcGVu
ZGVuY2UKICBhbWRncHU6IGRlbGV0ZSB0ZXN0IGNvbmZpZ3VyYXRpb24gZmlsZQogIGFtZGdwdTog
YWRkIHJhcyBpbmplY3QgdW5pdCB0ZXN0CiAgYW1kZ3B1OiBhZGQgcmFzIGZlYXR1cmUgY2FwYWJp
bGl0eSBjaGVjayBpbiBpbmplY3QgdGVzdAoKIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICB8ICAx
OCAtLS0KIGRhdGEvYW1kZ3B1X3Jhcy5qc29uICAgICB8IDI2NyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgfCAgIDEgLQogdGVzdHMv
YW1kZ3B1L01ha2VmaWxlLmFtIHwgICA1ICstCiB0ZXN0cy9hbWRncHUvbWVzb24uYnVpbGQgfCAg
MTYgKy0KIHRlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYyB8IDMwNSArKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIDYgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyks
IDQ5NiBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBkYXRhL2FtZGdwdV9yYXMuanNv
bgoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
