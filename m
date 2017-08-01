From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add tracepoint for DMA page mapping
Date: Tue, 1 Aug 2017 13:00:37 -0400
Message-ID: <8ba09a77-9bc6-35a1-8169-246a144430e8@amd.com>
References: <20170801115131.27610-1-tom.stdenis@amd.com>
 <b4945fed-aea3-1b15-b383-26bc65307139@vodafone.de>
 <21a75bbf-e9ca-e9e9-5831-e58908911e9b@amd.com>
 <56a6ecd5-d210-cd71-0fc0-2d0ffd36ab00@vodafone.de>
 <29f09f3b-154d-70d2-f5c6-315022b408ea@amd.com>
 <67a7f3ec-fd54-e997-75a0-4d6e3d2ff908@vodafone.de>
 <ae6e3523-dd8e-a14e-9bb2-297b0114bd5e@amd.com>
 <b38d7cac-533d-7029-f73f-445a92d6b952@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b38d7cac-533d-7029-f73f-445a92d6b952-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDgvMTcgMTE6NDEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2UgY2FuIHR1
cm4gb2YgdGhlIHRyYWNlIHN1YnN5c3RlbSBkdXJpbmcgY29tcGlsZSB0aW1lIGFscmVhZHkuCj4g
Cj4gQWRkaXRpb25hbCB0byB0aGF0IHRoZSB0cmFjZSBwb2ludHMgdXNlIHNlbGYgbW9kaWZ5aW5n
IGNvZGUgdG8gbWFrZSBzdXJlIAo+IHRoYXQgdGhleSBkb24ndCBoYXZlIGFueSBvdmVyaGVhZCBh
cyBsb25nIGFzIHRoZXkgYXJlIHR1cm5lZCBvZmYuIEJ1dCBJIAo+IGRvbid0IHRoaW5rIHRoaXMg
d29ya3Mgd2l0aCB0aGUgImlmICh0cmFjZV8qX2VuYWJsZWQoKSIgYXMgd2VsbC4KPiAKPiBBbnl3
YXksIG5vdCBhIHBlcmZvcm1hbmNlIGNyaXRpY2FsIGNvZGUgcGF0aCBzbyBJIGRvbid0IHJlYWxs
eSBib3RoZXIuCgpXZWxsIGFzaWRlIGZyb20gdGhhdCB0aGlzIHdpbGwgb25seSByZWFsbHkgYmUg
dXNlZnVsIGluIHVwc3RyZWFtIGtlcm5lbHMgCndoZXJlIHdlIGRvbid0IGNvbnRyb2wgdGhlIGNv
bmZpZ3VyYXRpb24uCgpFdmVudHVhbGx5IGlmIHdlIGNvbWUgdXAgd2l0aCBhIGJldHRlciBzb2x1
dGlvbiAodG0pIHRoZW4gd2UgY2FuIHJldmVydCAKdGhpcyBjbGVhbmx5LgoKVG9tCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
