From: Kevin Wang <kevwa-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: remove redundancy debug log about
 smu unsupported features
Date: Mon, 12 Aug 2019 08:35:16 +0000
Message-ID: <f2363940-6542-0b15-592f-d97d74af17eb@amd.com>
References: <1565598138-13844-1-git-send-email-Jack.Gui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565598138-13844-1-git-send-email-Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <67BCB5530274134EA496F4CC15B313AB-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

UmV2aWV3ZWQtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+DQoNCk9uIDgvMTIv
MTkgNDoyMiBQTSwgQ2hlbmdtaW5nIEd1aSB3cm90ZToNCj4gcmVtb3ZlIHJlZHVuZGFuY3kgZGVi
dWcgbG9nIGFib3V0IHNtdSB1bnN1cHBvcnRlZCBmZWF0dXJlcw0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBDaGVuZ21pbmcgR3VpIDxKYWNrLkd1aUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyB8IDEgLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FyY3R1cnVzX3BwdC5jDQo+IGluZGV4IGU2ZmNiZGYuLjAzY2U4NzEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jDQo+IEBAIC0yMTUsNyAr
MjE1LDYgQEAgc3RhdGljIGludCBhcmN0dXJ1c19nZXRfc211X2ZlYXR1cmVfaW5kZXgoc3RydWN0
IHNtdV9jb250ZXh0ICpzbWMsIHVpbnQzMl90IGluZGUNCj4gICANCj4gICAJbWFwcGluZyA9IGFy
Y3R1cnVzX2ZlYXR1cmVfbWFza19tYXBbaW5kZXhdOw0KPiAgIAlpZiAoIShtYXBwaW5nLnZhbGlk
X21hcHBpbmcpKSB7DQo+IC0JCXByX3dhcm4oIlVuc3VwcG9ydGVkIFNNVSBmZWF0dXJlOiAlZFxu
IiwgaW5kZXgpOw0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICANCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
