Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A0C17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498A82196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498A82196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060C46EA79;
	Tue, 12 Nov 2019 08:44:51 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6AF6E340;
 Tue, 12 Nov 2019 02:12:03 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7A28C9AFCD83B5867FBA;
 Tue, 12 Nov 2019 10:12:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 10:11:50 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>, <Anthony.Koo@amd.com>,
 <Zhan.Liu@amd.com>
Subject: [PATCH v2 -next] drm/amd/display: remove set but not used variable
 'bpc'
Date: Tue, 12 Nov 2019 10:10:50 +0800
Message-ID: <20191112021050.13128-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191109093538.23964-1-yuehaibing@huawei.com>
References: <20191109093538.23964-1-yuehaibing@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 12 Nov 2019 08:44:49 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112021050.afi_6sW0hYr14dEmjvRDIE4ApeAZ9IySBgGodW98zv8@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzogSW4gZnVuY3Rp
b24gZ2V0X3Bibl9mcm9tX3RpbWluZzoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9jb3JlL2RjX2xpbmsuYzoyMzY0OjExOiB3YXJuaW5nOgogdmFyaWFibGUgYnBjIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBub3QgdXNl
ZCBzaW5jZSBjb21taXQgZTQ5ZjY5MzYzYWRmICgiZHJtL2FtZC9kaXNwbGF5OiB1c2UKcHJvcGVy
IGZvcm11bGEgdG8gY2FsY3VsYXRlIGJhbmR3aWR0aCBmcm9tIHRpbWluZyIpLCB0aGlzIGFsc28K
cmVtb3ZlIGdldF9jb2xvcl9kZXB0aCgpLCB3aGljaCBpcyBvbmx5IHVzZWQgaGVyZS4KClNpZ25l
ZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KLS0tCnYyOiBhbHNv
IHJlbW92ZSB1bnVzZWQgZ2V0X2NvbG9yX2RlcHRoKCkKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rLmMKaW5kZXggYmRjOGJlMy4uMWJlNDI3NyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwpAQCAtMjYzOCwyOCArMjYzOCwx
MyBAQCBzdGF0aWMgc3RydWN0IGZpeGVkMzFfMzIgZ2V0X3Bibl9wZXJfc2xvdChzdHJ1Y3QgZGNf
c3RyZWFtX3N0YXRlICpzdHJlYW0pCiAJcmV0dXJuIGRjX2ZpeHB0X2Rpdl9pbnQobWJ5dGVzX3Bl
cl9zZWMsIDU0KTsKIH0KIAotc3RhdGljIGludCBnZXRfY29sb3JfZGVwdGgoZW51bSBkY19jb2xv
cl9kZXB0aCBjb2xvcl9kZXB0aCkKLXsKLQlzd2l0Y2ggKGNvbG9yX2RlcHRoKSB7Ci0JY2FzZSBD
T0xPUl9ERVBUSF82NjY6IHJldHVybiA2OwotCWNhc2UgQ09MT1JfREVQVEhfODg4OiByZXR1cm4g
ODsKLQljYXNlIENPTE9SX0RFUFRIXzEwMTAxMDogcmV0dXJuIDEwOwotCWNhc2UgQ09MT1JfREVQ
VEhfMTIxMjEyOiByZXR1cm4gMTI7Ci0JY2FzZSBDT0xPUl9ERVBUSF8xNDE0MTQ6IHJldHVybiAx
NDsKLQljYXNlIENPTE9SX0RFUFRIXzE2MTYxNjogcmV0dXJuIDE2OwotCWRlZmF1bHQ6IHJldHVy
biAwOwotCX0KLX0KLQogc3RhdGljIHN0cnVjdCBmaXhlZDMxXzMyIGdldF9wYm5fZnJvbV90aW1p
bmcoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKIHsKLQl1aW50MzJfdCBicGM7CiAJdWludDY0
X3Qga2JwczsKIAlzdHJ1Y3QgZml4ZWQzMV8zMiBwZWFrX2ticHM7CiAJdWludDMyX3QgbnVtZXJh
dG9yOwogCXVpbnQzMl90IGRlbm9taW5hdG9yOwogCi0JYnBjID0gZ2V0X2NvbG9yX2RlcHRoKHBp
cGVfY3R4LT5zdHJlYW1fcmVzLnBpeF9jbGtfcGFyYW1zLmNvbG9yX2RlcHRoKTsKIAlrYnBzID0g
ZGNfYmFuZHdpZHRoX2luX2ticHNfZnJvbV90aW1pbmcoJnBpcGVfY3R4LT5zdHJlYW0tPnRpbWlu
Zyk7CiAKIAkvKgotLSAKMi43LjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
