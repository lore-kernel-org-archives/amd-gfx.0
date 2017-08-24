From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: check memory allocation failure
Date: Thu, 24 Aug 2017 14:23:19 -0400
Message-ID: <CADnq5_NsFdS7dzogNVd=C_z3rCFfisST69gN8kYEWA+-bouhvQ@mail.gmail.com>
References: <20170823055236.25451-1-christophe.jaillet@wanadoo.fr>
 <9a4b653f-6445-f8d3-70c9-91ca9b059839@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9a4b653f-6445-f8d3-70c9-91ca9b059839-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "monk.liu" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBBdWcgMjMsIDIwMTcgYXQgNDozOSBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiBBbSAyMy4wOC4yMDE3IHVtIDA3OjUyIHNjaHJp
ZWIgQ2hyaXN0b3BoZSBKQUlMTEVUOgo+Pgo+PiBDaGVjayBtZW1vcnkgYWxsb2NhdGlvbiBmYWls
dXJlIGFuZCByZXR1cm4gLUVOT01FTSBpbiBzdWNoIGEgY2FzZS4KPj4KPj4gJ251bV9wb3N0X2Rl
cF9zeW5jb2Jqcycgc3RpbGwgaGFzIHRvIGJlIHNldCB0byAwIGJlZm9yZSB0aGUgdGVzdCBpbiBv
cmRlcgo+PiB0byBoYXZlIGl0IGluaXRpYWxpemVkIGlmICdhbWRncHVfY3NfcGFyc2VyX2Zpbmko
KScgaXMgY2FsbGVkIHRvIGZyZWUKPj4gcmVzb3VyY2VzLgo+Pgo+PiBUaGUgY2FsbGluZyBncmFw
aCB3b3VsZCBiZSwgaW4gc3VjaCBhIGNhc2UhCj4+ICAgICBmYWlsdXJlIGluIGFtZGdwdV9jc19w
cm9jZXNzX3N5bmNvYmpfb3V0X2RlcCgpCj4+ICAgICAgICAtLS0+IGVycm9yIGNvZGUgcmV0dXJu
ZWQgYnkgYW1kZ3B1X2NzX2RlcGVuZGVuY2llcygpCj4+ICAgICAgICAgICAtLT4gYW1kZ3B1X2Nz
X3BhcnNlcl9maW5pKCkgaXMgY2FsbGVkCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUg
SkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+Cj4KPgo+IFJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpBcHBsaWVkLiAg
dGhhbmtzIQoKQWxleAoKPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3MuYyB8IDMgKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMK
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+PiBpbmRleCAxNWQ0
YTI4ZDczYmIuLmJhYTkwZGY5MGFlYSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMKPj4gQEAgLTEwNzksNiArMTA3OSw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Nz
X3Byb2Nlc3Nfc3luY29ial9vdXRfZGVwKHN0cnVjdAo+PiBhbWRncHVfY3NfcGFyc2VyICpwLAo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBfS0VSTkVM
KTsKPj4gICAgICAgICBwLT5udW1fcG9zdF9kZXBfc3luY29ianMgPSAwOwo+PiAgICsgICAgIGlm
ICghcC0+cG9zdF9kZXBfc3luY29ianMpCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01F
TTsKPj4gKwo+PiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fZGVwczsgKytpKSB7Cj4+ICAg
ICAgICAgICAgICAgICBwLT5wb3N0X2RlcF9zeW5jb2Jqc1tpXSA9IGRybV9zeW5jb2JqX2ZpbmQo
cC0+ZmlscCwKPj4gZGVwc1tpXS5oYW5kbGUpOwo+PiAgICAgICAgICAgICAgICAgaWYgKCFwLT5w
b3N0X2RlcF9zeW5jb2Jqc1tpXSkKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
