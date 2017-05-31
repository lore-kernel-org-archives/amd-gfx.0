From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Remove two ! operations in an if condition
Date: Wed, 31 May 2017 08:59:53 +0200
Message-ID: <8c52220e-5c3e-d83d-1843-ab22604d88fc@vodafone.de>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
 <1496180868-2617-2-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496180868-2617-2-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMzAuMDUuMjAxNyB1bSAyMzo0NyBzY2hyaWViIEFsZXggWGllOgo+ICAgTWFrZSB0aGUgY29k
ZSBlYXNpZXIgdG8gdW5kZXJzdGFuZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxBbGV4
QmluLlhpZUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCA2ICsrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggN2EzMjNmOS4uOWZkZWI4MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4gQEAgLTY4MCw5ICs2ODAsMTEgQEAgYm9vbCBhbWRncHVfdm1fbmVlZF9waXBl
bGluZV9zeW5jKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAo+ICAgCWlmIChhbWRncHVf
dm1faGFkX2dwdV9yZXNldChhZGV2LCBpZCkpCj4gICAJCXJldHVybiB0cnVlOwo+IC0JaWYgKCF2
bV9mbHVzaF9uZWVkZWQgJiYgIWdkc19zd2l0Y2hfbmVlZGVkKQo+ICsKPiArCWlmICh2bV9mbHVz
aF9uZWVkZWQgfHwgZ2RzX3N3aXRjaF9uZWVkZWQpCj4gKwkJcmV0dXJuIHRydWU7Cj4gKwllbHNl
Cj4gICAJCXJldHVybiBmYWxzZTsKPiAtCXJldHVybiB0cnVlOwoKQWN0dWFsbHkgdGhhdCBzaG91
bGQgZXZlbiB1c2UgdGhlIGNhbm9uaWNhbCBmb3JtLCBlLmcuIHNvbWV0aGluZyBsaWtlIAoicmV0
dXJuIHZtX2ZsdXNoX25lZWRlZCB8fCBnZHNfc3dpdGNoX25lZWRlZDsiLgoKQXBhcnQgZnJvbSB0
aGF0IGxvb2tzIGdvb2QgdG8gbWUsCkNocmlzdGlhbi4KCj4gICB9Cj4gICAKPiAgIC8qKgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
