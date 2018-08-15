From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: fix off by one in handle_table_insert
Date: Wed, 15 Aug 2018 13:25:55 +0200
Message-ID: <20180815112555.3240-1-christian.koenig@amd.com>
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

U3R1cGlkIG1lLCBtYXhfa2V5IG11c3QgYWx3YXlzIGJlIGxhcmdlciB0aGFuIGtleS4KClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0t
CiBhbWRncHUvaGFuZGxlX3RhYmxlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hbWRncHUvaGFuZGxlX3RhYmxlLmMg
Yi9hbWRncHUvaGFuZGxlX3RhYmxlLmMKaW5kZXggMTVjZDQ3NjMuLjRmZGQyOWQzIDEwMDY0NAot
LS0gYS9hbWRncHUvaGFuZGxlX3RhYmxlLmMKKysrIGIvYW1kZ3B1L2hhbmRsZV90YWJsZS5jCkBA
IC0zMyw3ICszMyw3IEBAIGRybV9wcml2YXRlIGludCBoYW5kbGVfdGFibGVfaW5zZXJ0KHN0cnVj
dCBoYW5kbGVfdGFibGUgKnRhYmxlLCB1aW50MzJfdCBrZXksCiB7CiAJaWYgKGtleSA+PSB0YWJs
ZS0+bWF4X2tleSkgewogCQl1aW50MzJfdCBhbGlnbm1lbnQgPSBzeXNjb25mKF9TQ19QQUdFU0la
RSkgLyBzaXplb2Yodm9pZCopOwotCQl1aW50MzJfdCBtYXhfa2V5ID0gQUxJR04oa2V5LCBhbGln
bm1lbnQpOworCQl1aW50MzJfdCBtYXhfa2V5ID0gQUxJR04oa2V5ICsgMSwgYWxpZ25tZW50KTsK
IAkJdm9pZCAqKnZhbHVlczsKIAogCQl2YWx1ZXMgPSByZWFsbG9jKHRhYmxlLT52YWx1ZXMsIG1h
eF9rZXkgKiBzaXplb2Yodm9pZCAqKSk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
