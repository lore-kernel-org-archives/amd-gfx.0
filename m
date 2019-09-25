From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 01/11] drm/amdgpu: add UAPI for creating encrypted buffers
Date: Wed, 25 Sep 2019 13:45:11 +0000
Message-ID: <1569419090-5304-2-git-send-email-ray.huang@amd.com>
References: <1569419090-5304-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569419090-5304-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <8099FBBC75C83A4B8A2D7BD1CFF9D698-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpBZGQgYSBm
bGFnIHRvIHRoZSBHRU1fQ1JFQVRFIGlvY3RsIHRvIGNyZWF0ZSBlbmNyeXB0ZWQgYnVmZmVycy4N
CkJ1ZmZlcnMgd2l0aCB0aGlzIGZsYWcgc2V0IHdpbGwgYmUgY3JlYXRlZCB3aXRoIHRoZSBUTVog
Yml0IHNldA0KaW4gdGhlIFBURXMgb3IgZW5naW5lcyBhY2Nlc3NpbmcgdGhlbS4gIFRoaXMgaXMg
cmVxdWlyZWQgaW4gb3JkZXINCnRvIHByb3Blcmx5IGFjY2VzcyB0aGUgZGF0YSBmcm9tIHRoZSBl
bmdpbmVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQot
LS0NCiBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDUgKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaCBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQppbmRleCBmM2FkNDI5
Li5mOTBiNDUzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCisr
KyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQpAQCAtMTM1LDYgKzEzNSwxMSBAQCBl
eHRlcm4gIkMiIHsNCiAgKiByZWxlYXNpbmcgdGhlIG1lbW9yeQ0KICAqLw0KICNkZWZpbmUgQU1E
R1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UJKDEgPDwgOSkNCisvKiBGbGFnIHRo
YXQgQk8gd2lsbCBiZSBlbmNyeXB0ZWQgYW5kIHRoYXQgdGhlIFRNWiBiaXQgc2hvdWxkIGJlDQor
ICogc2V0IGluIHRoZSBQVEVzIHdoZW4gbWFwcGluZyB0aGlzIGJ1ZmZlciB2aWEgR1BVVk0gb3IN
CisgKiBhY2Nlc3NpbmcgaXQgd2l0aCB2YXJpb3VzIGh3IGJsb2Nrcw0KKyAqLw0KKyNkZWZpbmUg
QU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVECQkoMSA8PCAxMCkNCiANCiBzdHJ1Y3QgZHJtX2Ft
ZGdwdV9nZW1fY3JlYXRlX2luICB7DQogCS8qKiB0aGUgcmVxdWVzdGVkIG1lbW9yeSBzaXplICov
DQotLSANCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
