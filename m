From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: add gtt_sys_limit
Date: Tue, 27 Jun 2017 10:01:30 +0200
Message-ID: <7c144cd0-a5e2-7a6c-7192-194fdee000c2@vodafone.de>
References: <1498484397-1308-1-git-send-email-deathsimple@vodafone.de>
 <1498484397-1308-3-git-send-email-deathsimple@vodafone.de>
 <20170626233901.GA30922@kitsune.fastquake.com>
 <e3546936-bd31-d650-b5c8-807822213827@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e3546936-bd31-d650-b5c8-807822213827-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Cc: felix.kuehling-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjcuMDYuMjAxNyB1bSAwNDo1NyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI3LzA2
LzE3IDA4OjM5IEFNLCBKb2huIEJyb29rcyB3cm90ZToKPj4gT24gTW9uLCBKdW4gMjYsIDIwMTcg
YXQgMDM6Mzk6NTdQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Cj4+PiBMaW1pdCB0
aGUgc2l6ZSBvZiB0aGUgR0FSVCB0YWJsZSBmb3IgdGhlIHN5c3RlbSBkb21haW4uCj4+Pgo+Pj4g
VGhpcyBzYXZlcyB1cyBhIGJ1bmNoIG9mIHZpc2libGUgVlJBTSwgYnV0IGFsc28gbGltaXRhdGVz
IHRoZSBtYXhpbXVtIEJPIHNpemUgd2UgY2FuIHN3YXAgb3V0Lgo+Pj4KPj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gSG1tLgo+
Pgo+PiBPbiBteSBzeXN0ZW0sIEdUVCBpcyA0MDk2TWlCICgxMDQ4NTc2IHBhZ2VzKS4gRm9yIHRo
aXMsIHRoZSB0YWJsZSB0YWtlcyB1cAo+PiAxMDQ4NTc2KjggYnl0ZXMgPSA4TWlCLiBSZWR1Y2lu
ZyBHVFQgdG8gMjU2TWlCICg2NTUzNiBwYWdlcykgd291bGQgcmVkdWNlIHRoZQo+PiBzaXplIG9m
IHRoZSB0YWJsZSB0byA1MTIgS2lCLiBBIHJlbGF0aXZlbHkgbGFyZ2Ugc2F2aW5nLCB0byBiZSBz
dXJlLiBCdXQgaW4gdGhlCj4+IGdyYW5kZXIgc2NoZW1lIG9mIHRoaW5ncywgaXMgc2F2aW5nIDcu
NU1pQiAoMyUgb2YgdmlzaWJsZSBWUkFNIEAgMjU2TSkgd29ydGgKPj4gY3V0dGluZyBHVFQgbWVt
b3J5IGJ5IGEgZmFjdG9yIG9mIDE2PwoKVGhlIGFtb3VudCBvZiBHVFQgbWVtb3J5IHRoZSBhcHBs
aWNhdGlvbiBjYW4gdXNlIHRocm91Z2ggdGhlIFZNIHBhZ2UgCnRhYmxlcyBzdGF5cyB0aGUgc2Ft
ZS4KCk9ubHkgdGhlIHN5c3RlbSBWTSBpcyBsaW1pdGVkIHRvIDI1Nk1CIGFuZCBzbyBzYXZlcyB1
cyBhIHdob2xlIGJ1bmNoIG9mIApzcGFjZS4KCj4gSSdtIGFmcmFpZCBub3QsIGVzcGVjaWFsbHkg
c2luY2UgaXQgd291bGQgbGltaXQgdGhlIG1heGltdW0gQk8gc2l6ZSB0byA8Cj4gMjU2TUIsIGlm
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkuIFByZXR0eSBzdXJlIHRoYXQgd291bGQgY2F1c2UgZmFp
bHVyZXMKPiB3aXRoIHJlYWwgd29ybGQgYXBwcy4KWWVzLCBleGFjdGx5IHRoYXQncyB0aGUgbWFq
b3IgcHJvYmxlbSBoZXJlLiBJIHNob3VsZCBoYXZlIHB1dCBhIFdJUCBtYXJrIApvbiB0aGUgcGF0
Y2guCgpDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
