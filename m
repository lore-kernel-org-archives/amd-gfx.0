From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu: don't ask about CHASH just default it for now.
Date: Thu, 28 Sep 2017 14:04:46 -0400
Message-ID: <ee23b245-309f-20e0-3a3e-39b368333a74@amd.com>
References: <20170927223807.460-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170927223807.460-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gMjAxNy0wOS0yNyAwNjozOCBQTSwgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4gRnJvbTogRGF2ZSBB
aXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KPgo+IElmIHdlIGJ1bXAgdGhpcyB1cCBhIGxldmVs
LCB3ZSBjYW4gYXNrIGFib3V0IGl0LCBmb3Igbm93LAo+IGp1c3QgZGVmYXVsdCB0byB3aGF0IGFt
ZGdwdSBkb2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0
LmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2xpYi9LY29uZmlnIHwgMyArKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvbGliL0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2xpYi9LY29uZmlnCj4gaW5kZXggMDNlZTdhZC4uNzc2ZWYzNCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2xpYi9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9s
aWIvS2NvbmZpZwo+IEBAIC00LDcgKzQsOCBAQCBtZW51ICJBTUQgTGlicmFyeSByb3V0aW5lcyIK
PiAgIyBDbG9zZWQgaGFzaCB0YWJsZQo+ICAjCj4gIGNvbmZpZyBDSEFTSAo+IC0JdHJpc3RhdGUg
IkNsb3NlZCBoYXNoIHRhYmxlIgo+ICsJdHJpc3RhdGUKPiArCWRlZmF1bHQgRFJNX0FNREdQVQo+
ICAJaGVscAo+ICAJIFN0YXRpY2FsbHkgc2l6ZWQgY2xvc2VkIGhhc2ggdGFibGUgaW1wbGVtZW50
YXRpb24gd2l0aCBsb3cKPiAgCSBtZW1vcnkgYW5kIENQVSBvdmVyaGVhZC4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
