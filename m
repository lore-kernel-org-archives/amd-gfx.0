From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/si/dpm: fix swapped ck enable
Date: Wed, 14 Sep 2016 15:56:49 +0200
Message-ID: <2a82ee1a-6b2d-cd98-c177-0ce320441370@vodafone.de>
References: <1473860836-12401-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473860836-12401-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMTQuMDkuMjAxNiB1bSAxNTo0NyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBGaXhlcyBhIHJl
Z3Jlc3Npb24gaW46Cj4gZHJtL2FtZC9hbWRncHU6IFRpZHkgdXAgU0kgU01DIGNvZGUKPgo+IGJ1
ZzoKPiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD05NzgwMQo+
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfc21jLmMgfCA0ICsr
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfc21jLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9zbWMuYwo+IGluZGV4IDJjYzYyOGMuLjQ3YmJiNDAg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfc21jLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9zbWMuYwo+IEBAIC0xNDMsOSArMTQzLDkg
QEAgdm9pZCBzaV9zbWNfY2xvY2soc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5h
YmxlKQo+ICAgCXUzMiB0bXAgPSBSUkVHMzJfU01DKFNNQ19TWVNDT05fQ0xPQ0tfQ05UTF8wKTsK
PiAgIAo+ICAgCWlmIChlbmFibGUpCj4gLQkJdG1wIHw9IENLX0RJU0FCTEU7Cj4gLQllbHNlCj4g
ICAJCXRtcCAmPSB+Q0tfRElTQUJMRTsKPiArCWVsc2UKPiArCQl0bXAgfD0gQ0tfRElTQUJMRTsK
PiAgIAo+ICAgCVdSRUczMl9TTUMoU01DX1NZU0NPTl9DTE9DS19DTlRMXzAsIHRtcCk7Cj4gICB9
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
