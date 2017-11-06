From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: small cleanup in destruct()
Date: Mon, 6 Nov 2017 09:44:14 +0100
Message-ID: <031c92ca-86b0-718d-bf93-18d50db00ce9@amd.com>
References: <20171106070733.owgzad3bpuabfkkk@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171106070733.owgzad3bpuabfkkk@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

QW0gMDYuMTEuMjAxNyB1bSAwODowNyBzY2hyaWViIERhbiBDYXJwZW50ZXI6Cj4gU3RhdGljIGFu
YWx5c2lzIHRvb2xzIGdldCBhbm5veWVkIHRoYXQgd2UgZG9uJ3QgaW5kZW50IHRoaXMgaWYKPiBz
dGF0ZW1lbnQuICBBY3R1YWxseSwgdGhlIGlmIHN0YXRlbWVudCBpc24ndCByZXF1aXJlZCBiZWNh
dXNlIGtmcmVlKCkKPiBjYW4gaGFuZGxlIE5VTEwgcG9pbnRlcnMganVzdCBmaW5lLiAgVGhlIERD
RTExMFNUUkVOQ19GUk9NX1NUUkVOQygpCj4gbWFjcm8gaXMgYSB3cmFwcGVyIGFyb3VuZCBjb250
YWluZXJfb2YoKSBidXQgaXQncyBiYXNpY2FsbHkgYSBuby1vcCBvciBhCj4gY2FzdC4gIEFueXdh
eSwgaXQncyBub3QgcmVhbGx5IGFwcHJvcHJpYXRlIGhlcmUgc28gaXQgc2hvdWxkIGJlIHJlbW92
ZWQKPiBhcyB3ZWxsLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gdjI6IGluIHYxIEkganVzdCBhZGRlZCBhIHRhYgo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9y
ZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jl
c291cmNlLmMKPiBpbmRleCBkOTExNTkwZDA4YmMuLjRjNGJkNzJkNGU0MCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfcmVzb3VyY2UuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9yZXNvdXJj
ZS5jCj4gQEAgLTcyNSwxMCArNzI1LDggQEAgc3RhdGljIHZvaWQgZGVzdHJ1Y3Qoc3RydWN0IGRj
bjEwX3Jlc291cmNlX3Bvb2wgKnBvb2wpCj4gICAJCX0KPiAgIAl9Cj4gICAKPiAtCWZvciAoaSA9
IDA7IGkgPCBwb29sLT5iYXNlLnN0cmVhbV9lbmNfY291bnQ7IGkrKykgewo+IC0JCWlmIChwb29s
LT5iYXNlLnN0cmVhbV9lbmNbaV0gIT0gTlVMTCkKPiAtCQlrZnJlZShEQ0UxMTBTVFJFTkNfRlJP
TV9TVFJFTkMocG9vbC0+YmFzZS5zdHJlYW1fZW5jW2ldKSk7Cj4gLQl9Cj4gKwlmb3IgKGkgPSAw
OyBpIDwgcG9vbC0+YmFzZS5zdHJlYW1fZW5jX2NvdW50OyBpKyspCj4gKwkJa2ZyZWUocG9vbC0+
YmFzZS5zdHJlYW1fZW5jW2ldKTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBwb29sLT5iYXNl
LmF1ZGlvX2NvdW50OyBpKyspIHsKPiAgIAkJaWYgKHBvb2wtPmJhc2UuYXVkaW9zW2ldKQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
