From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/display: Only allow s/g when USWC flag is set.
Date: Tue, 23 Jul 2019 18:25:30 +0200
Message-ID: <3d20c8df-372b-dceb-fb06-8312bd06da7e@daenzer.net>
References: <1563897851-11501-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563897851-11501-3-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563897851-11501-3-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, hersenxs.wu-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, shirish.s-5C7GfCeVMHo@public.gmane.org

T24gMjAxOS0wNy0yMyA2OjA0IHAubS4sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IFRoaXMg
dmVyaWZpZXMgd2UgZG9uJ3QgY2FzdWUgSFcgaGFuZyBpbiBjYXNlIHRoaXMgZmxhZyBpcyBtaXNz
aW5nLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpv
dnNreUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4gVGVzdGVkLWJ5OiBTaGlyaXNoIFMgPHNoaXJpc2guc0BhbWQuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
IHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKPiBpbmRleCA5ZWY3ODU0Li4yZDUwZWVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTQ0MTMsNyArNDQx
Myw3IEBAIHN0YXRpYyBpbnQgZG1fcGxhbmVfaGVscGVyX3ByZXBhcmVfZmIoc3RydWN0IGRybV9w
bGFuZSAqcGxhbmUsCj4gIAkJcmV0dXJuIHI7Cj4gIAl9Cj4gIAo+IC0JaWYgKHBsYW5lLT50eXBl
ICE9IERSTV9QTEFORV9UWVBFX0NVUlNPUikKPiArCWlmIChwbGFuZS0+dHlwZSAhPSBEUk1fUExB
TkVfVFlQRV9DVVJTT1IgJiYgKHJiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RU
X1VTV0MpKQo+ICAJCWRvbWFpbiA9IGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGFk
ZXYpOwo+ICAJZWxzZQo+ICAJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07Cj4gCgph
bWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucygpIGlzIHVzZWQgaW4gb3RoZXIgcGxhY2Vz
IGFzIHdlbGwsIHNvCnRoaXMgc2hvdWxkIGJlIGhhbmRsZWQgaW5zaWRlIGl0IGluc3RlYWQuCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
IGh0dHBzOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
