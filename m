From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/5] Correct UVD/VCE/VCN powergate status retrieval
Date: Mon, 22 Jul 2019 11:15:26 +0800
Message-ID: <20190722031531.23437-1-evan.quan@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

VkNOIHNob3VsZCBiZSB1c2VkIGZvciBWZWdhMjAgbGF0ZXIgQVNJQ3MuCgpFdmFuIFF1YW4gKDUp
OgogIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgbmV3IHNlbnNvciB0eXBlIGZvciBWQ04gcG93ZXJn
YXRlIHN0YXR1cwogIGRybS9hbWQvcG93ZXJwbGF5OiBzdXBwb3J0IFZDTiBwb3dlcmdhdGUgc3Rh
dHVzIHJldHJpZXZhbCBvbiBSYXZlbgogIGRybS9hbWQvcG93ZXJwbGF5OiBzdXBwb3J0IFZDTiBw
b3dlcmdhdGUgc3RhdHVzIHJldHJpZXZhbCBmb3IgU1cgU01VCiAgZHJtL2FtZC9wb3dlcnBsYXk6
IGNvcnJlY3QgTmF2aTEwIFZDTiBwb3dlcmdhdGUgY29udHJvbAogIGRybS9hbWQvcG93ZXJwbGF5
OiBjb3JyZWN0IFVWRC9WQ0UvVkNOIHBvd2VyIHN0YXR1cyByZXRyaWV2YWwKCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyAgICAgICAgfCA1NiArKysrKysrKysrKystLS0t
LS0tCiAuLi4vZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggICAgfCAgMSAr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgICAgfCAgNCArKwog
Li4uL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jIHwgIDkgKysrCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgICAgfCAyNiArKystLS0t
LS0KIDUgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCgot
LSAKMi4yMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
