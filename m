From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: enable gfx 9.0 cp interrupts
Date: Thu, 1 Jun 2017 12:37:25 +0800
Message-ID: <592F9A05.2000606@amd.com>
References: <1496291208-15273-1-git-send-email-Qingqing.Wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496291208-15273-1-git-send-email-Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
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
To: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE35bm0MDbmnIgwMeaXpSAxMjoyNiwgS2VuIFdhbmcgd3JvdGU6Cj4gQ2hhbmdlLUlk
OiBJZjdkZWU3YmQxMDc0ZWFjN2ZhYTZhZjcyNGE3MjcyZjljZTZmM2E5OAo+IFNpZ25lZC1vZmYt
Ynk6IEtlbiBXYW5nIDxRaW5ncWluZy5XYW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHVubWlu
ZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAzIC0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBpbmRleCBkZTM1
ZGUyLi42OGEwZDQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4g
QEAgLTEzOTMsOSArMTM5Myw2IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX2VuYWJsZV9ndWlfaWRs
ZV9pbnRlcnJ1cHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICB7Cj4gICAJdTMyIHRt
cCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05UTF9SSU5HMCk7Cj4gICAKPiAtCWlm
IChlbmFibGUpCj4gLQkJcmV0dXJuOwo+IC0KPiAgIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwg
Q1BfSU5UX0NOVExfUklORzAsIENOVFhfQlVTWV9JTlRfRU5BQkxFLCBlbmFibGUgPyAxIDogMCk7
Cj4gICAJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0lOVF9DTlRMX1JJTkcwLCBDTlRYX0VN
UFRZX0lOVF9FTkFCTEUsIGVuYWJsZSA/IDEgOiAwKTsKPiAgIAl0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgQ1BfSU5UX0NOVExfUklORzAsIENNUF9CVVNZX0lOVF9FTkFCTEUsIGVuYWJsZSA/IDEg
OiAwKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
