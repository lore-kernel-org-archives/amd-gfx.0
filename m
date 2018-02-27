From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amdgpu: should call drm_helper with dc support
Date: Tue, 27 Feb 2018 10:37:37 +0100
Message-ID: <5fab3cbe-a1a6-40f0-7123-bb5310ec5d7f@daenzer.net>
References: <1519721235-28552-1-git-send-email-Monk.Liu@amd.com>
 <1519721235-28552-4-git-send-email-Monk.Liu@amd.com>
 <9259bfa0-5b0f-10b6-7b26-396adf41d984@daenzer.net>
 <BLUPR12MB04490304A6CB9A6FD7B28E9D84C00@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04490304A6CB9A6FD7B28E9D84C00-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMi0yNyAxMDoyNiBBTSwgTGl1LCBNb25rIHdyb3RlOgo+IEknbSBub3QgZmFtaWxp
YXIgd2l0aCBEQyBzdHVmZnMsIEkgZm91bmQgd2l0aG91dCB0aGlzIHBhdGNoIERSTSBhbHdheXMg
cmVwb3J0aW5nIGVycm9yIGxpa2UgdGhpczoKClsuLi5dCgo+IFsgICA4OS45MzY1MTRdIFtkcm06
ZHJtX2hlbHBlcl9kaXNhYmxlX3VudXNlZF9mdW5jdGlvbnMgW2RybV9rbXNfaGVscGVyXV0gKkVS
Uk9SKiBDYWxsZWQgZm9yIGF0b21pYyBkcml2ZXIsIHRoaXMgaXMgbm90IHdoYXQgeW91IHdhbnQu
CgoiYXRvbWljIGRyaXZlciIgbWVhbnMgREMgaXMgZW5hYmxlZCwgaW4gd2hpY2ggY2FzZQpkcm1f
aGVscGVyX2Rpc2FibGVfdW51c2VkX2Z1bmN0aW9ucyBzaG91bGRuJ3QgaGF2ZSBiZWVuIGNhbGxl
ZC4KCk1heWJlIHRoZSBpc3N1ZSBpcyB0aGF0IERSSVZFUl9BVE9NSUMgaXMgYSBkcml2ZXIgZmxh
Zywgd2hlcmVhcyBEQyBjYW4KYmUgZW5hYmxlZCBvciBub3QgcGVyIGRldmljZS4gU2VlIHRoZSBk
aXNjdXNzaW9uIG9uCmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8yMDAz
MDQvIC4KCk1lYW53aGlsZSwgTkFLIGZvciB0aGlzIHBhdGNoLgoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
