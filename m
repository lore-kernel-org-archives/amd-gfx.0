From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] amdgpu: check parameters in amdgpu_query_gpu_info
Date: Sun, 30 Oct 2016 17:23:59 +0100
Message-ID: <d7bf4086-a833-2a15-f927-a45ce4796c41@vodafone.de>
References: <1477688506-26549-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477688506-26549-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjguMTAuMjAxNiB1bSAyMzowMSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBNYWtlIHN1cmUg
dGhleSBhcmVuJ3QgTlVMTC4KPgo+IEJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9OTc5OTMKPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKPiAtLS0KPgo+IFRoaXMgYnVnIHByb2JhYmx5IG5l
ZWRzIHRvIGJlIGZpeGVkIGluIHRoZSBPQ0wgZHJpdmVyLCBidXQgdGhpcwo+IHBhdGNoIGZpeGVz
IHRoZSBhY3V0ZSBwcm9ibGVtIGFuZCBtYXkgYmUgZW5vdWdoIHRvIGZpeCB0aGUgYnVnCj4gb3Zl
cmFsbC4gIE5lZWRzIGZ1cnRoZXIgaW52ZXN0aWdhdGlvbiBieSB0aGUgT0NMIHRlYW0uCj4KPiBh
bWRncHUvYW1kZ3B1X2dwdV9pbmZvLmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9ncHVfaW5mby5jIGIvYW1k
Z3B1L2FtZGdwdV9ncHVfaW5mby5jCj4gaW5kZXggMGYyMzI5Ny4uNjZjN2UwZSAxMDA2NDQKPiAt
LS0gYS9hbWRncHUvYW1kZ3B1X2dwdV9pbmZvLmMKPiArKysgYi9hbWRncHUvYW1kZ3B1X2dwdV9p
bmZvLmMKPiBAQCAtMjMwLDYgKzIzMCw4IEBAIGRybV9wcml2YXRlIGludCBhbWRncHVfcXVlcnlf
Z3B1X2luZm9faW5pdChhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYpCj4gICBpbnQgYW1kZ3B1X3F1
ZXJ5X2dwdV9pbmZvKGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldiwKPiAgIAkJCXN0cnVjdCBhbWRn
cHVfZ3B1X2luZm8gKmluZm8pCj4gICB7Cj4gKwlpZiAoKGRldiA9PSBOVUxMKSB8fCAoaW5mbyA9
PSBOVUxMKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAkvKiBHZXQgQVNJQyBpbmZvKi8KPiAg
IAkqaW5mbyA9IGRldi0+aW5mbzsKPiAgIAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
