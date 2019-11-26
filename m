From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Date: Tue, 26 Nov 2019 13:20:06 +0100
Message-ID: <74af5d01-6d42-113e-9e74-4e481bb6bf2d@gmail.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574769024-30611-4-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjYuMTEuMTkgdW0gMTI6NTAgc2NocmllYiBNb25rIExpdToKPiBvdGhlcndzZSB0aGUgZmx1
c2hfZ3B1X3RsYiB3aWxsIGhhbmcgaWYgd2UgdW5sb2FkIHRoZQo+IEtNRCBiZWN1YXNlIHRoZSBz
Y2hlZHVsZXJzIGFscmVhZHkgc3RvcHBlZAo+Cj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1v
bmsuTGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IGluZGV4
IDMyMWY4YTkuLjRiYjRkMjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYwo+IEBAIC0zMjYsNyArMzI2LDggQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dw
dV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAKPiAg
IAlpZiAoIWFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzX2VuYWJsZWQgfHwKPiAgIAkgICAgIWFkZXYt
PmliX3Bvb2xfcmVhZHkgfHwKPiAtCSAgICBhZGV2LT5pbl9ncHVfcmVzZXQpIHsKPiArCSAgICBh
ZGV2LT5pbl9ncHVfcmVzZXQgfHwKPiArCQlyaW5nLT5zY2hlZC5yZWFkeSA9PSBmYWxzZSkgewoK
R29vZCBjYXRjaCwgYnV0IHlvdSBhcmUgc29tZWhvdyBtZXNzaW5nIHVwIHRoZSBpbmRlbnRhdGlv
biBoZXJlLgoKV2l0aCB0aGF0IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gICAJCWdtY192MTBfMF9m
bHVzaF92bV9odWIoYWRldiwgdm1pZCwgQU1ER1BVX0dGWEhVQl8wLCAwKTsKPiAgIAkJbXV0ZXhf
dW5sb2NrKCZhZGV2LT5tbWFuLmd0dF93aW5kb3dfbG9jayk7Cj4gICAJCXJldHVybjsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
