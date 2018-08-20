From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 5/5] drm/amdgpu:add VCN booting with firmware loaded by
 PSP
Date: Mon, 20 Aug 2018 17:06:45 +0200
Message-ID: <e5a248e4-5a63-b801-d625-800c7fcf0a8d@daenzer.net>
References: <1533832302-21440-1-git-send-email-James.Zhu@amd.com>
 <1533832302-21440-5-git-send-email-James.Zhu@amd.com>
 <18e7213d-1d9e-c613-43bd-fe735a9de130@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <18e7213d-1d9e-c613-43bd-fe735a9de130-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Likun.Gao-5C7GfCeVMHo@public.gmane.org, james.zhu-5C7GfCeVMHo@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOC0xOCAwMToyNSBBTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gUk9DbSBDUUUg
aXMgc2VlaW5nIHdoYXQgbG9va3MgbGlrZSBoYW5ncyBkdXJpbmcgYW1kZ3B1IGluaXRpYWxpemF0
aW9uIG9uCj4gUmF2ZW4gYW5kIFZlZ2EyMC4gQW1kZ3B1IGJhc2ljYWxseSBzdG9wcyBwcmludGlu
ZyBtZXNzYWdlcyB3aGlsZSB0cnlpbmcKPiB0byBsb2FkIFZDTiBmaXJtd2FyZS4gSXQgbmV2ZXIg
Y29tcGxldGVzIGluaXRpYWxpemF0aW9uLCBidXQgdGhlcmUgaXMgbm8KPiBvYnZpb3VzIGVycm9y
IG1lc3NhZ2UuCgpXaGF0IGRvZXMgIm5ldmVyIiBtZWFuIGV4YWN0bHk/IDopIEkuZS4gaG93IGxv
bmcgaGF2ZSB5b3Ugd2FpdGVkPwoKSWYgaXQgZG9lcyBjb250aW51ZSBhZnRlciBhIGZldyBtaW51
dGVzLCBpdCBzb3VuZHMgbGlrZSB0aGUgZmlybXdhcmUKaXNuJ3QgYXZhaWxhYmxlIGluIHRoZSBz
YW1lIHBsYWNlIHdoZXJlIHRoZSBkcml2ZXIgaXMgbG9hZGVkIGZyb20sIGkuZS4KZWl0aGVyIHRo
ZSBkcml2ZXIgaXMgbG9hZGVkIGZyb20gaW5pdHJkIGJ1dCB0aGUgZmlybXdhcmUgaXNuJ3QgYXZh
aWxhYmxlCnRoZXJlLCBvciB0aGUgZHJpdmVyIGlzIGJ1aWx0IGludG8gdGhlIGtlcm5lbCwgYnV0
IHRoZSBmaXJtd2FyZSBpc24ndApidWlsdCBpbnRvIHRoZSBrZXJuZWwuCgoKLS0gCkVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3
LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
