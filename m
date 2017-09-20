From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amgpu: update raven sdma golden setting
Date: Wed, 20 Sep 2017 14:47:22 +0800
Message-ID: <59C20EFA.3010903@amd.com>
References: <1505888524-6521-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505888524-6521-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDkvMjAvMjAxNyAwMjoyMiBQTSwgRXZhbiBRdWFuIHdyb3RlOgo+IENoYW5nZS1JZDogSWE0
MWJmNjQ1MDE1NTc3MjNmYTgxMWFkOThhN2I1NjMwZjEyZDllZDgKPiBTaWduZWQtb2ZmLWJ5OiBF
dmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxK
ZXJyeS5aaGFuZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwo+IGlu
ZGV4IGZkN2M3MmEuLjJiMjMxNmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y0XzAuYwo+IEBAIC04OSw3ICs4OSw3IEBAIHN0YXRpYyBjb25zdCB1MzIgZ29sZGVuX3NldHRp
bmdzX3NkbWFfdmcxMFtdID0gewo+Cj4gICBzdGF0aWMgY29uc3QgdTMyIGdvbGRlbl9zZXR0aW5n
c19zZG1hXzRfMVtdID0KPiAgIHsKPiAtCVNPQzE1X1JFR19PRkZTRVQoU0RNQTAsIDAsIG1tU0RN
QTBfQ0hJQ0tFTl9CSVRTKSwgMHhmZTkzMWYwNywgMHgwMjgzMWYwNywKPiArCVNPQzE1X1JFR19P
RkZTRVQoU0RNQTAsIDAsIG1tU0RNQTBfQ0hJQ0tFTl9CSVRTKSwgMHhmZTkzMWYwNywgMHgwMjgz
MWQwNywKPiAgIAlTT0MxNV9SRUdfT0ZGU0VUKFNETUEwLCAwLCBtbVNETUEwX0NMS19DVFJMKSwg
MHhmZmZmZmZmZiwgMHgzZjAwMDEwMCwKPiAgIAlTT0MxNV9SRUdfT0ZGU0VUKFNETUEwLCAwLCBt
bVNETUEwX0dGWF9JQl9DTlRMKSwgMHg4MDBmMDExMSwgMHgwMDAwMDEwMCwKPiAgIAlTT0MxNV9S
RUdfT0ZGU0VUKFNETUEwLCAwLCBtbVNETUEwX0dGWF9SQl9XUFRSX1BPTExfQ05UTCksIDB4ZmZm
ZmZmZjcsIDB4MDA0MDMwMDAsCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
