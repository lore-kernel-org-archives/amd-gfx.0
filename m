From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] High priority usermode contexts
Date: Tue,  3 Jan 2017 17:54:35 -0500
Message-ID: <1483484076-10424-1-git-send-email-andresx7@gmail.com>
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

VGhpcyBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgdGhlIGluaXRpYWwgQVBJcyBmb3IgaGlnaCBwcmlv
cml0eSBjb250ZXh0cy4KClRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGJhc2VkIG9uIHRv
cCBvZiB0aGUgU1cgc2NoZWR1bGVyLCB0aGVyZQphcmUgbm8gSFcgcHJpb3JpdGllcyBzZXQgeWV0
LgoKVGhpcyBkb2Vzbid0IHByb3ZpZGUgdGhlIHF1YWxpdHkgb2Ygc2VydmljZSB3ZSBuZWVkIGZv
ciBWUi4gRnVydGhlciBjaGFuZ2VzCnRvIGVuYWJsZSBIVyBwcmlvcml0aWVzIHdpbGwgYmUgcmVx
dWlyZWQuCgpGb3Igc29tZSBwZXJmb3JtYW5jZSBkYXRhIGNvbGxlY3RlZCB3aXRoIG11bHRpcGxl
IGFwcHMgc2VlOgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9hbWQtZ2Z4
LzIwMTYtRGVjZW1iZXIvMDA0MjU3Lmh0bWwKClRlc3QgYXBwcyBhdmFpbGFibGUgaGVyZToKaHR0
cHM6Ly9naXRodWIuY29tL2xvc3Rnb2F0L1Z1bGthbgoKUmVsYXRlZCBsaWJkcm0vcmFkdiBwYXRj
aGVzIHRvIGZvbGxvdwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
