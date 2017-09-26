From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] Selectively spread compute rings across pipes
Date: Tue, 26 Sep 2017 12:22:44 -0400
Message-ID: <20170926162246.3200-1-andresx7@gmail.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

VGhpcyB3YXMgZGlzYWJsZWQgZHVlIHRvIGFuIE9DTCBwZXJmIHJlZ3Jlc3Npb24gYXMgZGlzY3Vz
c2VkIG9uIGFtZC1nZnguCgpUaGlzIHNlcmllcyByZS1lbmFibGVzIHRoZSBmZWF0dXJlIGZvciBB
U0lDcyB0aGF0IGFyZSBub3QgYWZmZWN0ZWQsIGFuZCBhbHNvCmludHJvZHVjZXMgYSBib290IHBh
cmFtZXRlciB0byBmb3JjZSB0aGUgcG9saWN5IG9uIG9yIG9mZi4gVGhpcyBzaG91bGQgaGVscApm
dXR1cmUgZWZmb3J0IG9mIGNvbXBhcmluZyBwZXJmb3JtYW5jZSB3aXRoIHRoZSBmZWF0dXJlIGVu
YWJsZWQvZGlzYWJsZWQuCgoKCkFuZHJlcyBSb2RyaWd1ZXogKDIpOgogIGRybS9hbWRncHU6IHVz
ZSBtdWx0aXBpcGUgY29tcHV0ZSBwb2xpY3kgb24gbm9uIFBMMTEgYXNpY3MKICBkcm0vYW1kZ3B1
OiBhZGQgb3B0aW9uIGZvciBmb3JjZSBlbmFibGUgbXVsdGlwaXBlIHBvbGljeSBmb3IgY29tcHV0
ZQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8ICAxICsKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICA0ICsrKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCiAz
IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLSAKMi45
LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
