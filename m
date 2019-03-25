From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v13 14/20] drm/amdgpu, arm64: untag user pointers in
 amdgpu_ttm_tt_get_user_pages
Date: Mon, 25 Mar 2019 22:21:34 +0000
Message-ID: <574648a3-3a05-bea7-3f4e-7d71adedf1dc__29523.774264247$1553552516$gmane$org@amd.com>
References: <cover.1553093420.git.andreyknvl@google.com>
 <017804b2198a906463d634f84777b6087c9b4a40.1553093421.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <017804b2198a906463d634f84777b6087c9b4a40.1553093421.git.andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Content-ID: <CF30E59880AD324FB34B80E1527F955F-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kate Stewart <kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Kirill A .
 Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, Eric Dumazet <edumazet-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd>
Cc: Chintan Pandya <cpandya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jacob Bramley <Jacob.Bramley-5wv7dgnIgG8@public.gmane.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan-5wv7dgnIgG8@public.gmane.org>, Szabolcs Nagy <Szabolcs.Nagy-5wv7dgnIgG8@public.gmane.org>, Kevin Brodsky <kevin.brodsky-5wv7dgnIgG8@public.gmane.org>, Evgeniy Stepanov <eugenis-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kostya Serebryany <kcc-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Luc Van Oostenryck <luc.vanoostenryck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Smith <Lee.Smith-5wv7dgnIgG8@public.gmane.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

