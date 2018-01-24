From: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] radeon: Make XvMC extension initialize at depth 30.
Date: Wed, 24 Jan 2018 18:19:38 +0100
Message-ID: <20180124171938.26282-2-mario.kleiner.de@gmail.com>
References: <20180124171938.26282-1-mario.kleiner.de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180124171938.26282-1-mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

U2lnbmVkLW9mZi1ieTogTWFyaW8gS2xlaW5lciA8bWFyaW8ua2xlaW5lci5kZUBnbWFpbC5jb20+
Ci0tLQogc3JjL3JhZGVvbl90ZXh0dXJlZF92aWRlby5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRl
b25fdGV4dHVyZWRfdmlkZW8uYyBiL3NyYy9yYWRlb25fdGV4dHVyZWRfdmlkZW8uYwppbmRleCA2
MzYzMWM5Li4yM2JkZmQxIDEwMDY0NAotLS0gYS9zcmMvcmFkZW9uX3RleHR1cmVkX3ZpZGVvLmMK
KysrIGIvc3JjL3JhZGVvbl90ZXh0dXJlZF92aWRlby5jCkBAIC00OTksMTEgKzQ5OSwxMSBAQCBz
dGF0aWMgWEY4NlZpZGVvRW5jb2RpbmdSZWMgRHVtbXlFbmNvZGluZ0VHWzFdID0KICAgICB9CiB9
OwogCi0jZGVmaW5lIE5VTV9GT1JNQVRTIDMKKyNkZWZpbmUgTlVNX0ZPUk1BVFMgNAogCiBzdGF0
aWMgWEY4NlZpZGVvRm9ybWF0UmVjIEZvcm1hdHNbTlVNX0ZPUk1BVFNdID0KIHsKLSAgICB7MTUs
IFRydWVDb2xvcn0sIHsxNiwgVHJ1ZUNvbG9yfSwgezI0LCBUcnVlQ29sb3J9CisgICAgezE1LCBU
cnVlQ29sb3J9LCB7MTYsIFRydWVDb2xvcn0sIHsyNCwgVHJ1ZUNvbG9yfSwgezMwLCBUcnVlQ29s
b3J9CiB9OwogCiAjZGVmaW5lIE5VTV9BVFRSSUJVVEVTIDIKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
