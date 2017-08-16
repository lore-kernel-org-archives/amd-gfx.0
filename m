From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Implement image tiling mode support
Date: Wed, 16 Aug 2017 17:53:51 -0400
Message-ID: <f4c6d3c4-3dd9-3add-5ebc-01659a655e66@amd.com>
References: <1502513265-14281-1-git-send-email-Felix.Kuehling@amd.com>
 <1502513265-14281-5-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10iQhAvxZdwCYBK6f0fBKdpgD=f0W886awm2fJVCB=hLQ@mail.gmail.com>
 <fc37f1a8-9c12-f1da-cdab-f03b50643f19@amd.com>
 <2649fca7-9617-e434-a75a-f76d7e07d0f5@amd.com>
 <CAFCwf13bFDhL=_X-zx8AJE+0sD0Aw9z5Rku_7qDgY6VEdtS+qA@mail.gmail.com>
 <fd9a9222-f7fa-8f72-6a23-619a17a872e3@amd.com>
 <8ff456e3-94a8-7547-d01d-6aca5aaface8@daenzer.net>
 <CAFCwf11Rjt3smEjF6KAeUWCu=GCsSXAWbd1j4qA2tu+WL0C13g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf11Rjt3smEjF6KAeUWCu=GCsSXAWbd1j4qA2tu+WL0C13g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOC0xNiAwNToyNCBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4+IFRoZSBkZWFkbGlu
ZSBpcyB1c3VhbGx5IGFyb3VuZCAtcmM2IG9mIHRoZSBwcmV2aW91cyBjeWNsZSwgc28gZm9yIDQu
MTQKPj4gaXQgbWlnaHQgYmUgdGhlIGVuZCBvZiB0aGlzIHdlZWsgKGtlZXAgaW4gbWluZCB0aGF0
IERhdmUncyBpbiBBdXN0cmFsaWEsCj4+IHNvIGhpcyB3b3JrIGRheSBpcyBvdmVyIHdoZW4geW91
cnMgc3RhcnRzKS4KPj4KPiBZZWFoLCBNaWNoZWwgaXMgY29ycmVjdC4gSWYgaXRzIDEgb3IgMiB0
cml2aWFsIHBhdGNoZXMgSSBjYW4gcHJvYmFibHkKPiBnZXQgaXQgaW4gZXZlbiBkdXJpbmcgLXJj
NyBvciBzdGFydCBvZiBtZXJnZSB3aW5kb3csIGJ1dCBmb3IgdGhpcwo+IGxhcmdlIHBhdGNoLXNl
dCAtcmM1LzYgaXMgdGhlIHNhZmVyIHdheSB0byBnby4KCk9LLiBUaGVuIHRoaXMgaXMgaXQgZm9y
IDQuMTQuIEknbGwgdGFyZ2V0IHRoZSBuZXh0IHNldCBmb3IgNC4xNS4KClRoZSBuZXh0IHNldCB3
aWxsIGJlIGEgYnVuY2ggb2YgYnVnIGZpeGVzIGFuZCBzbWFsbGVyIGZlYXR1cmVzIHRoYXQKYXBw
bHkgdG8gS1YgYW5kIENaLiBJIHdhbnQgdG8gZ2V0IGFsbCB0aGUgc21hbGwgc3R1ZmYgb3V0IG9m
IHRoZSB3YXkgc28KaXQgY2FuIGJlIHJldmlld2VkIHByb3Blcmx5IHdpdGhvdXQgZ2V0dGluZyBj
b25mb3VuZGVkIHdpdGggdGhlIGJpZwpjaGFuZ2VzIGZvciBkR1BVIHN1cHBvcnQuCgpBZnRlciB0
aGF0IEknbGwgZ2V0IHRvIHRoZSBiaWcgcGllY2VzIG9mIGRHUFUgc3VwcG9ydCBmb3IgR0ZYNyBh
bmQgR0ZYOC4KCkZpbmFsbHkgSSdsbCBhZGQgR0ZYOSAoVmVnYTEwKSBzdXBwb3J0LgoKUmVnYXJk
cywKICBGZWxpeAoKPgo+IE9kZWQKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