T24gMjAxOS0wMy0yMCAxMDo1MSBhLm0uLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOg0KPiBUaGlz
IHBhdGNoIGlzIGEgcGFydCBvZiBhIHNlcmllcyB0aGF0IGV4dGVuZHMgYXJtNjQga2VybmVsIEFC
SSB0byBhbGxvdyB0bw0KPiBwYXNzIHRhZ2dlZCB1c2VyIHBvaW50ZXJzICh3aXRoIHRoZSB0b3Ag
Ynl0ZSBzZXQgdG8gc29tZXRoaW5nIGVsc2Ugb3RoZXINCj4gdGhhbiAweDAwKSBhcyBzeXNjYWxs
IGFyZ3VtZW50cy4NCj4NCj4gYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9wYWdlcygpIHVzZXMgcHJv
dmlkZWQgdXNlciBwb2ludGVycyBmb3Igdm1hDQo+IGxvb2t1cHMsIHdoaWNoIGNhbiBvbmx5IGJ5
IGRvbmUgd2l0aCB1bnRhZ2dlZCBwb2ludGVycy4NCj4NCj4gVW50YWcgdXNlciBwb2ludGVycyBp
biB0aGlzIGZ1bmN0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxh
bmRyZXlrbnZsQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDUgKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jDQo+IGluZGV4IDczZTcxZTYxZGM5OS4uODkxYjAyN2ZhMzNiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+IEBAIC03NTEsMTAgKzc1MSwx
MSBAQCBpbnQgYW1kZ3B1X3R0bV90dF9nZXRfdXNlcl9wYWdlcyhzdHJ1Y3QgdHRtX3R0ICp0dG0s
IHN0cnVjdCBwYWdlICoqcGFnZXMpDQo+ICAgCQkgKiBjaGVjayB0aGF0IHdlIG9ubHkgdXNlIGFu
b255bW91cyBtZW1vcnkgdG8gcHJldmVudCBwcm9ibGVtcw0KPiAgIAkJICogd2l0aCB3cml0ZWJh
Y2sNCj4gICAJCSAqLw0KPiAtCQl1bnNpZ25lZCBsb25nIGVuZCA9IGd0dC0+dXNlcnB0ciArIHR0
bS0+bnVtX3BhZ2VzICogUEFHRV9TSVpFOw0KPiArCQl1bnNpZ25lZCBsb25nIHVzZXJwdHIgPSB1
bnRhZ2dlZF9hZGRyKGd0dC0+dXNlcnB0cik7DQo+ICsJCXVuc2lnbmVkIGxvbmcgZW5kID0gdXNl
cnB0ciArIHR0bS0+bnVtX3BhZ2VzICogUEFHRV9TSVpFOw0KPiAgIAkJc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWE7DQo+ICAgDQo+IC0JCXZtYSA9IGZpbmRfdm1hKG1tLCBndHQtPnVzZXJwdHIp
Ow0KPiArCQl2bWEgPSBmaW5kX3ZtYShtbSwgdXNlcnB0cik7DQo+ICAgCQlpZiAoIXZtYSB8fCB2
bWEtPnZtX2ZpbGUgfHwgdm1hLT52bV9lbmQgPCBlbmQpIHsNCj4gICAJCQl1cF9yZWFkKCZtbS0+
bW1hcF9zZW0pOw0KPiAgIAkJCXJldHVybiAtRVBFUk07DQoNCldlJ2xsIG5lZWQgdG8gYmUgY2Fy
ZWZ1bCB0aGF0IHdlIGRvbid0IGJyZWFrIHlvdXIgY2hhbmdlIHdoZW4gdGhlIA0KZm9sbG93aW5n
IGNvbW1pdCBnZXRzIGFwcGxpZWQgdGhyb3VnaCBkcm0tbmV4dCBmb3IgTGludXggNS4yOg0KDQpo
dHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC9jb21taXQvP2g9ZHJtLW5l
eHQtNS4yLXdpcCZpZD05MTVkM2VlY2ZhMjM2OTNiYWM5ZTU0Y2RhY2Y4NGZiNGVmZGNjNWM0DQoN
CldvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYXBwbHkgdGhlIHVudGFnZ2luZyBpbiBhbWRncHVfdHRt
X3R0X3NldF91c2VycHRyIA0KaW5zdGVhZD8gVGhhdCB3b3VsZCBhdm9pZCB0aGlzIGNvbmZsaWN0
IGFuZCBJIHRoaW5rIGl0IHdvdWxkIGNsZWFybHkgcHV0IA0KdGhlIHVudGFnZ2luZyBpbnRvIHRo
ZSB1c2VyIG1vZGUgY29kZSBwYXRoIHdoZXJlIHRoZSB0YWdnZWQgcG9pbnRlciANCm9yaWdpbmF0
ZXMuDQoNCkluIGFtZGdwdV9nZW1fdXNlcnB0cl9pb2N0bCBhbmQgYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jIChpbml0X3VzZXJfcGFnZXMpIA0Kd2UgYWxzbyBzZXQgdXAgYW4gTU1VIG5vdGlmaWVyIHdp
dGggdGhlICh0YWdnZWQpIHBvaW50ZXIgZnJvbSB1c2VyIG1vZGUuIA0KVGhhdCBzaG91bGQgcHJv
YmFibHkgYWxzbyB1c2UgdGhlIHVudGFnZ2VkIGFkZHJlc3Mgc28gdGhhdCBNTVUgbm90aWZpZXJz
IA0KZm9yIHRoZSB1bnRhZ2dlZCBhZGRyZXNzIGdldCBjb3JyZWN0bHkgbWF0Y2hlZCB1cCB3aXRo
IHRoZSByaWdodCBCTy4gSSdkIA0KbW92ZSB0aGUgdW50YWdnaW5nIGZ1cnRoZXIgdXAgdGhlIGNh
bGwgc3RhY2sgdG8gY292ZXIgdGhhdC4gRm9yIHRoZSBHRU0gDQpjYXNlIEkgdGhpbmsgYW1kZ3B1
X2dlbV91c2VycHRyX2lvY3RsIHdvdWxkIGJlIHRoZSByaWdodCBwbGFjZS4gRm9yIHRoZSANCktG
RCBjYXNlLCBJJ2QgZG8gdGhpcyBpbiBhbWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9v
Zl9ncHUuDQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
