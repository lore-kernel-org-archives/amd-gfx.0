Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C3C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC2A2071E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC2A2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6906E3BC;
	Wed, 27 Nov 2019 17:42:44 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91DB6E4F4;
 Wed, 27 Nov 2019 09:26:32 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6914290590D71F0B58B1;
 Wed, 27 Nov 2019 17:26:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 17:26:20 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <rex.zhu@amd.com>, <evan.quan@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/powerplay: Remove unneeded variable 'result' in
 vega12_hwmgr.c
Date: Wed, 27 Nov 2019 17:33:41 +0800
Message-ID: <1574847222-51515-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
References: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 27 Nov 2019 17:42:39 +0000
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
Message-ID: <20191127093341.-JRpJ_YYGCaja5IMTncUQEgUPLjoKny5x7Epfj0qq1c@z>

Rml4ZXMgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3IvdmVnYTEyX2h3bWdyLmM6NTAyOjUtMTE6IFVubmVlZGVkIHZhcmlhYmxlOiAicmVzdWx0
Ii4gUmV0dXJuICIwIiBvbiBsaW5lIDUxNQoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtj
aUBodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWku
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21n
ci5jIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVn
YTEyX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJf
aHdtZ3IuYwppbmRleCA3YWY5YWQ0Li5hY2E2MWQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYwpAQCAtNDk5LDggKzQ5OSw2IEBA
IHN0YXRpYyBpbnQgdmVnYTEyX2dldF9udW1iZXJfb2ZfZHBtX2xldmVsKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IsCiBzdGF0aWMgaW50IHZlZ2ExMl9nZXRfZHBtX2ZyZXF1ZW5jeV9ieV9pbmRleChz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQlQUENMS19lIGNsa0lELCB1aW50MzJfdCBpbmRleCwg
dWludDMyX3QgKmNsb2NrKQogewotCWludCByZXN1bHQgPSAwOwotCiAJLyoKIAkgKlNNVSBleHBl
Y3RzIHRoZSBDbG9jayBJRCB0byBiZSBpbiB0aGUgdG9wIDE2IGJpdHMuCiAJICpMb3dlciAxNiBi
aXRzIHNwZWNpZnkgdGhlIGxldmVsCkBAIC01MTIsNyArNTEwLDcgQEAgc3RhdGljIGludCB2ZWdh
MTJfZ2V0X2RwbV9mcmVxdWVuY3lfYnlfaW5kZXgoc3RydWN0IHBwX2h3bWdyICpod21nciwKCiAJ
KmNsb2NrID0gc211bV9nZXRfYXJndW1lbnQoaHdtZ3IpOwoKLQlyZXR1cm4gcmVzdWx0OworCXJl
dHVybiAwOwogfQoKIHN0YXRpYyBpbnQgdmVnYTEyX3NldHVwX3NpbmdsZV9kcG1fdGFibGUoc3Ry
dWN0IHBwX2h3bWdyICpod21nciwKLS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
