From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_vm_handle_moved as well
Date: Tue, 12 Sep 2017 10:31:19 +0200
Message-ID: <2c0de3bb-23c6-be8e-5c73-dcf8edf60036@vodafone.de>
References: <1505127498-21621-1-git-send-email-deathsimple@vodafone.de>
 <8f74f7cb-afca-ace1-4a7c-93c533ef2923@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8f74f7cb-afca-ace1-4a7c-93c533ef2923-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Cj4+ICAgKyAgICAgICAgaWYgKGJvX3ZhLT5iYXNlLmJvLT50Ym8ucmVzdiAhPSB2bS0+cm9vdC5i
YXNlLmJvLT50Ym8ucmVzdikgewo+IFdoZW4gd2UgZXhwYW5kIG1hcHBpbmcgZmVuY2UsIHdlIHdp
bGwgc3luYyBhbGwgbW92ZWQgdXBkYXRlIGFuZCBjbGVhciAKPiBoZXJlLCBpbnN0ZWFkIG9mIG1v
dmVkIHVwZGF0ZSBpbiBhbWRncHVfdm1fYm9fdXBkYXRlIGluIHByZXZpb3VzIHBhdGNoLgoKWWVh
aCwgdHVybmVkIG91dCB0aGlzIHBhdGNoIGFjdHVhbGx5IGRpZG4ndCB3b3JrZWQgYXMgZXhwZWN0
ZWQgYmVjYXVzZSAKdGhlIGJvX3ZhLT5sYXN0X3B0X3VwZGF0ZSBmZW5jZSBjb3VsZCBiZSBzdGFs
ZSBhbmQgb2xkIGFuZCByZXBsYWNlcyB0aGUgCm5ldyBhbmQgZnJlc2ggZmVuY2UgaW4gdm0tPmxh
c3RfdXBkYXRlIHJlc3VsdGluZyBpbiBWTSBmYXVsdHMuCgpJJ3ZlIHNlbmQgYSBWMiBvZiB0aGF0
IHBhdGNoIHllc3RlcmRheSB3aGljaCBmaXhlcyB0aGlzIChhbmQgaXMgcXVpdGUgYSAKYml0IGNs
ZWFuZXIgaW4gZ2VuZXJhbCkuCgpQbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhhdCBvbmUgaW5zdGVh
ZC4KClRoYW5rcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
