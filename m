From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Trigger bug when allocation fails.
Date: Tue, 17 Oct 2017 22:12:29 +0200
Message-ID: <d035e531-09e5-0307-4340-7c96685dc60e@gmail.com>
References: <20171017174554.13930-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171017174554.13930-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTcuMTAuMjAxNyAxOTo0NSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+IElmIHRoZSBhbGxvY2F0
aW9uIGZhaWxzIGluIGFtZGdwdV9kbV9jb25uZWN0b3JfZnVuY3NfcmVzZXQoKSB0aGUKPiBBUEkg
Y2Fubm90IGNvbnRpbnVlIHNvIHRyaWdnZXIgYSBCVUdfT04uCgpUaGF0IHNlZW1zIHF1ZXN0aW9u
YWJsZSB0byBiZSBob25lc3QuIFRoZSBkcm1fYXRvbWljX2hlbHBlciB2ZXJzaW9uIG9mIAp0aGlz
IGZ1bmN0aW9uIGVuZHMgdXAgc2V0dGluZyBjb25uZWN0b3ItPnN0YXRlID0gTlVMTDsgaW4gdGhp
cyBjYXNlLgoKQ2hlZXJzLApOaWNvbGFpCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5p
cyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IDU4ZTI5YTJhNWNhNi4uYWM1OGJhNGYxMGNmIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jCj4gQEAgLTI3MjIsNiArMjcyMiw3IEBAIHZvaWQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9mdW5j
c19yZXNldChzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yKQo+ICAgCWtmcmVlKHN0YXRl
KTsKPiAgIAo+ICAgCXN0YXRlID0ga3phbGxvYyhzaXplb2YoKnN0YXRlKSwgR0ZQX0tFUk5FTCk7
Cj4gKwlCVUdfT04oc3RhdGUgPT0gTlVMTCk7Cj4gICAKPiAgIAlpZiAoc3RhdGUpIHsKPiAgIAkJ
c3RhdGUtPnNjYWxpbmcgPSBSTVhfT0ZGOwo+IAoKCi0tIApMZXJuZSwgd2llIGRpZSBXZWx0IHdp
cmtsaWNoIGlzdCwKQWJlciB2ZXJnaXNzIG5pZW1hbHMsIHdpZSBzaWUgc2VpbiBzb2xsdGUuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
