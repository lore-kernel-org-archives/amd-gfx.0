Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F968C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF4621845
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF4621845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D426EA7D;
	Wed, 20 Nov 2019 15:09:23 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443156E443;
 Wed, 20 Nov 2019 12:54:23 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9690A185A7C5B051E633;
 Wed, 20 Nov 2019 20:54:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 20:54:10 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
 <luben.tuikov@amd.com>
Subject: [PATCH 0/2] fix inappropriate use of declaring variable 'static' in
 fixed31_32.h
Date: Wed, 20 Nov 2019 21:15:31 +0800
Message-ID: <20191120131533.12720-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
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
Message-ID: <20191120131531.PNNv5BDmv30XeeRloGhz8MI5mi2mIccXGB2Bb-FUJN8@z>

VGhlIGZpcnN0IHBhdGNoIHJlbW92ZSB0d28gc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZS4KClRo
ZSBzZWNvbmQgcGF0Y2ggbWFrZSB0aGUgdmFyaWFibGVzIGluIGZpeGVkMzFfMzIuaCAnZ2xvYmFs
JwppbnN0ZWFkIG9mICdzdGF0aWMnLgoKeXUga3VhaSAoMik6CiAgZHJtL2FtZC9kaXNwbGF5OiBy
ZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnZGNfZml4cHRfZScgYW5kCiAgICAnZGNf
Zml4cHRfcGknCiAgZHJtL2FtZC9kaXNwbGF5OiBtYWtlIHZhcmlvdXMgdmFyaWFibGVzIGluIGZp
eGVkMzFfMzIuaCAnZ2xvYmFsJwogICAgaW5zdGVhZCBvZiAnc3RhdGljJwoKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vTWFrZWZpbGUgfCAgMiArLQogLi4uL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2ZpeGVkMzFfMzIuYyB8IDEzICsrKysrKysrKysrKysKIC4u
Li9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oICAgfCAxOCArKysrKysr
Ky0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9maXhlZDMxXzMyLmMKCi0tIAoyLjE3LjIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
