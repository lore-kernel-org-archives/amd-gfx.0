From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/54] Revert "drm/amd/display: Don't return ddc result
 and read_bytes in same return value"
Date: Tue, 10 Jul 2018 09:23:56 +0200
Message-ID: <1abb2620-10ad-e187-78ac-73213c3bb086@daenzer.net>
References: <20180710003732.16836-1-harry.wentland@amd.com>
 <20180710003732.16836-2-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180710003732.16836-2-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0xMCAwMjozNiBBTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gVGhpcyByZXZl
cnRzIGNvbW1pdCA4YTYxYmMwODVmZmFiMzA3MWM1OWVmY2JlZmY0MDQ0YzAzNGU3NDkwLgoKQSBy
ZXZlcnQgY29tbWl0IG5lZWRzIGEgcmF0aW9uYWxlICh3aHkgZGlkIHRoZSBjb21taXQgbmVlZCB0
byBiZQpyZXZlcnRlZD8pIGluIHRoZSBjb21taXQgbG9nLgoKClNpbmNlIHRoaXMgc2FtZSBjaGFu
Z2Ugd2VudCBpbnRvIDQuMTcgYXMgY29tbWl0CjAxOGQ4MmU1ZjAyZWYzNTgzNDExYmNhYTRlMDBj
Njk3ODZmNDZmMTksIHBsZWFzZSBhZGQKCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCgoKLS0g
CkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBo
dHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8
ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
