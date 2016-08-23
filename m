From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: amdgpu's dce_vX_0_afmt_setmode(): why so different from radeon's
Date: Mon, 22 Aug 2016 23:29:03 -0400
Message-ID: <c9ab6753-06f6-da9a-eb81-4c88ad31fe7d@gmail.com>
Reply-To: alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

V2hpbGUgbG9va2luZyBhdCBkY2VfdjhfMF9hZm10X3NldG1vZGUoKSwgSSB3YXMgdGhpbmtpbmcg
aG93IGNyYW1tZWQgaXQgCndhcyBhbmQgaG93IHVuaW50dWl0aXZlIGl0IGxvb2tlZC4gSSBjb21w
YXJlZCBpdCB0byBpdHMgcmFkZW9uIApjb3VudGVycGFydCBhbmQgSSByZWFsaXplZCBob3cgcmVh
ZGFibGUgdGhpcyBsYXN0IG9uZSB3YXMuIEkgaGFkIGEgbG9vayAKYXQgdGhlIG90aGVyIGRjZV92
WF8wX2FmbXRfc2V0bW9kZSgpIHVuZGVyIGFtZGdwdSBhbmQgdGhleSBhbGwgbG9vayBhbGlrZS4K
CkNhbiBzb21lYm9keSAgZXhwbGFpbiB3aHkgdGhlIGFtZGdwdSdzIHNpZGUganVzdCBpbmNsdWRl
cyBldmVyeXRoaW5nIGluIApkY2VfdlhfMF9hZm10X3NldG1vZGUoKSBpbnN0ZWFkIG9mIGhhdmlu
ZyBhIG5pY2VseSBzdHJ1Y3R1cmVkIGFuZCAKcmVhZGFibGUgcHJlc2VudGF0aW9uIGFzIGl0IGlz
IHVuZGVyIHJhZGVvbj8KCkknbSB0cnlpbmcgdG8gc3RydWN0dXJlIHRoZSB0aGluZyBhIGJpdCBt
b3JlIGxpa2UgdGhlIHJhZGVvbidzIHNpZGUgZm9yIApkY2U2LCBidXQgdGhlaXIgYXJlIHNvbWUg
ZGlmZmVyZW5jZXMgaW4gdGhlIHN0ZXAgb3JkZXIgYW5kIGV2ZW4gYSBmZXcgCm1vcmUgcmVnaXN0
cnkgcmVhZCBhbmQgd3JpdGUgY2FsbHMuIEFueSBjbHVlIHdpbGwgYmUgd2VsY29tZWQuCgpDaGVl
cnMuCgotLSAKQWxleGFuZHJlIERlbWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
