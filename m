From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] drm/ttm: remove the backing store if no placement is given
Date: Wed, 11 Apr 2018 15:39:57 +0200
Message-ID: <20180411133959.4257-3-christian.koenig@amd.com>
References: <20180411133959.4257-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180411133959.4257-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGlwZWxpbmUgcmVtb3ZhbCBvZiB0aGUgQk9zIGJhY2tpbmcgc3RvcmUgd2hlbiB0aGUgcGxhY2Vt
ZW50IGlzIGdpdmVuCmR1cmluZyB2YWxpZGF0aW9uLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKaW5kZXggOThlMDZmOGJmMjNiLi4xN2U4MjFmMDFkMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm8uYwpAQCAtMTA3OCw2ICsxMDc4LDE4IEBAIGludCB0dG1fYm9fdmFs
aWRhdGUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAl1aW50MzJfdCBuZXdfZmxhZ3M7
CiAKIAlyZXNlcnZhdGlvbl9vYmplY3RfYXNzZXJ0X2hlbGQoYm8tPnJlc3YpOworCisJLyoKKwkg
KiBSZW1vdmUgdGhlIGJhY2tpbmcgc3RvcmUgaWYgbm8gcGxhY2VtZW50IGlzIGdpdmVuLgorCSAq
LworCWlmICghcGxhY2VtZW50LT5udW1fcGxhY2VtZW50ICYmICFwbGFjZW1lbnQtPm51bV9idXN5
X3BsYWNlbWVudCkgeworCQlyZXQgPSB0dG1fYm9fcGlwZWxpbmVfZ3V0dGluZyhibyk7CisJCWlm
IChyZXQpCisJCQlyZXR1cm4gcmV0OworCisJCXJldHVybiB0dG1fdHRfY3JlYXRlKGJvLCBmYWxz
ZSk7CisJfQorCiAJLyoKIAkgKiBDaGVjayB3aGV0aGVyIHdlIG5lZWQgdG8gbW92ZSBidWZmZXIu
CiAJICovCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
