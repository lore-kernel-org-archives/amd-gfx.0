From: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 11/20] tracing,
 arm64: untag user pointers in seq_print_user_ip
Date: Wed, 20 Mar 2019 15:51:25 +0100
Message-ID: <c9553c3a4850d43c8af0c00e97850d70428b7de7.1553093421.git.andreyknvl@google.com>
References: <cover.1553093420.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cover.1553093420.git.andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kate Stewart <kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Kirill A . Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, Eric Dumazet <edumazet-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig
Cc: Kevin Brodsky <kevin.brodsky-5wv7dgnIgG8@public.gmane.org>, Chintan Pandya <cpandya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jacob Bramley <Jacob.Bramley-5wv7dgnIgG8@public.gmane.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan-5wv7dgnIgG8@public.gmane.org>, Szabolcs Nagy <Szabolcs.Nagy-5wv7dgnIgG8@public.gmane.org>, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lee Smith <Lee.Smith-5wv7dgnIgG8@public.gmane.org>, Kostya Serebryany <kcc-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan-5wv7dgnIgG8@public.gmane.org>, Luc Van Oostenryck <luc.vanoostenryck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Evgeniy Stepanov <eugenis-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

VGhpcyBwYXRjaCBpcyBhIHBhcnQgb2YgYSBzZXJpZXMgdGhhdCBleHRlbmRzIGFybTY0IGtlcm5l
bCBBQkkgdG8gYWxsb3cgdG8KcGFzcyB0YWdnZWQgdXNlciBwb2ludGVycyAod2l0aCB0aGUgdG9w
IGJ5dGUgc2V0IHRvIHNvbWV0aGluZyBlbHNlIG90aGVyCnRoYW4gMHgwMCkgYXMgc3lzY2FsbCBh
cmd1bWVudHMuCgpzZXFfcHJpbnRfdXNlcl9pcCgpIHVzZXMgcHJvdmlkZWQgdXNlciBwb2ludGVy
cyBmb3Igdm1hIGxvb2t1cHMsIHdoaWNoCmNhbiBvbmx5IGJ5IGRvbmUgd2l0aCB1bnRhZ2dlZCBw
b2ludGVycy4KClVudGFnIHVzZXIgcG9pbnRlcnMgaW4gdGhpcyBmdW5jdGlvbi4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4KLS0tCiBrZXJu
ZWwvdHJhY2UvdHJhY2Vfb3V0cHV0LmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFj
ZV9vdXRwdXQuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9vdXRwdXQuYwppbmRleCA1NDM3M2Q5M2Uy
NTEuLjYzNzZiZWU5M2M4NCAxMDA2NDQKLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX291dHB1dC5j
CisrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9vdXRwdXQuYwpAQCAtMzcwLDYgKzM3MCw3IEBAIHN0
YXRpYyBpbnQgc2VxX3ByaW50X3VzZXJfaXAoc3RydWN0IHRyYWNlX3NlcSAqcywgc3RydWN0IG1t
X3N0cnVjdCAqbW0sCiB7CiAJc3RydWN0IGZpbGUgKmZpbGUgPSBOVUxMOwogCXVuc2lnbmVkIGxv
bmcgdm1zdGFydCA9IDA7CisJdW5zaWduZWQgbG9uZyB1bnRhZ2dlZF9pcCA9IHVudGFnZ2VkX2Fk
ZHIoaXApOwogCWludCByZXQgPSAxOwogCiAJaWYgKHMtPmZ1bGwpCkBAIC0zNzksNyArMzgwLDcg
QEAgc3RhdGljIGludCBzZXFfcHJpbnRfdXNlcl9pcChzdHJ1Y3QgdHJhY2Vfc2VxICpzLCBzdHJ1
Y3QgbW1fc3RydWN0ICptbSwKIAkJY29uc3Qgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7CiAK
IAkJZG93bl9yZWFkKCZtbS0+bW1hcF9zZW0pOwotCQl2bWEgPSBmaW5kX3ZtYShtbSwgaXApOwor
CQl2bWEgPSBmaW5kX3ZtYShtbSwgdW50YWdnZWRfaXApOwogCQlpZiAodm1hKSB7CiAJCQlmaWxl
ID0gdm1hLT52bV9maWxlOwogCQkJdm1zdGFydCA9IHZtYS0+dm1fc3RhcnQ7CkBAIC0zODgsNyAr
Mzg5LDcgQEAgc3RhdGljIGludCBzZXFfcHJpbnRfdXNlcl9pcChzdHJ1Y3QgdHJhY2Vfc2VxICpz
LCBzdHJ1Y3QgbW1fc3RydWN0ICptbSwKIAkJCXJldCA9IHRyYWNlX3NlcV9wYXRoKHMsICZmaWxl
LT5mX3BhdGgpOwogCQkJaWYgKHJldCkKIAkJCQl0cmFjZV9zZXFfcHJpbnRmKHMsICJbKzB4JWx4
XSIsCi0JCQkJCQkgaXAgLSB2bXN0YXJ0KTsKKwkJCQkJCSB1bnRhZ2dlZF9pcCAtIHZtc3RhcnQp
OwogCQl9CiAJCXVwX3JlYWQoJm1tLT5tbWFwX3NlbSk7CiAJfQotLSAKMi4yMS4wLjIyNS5nODEw
YjI2OWQxYWMtZ29vZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
