From: Christoph Haag <haagch-7lD2lakjNIixeQ3y2VaiTg@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] fix include order for present.h configure
 test
Date: Thu,  1 Mar 2018 15:07:00 +0100
Message-ID: <20180301140700.20785-1-haagch@frickel.club>
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
Cc: Christoph Haag <haagch-7lD2lakjNIixeQ3y2VaiTg@public.gmane.org>

eG9yZy1zZXJ2ZXIuaCBkZWZpbmVzIF9YU0VSVkVSNjQgd2hpY2ggaXMgdXNlZCBpbiBYLmggdG8g
Y2hvb3NlIHRoZQpjb3JyZWN0IGRlZmluaXRpb24gb2YgWElECgp0aGlzIHByZXZlbnRzIGEgZmFp
bHVyZSBpbiB0aGUgcHJlc2VudC5oIGNvbmZpZ3VyZSB0ZXN0IHRoYXQgZGlzYWJsZXMKRFJJMyBv
biBYLk9yZyAxLjIwCi0tLQogY29uZmlndXJlLmFjIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5h
YyBiL2NvbmZpZ3VyZS5hYwppbmRleCBlYTQxZjQxLi4yZGRkNzUwIDEwMDY0NAotLS0gYS9jb25m
aWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC0xOTQsOCArMTk0LDggQEAgQUNfQ0hFQ0tf
SEVBREVSUyhbbWlzeW5jc2htLmhdLCBbXSwgW10sCiBBQ19DSEVDS19IRUFERVJTKFtwcmVzZW50
LmhdLCBbXSwgW10sCiAJCSBbI2luY2x1ZGUgPFgxMS9YbWQuaD4KIAkJICNpbmNsdWRlIDxYMTEv
WHByb3RvLmg+Ci0JCSAjaW5jbHVkZSA8WDExL1guaD4KLQkJICNpbmNsdWRlICJ4b3JnLXNlcnZl
ci5oIl0pCisJCSAjaW5jbHVkZSAieG9yZy1zZXJ2ZXIuaCIKKwkJICNpbmNsdWRlIDxYMTEvWC5o
Pl0pCiAKIEFDX0NIRUNLX0hFQURFUlMoW2RyaTMuaF0sIFtdLCBbXSwKIAkJIFsjaW5jbHVkZSA8
WDExL1htZC5oPgotLSAKMi4xNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
