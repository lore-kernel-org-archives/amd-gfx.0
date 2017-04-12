From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v2.1)
Date: Wed, 12 Apr 2017 12:44:08 +1000
Message-ID: <CAPM=9txg84JzHVOpA7mfp4774gT_TLcEiya5fXu9cMTSFdWYWg@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-9-airlied@gmail.com>
 <BN4PR12MB0787C6D1CD93D0FCB6F2069DEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN4PR12MB0787C6D1CD93D0FCB6F2069DEE030-aH9FTdWx9BancvD3hK8fMAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTIgQXByaWwgMjAxNyBhdCAxMjozNiwgTWFvLCBEYXZpZCA8RGF2aWQuTWFvQGFtZC5jb20+
IHdyb3RlOgo+IERvZXMgaXQgbWVhbnMgd2UgaGF2ZSB0byBzdWJtaXQgY29tbWFuZCB0byB0cmln
Z2VyIHRoZSBzZW1hcGhvcmUgd2FpdC9zaWduYWw/CgpZZXMsIGJ1dCBJIHRoaW5rIHRoYXQgc2hv
dWxkIGJlIGZpbmUsIHdlIG5lZWQgdG8gc3VibWl0IGEgam9iIHRvIHRoZQpzY2hlZHVsZXIgdG8K
Z2V0IHRoZSB3YWl0cyB0byBoYXBwZW4gb3IgdG8gaGF2ZSBhIGZlbmNlIHRvIGZpbGwgaW50byB0
aGUgc2lnbmFscy4KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
