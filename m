From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Integer overflows in ioctl
Date: Wed, 25 Apr 2018 12:21:55 +0300
Message-ID: <20180425092155.ibca4sdsxr553ouv@mwanda>
References: <20180424133549.GB10167@mwanda>
 <e2b7b3c1-cadb-330f-53a8-57568d4bc877@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e2b7b3c1-cadb-330f-53a8-57568d4bc877-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBBcHIgMjQsIDIwMTggYXQgMDI6NTg6MTBQTSAtMDQwMCwgRmVsaXggS3VlaGxpbmcg
d3JvdGU6Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPgo+IAo+IFdlIGNvdWxkIHByb2JhYmx5IGFkZCBhIHNhbml0eSBjaGVjayBmb3Igbl9kZXZp
Y2VzIHRvIGF2b2lkIHVzZXIgbW9kZQo+IGNhdXNpbmcgZXhjZXNzaXZlIG1lbW9yeSBhbGxvY2F0
aW9ucyBpbiB0aGUga2VybmVsLiBUaGVyZSBpcyBubyBnb29kCj4gcmVhc29uIGZvciB0aGlzIHRv
IGJlIGJpZ2dlciB0aGFuIHRoZSBudW1iZXIgb2YgR1BVcyBpbiB0aGUgc3lzdGVtLiBUaGUKPiBt
YXhpbXVtIG51bWJlciBvZiBHUFVzIHN1cHBvcnRlZCBkdWUgdG8gZGV2aWNlIG1pbm9yIGxpbWl0
IGluIERSTSBpcyAxMjguCj4gCgoxMjggaXMgc29ydCBvZiBhIG1hZ2ljIG51bWJlci4gIElzIHRo
ZXJlIGEgTUFYX0dQVSBkZWZpbmUgb3Igc29tZXRoaW5nPwoKcmVnYXJkcywKZGFuIGNhcnBlbnRl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
