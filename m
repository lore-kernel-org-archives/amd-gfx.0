From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm: amd: amdgpu: constify ttm_place structures.
Date: Sun, 2 Jul 2017 14:44:47 +0200
Message-ID: <933494d2-c793-f074-16b6-803ecddd96b4@vodafone.de>
References: <c5a3e3c10ef3728ce16693bfff813e6269d4dd28.1498986678.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c5a3e3c10ef3728ce16693bfff813e6269d4dd28.1498986678.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMDIuMDcuMjAxNyB1bSAxMToxMyBzY2hyaWViIEFydmluZCBZYWRhdjoKPiB0dG1fcGxhY2Ug
YXJlIG5vdCBzdXBwb3NlZCB0byBjaGFuZ2UgYXQgcnVudGltZS4gQWxsIGZ1bmN0aW9ucwo+IHdv
cmtpbmcgd2l0aCB0dG1fcGxhY2UgcHJvdmlkZWQgYnkgPGRybS90dG0vdHRtX3BsYWNlbWVudC5o
PiB3b3JrCj4gd2l0aCBjb25zdCB0dG1fcGxhY2UuIFNvIG1hcmsgdGhlIG5vbi1jb25zdCBzdHJ1
Y3RzIGFzIGNvbnN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJ2aW5kIFlhZGF2IDxhcnZpbmQueWFk
YXYuY3NAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBp
bmRleCA1ZGIwMjMwLi5hMmM4MzgwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+IEBAIC0xODYsNyArMTg2LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2V2aWN0
X2ZsYWdzKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gICB7Cj4gICAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYm8tPmJkZXYpOwo+ICAgCXN0cnVj
dCBhbWRncHVfYm8gKmFibzsKPiAtCXN0YXRpYyBzdHJ1Y3QgdHRtX3BsYWNlIHBsYWNlbWVudHMg
PSB7Cj4gKwlzdGF0aWMgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSBwbGFjZW1lbnRzID0gewo+ICAg
CQkuZnBmbiA9IDAsCj4gICAJCS5scGZuID0gMCwKPiAgIAkJLmZsYWdzID0gVFRNX1BMX01BU0tf
Q0FDSElORyB8IFRUTV9QTF9GTEFHX1NZU1RFTQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
