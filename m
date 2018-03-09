From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: save/restore backlight level in legacy dce
 code
Date: Fri, 9 Mar 2018 09:13:45 -0500
Message-ID: <6e76c6c7-a77d-d08c-fca5-ae3a05eb8ab6@amd.com>
References: <20180308202156.16314-1-alexander.deucher@amd.com>
 <f7b2d0c0-fd9a-46bb-d39d-609740f3866b@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f7b2d0c0-fd9a-46bb-d39d-609740f3866b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMy0wOSAwMzo0NCBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
My0wOCAwOToyMSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBTYXZlL3Jlc3RvcmUgdGhlIGJh
Y2tsaWdodCBsZXZlbCBzY3JhdGNoIHJlZ2lzdGVyIGluIFMzL1M0IHNvIHRoZQo+PiBiYWNrbGln
aHQgbGV2ZWwgY29tZXMgYmFjayBhdCB0aGUgcHJldmlvdXNseSByZXF1ZXN0ZWQgbGV2ZWwuCj4+
Cj4+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTkw
NDcKPj4gRml4ZXM6IDRlYzZlY2Y0OGM2NGQgKGRybS9hbWRncHU6IGRyb3Agc2NyYXRjaCByZWdz
IHNhdmUgYW5kIHJlc3RvcmUgZnJvbSBTMy9TNCBoYW5kbGluZykKPj4gU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IAo+IEFja2VkLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPiAKPiBNaWdodCBiZSBuaWNl
IHRvIGdldCBIYXJyeSBvciBzb21lb25lIGVsc2UgZnJvbSB0aGUgZGlzcGxheSB0ZWFtIHRvIHRh
a2UKPiBhIGxvb2sgYXMgd2VsbC4KPiAKCk5vbi1EQyBjb2RlIHBhdGggZm9yIGJhY2tsaWdodCBp
cyBjb21wbGV0ZWx5IGRpZmZlcmVudCBmb3IgYmFja2xpZ2h0IHRoYW4gREMncyBidXQgZnJvbSB3
aGF0IEkgY2FuIHNlZSBpbiBhdG9tYmlvc19lbmNvZGVyIGFuZCBnaXZlbiB0aGF0IHRoaXMgZml4
ZXMgYSBmYWxsb3V0IGR1ZSB0byBubyBsb25nZXIgc2F2aW5nIHRoZSBzY3JhdGNoIHJlZ3MgdGhp
cyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxo
YXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
