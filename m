From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't try to unreserve NULL pointer
Date: Mon, 17 Sep 2018 14:41:48 -0400
Message-ID: <4304faa2-5777-9d0a-c8e8-b00e431238f0@amd.com>
References: <20180917180724.1803-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180917180724.1803-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE4LTA5LTE3IDAyOjA3IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IERvbid0
IHRyeSB0byB1bnJlc2VydmUgYSBCTyB3ZSBkb2Vzbid0IGFsbG9jYXRlZC4KPgo+IEZpeGVzOiAw
NzAxMmZkZDQ5N2UgZHJtL2FtZGdwdTogZG9uJ3QgYWxsb2NhdGUgemVybyBzaXplZCBrZXJuZWwg
Qk9zCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
IGluZGV4IDg0ZDgyZDUzODJmOS4uYzEzODdlZmMwYzkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IEBAIC0zNDgsNyArMzQ4LDggQEAgaW50IGFt
ZGdwdV9ib19jcmVhdGVfa2VybmVsKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCWlm
IChyKQo+ICAgCQlyZXR1cm4gcjsKPiAgIAo+IC0JYW1kZ3B1X2JvX3VucmVzZXJ2ZSgqYm9fcHRy
KTsKPiArCWlmICgqYm9fcHRyKQpDYW4gd2UgcHV0IHRoaXMgY2hlY2sgaW5zaWRlIHR0bV9ib191
bnJlc2VydmU/CkphbWVzIFpodQo+ICsJCWFtZGdwdV9ib191bnJlc2VydmUoKmJvX3B0cik7Cj4g
ICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
