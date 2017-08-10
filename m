From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Uninitialized variable in
 amdgpu_ttm_backend_bind()
Date: Thu, 10 Aug 2017 01:34:54 -0400
Message-ID: <CADnq5_O_Hpk4X4wR5Be==C9AytXTX9OzB-fLJ_By4M1QLGS9hA@mail.gmail.com>
References: <20170809103046.mhj7mhe3qwy5ozvy@mwanda>
 <406505cd-fd17-b87a-0d3f-9adf5376880a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <406505cd-fd17-b87a-0d3f-9adf5376880a-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

T24gV2VkLCBBdWcgOSwgMjAxNyBhdCAxMDoxNiBQTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gT24gMDkvMDgvMTcgMDc6MzAgUE0sIERhbiBDYXJwZW50ZXIg
d3JvdGU6Cj4+IE15IHN0YXRpYyBjaGVja2VyIGNvbXBsYWlucyB0aGF0IGl0J3MgcG9zc2libGUg
Zm9yICJyIiB0byBiZQo+PiB1bmluaXRpYWxpemVkLiAgSXQgdXNlZCB0byBiZSBzZXQgdG8gemVy
byBzbyB0aGlzIHJldHVybnMgaXQgdG8gdGhlIG9sZAo+PiBiZWhhdmlvci4KPj4KPj4gRml4ZXM6
IDk4YTdmODhjZTlhOSAoImRybS9hbWRncHU6IGJpbmQgQk9zIHdpdGggR1RUIHNwYWNlIGFsbG9j
YXRlZCBkaXJlY3RseSB2MiIpCj4+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5j
YXJwZW50ZXJAb3JhY2xlLmNvbT4KPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwo+PiBpbmRleCBlNmY5YTU0Yzk1OWQuLmI1ZjJhMDg3NTdkNiAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBAQCAtNzUzLDcgKzc1Myw3IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9iYWNrZW5kX2JpbmQoc3RydWN0IHR0bV90dCAqdHRtLAo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdHRtX21lbV9yZWcgKmJv
X21lbSkKPj4gIHsKPj4gICAgICAgc3RydWN0IGFtZGdwdV90dG1fdHQgKmd0dCA9ICh2b2lkKil0
dG07Cj4+IC0gICAgIGludCByOwo+PiArICAgICBpbnQgciA9IDA7Cj4+Cj4+ICAgICAgIGlmIChn
dHQtPnVzZXJwdHIpIHsKPj4gICAgICAgICAgICAgICByID0gYW1kZ3B1X3R0bV90dF9waW5fdXNl
cnB0cih0dG0pOwo+Cj4gUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnpl
ckBhbWQuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
