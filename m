From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterruptible
 waits for cleanup
Date: Sat, 29 Apr 2017 11:36:09 +0900
Message-ID: <73b82af4-7903-512e-fe61-f05ebf18381f@daenzer.net>
References: <mailman.1551.1493369856.21890.amd-gfx@lists.freedesktop.org>
 <MWHPR1201MB0045C097101B0EDA13F28BD9F2130@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0045C097101B0EDA13F28BD9F2130-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjgvMDQvMTcgMTE6MTIgUE0sIFhpZSwgQWxleEJpbiB3cm90ZToKPj4gQW0gMjguMDQuMjAx
NyB1bSAxMDo0NyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Pj4gRnJvbTogTWljaGVsIETDpG56
ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+Pgo+Pj4gU29tZSBvZiB0aGVzZSBwYXRocyBw
cm9iYWJseSBjYW5ub3QgYmUgaW50ZXJydXB0ZWQgYnkgYSBzaWduYWwgYW55d2F5Lgo+Pj4gVGhv
c2UgdGhhdCBjYW4gd291bGQgZmFpbCB0byBjbGVhbiB1cCB0aGluZ3MgaWYgdGhleSBhY3R1YWxs
eSBnb3QKPj4+IGludGVycnVwdGVkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+PiAKPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAKPiBBbGV4IFg6IEp1c3QgYSBy
ZW1pbmRlcjogYW1kZ3B1X3VucGluX3dvcmtfZnVuYyBpcyBjYWxsZWQgYnkgd29yayBxdWV1ZS4K
PiBTaWduYWwgaXMgYmxvY2tlZCBhbHJlYWR5LiB1bi1pbnRlcnJ1cHRpYmxlIHdhaXRpbmcgbWln
aHQgc2xvdyB0aGluZwo+IGRvd24gdmVyeSBzbGlnaHRseS4KCkhvdyBzbz8KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93
d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
