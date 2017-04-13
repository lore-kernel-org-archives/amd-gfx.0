From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH split 2/3] LRU map compute/SDMA user ring ids to kernel ring
 ids
Date: Thu, 13 Apr 2017 18:04:30 -0400
Message-ID: <20170413220436.21555-1-andresx7@gmail.com>
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
Cc: andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

U2Vjb25kIHBhcnQgb2YgdGhlIHNwbGl0IG9mIHRoZSBzZXJpZXM6CkFkZCBzdXBwb3J0IGZvciBo
aWdoIHByaW9yaXR5IHNjaGVkdWxpbmcgaW4gYW1kZ3B1IHY4CgpUaGVzZSBwYXRjaGVzIHNob3Vs
ZCBiZSBjbG9zZSB0byBiZWluZyBnb29kIGVub3VnaCB0byBsYW5kLgoKVGhlIGZpcnN0IHR3byBw
YXRjaGVzIGFyZSBzaW1wbGUgZml4ZXMgSSd2ZSBwb3J0ZWQgZnJvbSB0aGUgUk9DbSBicmFuY2gu
IFRoZXNlCnN0aWxsIG5lZWQgcmV2aWV3LgoKSSd2ZSBmaXhlZCBhbGwgb2YgQ2hyaXN0aWFuJ3Mg
Y29tbWVudHMgZm9yIHBhdGNoIDA0Ogpkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgbHJ1IGFtZGdwdV9x
dWV1ZV9tZ3IgcG9saWN5IGZvciBjb21wdXRlIHY0CgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
