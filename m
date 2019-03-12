From: Helen Koike <helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 2/5] drm/amd: fix fb references in async update
Date: Mon, 11 Mar 2019 23:22:00 -0300
Message-ID: <20190312022204.2775-3-helen.koike@collabora.com>
References: <20190312022204.2775-1-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190312022204.2775-1-helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
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
Cc: andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, daniel.vetter-/w4YWyX8dFk@public.gmane.org, David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>, Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Helen Koike <helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

QXN5bmMgdXBkYXRlIGNhbGxiYWNrcyBhcmUgZXhwZWN0ZWQgdG8gc2V0IHRoZSBvbGRfZmIgaW4g
dGhlIG5ld19zdGF0ZQpzbyBwcmVwYXJlL2NsZWFudXAgZnJhbWVidWZmZXJzIGFyZSBiYWxhbmNl
ZC4KCkNhbGxpbmcgZHJtX2F0b21pY19zZXRfZmJfZm9yX3BsYW5lKCkgKHdoaWNoIGdldHMgYSBy
ZWZlcmVuY2Ugb2YgdGhlIG5ldwpmYiBhbmQgcHV0IHRoZSBvbGQgZmIpIGlzIG5vdCByZXF1aXJl
ZCwgYXMgaXQncyB0YWtlbiBjYXJlIGJ5CmRybV9tb2RlX2N1cnNvcl91bml2ZXJzYWwoKSB3aGVu
IGNhbGxpbmcgZHJtX2F0b21pY19oZWxwZXJfdXBkYXRlX3BsYW5lKCkuCgpTdWdnZXN0ZWQtYnk6
IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEhlbGVuIEtvaWtlIDxoZWxlbi5rb2lrZUBjb2xsYWJvcmEuY29tPgpSZXZpZXdlZC1i
eTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoKLS0t
CgpDaGFuZ2VzIGluIHYyOgotIGFkZGVkIHJldmlld2VkLWJ5IHRhZwoKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICstLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IDNhNmY1OTVmMjk1ZS4u
YmMwMjgwMDI1NGJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTM3NjAsOCArMzc2MCw3IEBAIHN0YXRpYyB2b2lkIGRtX3Bs
YW5lX2F0b21pY19hc3luY191cGRhdGUoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsCiAJc3RydWN0
IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3N0YXRlID0KIAkJZHJtX2F0b21pY19nZXRfb2xkX3BsYW5l
X3N0YXRlKG5ld19zdGF0ZS0+c3RhdGUsIHBsYW5lKTsKIAotCWlmIChwbGFuZS0+c3RhdGUtPmZi
ICE9IG5ld19zdGF0ZS0+ZmIpCi0JCWRybV9hdG9taWNfc2V0X2ZiX2Zvcl9wbGFuZShwbGFuZS0+
c3RhdGUsIG5ld19zdGF0ZS0+ZmIpOworCXN3YXAocGxhbmUtPnN0YXRlLT5mYiwgbmV3X3N0YXRl
LT5mYik7CiAKIAlwbGFuZS0+c3RhdGUtPnNyY194ID0gbmV3X3N0YXRlLT5zcmNfeDsKIAlwbGFu
ZS0+c3RhdGUtPnNyY195ID0gbmV3X3N0YXRlLT5zcmNfeTsKLS0gCjIuMjAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
