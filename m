From: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/3] Add DMCU fw loading on raven
Date: Wed, 12 Sep 2018 10:34:42 -0400
Message-ID: <20180912143445.10610-1-David.Francis@amd.com>
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
Cc: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>

djI6IG1lYXN1cmUgaW50diBvZmZzZXQgaW4gYnl0ZXMgaW5zdGVhZCBvZiB3b3JkcwoKRGF2aWQg
RnJhbmNpcyAoMyk6CiAgZHJtL2FtZDogQWRkIHVjb2RlIERNQ1Ugc3VwcG9ydAogIGRybS9hbWQ6
IEFkZCBQU1AgRE1DVSBzdXBwb3J0CiAgZHJtL2FtZDogQWRkIERNIERNQ1Ugc3VwcG9ydAoKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jICAgICB8IDIxICsrKystCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaCAgICAgfCAxMCArKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMF8wLmMgICAgICAgIHwgIDYgKysKIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDkxICsrKysrKysrKysr
KysrKysrKy0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaCB8
ICAyICsKIDUgZmlsZXMgY2hhbmdlZCwgMTI3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
