From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add the function to get the marketing name
 (v3)
Date: Tue, 8 Nov 2016 17:12:24 +0900
Message-ID: <b2a1f9f8-42e5-8cc2-4d6b-2402198fd094@daenzer.net>
References: <7d554227-df5a-5f5b-65f0-0497a45430c0@daenzer.net>
 <20161107090913.2464-1-michel@daenzer.net>
 <CACvgo53qtudiZhM2gDq9dXp1NfE6FZmKPaqEHyqPgdoDy6Y3Rg@mail.gmail.com>
 <CACvgo53Ld6R3qw-fsgPy=gVP8bfDVZqvOrmUzfAvyy2mbZK_gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo53Ld6R3qw-fsgPy=gVP8bfDVZqvOrmUzfAvyy2mbZK_gQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDgvMTEvMTYgMDE6MDIgQU0sIEVtaWwgVmVsaWtvdiB3cm90ZToKPiBPbiA3IE5vdmVtYmVy
IDIwMTYgYXQgMTE6NDMsIEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21haWwuY29tPiB3
cm90ZToKPj4gT24gNyBOb3ZlbWJlciAyMDE2IGF0IDA5OjA5LCBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPj4KPj4+ICtzdGF0aWMgc3RydWN0IGFtZGdwdV9hc2lj
X2lkX3RhYmxlX3Qgewo+Pj4gKyAgICAgICB1aW50MzJfdCBkaWQ7Cj4+PiArICAgICAgIHVpbnQz
Ml90IHJpZDsKPj4+ICsgICAgICAgY2hhciBtYXJrZXRpbmdfbmFtZVs2NF07Cj4+IFVzaW5nIGEg
Y2hhciAqIGhlcmUgbWlnaHQgYmUgYSBiZXR0ZXIuIEZyb20gYSBxdWljayBsb29rIFs2NF0gaXMg
cXVpdGUgd2FzdGVmdWwuCj4+Cj4gQnkgInF1aXRlIHdhc3RlZnVsIiBJIG1lYW50IH5kb3VibGlu
ZyB0aGUgYmluYXJ5IC50ZXh0IHNpemUuCj4gU29tZSBzYW1wbGUgbnVtYmVycyB3aGljaCBJIHNo
b3VsZCBoYXZlIG1lbnRpb25lZCBlYXJsaWVyIDotXAo+IAo+ICAgdGV4dCAgICBkYXRhICAgICBi
c3MgICAgIGRlYyAgICAgaGV4IGZpbGVuYW1lCj4gIDEwNTg3ICAgICA1NTIgICAgICAgOCAgIDEx
MTQ3ICAgIDJiOGIgLi9hLm91dC5maXhlZC1zaXplCj4gICA1MjI3ICAgICA1NTIgICAgICAgOCAg
ICA1Nzg3ICAgIDE2OWIgLi9hLm91dC5jaGFyLXN0YXIKCkdvb2QgY2F0Y2gsIHB1c2hlZCB2NCB3
aXRoIHRoaXMgY2hhbmdlZCB0byBjb25zdCBjaGFyICosIHRoYW5rcyEKCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cu
YW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
