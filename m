Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09DC83003
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2276F20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2276F20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675BD6E432;
	Thu, 30 Apr 2020 02:23:27 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D346E9E4;
 Thu, 30 Apr 2020 02:19:58 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8E3BE1679F5742A7E362;
 Thu, 30 Apr 2020 10:19:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 10:19:45 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: remove set but not used variable
 'direct_poll' in vcn_v2_0.c
Date: Thu, 30 Apr 2020 10:26:52 +0800
Message-ID: <20200430022653.46365-3-zhengbin13@huawei.com>
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
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYzoxODQ4OjM5OiB3YXJuaW5nOiB2YXJpYWJsZSDi
gJhkaXJlY3RfcG9sbOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQoKSXQgaXMgaW50cm9kdWNlZCBieSBjb21taXQgZGQyNjg1OGE5Y2Q4ICgiZHJtL2FtZGdw
dToKaW1wbGVtZW50IGluaXRpYWxpemF0aW9uIHBhcnQgb24gVkNOMi4wIGZvciBTUklPViIpLCBi
dXQgbmV2ZXIgdXNlZCwKc28gcmVtb3ZlIGl0LgoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1
bGtjaUBodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiBaaGVuZyBCaW4gPHpoZW5nYmluMTNAaHVh
d2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jIHwgMyAt
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjJfMC5jCmluZGV4IDM0OWRhN2JmN2M2OC4uOTBlZDc3MzY5NWVhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKQEAgLTE4NDUsNyArMTg0NSw2IEBAIHN0YXRpYyBp
bnQgdmNuX3YyXzBfc3RhcnRfc3Jpb3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJdWlu
dDMyX3QgdGFibGVfc2l6ZSA9IDA7CiAJc3RydWN0IG1tc2NoX3YyXzBfY21kX2RpcmVjdF93cml0
ZSBkaXJlY3Rfd3QgPSB7IHswfSB9OwogCXN0cnVjdCBtbXNjaF92Ml8wX2NtZF9kaXJlY3RfcmVh
ZF9tb2RpZnlfd3JpdGUgZGlyZWN0X3JkX21vZF93dCA9IHsgezB9IH07Ci0Jc3RydWN0IG1tc2No
X3YyXzBfY21kX2RpcmVjdF9wb2xsaW5nIGRpcmVjdF9wb2xsID0geyB7MH0gfTsKIAlzdHJ1Y3Qg
bW1zY2hfdjJfMF9jbWRfZW5kIGVuZCA9IHsgezB9IH07CiAJc3RydWN0IG1tc2NoX3YyXzBfaW5p
dF9oZWFkZXIgKmhlYWRlcjsKIAl1aW50MzJfdCAqaW5pdF90YWJsZSA9IGFkZXYtPnZpcnQubW1f
dGFibGUuY3B1X2FkZHI7CkBAIC0xODU1LDggKzE4NTQsNiBAQCBzdGF0aWMgaW50IHZjbl92Ml8w
X3N0YXJ0X3NyaW92KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWRpcmVjdF93dC5jbWRf
aGVhZGVyLmNvbW1hbmRfdHlwZSA9IE1NU0NIX0NPTU1BTkRfX0RJUkVDVF9SRUdfV1JJVEU7CiAJ
ZGlyZWN0X3JkX21vZF93dC5jbWRfaGVhZGVyLmNvbW1hbmRfdHlwZSA9CiAJCU1NU0NIX0NPTU1B
TkRfX0RJUkVDVF9SRUdfUkVBRF9NT0RJRllfV1JJVEU7Ci0JZGlyZWN0X3BvbGwuY21kX2hlYWRl
ci5jb21tYW5kX3R5cGUgPQotCQlNTVNDSF9DT01NQU5EX19ESVJFQ1RfUkVHX1BPTExJTkc7CiAJ
ZW5kLmNtZF9oZWFkZXIuY29tbWFuZF90eXBlID0gTU1TQ0hfQ09NTUFORF9fRU5EOwoKIAlpZiAo
aGVhZGVyLT52Y25fdGFibGVfb2Zmc2V0ID09IDAgJiYgaGVhZGVyLT52Y25fdGFibGVfc2l6ZSA9
PSAwKSB7Ci0tCjIuMjYuMC4xMDYuZzlmYWRlZGQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
