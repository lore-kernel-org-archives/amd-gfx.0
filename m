From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix dm-pp clks type convert error
Date: Tue, 26 Jun 2018 10:44:19 -0400
Message-ID: <d124469e-631d-d47d-93e3-37dc15f78c9b@amd.com>
References: <1529992395-8694-1-git-send-email-rezhu@amd.com>
 <1529992395-8694-2-git-send-email-rezhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529992395-8694-2-git-send-email-rezhu-5C7GfCeVMHo@public.gmane.org>
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
To: rex zhu <rezhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wNi0yNiAwMTo1MyBBTSwgcmV4IHpodSB3cm90ZToKPiBmaXggYSB0eXBvIHdoZW4g
Y29udmVydCBkaXNwbGF5cGh5Y2xrIHR5cGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8
UmV4LlpodUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4gaW5kZXggMmFjYmNjNy4uY2Y5
MmQ3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9wcF9zbXUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4gQEAgLTE2Nyw2ICsxNjcsOSBAQCBzdGF0aWMg
ZW51bSBhbWRfcHBfY2xvY2tfdHlwZSBkY190b19wcF9jbG9ja190eXBlKAo+ICAJCWFtZF9wcF9j
bGtfdHlwZSA9IGFtZF9wcF9mX2Nsb2NrOwo+ICAJCWJyZWFrOwo+ICAJY2FzZSBETV9QUF9DTE9D
S19UWVBFX0RJU1BMQVlQSFlDTEs6Cj4gKwkJYW1kX3BwX2Nsa190eXBlID0gYW1kX3BwX3BoeV9j
bG9jazsKPiArCQlicmVhazsKPiArCWNhc2UgRE1fUFBfQ0xPQ0tfVFlQRV9EUFBDTEs6Cj4gIAkJ
YW1kX3BwX2Nsa190eXBlID0gYW1kX3BwX2RwcF9jbG9jazsKPiAgCQlicmVhazsKPiAgCWRlZmF1
bHQ6Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
