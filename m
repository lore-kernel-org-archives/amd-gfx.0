Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C9C17441
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FBF20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FBF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9030E6E850;
	Mon, 11 Nov 2019 08:09:42 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AE96E188;
 Sat,  9 Nov 2019 09:37:45 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 90CE4619E8C40F4C68F4;
 Sat,  9 Nov 2019 17:37:37 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 17:37:27 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable
 'ds_port'
Date: Sat, 9 Nov 2019 17:37:25 +0800
Message-ID: <20191109093725.42364-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 11 Nov 2019 08:09:41 +0000
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
Message-ID: <20191109093725.NS3iCxk4pq8v2lgmpHHWIOhZfFs19djZCTBPOQ_v5Io@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYzogSW4gZnVu
Y3Rpb24gZHBfd2FfcG93ZXJfdXBfMDAxMEZBOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jOjIzMjA6MzU6IHdhcm5pbmc6CiB2YXJpYWJs
ZSBkc19wb3J0IHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJ
dCBpcyBuZXZlciB1c2VkLCBzbyBjYW4gYmUgcmVtb3ZlZC4KClNpZ25lZC1vZmYtYnk6IFl1ZUhh
aWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgfCA0IC0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X2xpbmtfZHAuYwppbmRleCA2NWRlMzJmLi5iODE0Yjc0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCkBAIC0yOTEwLDcgKzI5MTAsNiBA
QCBzdGF0aWMgdm9pZCBkcF93YV9wb3dlcl91cF8wMDEwRkEoc3RydWN0IGRjX2xpbmsgKmxpbmss
IHVpbnQ4X3QgKmRwY2RfZGF0YSwKIAkJaW50IGxlbmd0aCkKIHsKIAlpbnQgcmV0cnkgPSAwOwot
CXVuaW9uIGRwX2Rvd25zdHJlYW1fcG9ydF9wcmVzZW50IGRzX3BvcnQgPSB7IDAgfTsKIAogCWlm
ICghbGluay0+ZHBjZF9jYXBzLmRwY2RfcmV2LnJhdykgewogCQlkbyB7CkBAIC0yOTIzLDkgKzI5
MjIsNiBAQCBzdGF0aWMgdm9pZCBkcF93YV9wb3dlcl91cF8wMDEwRkEoc3RydWN0IGRjX2xpbmsg
KmxpbmssIHVpbnQ4X3QgKmRwY2RfZGF0YSwKIAkJfSB3aGlsZSAocmV0cnkrKyA8IDQgJiYgIWxp
bmstPmRwY2RfY2Fwcy5kcGNkX3Jldi5yYXcpOwogCX0KIAotCWRzX3BvcnQuYnl0ZSA9IGRwY2Rf
ZGF0YVtEUF9ET1dOU1RSRUFNUE9SVF9QUkVTRU5UIC0KLQkJCQkgRFBfRFBDRF9SRVZdOwotCiAJ
aWYgKGxpbmstPmRwY2RfY2Fwcy5kb25nbGVfdHlwZSA9PSBESVNQTEFZX0RPTkdMRV9EUF9WR0Ff
Q09OVkVSVEVSKSB7CiAJCXN3aXRjaCAobGluay0+ZHBjZF9jYXBzLmJyYW5jaF9kZXZfaWQpIHsK
IAkJLyogMDAxMEZBIGFjdGl2ZSBkb25nbGVzIChEUC1WR0EsIERQLURMRFZJIGNvbnZlcnRlcnMp
IHBvd2VyIGRvd24KLS0gCjIuNy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
