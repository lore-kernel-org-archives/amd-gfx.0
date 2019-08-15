From: "Thai, Thong" <Thong.Thai-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: enable VCN DPG for Renoir
Date: Thu, 15 Aug 2019 18:19:48 +0000
Message-ID: <20190815181940.4897-2-thong.thai@amd.com>
References: <20190815181940.4897-1-thong.thai@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190815181940.4897-1-thong.thai-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Thai, Thong" <Thong.Thai-5C7GfCeVMHo@public.gmane.org>

RW5hYmxlIFZDTiBEeW5hbWljIFBvd2VyZ2F0aW5nIG9uIFJlbm9pciBkZXZpY2VzLgoKVGhpcyB3
aWxsIGFsc28gZW5hYmxlIGluZGlyZWN0IFNSQU0gbG9hZGluZyBvZiBWQ04gZmlybXdhcmUgb24g
UmVub2lyLgoKU2lnbmVkLW9mZi1ieTogVGhvbmcgVGhhaSA8dGhvbmcudGhhaUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCA0ICsrKy0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYwppbmRleCA0M2E0NDE4ZjA1NjAuLjRkNzQ2MzI1ZDdlNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jCkBAIC0xMDM4LDcgKzEwMzgsOSBAQCBzdGF0aWMgaW50IHNvYzE1
X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQkgQU1EX0NHX1NVUFBPUlRfQVRI
VUJfTFMgfAogCQkJCSBBTURfQ0dfU1VQUE9SVF9BVEhVQl9NR0NHIHwKIAkJCQkgQU1EX0NHX1NV
UFBPUlRfREZfTUdDRzsKLQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9TRE1BOwor
CQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1NETUEgfAorCQkJCSBBTURfUEdfU1VQ
UE9SVF9WQ04gfAorCQkJCSBBTURfUEdfU1VQUE9SVF9WQ05fRFBHOwogCQlhZGV2LT5leHRlcm5h
bF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDkxOwogCiAJCWlmIChhZGV2LT5wbS5wcF9mZWF0
dXJlICYgUFBfR0ZYT0ZGX01BU0spCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
