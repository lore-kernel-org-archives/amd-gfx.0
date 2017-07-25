From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake: "suuport"-> "support"
Date: Tue, 25 Jul 2017 10:40:41 +0200
Message-ID: <98e76c8e-fb6e-9ee4-8188-2e290d88e653@amd.com>
References: <20170724224501.17037-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170724224501.17037-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMjUuMDcuMjAxNyB1bSAwMDo0NSBzY2hyaWViIENvbGluIEtpbmc6Cj4gRnJvbTogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPgo+IFRyaXZpYWwgZml4IHRvIHNw
ZWxsaW5nIG1pc3Rha2UgaW4gV0FSTl9PTkNFIG1lc3NhZ2UKPgo+IFNpZ25lZC1vZmYtYnk6IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9pY2FsLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNTc5NWY4MTM2OWYwLi4wNmYxMWUyYTMyYWYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xMzAxLDcgKzEzMDEs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3B0ZV91
cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAKPiAgIAkJaWYgKHBhcmFtcy0+c2hhZG93KSB7Cj4g
ICAJCQlpZiAoV0FSTl9PTkNFKHVzZV9jcHVfdXBkYXRlLAo+IC0JCQkJIkNQVSBWTSB1cGRhdGUg
ZG9lc24ndCBzdXVwb3J0IHNoYWRvdyBwYWdlcyIpKQo+ICsJCQkJIkNQVSBWTSB1cGRhdGUgZG9l
c24ndCBzdXBwb3J0IHNoYWRvdyBwYWdlcyIpKQo+ICAgCQkJCXJldHVybiAwOwo+ICAgCj4gICAJ
CQlpZiAoIXB0LT5zaGFkb3cpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
