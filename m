Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CEFC6195
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A78E21882
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A78E21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B976F9CF;
	Fri,  8 Nov 2019 15:34:59 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4499C6E38A;
 Fri,  8 Nov 2019 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26D3C21882;
 Fri,  8 Nov 2019 15:34:55 +0000 (UTC)
From: Will Deacon <will@kernel.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/radeon: Handle workqueue allocation failure
Date: Fri,  8 Nov 2019 15:34:46 +0000
Message-Id: <20191108153446.21244-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1573227297;
 bh=zN3rpR9wQehYQ/IBV1VV1sl0YioG8ZqhL8nEdmNUJzI=;
 h=From:To:Cc:Subject:Date:From;
 b=j31GgUY6npbSns0Lp5k0+nk597AYvETm92OAnsVM80BmSDDq/Wis/5qT56ttURWDV
 1uXWbY7AUUQKTXQYiHq3rvZoOL7Qo8tQ7jBLqVlB6evQhOapgA9k8bc3fiwmIi9/rv
 yFpZdui1H7yv5rkhsYAUron/xLU0NWjVjqUogFDk=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Nicolas Waisman <nico@semmle.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108153446.ZBsafBF-6yQ_XCG6BIvXfH3TAPQrkRAmAYG8N4yWjDw@z>

