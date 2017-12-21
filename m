From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Simplify amdgpu_lockup_timeout usage.
Date: Thu, 21 Dec 2017 18:30:10 +0100
Message-ID: <55707628-5d2e-6c78-473f-9c677e10d015@amd.com>
References: <1513194292-8416-1-git-send-email-andrey.grodzovsky@amd.com>
 <966ada12-9d57-b6bd-37a2-494f6dfa67cd@daenzer.net>
 <f5351f8f-ad38-5517-ae87-e5d8efab1839@amd.com>
 <e66e22c8-bdaa-7ce6-7d03-c93107387bcb@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e66e22c8-bdaa-7ce6-7d03-c93107387bcb-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMTIuMjAxNyB1bSAxODowOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTct
MTItMTkgMDY6NDcgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFllYWgsIHRoYXQgaXMg
YSBrbm93biBpc3N1ZSB3aGljaCBjYW1lIHRvIGZyb250IGFnYWluIGJlY2F1c2UgQW5kcmV5J3MK
Pj4gcGF0Y2ggaXMgc2xpZ2h0bHkgYnVnZ3kuCj4+Cj4+IFBsZWFzZSB0ZXN0IGFuZCByZXZpZXcg
dGhlIGF0dGFjaGVkIChvbmx5IGNvbXBpbGUgdGVzdGVkKSBmaXggZm9yCj4+IEFuZHJleSdzIHBh
dGNoLgo+Pgo+PiBTdGlsbCB3b3JraW5nIG9uIGZpbmRpbmcgdGhlIHJvb3QgY2F1c2UsIGJ1dCBz
byBmYXIgZGlkbid0IGhhZCB0aW1lIGZvcgo+PiB0aGF0Lgo+IFVuZm9ydHVuYXRlbHksIEkgaGF2
ZW4ndCBiZWVuIGFibGUgdG8gbmFycm93IGl0IGRvd24gdG8gYW55IHBhcnRpY3VsYXIKPiBwaWds
aXQgdGVzdHMuIFdoYXQgSSBjYW4gc2F5IHRob3VnaCBpcyB0aGF0IGl0J3MgdHJpZ2dlcmVkIG11
Y2ggbW9yZQo+IHF1aWNrbHkgd2hlbiBydW5uaW5nIHBpZ2xpdCB3aXRoIC0tcHJvY2Vzcy1pc29s
YXRpb24gZmFsc2UuCgpJIHRoaW5rIEknbSBhYmxlIHRvIHJlcHJvZHVjZSBpdCBub3cgYXMgd2Vs
bC4KCkkgdGhvdWdodCBhIGJpdCBhYm91dCB3aGF0IGNvdWxkIGJlIHRoZSBkaWZmZXJlbmNlIGJl
dHdlZW4gbXkgdGVzdCAKbWFjaGluZXMgYW5kIHRoZSBzeXN0ZW0geW91IGd1eXMgd2hlcmUgYWJs
ZSB0byByZXByb2R1Y2UgaXQgb24sIGJlY2F1c2UgCm9mIHRoZSBsYWNrIG9mIFZNIGZhdWx0cyBv
biBteSBzaWRlIG5vIG1hdHRlciB3aGF0IEkgZG8uCgpNeSBjb25jbHVzaW9uIHdhcyB0aGF0IGl0
IGlzIHNvbWVob3cgcmVsYXRlZCB0byB0aGUgaW5zdGFsbGVkIGFtb3VudCBvZiAKc3lzdGVtIG1l
bW9yeSBhbmQgcmVkdWNpbmcgVFRNcyBzd2FwIGxpbWl0IGluZGVlZCByZXN1bHRlZCBpbiBhIFZN
IGZhdWx0IApyYXRoZXIgcXVpY2tseS4KCkkgd2FzIG9ubHkgYWJsZSB0byByZXByb2R1Y2UgdGhp
cyBvbmNlIG5vdywgYnV0IHRoYXQgd2FzIHNvIHF1aWNrIHRoYXQgSSAKbWlnaHQgaGF2ZSBmb3Vu
ZCB0aGUgcm9vdCBjYXVzZS4KCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
