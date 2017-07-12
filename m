From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/amdgpu: trace setting VM page tables with the CPU
 as well
Date: Wed, 12 Jul 2017 16:27:13 -0400
Message-ID: <eb2912c8-6f63-8823-88a2-13108543cfcb@amd.com>
References: <1499848308-1441-1-git-send-email-deathsimple@vodafone.de>
 <1499848308-1441-4-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499848308-1441-4-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCk9u
IDE3LTA3LTEyIDA0OjMxIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IEhhbmR5IGZvciBkZWJ1
Z2dpbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGRiMmRlZGUuLmY1MmEzNTggMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC05ODEsNiArOTgx
LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2NwdV9zZXRfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3B0
ZV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gIAl1bnNpZ25lZCBpbnQgaTsKPiAgCXVpbnQ2NF90
IHZhbHVlOwo+ICAKPiArCXRyYWNlX2FtZGdwdV92bV9zZXRfcHRlcyhwZSwgYWRkciwgY291bnQs
IGluY3IsIGZsYWdzKTsKPiArCj4gIAlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewo+ICAJ
CXZhbHVlID0gcGFyYW1zLT5wYWdlc19hZGRyID8KPiAgCQkJYW1kZ3B1X3ZtX21hcF9nYXJ0KHBh
cmFtcy0+cGFnZXNfYWRkciwgYWRkcikgOgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
