From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu/ci: disable mclk switching for high
 refresh rates (v2)
Date: Wed, 24 May 2017 10:34:10 +0200
Message-ID: <5ad5330a-fe69-90a4-51d0-d0c37a5d09d4@vodafone.de>
References: <1495574797-11157-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495574797-11157-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjMuMDUuMjAxNyB1bSAyMzoyNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBFdmVuIGlmIHRo
ZSB2YmxhbmsgcGVyaW9kIHdvdWxkIGFsbG93IGl0LCBpdCBzdGlsbCBzZWVtcyB0bwo+IGJlIHBy
b2JsZW1hdGljIG9uIHNvbWUgY2FyZHMuCj4KPiB2MjogZml4IGxvZ2ljIGludmVyc2lvbiAoTmls
cykKPgo+IGJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
OTY4NjgKPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+IGZvciB0aGUgd2hvbGUgc2VyaWVzLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2NpX2RwbS5jIHwgNiArKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaV9k
cG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCj4gaW5kZXggNmRjMTQx
MC4uZWM5MzcxNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaV9k
cG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCj4gQEAgLTkw
Niw2ICs5MDYsMTIgQEAgc3RhdGljIGJvb2wgY2lfZHBtX3ZibGFua190b29fc2hvcnQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJdTMyIHZibGFua190aW1lID0gYW1kZ3B1X2RwbV9n
ZXRfdmJsYW5rX3RpbWUoYWRldik7Cj4gICAJdTMyIHN3aXRjaF9saW1pdCA9IGFkZXYtPm1jLnZy
YW1fdHlwZSA9PSBBTURHUFVfVlJBTV9UWVBFX0dERFI1ID8gNDUwIDogMzAwOwo+ICAgCj4gKwkv
KiBkaXNhYmxlIG1jbGsgc3dpdGNoaW5nIGlmIHRoZSByZWZyZXNoIGlzID4xMjBIeiwgZXZlbiBp
ZiB0aGUKPiArCSAqIGJsYW5raW5nIHBlcmlvZCB3b3VsZCBhbGxvdyBpdAo+ICsJICovCj4gKwlp
ZiAoYW1kZ3B1X2RwbV9nZXRfdnJlZnJlc2goYWRldikgPiAxMjApCj4gKwkJcmV0dXJuIHRydWU7
Cj4gKwo+ICAgCWlmICh2YmxhbmtfdGltZSA8IHN3aXRjaF9saW1pdCkKPiAgIAkJcmV0dXJuIHRy
dWU7Cj4gICAJZWxzZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
