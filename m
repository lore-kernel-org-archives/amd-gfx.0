From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH umr] Fix ring offset to dword instead of bytes
Date: Wed,  8 Mar 2017 11:31:39 -0500
Message-ID: <20170308163139.20015-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VGhpcyBhbGxvd3MgeW91IHRvIHNwZWNpZnkgKHNheSkKCi1SIGdmeFsxNjozMl0gdG8gcmVhZCB3
b3JkcyAxNiB0aHJvdWdoIDMyIHdoaWNoIGlzCmNvbnNpc3RlbnQgd2l0aCBob3cgdGhlIGRhdGEg
aXMgcHJlc2VudGVkLgoKVGhpcyBwYXRjaCBhbHNvIGNvcnJlY3RseSBlbmFibGVzIHRoZSBQTTQg
ZGVjb2Rlcgp3aGVuIHNwZWNpZnlpbmcgYSByYW5nZSBvZiB3b3Jkcy4KClNpZ25lZC1vZmYtYnk6
IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBzcmMvYXBwL3JpbmdfcmVh
ZC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9zcmMvYXBwL3JpbmdfcmVhZC5jIGIvc3JjL2FwcC9yaW5nX3JlYWQuYwppbmRleCA5NzAzMTBi
OWJmNTIuLmQ2YjNkZjU4YmU0ZCAxMDA2NDQKLS0tIGEvc3JjL2FwcC9yaW5nX3JlYWQuYworKysg
Yi9zcmMvYXBwL3JpbmdfcmVhZC5jCkBAIC05Niw3ICs5NiwxMCBAQCB2b2lkIHVtcl9yZWFkX3Jp
bmcoc3RydWN0IHVtcl9hc2ljICphc2ljLCBjaGFyICpyaW5ncGF0aCkKIAkJfSBlbHNlIHsKIAkJ
CXNzY2FuZihmcm9tLCAiJSJTQ051MzIsICZzdGFydCk7CiAJCQlzc2NhbmYodG8sICIlIlNDTnUz
MiwgJmVuZCk7CisJCQlzdGFydCAqPSA0OworCQkJZW5kICo9IDQ7CiAJCQl1c2VfZGVjb2RlciA9
IDE7CisJCQlkZWNvZGVyLnBtNC5jdXJfb3Bjb2RlID0gMHhGRkZGRkZGRjsKIAkJfQogCX0KIAll
bmQgJT0gcmluZ3NpemU7Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
