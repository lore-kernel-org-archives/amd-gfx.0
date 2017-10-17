From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/13] drm/amd/display: Replace block with strncpy() in
 fill_audio_info()
Date: Tue, 17 Oct 2017 12:19:07 -0400
Message-ID: <20171017161912.11357-9-tom.stdenis@amd.com>
References: <20171017161912.11357-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171017161912.11357-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

UmVwbGFjZSBpbmxpbmVkIHN0cm5jcHkgd2l0aCBsaWJyYXJ5IGNhbGwuCgpTaWduZWQtb2ZmLWJ5
OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDggKysrLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggZTM3MWQ3NDBi
NjYyLi5jMjNlNmEyODg2NjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMjI1MSwxMSArMjI1MSw5IEBAIHN0YXRpYyB2b2lk
IGZpbGxfYXVkaW9faW5mbyhzdHJ1Y3QgYXVkaW9faW5mbyAqYXVkaW9faW5mbywKIAogCWNlYV9y
ZXZpc2lvbiA9IGRybV9jb25uZWN0b3ItPmRpc3BsYXlfaW5mby5jZWFfcmV2OwogCi0Jd2hpbGUg
KGkgPCBBVURJT19JTkZPX0RJU1BMQVlfTkFNRV9TSVpFX0lOX0NIQVJTICYmCi0JCWVkaWRfY2Fw
cy0+ZGlzcGxheV9uYW1lW2ldKSB7Ci0JCWF1ZGlvX2luZm8tPmRpc3BsYXlfbmFtZVtpXSA9IGVk
aWRfY2Fwcy0+ZGlzcGxheV9uYW1lW2ldOwotCQlpKys7Ci0JfQorCXN0cm5jcHkoYXVkaW9faW5m
by0+ZGlzcGxheV9uYW1lLAorCQllZGlkX2NhcHMtPmRpc3BsYXlfbmFtZSwKKwkJQVVESU9fSU5G
T19ESVNQTEFZX05BTUVfU0laRV9JTl9DSEFSUyAtIDEpOwogCiAJaWYgKGNlYV9yZXZpc2lvbiA+
PSAzKSB7CiAJCWF1ZGlvX2luZm8tPm1vZGVfY291bnQgPSBlZGlkX2NhcHMtPmF1ZGlvX21vZGVf
Y291bnQ7Ci0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
