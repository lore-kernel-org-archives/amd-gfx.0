From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/pp: remove polaris10_smc/smumgr split.
Date: Mon, 9 Oct 2017 15:55:33 -0400
Message-ID: <CADnq5_NJCVF_6Xy6yaUtSVnmGeOU=YQgXR4yswaHM+cz1HXz+Q@mail.gmail.com>
References: <1507538622-5362-1-git-send-email-Rex.Zhu@amd.com>
 <1507538622-5362-5-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507538622-5362-5-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBPY3QgOSwgMjAxNyBhdCA0OjQzIEFNLCBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+
IHdyb3RlOgo+IG1vdmUgZnVuY3Rpb25zIGluIHBvbGFyaXNfc21jLmMgdG8KPiBwb2xhcmlzMTBf
c211bWdyLmMgYW5kIG1ha2UgYWxsIGZ1bmN0aW9ucyBpbgo+IHBvbGFyaXMxMF9zbXVtZ3IuYyBz
dGF0aWMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Cj4KPiBD
aGFuZ2UtSWQ6IElhOTkwZmMyOTE0OGZkN2M0ZDliMThhNWVmOWMyZmY1NDEwY2M5MDA0Cj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9NYWtlZmlsZSAgICAgIHwg
ICAgMiArLQo+ICAuLi4vZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc21j
LmMgICB8IDIzNTQgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgLi4uL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVtZ3IvcG9sYXJpczEwX3NtYy5oICAgfCAgIDQ0IC0KPiAgLi4uL2RybS9hbWQvcG93
ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmMgICAgfCAyMjI2ICsrKysrKysrKysrKysr
KysrLQo+ICA0IGZpbGVzIGNoYW5nZWQsIDIyMjYgaW5zZXJ0aW9ucygrKSwgMjQwMCBkZWxldGlv
bnMoLSkKPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdW1nci9wb2xhcmlzMTBfc21jLmMKPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc21jLmgKClNlcmllcyBpczoKUmV2
aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
