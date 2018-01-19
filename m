From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add a missing lock for drm_mm_takedown
Date: Fri, 19 Jan 2018 14:08:32 -0500
Message-ID: <19c27c46-aec9-557d-4393-f44f8e77b373@amd.com>
References: <1516388400-31591-1-git-send-email-mikita.lipski@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516388400-31591-1-git-send-email-mikita.lipski-5C7GfCeVMHo@public.gmane.org>
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
To: mikita.lipski-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
PgoKVGhhbmtzLAoKQW5kcmV5CgoKT24gMDEvMTkvMjAxOCAwMjowMCBQTSwgbWlraXRhLmxpcHNr
aUBhbWQuY29tIHdyb3RlOgo+IEZyb206IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1k
LmNvbT4KPgo+IEluc2lkZSBhbWRncHVfZ3R0X21ncl9maW5pIGFkZCBhIG1pc3NpbmcgbG9jayB0
byBtYWludGFpbgo+IGxvY2tpbmcgYmFsYW5jZQo+Cj4gU2lnbmVkLW9mZi1ieTogTWlraXRhIExp
cHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ3R0X21nci5jCj4gaW5kZXggN2FiYzFmMy4uZGE3YjFiOSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYwo+IEBAIC03NSw3ICs3NSw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2d0dF9tZ3JfaW5pdChzdHJ1Y3QgdHRtX21lbV90eXBlX21h
bmFnZXIgKm1hbiwKPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X2d0dF9tZ3JfZmluaShzdHJ1Y3QgdHRt
X21lbV90eXBlX21hbmFnZXIgKm1hbikKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2d0dF9tZ3Ig
Km1nciA9IG1hbi0+cHJpdjsKPiAtCj4gKwlzcGluX2xvY2soJm1nci0+bG9jayk7Cj4gICAJZHJt
X21tX3Rha2Vkb3duKCZtZ3ItPm1tKTsKPiAgIAlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPiAg
IAlrZnJlZShtZ3IpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
