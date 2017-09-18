From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: remove ttm trace and add iova debugfs (v2)
Date: Mon, 18 Sep 2017 13:33:46 -0400
Message-ID: <20170918173350.9543-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SW4gdGhpcyByZXNwaW4gSSBhZGQgc29tZSBjaGFuZ2VzIHBlciBmZWVkYmFjayBhbmQgbWFrZSB0
aGUgaW92YQplbnRyeSBoYXZlIHByb3BlciByZWFkL3dyaXRlIG1ldGhvZHMgd2hpY2ggYWNjZXNz
IHBhZ2VzIG1hcHBlZApieSBhbWRncHUuICBTbyB0aGVyZSBpcyBubyBuZWVkIGZvciAvZGV2L21l
bSBvciAvZGV2L2ZtZW0gYW55bW9yZQp3aGVuIHJlYWRpbmcgc3lzdGVtIG1lbW9yeS4KClBhdGNo
ZXMgMy80IGFyZSB1bmNoYW5nZWQgYW5kIHJlbW92ZSB0aGUgVFRNIHRyYWNlIGZyb20gYW1kZ3B1
IAphbmQgZnJvbSBUVE0gaXRzZWxmLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
