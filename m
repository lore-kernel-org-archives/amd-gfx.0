From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 0/10] drm/amd: drop use of drmP.h
Date: Tue, 11 Jun 2019 00:02:39 +0200
Message-ID: <20190610220239.GA13919@ravnborg.org>
References: <20190609220757.10862-1-sam@ravnborg.org>
 <CADnq5_PtU+-FrTcOF9hkFYbqsSjAKmJkWReu-91pQH6mWoHtgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_PtU+-FrTcOF9hkFYbqsSjAKmJkWReu-91pQH6mWoHtgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SGkgQWxleC4KCj4gCj4gU2VyaWVzIGlzOgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gSSdtIGZpbmUgdG8gaGF2ZSB0aGlzIGdvIHRocm91
Z2ggZWl0aGVyIGRybS1taXNjIG9yIG15IHRyZWUuClRoYW5rcywgcHVzaGVkIHRvIGRybS1taXNj
LW5leHQuCkkgZW5kZWQgdXAgd2l0aCBhIG1lcmdlIGVycm9yIGluIGRybS10aXAgdGhhdCBJIGR1
bm5vIGhvdyB0byB3b3JrIHdpdGguCkhlbHAgd291bGQgYmUgYXBwcmVjaWF0ZWQuCihJIGFsc28g
d3JvdGUgdGhpcyBvbiBpcmMpCgpJdCBpcyBnZXR0aW5nIGxhdGUgaGVyZSwgSSBob3BlIHNvbWVv
bmUgaGFzIGZpeGVkIGl0IHRvbW9ycm93IG1vcm5pbmcuCgoJU2FtCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
