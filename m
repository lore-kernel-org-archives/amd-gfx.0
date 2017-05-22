From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix ocl test performance drop
Date: Mon, 22 May 2017 13:16:37 +0200
Message-ID: <a22a526f-4fd8-3bc8-4f33-d15ed5eb141e@vodafone.de>
References: <1495442049-7481-1-git-send-email-Flora.Cui@amd.com>
 <5922A818.9010301@amd.com> <20170522101052.GC19238@flora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170522101052.GC19238@flora>
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
To: Flora Cui <flora.cui-5C7GfCeVMHo@public.gmane.org>, zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjIuMDUuMjAxNyB1bSAxMjoxMCBzY2hyaWViIEZsb3JhIEN1aToKPiBwYXJ0aWFsIHJldmVy
dCBjb21taXQgPDY5NzFkM2Q+IC0gZHJtL2FtZGdwdTogY2xlYW51cCBsb2dpYyBpbgo+IGFtZGdw
dV92bV9mbHVzaAo+Cj4gQ2hhbmdlLUlkOiBJYWRjZTlkNjEzZGZlOWE3Mzk2NDNhNzQwNTBjZWE1
NTg1NDgzMmFkYgo+IFNpZ25lZC1vZmYtYnk6IEZsb3JhIEN1aSA8RmxvcmEuQ3VpQGFtZC5jb20+
CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMyAr
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNDU3M2Q4Yy4uNWI5
YTczZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTc0
Myw4ICs3NDMsNyBAQCBpbnQgYW1kZ3B1X3ZtX2ZsdXNoKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
Zywgc3RydWN0IGFtZGdwdV9qb2IgKmpvYikKPiAgIAkJaWQtPmd3c19zaXplICE9IGpvYi0+Z3dz
X3NpemUgfHwKPiAgIAkJaWQtPm9hX2Jhc2UgIT0gam9iLT5vYV9iYXNlIHx8Cj4gICAJCWlkLT5v
YV9zaXplICE9IGpvYi0+b2Ffc2l6ZSk7Cj4gLQlib29sIHZtX2ZsdXNoX25lZWRlZCA9IGpvYi0+
dm1fbmVlZHNfZmx1c2ggfHwKPiAtCQlhbWRncHVfdm1fcmluZ19oYXNfY29tcHV0ZV92bV9idWco
cmluZyk7Cj4gKwlib29sIHZtX2ZsdXNoX25lZWRlZCA9IGpvYi0+dm1fbmVlZHNfZmx1c2g7Cj4g
ICAJdW5zaWduZWQgcGF0Y2hfb2Zmc2V0ID0gMDsKPiAgIAlpbnQgcjsKPiAgIAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
