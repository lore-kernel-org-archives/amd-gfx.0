Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742DC43215
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57950206F0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57950206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667266EB76;
	Thu, 14 Nov 2019 14:56:24 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBCA6E22C;
 Thu, 14 Nov 2019 12:29:17 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A4F6593F2003AFA9F635;
 Thu, 14 Nov 2019 20:29:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 20:29:03 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/display: remove set but not used variable
 'old_plane_crtc'
Date: Thu, 14 Nov 2019 20:36:24 +0800
Message-ID: <1573734987-119703-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
References: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 14 Nov 2019 14:56:23 +0000
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
Message-ID: <20191114123624.PfSKJO_NO4APoCNsCUlm9g2P2G6vtkbim-lQdHzMWc8@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzogSW4gZnVuY3Rpb24gZG1f
ZGV0ZXJtaW5lX3VwZGF0ZV90eXBlX2Zvcl9jb21taXQ6CmRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6NjUxNjozNjogd2FybmluZzogdmFyaWFibGUgb2xk
X3BsYW5lX2NydGMgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0K
Ckl0IGlzIGludHJvZHVjZWQgYnkgY29tbWl0IGE4N2ZhOTkzODc0OSAoImRybS9hbWQvZGlzcGxh
eToKQnVpbGQgc3RyZWFtIHVwZGF0ZSBhbmQgcGxhbmUgdXBkYXRlcyBpbiBkbSIpLCBidXQgbmV2
ZXIgdXNlZCwKc28gcmVtb3ZlIGl0LgoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBo
dWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
fCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CmluZGV4IGMyNzAwYmMuLjcwMGNiZDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtNzYxMSw3ICs3NjExLDcgQEAgZG1fZGV0
ZXJtaW5lX3VwZGF0ZV90eXBlX2Zvcl9jb21taXQoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFn
ZXIgKmRtLAogCWludCBpLCBqLCBudW1fcGxhbmUsIHJldCA9IDA7CiAJc3RydWN0IGRybV9wbGFu
ZV9zdGF0ZSAqb2xkX3BsYW5lX3N0YXRlLCAqbmV3X3BsYW5lX3N0YXRlOwogCXN0cnVjdCBkbV9w
bGFuZV9zdGF0ZSAqbmV3X2RtX3BsYW5lX3N0YXRlLCAqb2xkX2RtX3BsYW5lX3N0YXRlOwotCXN0
cnVjdCBkcm1fY3J0YyAqbmV3X3BsYW5lX2NydGMsICpvbGRfcGxhbmVfY3J0YzsKKwlzdHJ1Y3Qg
ZHJtX2NydGMgKm5ld19wbGFuZV9jcnRjOwogCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lOwoKIAlz
dHJ1Y3QgZHJtX2NydGMgKmNydGM7CkBAIC03NjU3LDcgKzc2NTcsNiBAQCBkbV9kZXRlcm1pbmVf
dXBkYXRlX3R5cGVfZm9yX2NvbW1pdChzdHJ1Y3QgYW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0s
CiAJCQl1aW50NjRfdCB0aWxpbmdfZmxhZ3M7CgogCQkJbmV3X3BsYW5lX2NydGMgPSBuZXdfcGxh
bmVfc3RhdGUtPmNydGM7Ci0JCQlvbGRfcGxhbmVfY3J0YyA9IG9sZF9wbGFuZV9zdGF0ZS0+Y3J0
YzsKIAkJCW5ld19kbV9wbGFuZV9zdGF0ZSA9IHRvX2RtX3BsYW5lX3N0YXRlKG5ld19wbGFuZV9z
dGF0ZSk7CiAJCQlvbGRfZG1fcGxhbmVfc3RhdGUgPSB0b19kbV9wbGFuZV9zdGF0ZShvbGRfcGxh
bmVfc3RhdGUpOwoKLS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
