From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 06/25] drm/amdgpu: Add KFD eviction fence
Date: Mon, 12 Feb 2018 14:19:40 -0500
Message-ID: <4aa6ae8d-997b-20b9-cfd3-d204de6a8614@amd.com>
References: <1517967174-21709-1-git-send-email-Felix.Kuehling@amd.com>
 <1517967174-21709-7-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10oRMFOr+0NfKXxcYN1w2uuxQRw3GDZZiVyBoUerUCC=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10oRMFOr+0NfKXxcYN1w2uuxQRw3GDZZiVyBoUerUCC=Q@mail.gmail.com>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMi0xMSAwNzo0MiBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gSGkgRmVsaXgsCj4g
RG8geW91IG9iamVjdCB0byBtZSBjaGFuZ2luZyBhbWRfa2ZkXyB0byBhbWRrZmRfIGluIHRoZSB2
YXJpb3VzCj4gc3RydWN0dXJlcyBhbmQgZnVuY3Rpb25zID8KPiBTbyBmYXIsIHdlIGRvbid0IGhh
dmUgYW55dGhpbmcgd2l0aCBwcmVmaXggb2YgYW1kX2tmZF8gc28gSSB3b3VsZCBsaWtlCj4gdG8g
a2VlcCBvbiBjb25zaXN0ZW5jeS4KCldlIHVzZSB0aGUgcHJlZml4IGFtZGdwdV9hbWRrZmRfIHRo
cm91Z2hvdXQgdGhlIEtGRC1yZWxhdGVkIGFtZGdwdSBjb2RlLgpOb3Qgc3VyZSB3aHkgd2UgZGlk
IHNvbWV0aGluZyBkaWZmZXJlbnQgaGVyZS4gSSdtIE9LIHdpdGggY2hhbmdpbmcgaXQKZm9yIGNv
bnNpc3RlbmN5LgoKVGhhbmtzLArCoCBGZWxpeAoKPgo+IE90aGVyIHRoZW4gdGhhdCwgdGhpcyBw
YXRjaCBpczoKPiBSZXZpZXdlZC1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNv
bT4KPgo+Cj4gT2RlZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
