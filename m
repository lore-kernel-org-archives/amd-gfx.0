From: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 13/20] bpf,
 arm64: untag user pointers in stack_map_get_build_id_offset
Date: Wed, 20 Mar 2019 15:51:27 +0100
Message-ID: <09d6b8e5c8275de85c7aba716578fbcb3cbce924.1553093421.git.andreyknvl__26468.6213269428$1553093624$gmane$org@google.com>
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
cmd1bWVudHMuCgpzdGFja19tYXBfZ2V0X2J1aWxkX2lkX29mZnNldCgpIHVzZXMgcHJvdmlkZWQg
dXNlciBwb2ludGVycyBmb3Igdm1hCmxvb2t1cHMsIHdoaWNoIGNhbiBvbmx5IGJ5IGRvbmUgd2l0
aCB1bnRhZ2dlZCBwb2ludGVycy4KClVudGFnIHVzZXIgcG9pbnRlcnMgaW4gdGhpcyBmdW5jdGlv
biBmb3IgZG9pbmcgdGhlIGxvb2t1cCBhbmQKY2FsY3VsYXRpbmcgdGhlIG9mZnNldCwgYnV0IHNh
dmUgYXMgaXMgaW4gdGhlIGJwZl9zdGFja19idWlsZF9pZApzdHJ1Y3QuCgpTaWduZWQtb2ZmLWJ5
OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+Ci0tLQoga2VybmVsL2Jw
Zi9zdGFja21hcC5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9zdGFja21hcC5jIGIva2Vy
bmVsL2JwZi9zdGFja21hcC5jCmluZGV4IDk1MGFiMmYyODkyMi4uYmI4OTM0MWQzZmFmIDEwMDY0
NAotLS0gYS9rZXJuZWwvYnBmL3N0YWNrbWFwLmMKKysrIGIva2VybmVsL2JwZi9zdGFja21hcC5j
CkBAIC0zMjAsNyArMzIwLDkgQEAgc3RhdGljIHZvaWQgc3RhY2tfbWFwX2dldF9idWlsZF9pZF9v
ZmZzZXQoc3RydWN0IGJwZl9zdGFja19idWlsZF9pZCAqaWRfb2ZmcywKIAl9CiAKIAlmb3IgKGkg
PSAwOyBpIDwgdHJhY2VfbnI7IGkrKykgewotCQl2bWEgPSBmaW5kX3ZtYShjdXJyZW50LT5tbSwg
aXBzW2ldKTsKKwkJdTY0IHVudGFnZ2VkX2lwID0gdW50YWdnZWRfYWRkcihpcHNbaV0pOworCisJ
CXZtYSA9IGZpbmRfdm1hKGN1cnJlbnQtPm1tLCB1bnRhZ2dlZF9pcCk7CiAJCWlmICghdm1hIHx8
IHN0YWNrX21hcF9nZXRfYnVpbGRfaWQodm1hLCBpZF9vZmZzW2ldLmJ1aWxkX2lkKSkgewogCQkJ
LyogcGVyIGVudHJ5IGZhbGwgYmFjayB0byBpcHMgKi8KIAkJCWlkX29mZnNbaV0uc3RhdHVzID0g
QlBGX1NUQUNLX0JVSUxEX0lEX0lQOwpAQCAtMzI4LDcgKzMzMCw3IEBAIHN0YXRpYyB2b2lkIHN0
YWNrX21hcF9nZXRfYnVpbGRfaWRfb2Zmc2V0KHN0cnVjdCBicGZfc3RhY2tfYnVpbGRfaWQgKmlk
X29mZnMsCiAJCQltZW1zZXQoaWRfb2Zmc1tpXS5idWlsZF9pZCwgMCwgQlBGX0JVSUxEX0lEX1NJ
WkUpOwogCQkJY29udGludWU7CiAJCX0KLQkJaWRfb2Zmc1tpXS5vZmZzZXQgPSAodm1hLT52bV9w
Z29mZiA8PCBQQUdFX1NISUZUKSArIGlwc1tpXQorCQlpZF9vZmZzW2ldLm9mZnNldCA9ICh2bWEt
PnZtX3Bnb2ZmIDw8IFBBR0VfU0hJRlQpICsgdW50YWdnZWRfaXAKIAkJCS0gdm1hLT52bV9zdGFy
dDsKIAkJaWRfb2Zmc1tpXS5zdGF0dXMgPSBCUEZfU1RBQ0tfQlVJTERfSURfVkFMSUQ7CiAJfQot
LSAKMi4yMS4wLjIyNS5nODEwYjI2OWQxYWMtZ29vZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
