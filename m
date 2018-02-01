From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amdgpu: make VMID assignment more fair
Date: Thu, 1 Feb 2018 17:12:49 +0800
Message-ID: <89b5e2fd-1d11-995d-1dce-584dd38f96ad@amd.com>
References: <20180131154756.3374-1-christian.koenig@amd.com>
 <2e5a2349-5036-dff7-ab06-286bcf9de9b3@amd.com>
 <d3c6258b-2015-6d11-65cf-06e6449d76c7@gmail.com>
 <a8418ef0-6bec-af57-0555-cf48b38fa09a@amd.com>
 <d4989e55-7331-9e1b-327b-8cf6789fefc3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d4989e55-7331-9e1b-327b-8cf6789fefc3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE45bm0MDLmnIgwMeaXpSAxNzowNSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBX
aXRoIHRoZSBhZGRpdGlvbiBvZiB0aGUgbXV0ZXggY2FuIEkgZ2V0IHlvdXIgcmIgb3IgYWIgZm9y
IHBhdGNoICMzIGFzIAo+IHdlbGw/IENhdXNlIHRoZW4gaXQgbG9va3MgcmVhZHkgZm9yIGNvbW1p
dC4KRmVlbCBmcmVlIHRvIGFkZCBteSBSQiBmb3IgdGhhdCBvbmUuCgpSZWdhcmRzLApEYXZpZCBa
aG91Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
