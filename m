Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB76EC55183
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAE82078C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 13:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAE82078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65016E952;
	Tue, 21 Apr 2020 13:28:22 +0000 (UTC)
Received: from m176149.mail.qiye.163.com (m176149.mail.qiye.163.com
 [59.111.176.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309D96E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 08:45:19 +0000 (UTC)
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
 by m176149.mail.qiye.163.com (Hmail) with ESMTP id E5B7F282304;
 Tue, 21 Apr 2020 16:44:43 +0800 (CST)
Message-ID: <AIsA-wCZCFCxiq0WKb3WjKr*.3.1587458683834.Hmail.bernard@vivo.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCBWM10gYW1kZ3B1OiByZW1vdmUgdW5uZWNlc3NhcnkgY29uZGl0aW9uIGNoZWNr?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <4c027bd0-c2ff-b587-6389-62a3d25dec1b@amd.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail (
 [127.0.0.1] ) ; Tue, 21 Apr 2020 16:44:43 +0800 (GMT+08:00)
From: =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date: Tue, 21 Apr 2020 16:44:43 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVJQ0tCQkJNTUtPQkpCT1lXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEhCTUJOSUNLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6Mgg6Vgw4ITg9OAMSCkssMBlILBEwCVFVSFVKTkNMT05DTUNMS0pKVTMWGhIXVRkeCRUaCR87
 DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTE9DTjcG
X-HM-Tid: 0a719be934309395kuwse5b7f282304
X-Mailman-Approved-At: Tue, 21 Apr 2020 13:28:21 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>, opensource.kernel@vivo.com,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpGcm9tOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KRGF0
ZTogMjAyMC0wNC0yMSAxNjowNjowMwpUbzogIDE1ODcxODAwMzctMTEzODQwLTEtZ2l0LXNlbmQt
ZW1haWwtYmVybmFyZEB2aXZvLmNvbSxGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4sQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiwiRGF2aWQgKENo
dW5NaW5nKSBaaG91IiA8RGF2aWQxLlpob3VAYW1kLmNvbT4sRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+LGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnLGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcsbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwpDYzogIG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tLEJlcm5h
cmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KU3ViamVjdDogUmU6IFtQQVRDSCBWM10gYW1kZ3B1
OiByZW1vdmUgdW5uZWNlc3NhcnkgY29uZGl0aW9uIGNoZWNrPkFtIDIxLjA0LjIwIHVtIDEwOjAz
IHNjaHJpZWIgQmVybmFyZCBaaGFvOgo+PiBUaGVyZSBpcyBubyBuZWVkIHRvIGlmIGNoZWNrIGFn
YWluLCBtYXliZSB3ZSBjb3VsZCBtZXJnZQo+PiBpbnRvIHRoZSBhYm92ZSBlbHNlIGJyYW5jaC4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgo+Pgo+
PiBDaGFuZ2VzIHNpbmNlIFYxOgo+PiAqY29tbWl0IG1lc3NhZ2UgaW1wcm92ZQo+PiAqY29kZSBz
dHlsZSByZWZhY3RvcmluZwo+Pgo+PiBDaGFuZ2VzIHNpbmNlIFYyOgo+PiAqY29kZSBzdHlsZSBh
ZGp1c3QKPj4KPj4gTGluayBmb3IgVjE6Cj4+ICpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZw
YXRjaHdvcmslMkZwYXRjaCUyRjEyMjY1ODclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2NocmlzdGlh
bi5rb2VuaWclNDBhbWQuY29tJTdDMGI4ZmZmYWZiNzE1NDc0Mjg5YjIwOGQ3ZTVjYTdmNmMlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjMwNTMwMjAxMjgw
MzUwJmFtcDtzZGF0YT1TZXd2NUVTWCUyQjBCNERiRmJFMDN1TTVzaWZyRWNtSmxsQzhwdDdKNDJJ
N00lM0QmYW1wO3Jlc2VydmVkPTAKPj4gLS0tCj4+ICAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMgICB8IDE4ICsrKysrKystLS0tLS0tLS0tLQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+IGluZGV4
IDlkZmY3OTJjOTI5MC4uNTQyNGJkOTIxYTdiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+IEBAIC02NjAsMTMgKzY2MCwx
MiBAQCBzdGF0aWMgaW50IHJlc2VydmVfYm9fYW5kX3ZtKHN0cnVjdCBrZ2RfbWVtICptZW0sCj4+
ICAgCj4+ICAgCXJldCA9IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMoJmN0eC0+dGlja2V0LCAmY3R4
LT5saXN0LAo+PiAgIAkJCQkgICAgIGZhbHNlLCAmY3R4LT5kdXBsaWNhdGVzKTsKPj4gLQlpZiAo
IXJldCkKPj4gLQkJY3R4LT5yZXNlcnZlZCA9IHRydWU7Cj4+IC0JZWxzZSB7Cj4+IC0JCXByX2Vy
cigiRmFpbGVkIHRvIHJlc2VydmUgYnVmZmVycyBpbiB0dG1cbiIpOwo+PiArCWlmIChyZXQpIHsK
Pj4gKwkJcHJfZXJyKCJGYWlsZWQgdG8gcmVzZXJ2ZSBidWZmZXJzIGluIHR0bS5cbiIpOwo+PiAg
IAkJa2ZyZWUoY3R4LT52bV9wZCk7Cj4+ICAgCQljdHgtPnZtX3BkID0gTlVMTDsKPj4gLQl9Cj4+
ICsJfSBlbHNlCj4+ICsJCWN0eC0+cmVzZXJ2ZWQgPSB0cnVlOwo+Cj5UaGF0IGlzIHN0aWxsIG5v
dCBjb3JyZWN0IGNvZGluZyBzdHlsZS4gSW4gZ2VuZXJhbCB3aGVuIG9uZSBicmFuY2ggb2YgYW4g
Cj5pZi9lbHNlIHVzZXMge30gdGhlIG90aGVyIG9uZSBzaG91bGQgdXNlIGl0IGFzIHdlbGwuCj4K
PkJ1dCBJIGFncmVlIHdpdGggRmVsaXggdGhhdCB0aGlzIGNoYW5nZSBsb29rcyByYXRoZXIgc3Vw
ZXJmbHVvdXMgdG8gbWUgCj5hcyB3ZWxsLgo+Cj5SZWdhcmRzLAo+Q2hyaXN0aWFuLgoKQWJvdXQg
dGhlIGNvZGUgc3R5bGUsIHlvdSBhcmUgcmlnaHQsIEkgY2hlY2tlZCB0aGUgcmVmZXJzOgpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9pZD05MDI4
MGVhYTg4YWMxYTkxNDBkYzc1OTk0MTEyMzUzMGQ1NTQ1YmI2I24xOTEKVGhlIGlmIGFuZCBlbHNl
IHNob3VsZCB1c2UgdGhlIHNhbWUgc3R5bGUuCkJ1dCBpIGhhdmUgdG8gc2F5IHRoZXJlIGFyZSBz
byBtYW55IGNvZGUgbm90IGZvbGxvdyB0aGUga2VybmVsIGNvZGUtc3R5bGUgaW4gYW1kZ3B1IG1v
ZHVsZS4KQW5kIGFsc28gdGhlIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIGRpZCBub3QgdGhyb3cg
YW55IHdhcm5pbmcgb3IgZXJyb3IuCgpJZiB0aGlzIGNoYW5nZSBsb29rcyByYXRoZXIgc3VwZXJm
bHVvdXMgdG8gYWxsIG9mIHlvdSwgc2hvdWxkIGkgY2hhbmdlIHRvIHRoZSBWMSBjaGFuZ2U/CkFm
dGVyIGFsbCBpIGRvbmB0IHRoaW5rIHRoZXJlIGlzIGFueSBuZWNlc3NhcnkgdG8gY2hlY2sgInJl
dCIgYWdhaW4sIG1lcmdlIHRoZSA8ZWxzZSBhbmQgaWYgKHJldCk+Cm1heWJlIGJldHRlci4KT3Jp
Z2luYWwgY29kZToKc3RhdGljIGludCByZXNlcnZlX2JvX2FuZF9jb25kX3ZtcyhzdHJ1Y3Qga2dk
X21lbSAqbWVtLC4uLi4uCglpZiAoIXJldCkKCQljdHgtPnJlc2VydmVkID0gdHJ1ZTsKCWVsc2UK
CQlwcl9lcnIoIkZhaWxlZCB0byByZXNlcnZlIGJ1ZmZlcnMgaW4gdHRtLlxuIik7CgoJaWYgKHJl
dCkgewoJCWtmcmVlKGN0eC0+dm1fcGQpOwoJCWN0eC0+dm1fcGQgPSBOVUxMOwoJfQoKQlIvL2Jl
cm5hcmQKCj4+ICAgCj4+ICAgCXJldHVybiByZXQ7Cj4+ICAgfQo+PiBAQCAtNzMzLDE1ICs3MzIs
MTIgQEAgc3RhdGljIGludCByZXNlcnZlX2JvX2FuZF9jb25kX3ZtcyhzdHJ1Y3Qga2dkX21lbSAq
bWVtLAo+PiAgIAo+PiAgIAlyZXQgPSB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzKCZjdHgtPnRpY2tl
dCwgJmN0eC0+bGlzdCwKPj4gICAJCQkJICAgICBmYWxzZSwgJmN0eC0+ZHVwbGljYXRlcyk7Cj4+
IC0JaWYgKCFyZXQpCj4+IC0JCWN0eC0+cmVzZXJ2ZWQgPSB0cnVlOwo+PiAtCWVsc2UKPj4gLQkJ
cHJfZXJyKCJGYWlsZWQgdG8gcmVzZXJ2ZSBidWZmZXJzIGluIHR0bS5cbiIpOwo+PiAtCj4+ICAg
CWlmIChyZXQpIHsKPj4gKwkJcHJfZXJyKCJGYWlsZWQgdG8gcmVzZXJ2ZSBidWZmZXJzIGluIHR0
bS5cbiIpOwo+PiAgIAkJa2ZyZWUoY3R4LT52bV9wZCk7Cj4+ICAgCQljdHgtPnZtX3BkID0gTlVM
TDsKPj4gLQl9Cj4+ICsJfSBlbHNlCj4+ICsJCWN0eC0+cmVzZXJ2ZWQgPSB0cnVlOwo+PiAgIAo+
PiAgIAlyZXR1cm4gcmV0Owo+PiAgIH0KPgoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
