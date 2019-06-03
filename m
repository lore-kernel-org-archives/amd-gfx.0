From: Helen Koike <helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v4 2/5] drm/amd: fix fb references in async update
Date: Mon, 3 Jun 2019 17:14:59 -0300
Message-ID: <6edde2bb-c760-884c-1b84-1f88a8752699@collabora.com>
References: <20190603165610.24614-1-helen.koike@collabora.com>
 <20190603165610.24614-3-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190603165610.24614-3-helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org
Cc: andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, daniel.vetter-/w4YWyX8dFk@public.gmane.org, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

CgpPbiA2LzMvMTkgMTo1NiBQTSwgSGVsZW4gS29pa2Ugd3JvdGU6Cj4gQXN5bmMgdXBkYXRlIGNh
bGxiYWNrcyBhcmUgZXhwZWN0ZWQgdG8gc2V0IHRoZSBvbGRfZmIgaW4gdGhlIG5ld19zdGF0ZQo+
IHNvIHByZXBhcmUvY2xlYW51cCBmcmFtZWJ1ZmZlcnMgYXJlIGJhbGFuY2VkLgo+IAo+IENhbGxp
bmcgZHJtX2F0b21pY19zZXRfZmJfZm9yX3BsYW5lKCkgKHdoaWNoIGdldHMgYSByZWZlcmVuY2Ug
b2YgdGhlIG5ldwo+IGZiIGFuZCBwdXQgdGhlIG9sZCBmYikgaXMgbm90IHJlcXVpcmVkLCBhcyBp
dCdzIHRha2VuIGNhcmUgYnkKPiBkcm1fbW9kZV9jdXJzb3JfdW5pdmVyc2FsKCkgd2hlbiBjYWxs
aW5nIGRybV9hdG9taWNfaGVscGVyX3VwZGF0ZV9wbGFuZSgpLgo+IAo+IFN1Z2dlc3RlZC1ieTog
Qm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBIZWxlbiBLb2lrZSA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT4KPiBSZXZpZXdl
ZC1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY0LjIwKwpGaXhlczogNjc0ZTc4YWNhZTBk
ICgiZHJtL2FtZC9kaXNwbGF5OiBBZGQgZmFzdCBwYXRoIGZvciBjdXJzb3IgcGxhbmUKdXBkYXRl
cyIpCgoKPiAKPiAtLS0KPiAKPiBDaGFuZ2VzIGluIHY0OiBOb25lCj4gQ2hhbmdlcyBpbiB2Mzog
Tm9uZQo+IENoYW5nZXMgaW4gdjI6Cj4gLSBhZGRlZCByZXZpZXdlZC1ieSB0YWcKPiAKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMgKy0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBp
bmRleCA0NDNiMTNlYzI2OGQuLjQwNjI0YjJjNjMwZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC00MzQ3LDggKzQz
NDcsNyBAQCBzdGF0aWMgdm9pZCBkbV9wbGFuZV9hdG9taWNfYXN5bmNfdXBkYXRlKHN0cnVjdCBk
cm1fcGxhbmUgKnBsYW5lLAo+ICAJc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3N0YXRlID0K
PiAgCQlkcm1fYXRvbWljX2dldF9vbGRfcGxhbmVfc3RhdGUobmV3X3N0YXRlLT5zdGF0ZSwgcGxh
bmUpOwo+ICAKPiAtCWlmIChwbGFuZS0+c3RhdGUtPmZiICE9IG5ld19zdGF0ZS0+ZmIpCj4gLQkJ
ZHJtX2F0b21pY19zZXRfZmJfZm9yX3BsYW5lKHBsYW5lLT5zdGF0ZSwgbmV3X3N0YXRlLT5mYik7
Cj4gKwlzd2FwKHBsYW5lLT5zdGF0ZS0+ZmIsIG5ld19zdGF0ZS0+ZmIpOwo+ICAKPiAgCXBsYW5l
LT5zdGF0ZS0+c3JjX3ggPSBuZXdfc3RhdGUtPnNyY194Owo+ICAJcGxhbmUtPnN0YXRlLT5zcmNf
eSA9IG5ld19zdGF0ZS0+c3JjX3k7Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
