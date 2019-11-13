Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24379C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00270222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00270222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329406ED28;
	Wed, 13 Nov 2019 14:12:09 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AAA8919E;
 Wed, 13 Nov 2019 12:37:24 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CC1AEF0991859E3B9BCD;
 Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:11 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Rex.Zhu@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: remove set but not used variable 'invalid'
Date: Wed, 13 Nov 2019 20:44:31 +0800
Message-ID: <1573649074-72589-5-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 13 Nov 2019 14:12:08 +0000
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
Cc: yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com,
 dri-devel@lists.freedesktop.org, yukuai3@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113124431.bMNTBniPgsg7lPSydHGNUS_uvBbHkbcxBGb6DWCA7sk@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jOiBJbiBmdW5jdGlvbgrigJhh
bWRncHVfYW1ka2ZkX2V2aWN0X3VzZXJwdHLigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYzoxNjY1OjY6IHdhcm5pbmc6CnZhcmlhYmxlIOKAmGludmFs
aWTigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCidpbnZh
bGlkJyBpcyBuZXZlciB1c2VkLCBzbyBjYW4gYmUgcmVtb3ZlZC4gVGh1cyAnYXRvbWljX2luY19y
ZXR1cm4nCmNhbiBiZSByZXBsYWNlZCBhcyAnYXRvbWljX2luYycKCkZpeGVzOiA1YWUwMjgzZTgz
MWEgKCJkcm0vYW1kZ3B1OiBBZGQgdXNlcnB0ciBzdXBwb3J0IGZvciBLRkQiKQpTaWduZWQtb2Zm
LWJ5OiB5dSBrdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwppbmRleCBhZTZmNTQ0Li5hMWVkOGE4ZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
YwpAQCAtMTY2MiwxMCArMTY2MiwxMCBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ldmljdF91c2VycHRy
KHN0cnVjdCBrZ2RfbWVtICptZW0sCiAJCQkJc3RydWN0IG1tX3N0cnVjdCAqbW0pCiB7CiAJc3Ry
dWN0IGFtZGtmZF9wcm9jZXNzX2luZm8gKnByb2Nlc3NfaW5mbyA9IG1lbS0+cHJvY2Vzc19pbmZv
OwotCWludCBpbnZhbGlkLCBldmljdGVkX2JvczsKKwlpbnQgZXZpY3RlZF9ib3M7CiAJaW50IHIg
PSAwOwogCi0JaW52YWxpZCA9IGF0b21pY19pbmNfcmV0dXJuKCZtZW0tPmludmFsaWQpOworCWF0
b21pY19pbmMoJm1lbS0+aW52YWxpZCk7CiAJZXZpY3RlZF9ib3MgPSBhdG9taWNfaW5jX3JldHVy
bigmcHJvY2Vzc19pbmZvLT5ldmljdGVkX2Jvcyk7CiAJaWYgKGV2aWN0ZWRfYm9zID09IDEpIHsK
IAkJLyogRmlyc3QgZXZpY3Rpb24sIHN0b3AgdGhlIHF1ZXVlcyAqLwotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
