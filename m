Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE0AC83004
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776DA20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776DA20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA676E445;
	Thu, 30 Apr 2020 02:23:27 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35166E445;
 Thu, 30 Apr 2020 02:19:59 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 891D946E08F4BC3E21C7;
 Thu, 30 Apr 2020 10:19:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 10:19:45 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: remove set but not used variable
 'direct_poll' in vcn_v2_5.c
Date: Thu, 30 Apr 2020 10:26:53 +0800
Message-ID: <20200430022653.46365-4-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200430022653.46365-1-zhengbin13@huawei.com>
References: <20200430022653.46365-1-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 30 Apr 2020 02:23:26 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYzoxMTcwOjM5OiB3YXJuaW5nOiB2YXJpYWJsZSDi
gJhkaXJlY3RfcG9sbOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQoKSXQgaXMgaW50cm9kdWNlZCBieSBjb21taXQgN2RhYWViZmVhNWU1ICgiZHJtL2FtZGdw
dToKYWRkIFZDTjIuNSBzcmlvdiBzdGFydCBmb3IgQXJjdHJ1cyIpLCBidXQgbmV2ZXIgdXNlZCwK
c28gcmVtb3ZlIGl0LgoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29t
PgpTaWduZWQtb2ZmLWJ5OiBaaGVuZyBCaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIHwgMiAtLQogMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKaW5k
ZXggMzhjYTRhNzEyZjEyLi41YzFiOWVkNzY1MzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3YyXzUuYwpAQCAtMTE2NywxNCArMTE2NywxMiBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3Ny
aW92X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXVpbnQzMl90IHRhYmxlX3Np
emUgPSAwOwogCXN0cnVjdCBtbXNjaF92MV8wX2NtZF9kaXJlY3Rfd3JpdGUgZGlyZWN0X3d0ID0g
eyB7IDAgfSB9OwogCXN0cnVjdCBtbXNjaF92MV8wX2NtZF9kaXJlY3RfcmVhZF9tb2RpZnlfd3Jp
dGUgZGlyZWN0X3JkX21vZF93dCA9IHsgeyAwIH0gfTsKLQlzdHJ1Y3QgbW1zY2hfdjFfMF9jbWRf
ZGlyZWN0X3BvbGxpbmcgZGlyZWN0X3BvbGwgPSB7IHsgMCB9IH07CiAJc3RydWN0IG1tc2NoX3Yx
XzBfY21kX2VuZCBlbmQgPSB7IHsgMCB9IH07CiAJdWludDMyX3QgKmluaXRfdGFibGUgPSBhZGV2
LT52aXJ0Lm1tX3RhYmxlLmNwdV9hZGRyOwogCXN0cnVjdCBtbXNjaF92MV8xX2luaXRfaGVhZGVy
ICpoZWFkZXIgPSAoc3RydWN0IG1tc2NoX3YxXzFfaW5pdF9oZWFkZXIgKilpbml0X3RhYmxlOwoK
IAlkaXJlY3Rfd3QuY21kX2hlYWRlci5jb21tYW5kX3R5cGUgPSBNTVNDSF9DT01NQU5EX19ESVJF
Q1RfUkVHX1dSSVRFOwogCWRpcmVjdF9yZF9tb2Rfd3QuY21kX2hlYWRlci5jb21tYW5kX3R5cGUg
PSBNTVNDSF9DT01NQU5EX19ESVJFQ1RfUkVHX1JFQURfTU9ESUZZX1dSSVRFOwotCWRpcmVjdF9w
b2xsLmNtZF9oZWFkZXIuY29tbWFuZF90eXBlID0gTU1TQ0hfQ09NTUFORF9fRElSRUNUX1JFR19Q
T0xMSU5HOwogCWVuZC5jbWRfaGVhZGVyLmNvbW1hbmRfdHlwZSA9IE1NU0NIX0NPTU1BTkRfX0VO
RDsKCiAJaGVhZGVyLT52ZXJzaW9uID0gTU1TQ0hfVkVSU0lPTjsKLS0KMi4yNi4wLjEwNi5nOWZh
ZGVkZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
