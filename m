From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] drm/amdgpu:Add DPG support flag
Date: Wed, 26 Sep 2018 10:02:23 +0200
Message-ID: <44a25354-4329-c942-8f86-0528a0b2ce84@gmail.com>
References: <1537905323-27071-1-git-send-email-James.Zhu@amd.com>
 <1537905323-27071-3-git-send-email-James.Zhu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537905323-27071-3-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: james.zhu-5C7GfCeVMHo@public.gmane.org

QW0gMjUuMDkuMjAxOCB1bSAyMTo1NSBzY2hyaWViIEphbWVzIFpodToKPiBBZGQgRFBHIHN1cHBv
cnQgZmxhZyBmb3IgVkNOIERQRyBtb2RlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxK
YW1lcy5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9h
bWRfc2hhcmVkLmggfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKPiBpbmRleCA4NmIxNjdl
Li4yZjZiZGYxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRf
c2hhcmVkLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5o
Cj4gQEAgLTExMCw2ICsxMTAsOCBAQCBlbnVtIGFtZF9wb3dlcmdhdGluZ19zdGF0ZSB7Cj4gICAj
ZGVmaW5lIEFNRF9QR19TVVBQT1JUX01NSFVCCQkJKDEgPDwgMTMpCj4gICAjZGVmaW5lIEFNRF9Q
R19TVVBQT1JUX1ZDTgkJCSgxIDw8IDE0KQo+ICAgCgpMb29rcyBsaWtlIHlvdSBhZGRlZCBhbiBl
eHRyYSBlbXB0eSBsaW5lIGJldHdlZW4gQU1EX1BHX1NVUFBPUlRfVkNOIGFuZCAKdGhlIG5ldyBl
bnRyeSwgd2FzIHRoYXQgaW50ZW50aW9uYWw/CgpBcGFydCBmcm9tIHRoYXQgdGhlIHBhdGNoZXMg
bG9vayBnb29kIHRvIG1lLCBidXQgY2FuJ3QganVkZ2UgaWYgdGhhdCBpcyAKcmVhbGx5IGNvcnJl
Y3QuCgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PiBmb3IgdGhlIHNlcmllcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gKyNkZWZpbmUgQU1EX1BH
X1NVUFBPUlRfRFBHCQkJKDEgPDwgMTUpCj4gKwo+ICAgZW51bSBQUF9GRUFUVVJFX01BU0sgewo+
ICAgCVBQX1NDTEtfRFBNX01BU0sgPSAweDEsCj4gICAJUFBfTUNMS19EUE1fTUFTSyA9IDB4MiwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
