From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: convert dc to using krefs for object reference counts
Date: Tue,  3 Oct 2017 12:38:56 +1000
Message-ID: <20171003023902.5036-1-airlied@gmail.com>
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

VGhpcyBzZXJpZXMgbWlnaHQgYmUgYSBiaXQgb2YgYSB0b28gYmlnIHN0ZXAgOi0pCgpTbyBpbiB0
aGUga2VybmVsIHdlIHVzZSBrcmVmcyBmb3IgcmVmZXJlbmNlIGNvdW50cyBmb3IgbG90cyBvZiBn
b29kCnJlYXNvbnMsIHRoZSBtYWluIG9uZSwgaXMgbm8gYnVncyB3aXRoIHJvbGwgeW91ciBvd24g
YXRvbWljIHJlZmVyZW5jZQpjb3VudGluZyBmb3Igc3RydWN0cywgd2hpY2ggbG90cyBvZiB0aGlz
IGNvZGUgaXMuCgpJJ3ZlIHBvcnRlZCBhbGwgdGhlIHN0cnVjdHMgSSBjb3VsZCBmaW5kIHVzaW5n
IGhhbmQgcm9sbGVkIGF0b21pYwpyZWZlcmVuY2UgY291bnRlcnMgdG8gdXNlIGtyZWZzLgoKRGF2
ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
