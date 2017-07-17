From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm_amdgpu: add kernel semaphore support
Date: Mon, 17 Jul 2017 13:36:42 +1000
Message-ID: <CAPM=9twZq965gfWHPhjF-P1W6fAV5=dutH3TRmpGK2mwG7waJg@mail.gmail.com>
References: <20170706011749.4217-1-airlied@gmail.com>
 <CAPM=9tzzKNA_4GYyz1Aa0QytEJ=mZSVbvBWcGDx29pf+5292dw@mail.gmail.com>
 <8a5bb44b-c749-43e1-c58a-6c340bbf5474@vodafone.de>
 <CAPM=9twcN5y4H3yvKfUNEK+k4E3_6zoTPpWWsn+vdE2bYt7qhg@mail.gmail.com>
 <e8320749-8afb-5d64-93e4-7c64192735c5@vodafone.de>
 <CAPM=9tw2jGVmJW=VcE=t1WuOXVdj61Qj4jocZQUVGwmHe4DFGA@mail.gmail.com>
 <c8c18534-e831-4e48-603a-f72e0234ba6e@vodafone.de>
 <CAPM=9tzweASCX=Jf2S6-YEqbCnff94WkDN563TDN55v+F-0sQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzweASCX=Jf2S6-YEqbCnff94WkDN563TDN55v+F-0sQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Pgo+IEkgY2FuIHRha2UgYSBsb29rIGF0IGl0LCBJIGp1c3Qgd29uJ3QgaGF2ZSB0aW1lIHVudGls
IG5leHQgd2VlayBtb3N0IGxpa2VseS4KCkkndmUgdGFrZW4gYSBsb29rLCBhbmQgaXQncyBzZWVt
aW5nbHkgbW9yZSBjb21wbGljYXRlZCB0aGFuIEknbQpleHBlY3RpbmcgSSdkIHdhbnQgdG8gbGFu
ZCBpbiBNZXNhIGJlZm9yZSAxNy4yIHNoaXBzLCBJJ2QgcmVhbGx5CnByZWZlciB0byBqdXN0IHB1
c2ggdGhlIG5ldyBsaWJkcm1fYW1kZ3B1IGFwaSBmcm9tIHRoaXMgcGF0Y2guIElmIEkKaGF2ZSB0
byBwb3J0IGFsbCB0aGUgY3VycmVudCByYWR2IGNvZGUgdG8gdGhlIG5ldyBBUEksIEknbGwgbW9z
dApkZWZpbml0ZWx5IGdldCBzb21ldGhpbmcgd3JvbmcuCgpBZGRpbmcgdGhlIG5ldyBBUEkgc28g
ZmFyIGxvb2tzIGxpa2UKaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+YWlybGllZC9kcm0v
bG9nLz9oPWRybS1hbWRncHUtY3Mtc3VibWl0LXJhdwoKaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9w
Lm9yZy9+YWlybGllZC9kcm0vY29tbWl0Lz9oPWRybS1hbWRncHUtY3Mtc3VibWl0LXJhdyZpZD1l
N2Y4NWQwY2E2MTdmYTQxZTcyNjI0NzgwYzkwMzVkZjEzMmUyM2M0CmJlaW5nIHRoZSBBUEksIGFu
ZCB3aGV0aGVyIGl0IHNob3VsZCB0YWtlIGEgdWludDMyX3QgY29udGV4dCBpZCBvcgpjb250ZXh0
IGhhbmRsZSBsZWZ0IGFzIGFuIG9wZW4gcXVlc3Rpb24gaW4gdGhlIGxhc3QgcGF0Y2ggaW4gdGhl
CnNlcmllcy4KCkhvd2V2ZXIgdG8gaG9vayB0aGlzIGludG8gcmFkdiBvciByYWRlb25zaSB3aWxs
IHRha2UgYSBiaXQgb2YKcmV3cml0aW5nIG9mIGEgbG90IG9mIGNvZGUgdGhhdCBpcyBwcm9iYWJs
eSBhIGJpdCBtb3JlIGZyYWdpbGUgdGhhbgpJJ2QgbGlrZSBmb3IgdGhpcyBzb3J0IG9mIHN1cmdl
cnkgYXQgdGhpcyBwb2ludC4KCkknZCBhY3R1YWxseSBzdXNwZWN0IGlmIHdlIGRvIHdhbnQgdG8g
cHJvY2VlZCB3aXRoIHRoaXMgdHlwZSBvZgppbnRlcmZhY2UsIHdlIG1pZ2h0IGJlIGJldHRlciBk
b2luZyBpdCBhbGwgaW4gY29tbW9uIG1lc2EgY29kZSwgYW5kCm1heWJlIGJ5cGFzc2luZyBsaWJk
cm1fYW1kZ3B1IGFsdG9nZXRoZXIsIHdoaWNoIEkgc3VwcG9zZSB0aGUgQVBJIEkndmUKd3JpdHRl
biBoZXJlIGlzIG1vc3RseSBhbHJlYWR5IGRvaW5nLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
