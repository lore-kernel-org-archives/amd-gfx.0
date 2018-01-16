From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: Use new TTM flag to avoid OOM triggering.
Date: Tue, 16 Jan 2018 15:00:02 -0500
Message-ID: <a8cc5f06-7b07-abab-4dbb-b9a1deaf04f0@amd.com>
References: <4a3881f0-a656-e1fa-ad93-cfb7e24bbd9e@amd.com>
 <1516132211-32035-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516132211-32035-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCk9u
IDIwMTgtMDEtMTYgMDI6NTAgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IEF2b2lkIE9P
TSBvbiBzeWF0ZW0gcGFnZXMgYWxsb2NhdGlvbnMuCj4KPiB2MjoKPiBSZW1vdmUgbW9kZXByb2Jl
IHBhcmFtZXRlciwgbWFrZSB0aGlzIGJlaGF2aW91ciB0aGUgb25seSBvcHRpb24uCj4KPiB2MzoK
PiBNb3ZlIHNldHRpbmcgbm9fcmV0cnkgZmxhZyBpbnRvIGFtZGdwdV90dG1faW5pdC4KPgo+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0ICsr
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDI5MGNkZjAuLmQzMmY0ODIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTEzODcsNiArMTM4Nywx
MCBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAJ
CXJldHVybiByOwo+ICAJfQo+ICAJYWRldi0+bW1hbi5pbml0aWFsaXplZCA9IHRydWU7Cj4gKwo+
ICsJLyogV2Ugb3B0IHRvIGF2b2lkIE9PTSBvbiBzeXN0ZW0gcGFnZXMgYWxsb2NhdGlvbnMgKi8K
PiArCWFkZXYtPm1tYW4uYmRldi5ub19yZXRyeSA9IHRydWU7Cj4gKwo+ICAJciA9IHR0bV9ib19p
bml0X21tKCZhZGV2LT5tbWFuLmJkZXYsIFRUTV9QTF9WUkFNLAo+ICAJCQkJYWRldi0+Z21jLnJl
YWxfdnJhbV9zaXplID4+IFBBR0VfU0hJRlQpOwo+ICAJaWYgKHIpIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
