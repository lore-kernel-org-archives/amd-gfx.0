From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/4] drm/amdgpu: s/disp_detetion_ports/disp_detection_ports/
Date: Thu, 28 Jun 2018 15:14:53 -0400
Message-ID: <20180628191505.10015-3-lyude@redhat.com>
References: <20180628191505.10015-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180628191505.10015-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Luc Van Oostenryck <luc.vanoostenryck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

UmV2aWV3ZWQtYnk6IEppbSBRdSA8SmltLlF1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEx5dWRl
IFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2F0cHhfaGFuZGxlci5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hdHB4X2hhbmRsZXIuYwppbmRleCBkYWEwNmU3YzViYjcuLmEzODk2NDEyYTAxOSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0cHhfaGFuZGxl
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIu
YwpAQCAtMzIsNyArMzIsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2F0cHhfZnVuY3Rpb25zIHsKIAlib29s
IHN3aXRjaF9zdGFydDsKIAlib29sIHN3aXRjaF9lbmQ7CiAJYm9vbCBkaXNwX2Nvbm5lY3RvcnNf
bWFwcGluZzsKLQlib29sIGRpc3BfZGV0ZXRpb25fcG9ydHM7CisJYm9vbCBkaXNwX2RldGVjdGlv
bl9wb3J0czsKIH07CiAKIHN0cnVjdCBhbWRncHVfYXRweCB7CkBAIC0xNTYsNyArMTU2LDcgQEAg
c3RhdGljIHZvaWQgYW1kZ3B1X2F0cHhfcGFyc2VfZnVuY3Rpb25zKHN0cnVjdCBhbWRncHVfYXRw
eF9mdW5jdGlvbnMgKmYsIHUzMiBtYXMKIAlmLT5zd2l0Y2hfc3RhcnQgPSBtYXNrICYgQVRQWF9H
UkFQSElDU19ERVZJQ0VfU1dJVENIX1NUQVJUX05PVElGSUNBVElPTl9TVVBQT1JURUQ7CiAJZi0+
c3dpdGNoX2VuZCA9IG1hc2sgJiBBVFBYX0dSQVBISUNTX0RFVklDRV9TV0lUQ0hfRU5EX05PVElG
SUNBVElPTl9TVVBQT1JURUQ7CiAJZi0+ZGlzcF9jb25uZWN0b3JzX21hcHBpbmcgPSBtYXNrICYg
QVRQWF9HRVRfRElTUExBWV9DT05ORUNUT1JTX01BUFBJTkdfU1VQUE9SVEVEOwotCWYtPmRpc3Bf
ZGV0ZXRpb25fcG9ydHMgPSBtYXNrICYgQVRQWF9HRVRfRElTUExBWV9ERVRFQ1RJT05fUE9SVFNf
U1VQUE9SVEVEOworCWYtPmRpc3BfZGV0ZWN0aW9uX3BvcnRzID0gbWFzayAmIEFUUFhfR0VUX0RJ
U1BMQVlfREVURUNUSU9OX1BPUlRTX1NVUFBPUlRFRDsKIH0KIAogLyoqCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
