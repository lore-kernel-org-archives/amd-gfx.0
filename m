From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [V2 0/6] drm/amdgpu: add support SR-IOV initialization
Date: Fri, 2 Dec 2016 11:11:48 +0100
Message-ID: <3cbac631-ad92-7ddf-dc62-5fc9b352889c@vodafone.de>
References: <1480658628-24446-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1480658628-24446-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SSdtIG5vdCBzbyBkZWVwbHkgaW50byB0aG9zZSBwYXJ0cywgYnV0IHRoYXQgc2VlbSB0byBtYWtl
IHNlbnNlLgoKU28gd2hvbGUgc2V0IGlzIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMDIuMTIuMjAx
NiB1bSAwNzowMyBzY2hyaWViIFhpYW5nbGlhbmcgWXU6Cj4gQXMgU1ItSU9WIGluaXRpYWxpemF0
aW9uIGlzIGRpZmZlcmVuY2UgZnJvbSBiYXJlIG1ldGFsLCB0aGUgc2VyaWVzIHBhdGNoCj4gd2ls
bCBjaGFuZ2UgY29kZSBwYXRoIG9mIGluaXRpYWxpemF0aW9uIGFjY29yZGluZyB0byBIVyBkZXNp
Z24uCj4KPiBDaGFuZ2VzIGluIFYyOgo+IDEuIFJlbW92ZSBWTSBmYXVsdCBwYXRjaDsKPiAyLiBT
cGxpdCBvdXQgdGhlIHRoaXJkIHBhdGNoIGludG8gdHdvIHBhdGNoZXMgdG8gbWFrZSBtb3JlIGNs
ZWFyOwo+Cj4gWGlhbmdsaWFuZyBZdSAoNik6Cj4gICAgZHJtL2FtZGdwdTogZHJvcCByZWR1bmRh
bnQgdmlfbXFkIGRlZmluZQo+ICAgIGRybS9hbWQvcG93ZXJwbGF5OiBjdXQgZGlnZXN0IHBhcnQK
PiAgICBkcm0vYW1kL3Bvd2VycGxheTogSWdub3JlIHNtdSBidWZmZXIgdXNhZ2UKPiAgICBkcm0v
YW1kL3Bvd2VycGxheTogQWRqdXN0IHRoZSBwb3NpdGlvbiBvZiBkYXRhIHNpemUgaW5pdGlhbAo+
ICAgIGRybS9hbWRncHU6IERvbid0IHRvdWNoIEdGWCBodyBkdXJpbmcgSFcgZmluaQo+ICAgIGRy
bS9hbWQvcG93ZXJwbGF5OiBGaXggcG90ZW50aWFsIE5VTEwgcG9pbnRlciBpc3N1ZQo+Cj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICAgICAgICAgICAgICB8IDI3MCAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZF9wb3dlcnBsYXkuYyAgICAgIHwgICA0ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVtZ3Ivc211N19zbXVtZ3IuYyB8ICAxOSArLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAyNjggZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
