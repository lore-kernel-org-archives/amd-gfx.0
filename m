Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6EC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FCC6113E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 12:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FCC6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2603898F5;
	Tue, 25 May 2021 12:42:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E03D6E059;
 Tue, 25 May 2021 12:32:55 +0000 (UTC)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FqD0W5PZzzQs3D;
 Tue, 25 May 2021 20:29:15 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 20:32:31 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 20:32:31 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/radeon/evergreen: Remove the repeated declaration
Date: Tue, 25 May 2021 20:32:24 +0800
Message-ID: <1621945944-52797-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 25 May 2021 12:42:35 +0000
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnVuY3Rpb24gJ2V2ZXJncmVlbl9wcmludF9ncHVfc3RhdHVzX3JlZ3MnIGlzIGRlY2xhcmVkIHR3
aWNlLCByZW1vdmUKdGhlIHJlcGVhdGVkIGRlY2xhcmF0aW9uLgoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTaGFva3VuIFpoYW5nIDx6aGFuZ3No
YW9rdW5AaGlzaWxpY29uLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVl
bi5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2V2ZXJncmVlbi5oCmluZGV4IDQwMjVhNGU0NzRkMS4uYjA3YmVmZTE0NDU4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5oCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vZXZlcmdyZWVuLmgKQEAgLTQ1LDcgKzQ1LDYgQEAgdm9pZCBzdW1vX3JsY19maW5p
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIGludCBzdW1vX3JsY19pbml0KHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2KTsKIHZvaWQgZXZlcmdyZWVuX2dwdV9wY2lfY29uZmlnX3Jlc2V0
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIHUzMiBldmVyZ3JlZW5fZ2V0X251bWJlcl9v
Zl9kcmFtX2NoYW5uZWxzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKLXZvaWQgZXZlcmdy
ZWVuX3ByaW50X2dwdV9zdGF0dXNfcmVncyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB1
MzIgZXZlcmdyZWVuX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2aWNlICpy
ZGV2KTsKIGludCBldmVyZ3JlZW5fcmxjX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiBzdHJ1Y3QgZXZlcmdyZWVuX3Bvd2VyX2luZm8gKmV2ZXJncmVlbl9nZXRfcGkoc3RydWN0
IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
