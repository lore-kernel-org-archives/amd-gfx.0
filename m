From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display/dc: make dce120_link_encoder_create
 static
Date: Thu, 10 Aug 2017 21:41:03 -0400
Message-ID: <d4cb0107-c16e-115e-f585-06c47ae4c2ec@amd.com>
References: <1502389342-915-1-git-send-email-alexander.deucher@amd.com>
 <1502389342-915-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502389342-915-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Qm90aCBwYXRjaGVzIGFyZQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+CgpIYXJyeQoKT24gMjAxNy0wOC0xMCAwMjoyMiBQTSwgQWxleCBEZXVjaGVy
IHdyb3RlOgo+IE9ubHkgdXNlZCBpbiBkY2UxMjBfcmVzb3VyY2UuYy4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmMgfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEy
MF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2Ux
MjBfcmVzb3VyY2UuYwo+IGluZGV4IDY0NDhkMTUuLmQ0ZTk2MjcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfcmVzb3VyY2UuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNl
LmMKPiBAQCAtNTM1LDcgKzUzNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZW5jb2Rlcl9mZWF0
dXJlX3N1cHBvcnQgbGlua19lbmNfZmVhdHVyZSA9IHsKPiAgCQkuZmxhZ3MuYml0cy5JU19ZQ0JD
Ul9DQVBBQkxFID0gdHJ1ZQo+ICB9Owo+ICAKPiAtc3RydWN0IGxpbmtfZW5jb2RlciAqZGNlMTIw
X2xpbmtfZW5jb2Rlcl9jcmVhdGUoCj4gK3N0YXRpYyBzdHJ1Y3QgbGlua19lbmNvZGVyICpkY2Ux
MjBfbGlua19lbmNvZGVyX2NyZWF0ZSgKPiAgCWNvbnN0IHN0cnVjdCBlbmNvZGVyX2luaXRfZGF0
YSAqZW5jX2luaXRfZGF0YSkKPiAgewo+ICAJc3RydWN0IGRjZTExMF9saW5rX2VuY29kZXIgKmVu
YzExMCA9Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
