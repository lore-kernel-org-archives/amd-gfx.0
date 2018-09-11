From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: try allocating VRAM as power of two
Date: Tue, 11 Sep 2018 09:46:12 +0200
Message-ID: <d0af0309-e4f9-9825-fd30-9cf79ed5f823@amd.com>
References: <20180909180339.1910-1-christian.koenig@amd.com>
 <20180909180339.1910-2-christian.koenig@amd.com>
 <60b9c96a-d31d-cd61-df22-c8414f0166dc@amd.com>
 <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4@gmail.com>
 <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTEuMDkuMjAxOCB1bSAwOTozNyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDktMTEgODo0OSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBCdXQgYW5vdGhlciBx
dWVzdGlvbjogV2h5IGRvIHlvdSB3YW50IHRvIGNsZWFyIFZSQU0gb24gYWxsb2NhdGlvbj8gV2UK
Pj4gcGVyZmVjdGx5IHN1cHBvcnQgYWxsb2NhdGluZyBWUkFNIHdpdGhvdXQgY2xlYXJpbmcgaXQu
Cj4gV2hpY2ggaXMgYSBwcm9ibGVtIG9mIGl0cyBvd24sIGFzIGl0IGNhbiBsZWFrIGluZm9ybWF0
aW9uIGZyb20gb25lCj4gcHJvY2VzcyB0byBhbm90aGVyLgoKSG93IGFib3V0IGFkZGluZyBhIEFN
REdQVV9HRU1fQ1JFQVRFX1ZSQU1fU0VDUkVEIGZsYWcgd2hpY2ggdHJpZ2dlcnMgCmNsZWFyaW5n
IFZSQU0gd2hlbiB0aGUgQk8gaXMgZnJlZWQ/Cgo+IEFueXdheSwgbm90IGNsZWFyaW5nIHdoZW4g
dXNlcnNwYWNlIHNldHMgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DTEVBUkVECj4gd291bGQgYnJl
YWsgdGhlIHVzZXJzcGFjZSBBQkksIHNvIHRoYXQncyBubyBnby4KWWVhaCwgZXhhY3RseSBteSBw
b2ludC4KCldoYXQgRmVsaXggc2VlbXMgdG8gdHJ5IGlzIHRvIGF2b2lkIGNsZWFyaW5nIFZSQU0g
d2hlbiB0aGUgYWxsb2NhdGVkIAptZW1vcnkgY2FtZSBmcm9tIHRoZSBzYW1lIHByb2Nlc3MuCgpC
dXQgdGhhdCBpc24ndCB0aGUgaW50ZW50aW9uIG9mIHRoZSBBTURHUFVfR0VNX0NSRUFURV9WUkFN
X0NMRUFSRUQgZmxhZy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
