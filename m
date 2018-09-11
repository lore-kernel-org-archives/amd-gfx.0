From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/11] drm/amdgpu: try allocating VRAM as power of two
Date: Tue, 11 Sep 2018 09:37:50 +0200
Message-ID: <46b7da24-4b04-7daf-e6c3-07e10ecb6fd6@daenzer.net>
References: <20180909180339.1910-1-christian.koenig@amd.com>
 <20180909180339.1910-2-christian.koenig@amd.com>
 <60b9c96a-d31d-cd61-df22-c8414f0166dc@amd.com>
 <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9b61bb4c-4721-c8af-0810-4ecc18ed1ea4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOS0xMSA4OjQ5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gCj4gQnV0
IGFub3RoZXIgcXVlc3Rpb246IFdoeSBkbyB5b3Ugd2FudCB0byBjbGVhciBWUkFNIG9uIGFsbG9j
YXRpb24/IFdlCj4gcGVyZmVjdGx5IHN1cHBvcnQgYWxsb2NhdGluZyBWUkFNIHdpdGhvdXQgY2xl
YXJpbmcgaXQuCgpXaGljaCBpcyBhIHByb2JsZW0gb2YgaXRzIG93biwgYXMgaXQgY2FuIGxlYWsg
aW5mb3JtYXRpb24gZnJvbSBvbmUKcHJvY2VzcyB0byBhbm90aGVyLgoKQW55d2F5LCBub3QgY2xl
YXJpbmcgd2hlbiB1c2Vyc3BhY2Ugc2V0cyBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFSRUQK
d291bGQgYnJlYWsgdGhlIHVzZXJzcGFjZSBBQkksIHNvIHRoYXQncyBubyBnby4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
