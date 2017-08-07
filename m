From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] drm: fix missing mutex unlock before return
Date: Mon, 7 Aug 2017 16:46:49 +0200
Message-ID: <3fa1478e-4701-343c-0288-e8c41eb1f2c4@vodafone.de>
References: <1502116512-14264-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502116512-14264-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDcuMDguMjAxNyB1bSAxNjozNSBzY2hyaWViIE1vbmsgTGl1Ogo+IEZyb206IE1vbmsgTGl1
IDxtb25rLmxpdUBhbWQuY29tPgo+Cj4gQ2hhbmdlLUlkOiBJMzc3ZGRlOTc2NjQ4ZDUzYmM5YTNh
MmQ1YmEyOTRjMjg0OTEwYjEwOQo+IFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxtb25rLmxpdUBh
bWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4gZm9yIHRoaXMgb25lLgoKPiAtLS0KPiAgIGFtZGdwdS9hbWRncHVfYm8uYyB8IDEg
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvYW1k
Z3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9iby5jCj4gaW5kZXggZWM5OTQ4OC4uMDdl
Yjc0MyAxMDA2NDQKPiAtLS0gYS9hbWRncHUvYW1kZ3B1X2JvLmMKPiArKysgYi9hbWRncHUvYW1k
Z3B1X2JvLmMKPiBAQCAtMjk3LDYgKzI5Nyw3IEBAIGludCBhbWRncHVfYm9faW1wb3J0KGFtZGdw
dV9kZXZpY2VfaGFuZGxlIGRldiwKPiAgIAkJLyogR2V0IGEgS01TIGhhbmRsZS4gKi8KPiAgIAkJ
ciA9IGRybVByaW1lRkRUb0hhbmRsZShkZXYtPmZkLCBzaGFyZWRfaGFuZGxlLCAmaGFuZGxlKTsK
PiAgIAkJaWYgKHIpIHsKPiArCQkJcHRocmVhZF9tdXRleF91bmxvY2soJmRldi0+Ym9fdGFibGVf
bXV0ZXgpOwo+ICAgCQkJcmV0dXJuIHI7Cj4gICAJCX0KPiAgIAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
