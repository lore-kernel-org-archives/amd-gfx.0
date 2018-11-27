From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 0/3] Add support for XGMI hive reset
Date: Tue, 27 Nov 2018 13:37:25 -0500
Message-ID: <1543343848-11249-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Monk.Liu-5C7GfCeVMHo@public.gmane.org

VGhpcyBzZXQgb2YgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgdG8gcmVzZXQgZW50aXJlIFhHTUkgaGl2
ZQp3aGVuIHJlc2V0IGlzIHJlcXVpcmVkLgoKUGF0Y2hlcyAxLTIgcmVmYWN0b3JpbmcgYSBiaXQg
dGhlIFhHTUkgaW5mcmFzdHJ1Y3R1cmUgYXMKcHJlcGFyYXRvbiBmb3IgdGhlIGFjdHVhbCBoaXZl
IHJlc2V0IGNoYW5nZS4KClBhdGNoIDUgaXMgR1BVIHJlc2V0L3JlY292ZXJ5IHJlZmFjdG9yZWQg
dG8gc3VwcG9ydCBYR01JCmhpdmUgcmVzZXQuCgpBbmRyZXkgR3JvZHpvdnNreSAoMyk6CiAgZHJt
L2FtZGdwdTogUmVmYWN0b3IgYW1kZ3B1X3hnbWlfYWRkX2RldmljZSB2MwogIGRybS9hbWRncHU6
IEV4cG9zZSBoaXZlIGFkZXYgbGlzdCBhbmQgeGdtaV9tdXRleCB2MwogIGRybS9hbWRncHU6IFJl
ZmFjdG9yIEdQVSByZXNldCBmb3IgWEdNSSBoaXZlIGNhc2UgdjMKCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAgIDkgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDM3NiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyAgIHwgIDY4ICsrKy0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCAgIHwgIDM5ICsrKwog
NCBmaWxlcyBjaGFuZ2VkLCAzNDMgaW5zZXJ0aW9ucygrKSwgMTQ5IGRlbGV0aW9ucygtKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgK
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
