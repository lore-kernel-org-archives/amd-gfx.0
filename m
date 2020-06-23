Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD0C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA2620702
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18Raxs/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA2620702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7ECE6E7F5;
	Tue, 23 Jun 2020 21:02:06 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0E589DB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 20:33:21 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23218206C3;
 Tue, 23 Jun 2020 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592944401;
 bh=0isMCShVUmt0PgznSHcfZZBMuds+0OqhFhci1HPEPVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=18Raxs/PuzJ1x5hQggaGQuCzppFkNmSpHl1FAIReb1L8XTCA1ctpcvrpEw39c1U7n
 gw1/ZZZxrllt7VSCu2HYGJPacovQaqxfBJH3w5ah+1jWXe4FWLHxzdgNiIlfvx10zA
 CoWRF2drNVYKS2lJ6R0jfffMmnx96PVVJJ9CJIWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.4 290/314] drm/amd/display: Use swap() where appropriate
Date: Tue, 23 Jun 2020 21:58:05 +0200
Message-Id: <20200623195352.809162782@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 23 Jun 2020 21:02:05 +0000
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
Cc: Sasha Levin <sashal@kernel.org>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KClsg
VXBzdHJlYW0gY29tbWl0IDM0Yjg2Yjc1ZGZjOTBhYjNkOTk2YzIyNDMxNGNlNTE3NzJhM2IzNTEg
XQoKTW9zdGx5IGEgY29jY2ktam9iLCBidXQgaXQgZmxhdCBvdXQgcmVmdXNlZCB0byByZW1vdmUg
dGhlCmRlY2xhcmF0aW9uIGluIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
LmMgc28KaGFkIHRvIGRvIHRoYXQgcGFydCBtYW51YWxseS4KCkBzd2FwQAppZGVudGlmaWVyIFRF
TVA7CmV4cHJlc3Npb24gQSxCOwpAQAotIFRFTVAgPSBBOwotIEEgPSBCOwotIEIgPSBURU1QOwor
IHN3YXAoQSwgQik7CgpAQAp0eXBlIFQ7CmlkZW50aWZpZXIgc3dhcC5URU1QOwpAQAooCi0gVCBU
RU1QOwp8Ci0gVCBURU1QID0gey4uLn07CikKLi4uIHdoZW4gIT0gVEVNUAoKQ2M6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFt
ZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAi
Q2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6ICJEYXZpZCAo
Q2h1bk1pbmcpIFpob3UiIDxEYXZpZDEuWmhvdUBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogVmlsbGUgU3lyasOkbMOkIDx2aWxs
ZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2Fz
aGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3Mv
Ymlvc19wYXJzZXIuYyAgfCA3ICsrLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2Jpb3NfcGFyc2VyMi5jIHwgOCArKy0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYyAgICAgICAgICAgfCA2ICstLS0tLQogMyBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5jCmluZGV4IDIyMWUwZjU2Mzg5ZjMu
LjgyMzg0M2NkMjYxMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2Jpb3NfcGFyc2VyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2Jpb3MvYmlvc19wYXJzZXIuYwpAQCAtMjU0Myw3ICsyNTQzLDYgQEAgc3RhdGljIGVudW0gYnBf
cmVzdWx0IGNvbnN0cnVjdF9pbnRlZ3JhdGVkX2luZm8oCiAKIAkvKiBTb3J0IHZvbHRhZ2UgdGFi
bGUgZnJvbSBsb3cgdG8gaGlnaCovCiAJaWYgKHJlc3VsdCA9PSBCUF9SRVNVTFRfT0spIHsKLQkJ
c3RydWN0IGNsb2NrX3ZvbHRhZ2VfY2FwcyB0ZW1wID0gezAsIDB9OwogCQl1aW50MzJfdCBpOwog
CQl1aW50MzJfdCBqOwogCkBAIC0yNTUzLDEwICsyNTUyLDggQEAgc3RhdGljIGVudW0gYnBfcmVz
dWx0IGNvbnN0cnVjdF9pbnRlZ3JhdGVkX2luZm8oCiAJCQkJCQlpbmZvLT5kaXNwX2Nsa192b2x0
YWdlW2pdLm1heF9zdXBwb3J0ZWRfY2xrIDwKIAkJCQkJCWluZm8tPmRpc3BfY2xrX3ZvbHRhZ2Vb
ai0xXS5tYXhfc3VwcG9ydGVkX2NsaykgewogCQkJCQkvKiBzd2FwIGogYW5kIGogLSAxKi8KLQkJ
CQkJdGVtcCA9IGluZm8tPmRpc3BfY2xrX3ZvbHRhZ2Vbai0xXTsKLQkJCQkJaW5mby0+ZGlzcF9j
bGtfdm9sdGFnZVtqLTFdID0KLQkJCQkJCQlpbmZvLT5kaXNwX2Nsa192b2x0YWdlW2pdOwotCQkJ
CQlpbmZvLT5kaXNwX2Nsa192b2x0YWdlW2pdID0gdGVtcDsKKwkJCQkJc3dhcChpbmZvLT5kaXNw
X2Nsa192b2x0YWdlW2ogLSAxXSwKKwkJCQkJICAgICBpbmZvLT5kaXNwX2Nsa192b2x0YWdlW2pd
KTsKIAkJCQl9CiAJCQl9CiAJCX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKaW5kZXggZGZmNjVjMGZlODJmOC4uNzg3M2FiZWE0MTEy
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19w
YXJzZXIyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19w
YXJzZXIyLmMKQEAgLTE2MTMsOCArMTYxMyw2IEBAIHN0YXRpYyBlbnVtIGJwX3Jlc3VsdCBjb25z
dHJ1Y3RfaW50ZWdyYXRlZF9pbmZvKAogCiAJc3RydWN0IGF0b21fY29tbW9uX3RhYmxlX2hlYWRl
ciAqaGVhZGVyOwogCXN0cnVjdCBhdG9tX2RhdGFfcmV2aXNpb24gcmV2aXNpb247Ci0KLQlzdHJ1
Y3QgY2xvY2tfdm9sdGFnZV9jYXBzIHRlbXAgPSB7MCwgMH07CiAJdWludDMyX3QgaTsKIAl1aW50
MzJfdCBqOwogCkBAIC0xNjQ0LDEwICsxNjQyLDggQEAgc3RhdGljIGVudW0gYnBfcmVzdWx0IGNv
bnN0cnVjdF9pbnRlZ3JhdGVkX2luZm8oCiAJCQkJaW5mby0+ZGlzcF9jbGtfdm9sdGFnZVtqLTFd
Lm1heF9zdXBwb3J0ZWRfY2xrCiAJCQkJKSB7CiAJCQkJLyogc3dhcCBqIGFuZCBqIC0gMSovCi0J
CQkJdGVtcCA9IGluZm8tPmRpc3BfY2xrX3ZvbHRhZ2Vbai0xXTsKLQkJCQlpbmZvLT5kaXNwX2Ns
a192b2x0YWdlW2otMV0gPQotCQkJCQlpbmZvLT5kaXNwX2Nsa192b2x0YWdlW2pdOwotCQkJCWlu
Zm8tPmRpc3BfY2xrX3ZvbHRhZ2Vbal0gPSB0ZW1wOworCQkJCXN3YXAoaW5mby0+ZGlzcF9jbGtf
dm9sdGFnZVtqIC0gMV0sCisJCQkJICAgICBpbmZvLT5kaXNwX2Nsa192b2x0YWdlW2pdKTsKIAkJ
CX0KIAkJfQogCX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4
IGI5NWE1OGFhODJkOTEuLjQ3ZTdkMTFjYTBjOWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGMuYwpAQCAtOTA3LDE1ICs5MDcsMTEgQEAgc3RhdGljIHZvaWQgcHJvZ3Jh
bV90aW1pbmdfc3luYygKIAogCQkvKiBzZXQgZmlyc3QgcGlwZSB3aXRoIHBsYW5lIGFzIG1hc3Rl
ciAqLwogCQlmb3IgKGogPSAwOyBqIDwgZ3JvdXBfc2l6ZTsgaisrKSB7Ci0JCQlzdHJ1Y3QgcGlw
ZV9jdHggKnRlbXA7Ci0KIAkJCWlmIChwaXBlX3NldFtqXS0+cGxhbmVfc3RhdGUpIHsKIAkJCQlp
ZiAoaiA9PSAwKQogCQkJCQlicmVhazsKIAotCQkJCXRlbXAgPSBwaXBlX3NldFswXTsKLQkJCQlw
aXBlX3NldFswXSA9IHBpcGVfc2V0W2pdOwotCQkJCXBpcGVfc2V0W2pdID0gdGVtcDsKKwkJCQlz
d2FwKHBpcGVfc2V0WzBdLCBwaXBlX3NldFtqXSk7CiAJCQkJYnJlYWs7CiAJCQl9CiAJCX0KLS0g
CjIuMjUuMQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
