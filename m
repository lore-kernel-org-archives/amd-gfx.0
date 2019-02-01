From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] v2 Override DPM1 PCIe parameters
Date: Fri, 1 Feb 2019 21:17:02 +0000
Message-ID: <1549055816-12976-1-git-send-email-Harish.Kasiviswanathan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>

RHVlIHRvIG1pc3VuZGVyc3RhbmRpbmcgd2l0aCB0aGUgU01VIHRlYW0sIHRoZSBwcmV2aW91cyBw
YXRjaCAiMWYzMzcwNDQzMWEiIGlzIGluY29ycmVjdC4gVGhpcyBwYXRjaCBpcyB2ZXJpZmllZCBv
biBWZWdhMjAgd2l0aCBYOTkgKEludGVsKSBQQ0kgR2VuMyBtYWNoaW5lLgoKSGFyaXNoIEthc2l2
aXN3YW5hdGhhbiAoMSk6CiAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBvdmVycmlkZSBwY2llIHBh
cmFtZXRlcnMgZm9yIFZlZ2EyMCAodjIpCgogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvdmVnYTIwX2h3bWdyLmMgfCA5MyArKysrKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
