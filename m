From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: separate gpu address from bo pin
Date: Tue, 26 Jun 2018 09:46:00 +0200
Message-ID: <6c63256a-17d2-ee6e-8b3c-2e0a928aeb84@daenzer.net>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529992843-649-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0yNiAwODowMCBBTSwgSnVud2VpIFpoYW5nIHdyb3RlOgo+IEl0IGNvdWxkIGJl
IGdvdCBieSBhbWRncHVfYm9fZ3B1X29mZnNldCgpIGlmIG5lZWQKPiAKPiBTaWduZWQtb2ZmLWJ5
OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4gIAo+IFsuLi5dCj4gIAo+IEBA
IC05MzEsNyArOTI4LDYgQEAgaW50IGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChzdHJ1Y3QgYW1k
Z3B1X2JvICpibywgdTMyIGRvbWFpbiwKPiAgICogYW1kZ3B1X2JvX3BpbiAtIHBpbiBhbiAmYW1k
Z3B1X2JvIGJ1ZmZlciBvYmplY3QKPiAgICogQGJvOiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3Qg
dG8gYmUgcGlubmVkCj4gICAqIEBkb21haW46IGRvbWFpbiB0byBiZSBwaW5uZWQgdG8KPiAtICog
QGdwdV9hZGRyOiBHUFUgb2Zmc2V0IG9mIHRoZSAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QKPiAg
ICoKPiAgICogQSBzaW1wbGUgd3JhcHBlciB0byBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoKS4K
PiAgICogUHJvdmlkZXMgYSBzaW1wbGVyIEFQSSBmb3IgYnVmZmVycyB0aGF0IGRvIG5vdCBoYXZl
IGFueSBzdHJpY3QgcmVzdHJpY3Rpb25zCgpUaGlzIGFsc28gbmVlZHMgdG8gYmUgcmVtb3ZlZCBp
biB0aGUgY29tbWVudCBiZWZvcmUKYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkLiBXaXRoIHRoYXQg
Zml4ZWQsCgpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5j
b20+CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
