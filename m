Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD5CA9ECF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 13:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0D620869
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 13:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0D620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165576E471;
	Mon,  4 Nov 2019 13:54:51 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441186E438;
 Mon,  4 Nov 2019 13:20:18 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 90058C797121F5EFFA09;
 Mon,  4 Nov 2019 21:20:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 21:20:04 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
 <luben.tuikov@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: remove set but not used variable 'dig'
Date: Mon, 4 Nov 2019 21:27:24 +0800
Message-ID: <1572874046-30996-6-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 04 Nov 2019 13:54:47 +0000
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
 dri-devel@lists.freedesktop.org, zhengbin13@huawei.com,
 amd-gfx@lists.freedesktop.org, yukuai3@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104132724.zFVIQhHmHy4fBgfEXjNn6Zzd5r9q-2tzv4IqcHD1N5k@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYzogSW4gZnVuY3Rpb24K4oCYYW1kZ3B1X2F0
b21iaW9zX2RwX2xpbmtfdHJhaW7igJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21i
aW9zX2RwLmM6NzE2OjM0OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhkaWfigJkKc2V0IGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkZpeGVzOiBkMzhjZWFmOTllZDAgKCJk
cm0vYW1kZ3B1OiBhZGQgY29yZSBkcml2ZXIgKHY0KSIpClNpZ25lZC1vZmYtYnk6IHl1IGt1YWkg
PHl1a3VhaTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9t
Ymlvc19kcC5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9zX2RwLmMKaW5kZXggOTQyNjUzMC4uZWE3MDJhNiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jCkBAIC03MTAsNyArNzEw
LDYgQEAgdm9pZCBhbWRncHVfYXRvbWJpb3NfZHBfbGlua190cmFpbihzdHJ1Y3QgZHJtX2VuY29k
ZXIgKmVuY29kZXIsCiAJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGVuY29kZXItPmRldjsKIAlz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CiAJc3RydWN0IGFt
ZGdwdV9lbmNvZGVyICphbWRncHVfZW5jb2RlciA9IHRvX2FtZGdwdV9lbmNvZGVyKGVuY29kZXIp
OwotCXN0cnVjdCBhbWRncHVfZW5jb2Rlcl9hdG9tX2RpZyAqZGlnOwogCXN0cnVjdCBhbWRncHVf
Y29ubmVjdG9yICphbWRncHVfY29ubmVjdG9yOwogCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yX2F0
b21fZGlnICpkaWdfY29ubmVjdG9yOwogCXN0cnVjdCBhbWRncHVfYXRvbWJpb3NfZHBfbGlua190
cmFpbl9pbmZvIGRwX2luZm87CkBAIC03MTgsNyArNzE3LDYgQEAgdm9pZCBhbWRncHVfYXRvbWJp
b3NfZHBfbGlua190cmFpbihzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCiAKIAlpZiAoIWFt
ZGdwdV9lbmNvZGVyLT5lbmNfcHJpdikKIAkJcmV0dXJuOwotCWRpZyA9IGFtZGdwdV9lbmNvZGVy
LT5lbmNfcHJpdjsKIAogCWFtZGdwdV9jb25uZWN0b3IgPSB0b19hbWRncHVfY29ubmVjdG9yKGNv
bm5lY3Rvcik7CiAJaWYgKCFhbWRncHVfY29ubmVjdG9yLT5jb25fcHJpdikKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