SW4gdGhlIGhpZ2hseSB1bmxpa2VseSBldmVudCB0aGF0IHdlIGZhaWwgdG8gYWxsb2NhdGUgdGhl
ICJyYWRlb24tY3J0YyIKd29ya3F1ZXVlLCB3ZSBzaG91bGQgYmFpbCBjbGVhbmx5IHJhdGhlciB0
aGFuIGJsaW5kbHkgbWFyY2hpbmcgb24gd2l0aCBhCk5VTEwgcG9pbnRlciBpbnN0YWxsZWQgZm9y
IHRoZSAnZmxpcF9xdWV1ZScgZmllbGQgb2YgdGhlICdyYWRlb25fY3J0YycKc3RydWN0dXJlLgoK
VGhpcyB3YXMgcmVwb3J0ZWQgcHJldmlvdXNseSBieSBOaWNvbGFzLCBidXQgSSBkb24ndCB0aGlu
ayBoaXMgZml4IHdhcwpjb3JyZWN0LgoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PgpSZXBv
cnRlZC1ieTogTmljb2xhcyBXYWlzbWFuIDxuaWNvQHNlbW1sZS5jb20+Ckxpbms6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FESl8zYThXRnJzNU5vdVhOcVM1V1llN3JlYkZQK19BNUNo
ZWVxQXlEX3A3REZKSmNnQG1haWwuZ21haWwuY29tLwpTaWduZWQtb2ZmLWJ5OiBXaWxsIERlYWNv
biA8d2lsbEBrZXJuZWwub3JnPgotLS0KCnYyOiBBZGQgZmFpbHVyZSBwYXRoIHRvIHJhZGVvbl9t
b2Rlc2V0X2luaXQoKS4gQ29tcGlsZS10ZXN0ZWQgb25seS4KCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAyOSArKysrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKaW5kZXggZTgxYjAxZjhkYjkwLi4xNzdhY2VlMDY2
MjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKQEAgLTY2OCwyMSAr
NjY4LDI5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2NydGNfZnVuY3MgcmFkZW9uX2NydGNf
ZnVuY3MgPSB7CiAJLnBhZ2VfZmxpcF90YXJnZXQgPSByYWRlb25fY3J0Y19wYWdlX2ZsaXBfdGFy
Z2V0LAogfTsKIAotc3RhdGljIHZvaWQgcmFkZW9uX2NydGNfaW5pdChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCBpbnQgaW5kZXgpCitzdGF0aWMgaW50IHJhZGVvbl9jcnRjX2luaXQoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwgaW50IGluZGV4KQogewogCXN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
ID0gZGV2LT5kZXZfcHJpdmF0ZTsKIAlzdHJ1Y3QgcmFkZW9uX2NydGMgKnJhZGVvbl9jcnRjOwor
CXN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cTsKIAlpbnQgaTsKIAogCXJhZGVvbl9jcnRjID0g
a3phbGxvYyhzaXplb2Yoc3RydWN0IHJhZGVvbl9jcnRjKSArIChSQURFT05GQl9DT05OX0xJTUlU
ICogc2l6ZW9mKHN0cnVjdCBkcm1fY29ubmVjdG9yICopKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKHJh
ZGVvbl9jcnRjID09IE5VTEwpCi0JCXJldHVybjsKKwkJcmV0dXJuIC1FTk9NRU07CisKKwl3cSA9
IGFsbG9jX3dvcmtxdWV1ZSgicmFkZW9uLWNydGMiLCBXUV9ISUdIUFJJLCAwKTsKKwlpZiAodW5s
aWtlbHkoIXdxKSkgeworCQlrZnJlZShyYWRlb25fY3J0Yyk7CisJCXJldHVybiAtIEVOT01FTTsK
Kwl9CiAKIAlkcm1fY3J0Y19pbml0KGRldiwgJnJhZGVvbl9jcnRjLT5iYXNlLCAmcmFkZW9uX2Ny
dGNfZnVuY3MpOwogCiAJZHJtX21vZGVfY3J0Y19zZXRfZ2FtbWFfc2l6ZSgmcmFkZW9uX2NydGMt
PmJhc2UsIDI1Nik7CiAJcmFkZW9uX2NydGMtPmNydGNfaWQgPSBpbmRleDsKLQlyYWRlb25fY3J0
Yy0+ZmxpcF9xdWV1ZSA9IGFsbG9jX3dvcmtxdWV1ZSgicmFkZW9uLWNydGMiLCBXUV9ISUdIUFJJ
LCAwKTsKKwlyYWRlb25fY3J0Yy0+ZmxpcF9xdWV1ZSA9IHdxOworCiAJcmRldi0+bW9kZV9pbmZv
LmNydGNzW2luZGV4XSA9IHJhZGVvbl9jcnRjOwogCiAJaWYgKHJkZXYtPmZhbWlseSA+PSBDSElQ
X0JPTkFJUkUpIHsKQEAgLTcxMSw2ICs3MTksOCBAQCBzdGF0aWMgdm9pZCByYWRlb25fY3J0Y19p
bml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGludCBpbmRleCkKIAkJcmFkZW9uX2F0b21iaW9z
X2luaXRfY3J0YyhkZXYsIHJhZGVvbl9jcnRjKTsKIAllbHNlCiAJCXJhZGVvbl9sZWdhY3lfaW5p
dF9jcnRjKGRldiwgcmFkZW9uX2NydGMpOworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBjb25z
dCBjaGFyICplbmNvZGVyX25hbWVzWzM4XSA9IHsKQEAgLTE2MDIsOSArMTYxMiw4IEBAIGludCBy
YWRlb25fbW9kZXNldF9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogCXJkZXYtPmRk
ZXYtPm1vZGVfY29uZmlnLmZiX2Jhc2UgPSByZGV2LT5tYy5hcGVyX2Jhc2U7CiAKIAlyZXQgPSBy
YWRlb25fbW9kZXNldF9jcmVhdGVfcHJvcHMocmRldik7Ci0JaWYgKHJldCkgewotCQlyZXR1cm4g
cmV0OwotCX0KKwlpZiAocmV0KQorCQlnb3RvIGVycl9kcm1fbW9kZV9jb25maWdfY2xlYW51cDsK
IAogCS8qIGluaXQgaTJjIGJ1c2VzICovCiAJcmFkZW9uX2kyY19pbml0KHJkZXYpOwpAQCAtMTYx
Nyw3ICsxNjI2LDkgQEAgaW50IHJhZGVvbl9tb2Rlc2V0X2luaXQoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpCiAKIAkvKiBhbGxvY2F0ZSBjcnRjcyAqLwogCWZvciAoaSA9IDA7IGkgPCByZGV2
LT5udW1fY3J0YzsgaSsrKSB7Ci0JCXJhZGVvbl9jcnRjX2luaXQocmRldi0+ZGRldiwgaSk7CisJ
CXJldCA9IHJhZGVvbl9jcnRjX2luaXQocmRldi0+ZGRldiwgaSk7CisJCWlmIChyZXQpCisJCQln
b3RvIGVycl9kcm1fbW9kZV9jb25maWdfY2xlYW51cDsKIAl9CiAKIAkvKiBva2F5IHdlIHNob3Vs
ZCBoYXZlIGFsbCB0aGUgYmlvcyBjb25uZWN0b3JzICovCkBAIC0xNjQ1LDYgKzE2NTYsMTAgQEAg
aW50IHJhZGVvbl9tb2Rlc2V0X2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiAJcmV0
ID0gcmFkZW9uX3BtX2xhdGVfaW5pdChyZGV2KTsKIAogCXJldHVybiAwOworCitlcnJfZHJtX21v
ZGVfY29uZmlnX2NsZWFudXA6CisJZHJtX21vZGVfY29uZmlnX2NsZWFudXAocmRldi0+ZGRldik7
CisJcmV0dXJuIHJldDsKIH0KIAogdm9pZCByYWRlb25fbW9kZXNldF9maW5pKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2KQotLSAKMi4yNC4wLnJjMS4zNjMuZ2IxYmNjZDNlM2QtZ29vZwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
