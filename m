Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E3C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854B320740
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854B320740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406456E620;
	Fri, 15 Nov 2019 14:55:58 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3ED96E519;
 Fri, 15 Nov 2019 12:05:53 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F16483CF5751AA724F9D;
 Fri, 15 Nov 2019 20:05:46 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 20:05:38 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/radeon: remove set but not used variable
 'radeon_connector'
Date: Fri, 15 Nov 2019 20:12:58 +0800
Message-ID: <1573819980-54523-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
References: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 15 Nov 2019 14:55:58 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115121258.qIxiXZAe5DbB1Hd54jqNv6pF4xNVtWyEsx4tqtsWZYY@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOiBJbiBmdW5jdGlvbiByYWRlb25fY3J0Y19z
Y2FsaW5nX21vZGVfZml4dXA6CmRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXku
YzoxNjg1OjI3OiB3YXJuaW5nOiB2YXJpYWJsZSByYWRlb25fY29ubmVjdG9yIHNldCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBub3QgdXNlZCBzaW5jZSBj
b21taXQgMzc3YmQ4YTk4ZDdkICgiZHJtL3JhZGVvbjoKdXNlIGEgZmV0Y2ggZnVuY3Rpb24gdG8g
Z2V0IHRoZSBlZGlkIikKClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNv
bT4KU2lnbmVkLW9mZi1ieTogemhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAyIC0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5
LmMKaW5kZXggZTgxYjAxZi4uODRkM2Q4ODUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2Rpc3BsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9kaXNwbGF5LmMKQEAgLTE2ODcsNyArMTY4Nyw2IEBAIGJvb2wgcmFkZW9uX2NydGNfc2NhbGlu
Z19tb2RlX2ZpeHVwKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAlzdHJ1Y3QgcmFkZW9uX2NydGMg
KnJhZGVvbl9jcnRjID0gdG9fcmFkZW9uX2NydGMoY3J0Yyk7CiAJc3RydWN0IHJhZGVvbl9lbmNv
ZGVyICpyYWRlb25fZW5jb2RlcjsKIAlzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOwot
CXN0cnVjdCByYWRlb25fY29ubmVjdG9yICpyYWRlb25fY29ubmVjdG9yOwogCWJvb2wgZmlyc3Qg
PSB0cnVlOwogCXUzMiBzcmNfdiA9IDEsIGRzdF92ID0gMTsKIAl1MzIgc3JjX2ggPSAxLCBkc3Rf
aCA9IDE7CkBAIC0xNzAwLDcgKzE2OTksNiBAQCBib29sIHJhZGVvbl9jcnRjX3NjYWxpbmdfbW9k
ZV9maXh1cChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsCiAJCQljb250aW51ZTsKIAkJcmFkZW9uX2Vu
Y29kZXIgPSB0b19yYWRlb25fZW5jb2RlcihlbmNvZGVyKTsKIAkJY29ubmVjdG9yID0gcmFkZW9u
X2dldF9jb25uZWN0b3JfZm9yX2VuY29kZXIoZW5jb2Rlcik7Ci0JCXJhZGVvbl9jb25uZWN0b3Ig
PSB0b19yYWRlb25fY29ubmVjdG9yKGNvbm5lY3Rvcik7CgogCQlpZiAoZmlyc3QpIHsKIAkJCS8q
IHNldCBzY2FsaW5nICovCi0tCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
