Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212BC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A2121845
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A2121845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A6F6EA77;
	Wed, 20 Nov 2019 15:09:22 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475136E443;
 Wed, 20 Nov 2019 12:54:24 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8F512BC4B6B6A5AB39FE;
 Wed, 20 Nov 2019 20:54:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 20:54:11 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
 <luben.tuikov@amd.com>
Subject: [PATCH 1/2] drm/amd/display: remove set but not used variable
 'dc_fixpt_e' and 'dc_fixpt_pi'
Date: Wed, 20 Nov 2019 21:15:32 +0800
Message-ID: <20191120131533.12720-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191120131533.12720-1-yukuai3@huawei.com>
References: <20191120131533.12720-1-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 20 Nov 2019 15:09:21 +0000
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
Message-ID: <20191120131532.LwKpogkrF0Nxmb1NkqXGVrkh8zw8HOFDoAhQep315Wc@z>

J2RjX2ZpeHB0X2UnIGFuZCAnZGNfZml4cHRfcGknIGFyZSBzZXQgaW4gJ2ZpeGVkMzFfMzIuaCcu
IEhvd2V2ZXIsIHRoZXkKYXJlIG5ldmVyIHVzZWQgYW5kIHNvIGNhbiBiZSByZW1vdmVkLgoKRml4
ZXM6IGViMGU1MTU0NjRlNCAoImRybS9hbWQvZGlzcGxheTogZ2V0IHJpZCBvZiAzMi4zMiB1bnNp
Z25lZCBmaXhlZCBwb2ludCIpClNpZ25lZC1vZmYtYnk6IHl1IGt1YWkgPHl1a3VhaTNAaHVhd2Vp
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9maXhlZDMxXzMy
LmggfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9maXhlZDMxXzMyLmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9maXhlZDMxXzMyLmgKaW5kZXggODllZjlmNjg2
MGU1Li4yOTEyMTUzNjJlM2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9pbmNsdWRlL2ZpeGVkMzFfMzIuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
aW5jbHVkZS9maXhlZDMxXzMyLmgKQEAgLTY5LDkgKzY5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2Vwc2lsb24gPSB7IDFMTCB9Owogc3RhdGljIGNvbnN0IHN0
cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2hhbGYgPSB7IDB4ODAwMDAwMDBMTCB9Owogc3RhdGlj
IGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X29uZSA9IHsgMHgxMDAwMDAwMDBMTCB9
OwogCi1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfcGkgPSB7IDEzNDkz
MDM3NzA1TEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF90d29f
cGkgPSB7IDI2OTg2MDc1NDA5TEwgfTsKLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBk
Y19maXhwdF9lID0geyAxMTY3NDkzMTU1NUxMIH07CiBzdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVk
MzFfMzIgZGNfZml4cHRfbG4yID0geyAyOTc3MDQ0NDcxTEwgfTsKIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZml4ZWQzMV8zMiBkY19maXhwdF9sbjJfZGl2XzIgPSB7IDE0ODg1MjIyMzZMTCB9OwogCi0t
IAoyLjE3LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
