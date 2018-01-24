From: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] Add missing depth 30 -> cpp=4 handling for DRI2.
Date: Wed, 24 Jan 2018 18:19:37 +0100
Message-ID: <20180124171938.26282-1-mario.kleiner.de@gmail.com>
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
Cc: mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

TWlzc2luZyB0aGlzIGFwcGFyZW50bHkgZGlkbid0IGNhdXNlIGFueSBpbGwgc2lkZSBlZmZlY3Rz
LCBvbmx5IGEgYml0IG9mCmNvbmZ1c2lvbiB3aGVuIGxvb2tpbmcgYXQgeHRyYWNlJ3Mgb2YgRFJJ
MiBjbGllbnRzLgoKU2lnbmVkLW9mZi1ieTogTWFyaW8gS2xlaW5lciA8bWFyaW8ua2xlaW5lci5k
ZUBnbWFpbC5jb20+Ci0tLQogc3JjL3JhZGVvbl9kcmkyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRlb25fZHJpMi5jIGIvc3JjL3Jh
ZGVvbl9kcmkyLmMKaW5kZXggYjU2OWJiNC4uNmRjZTJjMSAxMDA2NDQKLS0tIGEvc3JjL3JhZGVv
bl9kcmkyLmMKKysrIGIvc3JjL3JhZGVvbl9kcmkyLmMKQEAgLTEyNSw2ICsxMjUsNyBAQCByYWRl
b25fZHJpMl9jcmVhdGVfYnVmZmVyMihTY3JlZW5QdHIgcFNjcmVlbiwKIAkgICAgY3BwID0gMjsK
IAkgICAgYnJlYWs7CiAJY2FzZSAyNDoKKwljYXNlIDMwOgogCSAgICBjcHAgPSA0OwogCSAgICBi
cmVhazsKIAlkZWZhdWx0OgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
