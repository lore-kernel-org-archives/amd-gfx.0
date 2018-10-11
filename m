From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 18/18] drm/amdgpu/vcn:Update SPG mode UVD status clear
Date: Thu, 11 Oct 2018 11:48:32 -0400
Message-ID: <f4c68edf-e44f-a4c4-a898-4433ec3802b5@amd.com>
References: <1539196928-28890-1-git-send-email-James.Zhu@amd.com>
 <1539196928-28890-19-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539196928-28890-19-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-GB
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

TG9va3MgZ29vZCB0byBtZS4gVGhlIHdob2xlIHNlcmllcyBhcmU6CgpBY2tlZC1ieTogTGVvIExp
dSA8bGVvLmxpdUBhbWQuY29tPgoKCk9uIDEwLzEwLzIwMTggMDI6NDIgUE0sIEphbWVzIFpodSB3
cm90ZToKPiBVcGRhdGUgU3RhdGljIFBvd2VyIEdhdGUgbW9kZSBVVkQgc3RhdHVzIGNsZWFyCj4K
PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDYgKysrLS0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gaW5kZXggZDhmZTE0ZC4uYmM2NDcwNiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+IEBAIC04ODMsOSArODgzLDkgQEAg
c3RhdGljIGludCB2Y25fdjFfMF9zdGFydF9zcGdfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIAkJVVZEX1NZU19JTlRfRU5fX1VWRF9KUkJDX0VOX01BU0ssCj4gICAJCX5VVkRf
U1lTX0lOVF9FTl9fVVZEX0pSQkNfRU5fTUFTSyk7Cj4gICAKPiAtCS8qIGNsZWFyIHRoZSBiaXQg
NCBvZiBWQ05fU1RBVFVTICovCj4gLQlXUkVHMzJfUChTT0MxNV9SRUdfT0ZGU0VUKFVWRCwgMCwg
bW1VVkRfU1RBVFVTKSwgMCwKPiAtCQkJfigyIDw8IFVWRF9TVEFUVVNfX1ZDUFVfUkVQT1JUX19T
SElGVCkpOwo+ICsJLyogY2xlYXIgdGhlIGJ1c3kgYml0IG9mIFVWRF9TVEFUVVMgKi8KPiArCXRt
cCA9IFJSRUczMl9TT0MxNShVVkQsIDAsIG1tVVZEX1NUQVRVUykgJiB+VVZEX1NUQVRVU19fVVZE
X0JVU1k7Cj4gKwlXUkVHMzJfU09DMTUoVVZELCAwLCBtbVVWRF9TVEFUVVMsIHRtcCk7Cj4gICAK
PiAgIAkvKiBmb3JjZSBSQkMgaW50byBpZGxlIHN0YXRlICovCj4gICAJcmJfYnVmc3ogPSBvcmRl
cl9iYXNlXzIocmluZy0+cmluZ19zaXplKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
