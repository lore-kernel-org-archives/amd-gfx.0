From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: use exiting
 amdgput_ctx_total_num_entities function
Date: Tue, 13 Aug 2019 11:44:07 +0200
Message-ID: <b88ca84b-260e-9218-ec3d-f292ef1fb3fc@gmail.com>
References: <20190813090745.9496-1-kevin1.wang@amd.com>
 <20190813090745.9496-2-kevin1.wang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190813090745.9496-2-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "dl.srdc_lnx_nv10" <dl.srdc_lnx_nv10-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTMuMDguMTkgdW0gMTE6MDggc2NocmllYiBXYW5nLCBLZXZpbihZYW5nKToKPiBzaW1wbGlm
eSBkcml2ZXIgY29kZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5n
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
dHguYyB8IDUgKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiBpbmRl
eCA5NWQ4MjAxYTczOGUuLjg5YzI2YmIwZjA1YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMKPiBAQCAtMjkwLDEwICsyOTAsNyBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfY3R4X2RvX3JlbGVhc2Uoc3RydWN0IGtyZWYgKnJlZikKPiAgIAo+ICAgCWN0eCA9IGNvbnRh
aW5lcl9vZihyZWYsIHN0cnVjdCBhbWRncHVfY3R4LCByZWZjb3VudCk7Cj4gICAKPiAtCW51bV9l
bnRpdGllcyA9IDA7Cj4gLQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX0hXX0lQX05VTTsgaSsrKQo+
IC0JCW51bV9lbnRpdGllcyArPSBhbWRncHVfY3R4X251bV9lbnRpdGllc1tpXTsKPiAtCj4gKwlu
dW1fZW50aXRpZXMgPSBhbWRncHVfY3R4X3RvdGFsX251bV9lbnRpdGllcygpOwo+ICAgCWZvciAo
aSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykKPiAgIAkJZHJtX3NjaGVkX2VudGl0eV9kZXN0
cm95KCZjdHgtPmVudGl0aWVzWzBdW2ldLmVudGl0eSk7Cj4gICAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
