From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: rename amdgpu_gca_config to amdgpu_gfx_config
Date: Tue, 21 Feb 2017 10:14:19 +0100
Message-ID: <7d506237-d9a1-dfab-05a1-13e3f2619a6a@vodafone.de>
References: <1487644551-7951-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487644551-7951-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMDIuMjAxNyB1bSAwMzozNSBzY2hyaWViIEp1bndlaSBaaGFuZzoKPiBTaWduZWQtb2Zm
LWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCj4gaW5kZXggZTJkNTgzYy4uZDBjMDAwOSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oCj4gQEAgLTgyNyw3ICs4MjcsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Ji
X2NvbmZpZyB7Cj4gICAJdWludDMyX3QgcmFzdGVyX2NvbmZpZ18xOwo+ICAgfTsKPiAgIAo+IC1z
dHJ1Y3QgYW1kZ3B1X2djYV9jb25maWcgewo+ICtzdHJ1Y3QgYW1kZ3B1X2dmeF9jb25maWcgewo+
ICAgCXVuc2lnbmVkIG1heF9zaGFkZXJfZW5naW5lczsKPiAgIAl1bnNpZ25lZCBtYXhfdGlsZV9w
aXBlczsKPiAgIAl1bnNpZ25lZCBtYXhfY3VfcGVyX3NoOwo+IEBAIC04NzksNyArODc5LDcgQEAg
c3RydWN0IGFtZGdwdV9nZnhfZnVuY3Mgewo+ICAgCj4gICBzdHJ1Y3QgYW1kZ3B1X2dmeCB7Cj4g
ICAJc3RydWN0IG11dGV4CQkJZ3B1X2Nsb2NrX211dGV4Owo+IC0Jc3RydWN0IGFtZGdwdV9nY2Ff
Y29uZmlnCWNvbmZpZzsKPiArCXN0cnVjdCBhbWRncHVfZ2Z4X2NvbmZpZwljb25maWc7Cj4gICAJ
c3RydWN0IGFtZGdwdV9ybGMJCXJsYzsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X21lYwkJbWVjOwo+ICAg
CXN0cnVjdCBhbWRncHVfa2lxCQlraXE7CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
