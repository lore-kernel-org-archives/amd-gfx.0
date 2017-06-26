From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 5/8] drm/amdgpu: move priority decay logic into
 amd_sched_priority_ctr
Date: Mon, 26 Jun 2017 15:32:22 +0200
Message-ID: <b86706a7-cdcd-8eaa-197a-9e78b2f16515@vodafone.de>
References: <20170608220623.9002-1-andresx7@gmail.com>
 <20170608220623.9002-6-andresx7@gmail.com>
 <71de1089-f4c1-47c4-c82f-da15ac43506e@vodafone.de>
 <ea42b3d8-cc3f-88f7-7c3d-46cf6dacf0a7@gmail.com>
 <5bbec90f-4746-c314-cca4-d33f4701615f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5bbec90f-4746-c314-cca4-d33f4701615f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U29ycnkgZm9yIHRoZSBkZWxheSwgYmFjayBmcm9tIGEgcmF0aGVyIGxvbmcgc2ljayBsZWF2ZSB0
b2RheSBhbmQgdHJ5aW5nIAp0byBjYXRjaCB1cCB3aXRoIG15IHdvcmsuCgo+IFF1aWNrIHBpbmcg
b24gdGhlIHF1ZXJ5IGFib3ZlLiBUaGUgcXVlcnkgY2FuIGJlIHN1bW1hcml6ZWQgYXM6IHdoaWNo
IAo+IGlvY3RsIGludGVyZmFjZSBkbyB3ZSBwcmVmZXIgZm9yIHRoZSBvdmVycmlkZT8KPgo+ICAg
KiBBTURHUFVfU0NIRURfT1BfUFJPQ0VTU19QUklPUklUWV9HRVQvUFVUIC0gcmVmY291bnRlZCBv
dmVycmlkZQo+Cj4gb3IKPgo+ICAgKiBBTURHUFVfU0NIRURfT1BfUFJPQ0VTU19QUklPUklUWV9T
RVQgLSBzaW1wbGUgc2V0CgpQbGVhc2Uga2VlcCBpdCBzaW1wbGUgYW5kIHN0dXBpZC4gTm8gZXh0
cmEgZmlkZGxpbmcgaGVyZSwgdGhhdCBzdHVmZiBpcyAKY29tcGxpY2F0ZWQgZW5vdWdoLgoKU28g
SSB3b3VsZCBzdHJvbmdseSBzdWdnZXN0IHRvIGhhdmUgYSBzaW1wbGUgc2V0IGludGVyZmFjZSB3
aGljaCB0aGUgRFJNIAptYXN0ZXIgY2FuIHVzZSB0byBzZXQgdGhlIHByaW9yaXR5LgoKSWYgd2Ug
aGF2ZSBtdWx0aXBsZSBEUk0gbWFzdGVycyB3aGljaCBmZWVsIHJlc3BvbnNpYmxlIGZvciB0aGlz
IHRoZXkgCnNob3VsZCB0byBzeW5jIHVwIGluIHVzZXJzcGFjZSB3aGF0IHRvIGRvLgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
