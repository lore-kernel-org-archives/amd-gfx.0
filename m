From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] [reference] Disable implicit sync for non-wsi bos
Date: Tue, 19 Sep 2017 11:49:10 -0400
Message-ID: <20170919154912.29916-1-andresx7@gmail.com>
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
Cc: airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org, andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

VGhpcyBpcyBhIHJlZmVyZW5jZSBwYXRjaCBzZXJpZXMgZm9yIHRoZSBrZXJuZWwgc2VyaWVzOgoi
ZHJtL2FtZGdwdTogaW50cm9kdWNlIEFNREdQVV9HRU1fQ1JFQVRFX0VYUExJQ0lUX1NZTkMgdjIi
CgpBbmRyZXMgUm9kcmlndWV6ICgyKToKICByYWR2OiBmYWN0b3Igb3V0IHJhZHZfYWxsb2NfbWVt
b3J5CiAgcmFkdjogZGlzYWJsZSBpbXBsaWNpdCBzeW5jIGZvciByYWR2IGFsbG9jYXRlZCBib3Mg
djIKCiBzcmMvYW1kL3Z1bGthbi9yYWR2X2RldmljZS5jICAgICAgICAgICAgICAgICAgfCAyMiAr
KysrKysrKysrKysrKysrKy0tLS0tCiBzcmMvYW1kL3Z1bGthbi9yYWR2X3ByaXZhdGUuaCAgICAg
ICAgICAgICAgICAgfCAxMSArKysrKysrKysrKwogc3JjL2FtZC92dWxrYW4vcmFkdl9yYWRlb25f
d2luc3lzLmggICAgICAgICAgIHwgIDEgKwogc3JjL2FtZC92dWxrYW4vcmFkdl93c2kuYyAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgKystCiBzcmMvYW1kL3Z1bGthbi93aW5zeXMvYW1kZ3B1L3Jh
ZHZfYW1kZ3B1X2JvLmMgfCAgMiArKwogNSBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
