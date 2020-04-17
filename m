Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B87C2D0EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3B32087E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3B32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846636E225;
	Fri, 17 Apr 2020 13:16:48 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46456E3A6;
 Fri, 17 Apr 2020 07:06:13 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E3852DE581F6460A0D08;
 Fri, 17 Apr 2020 15:06:08 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:05:59 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <evan.quan@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <yanaijie@huawei.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/powerplay: remove defined but not used variables
Date: Fri, 17 Apr 2020 15:32:19 +0800
Message-ID: <20200417073219.40320-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 17 Apr 2020 13:16:48 +0000
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
Cc: Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoZSBmb2xsb3dpbmcgZ2NjIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Bvd2VydHVuZS5jOjcxMDo0NjoKd2FybmluZzog
4oCYUFNNR0NFRENUaHJlc2hvbGRDb25maWdfdmVnYTEw4oCZIGRlZmluZWQgYnV0IG5vdCB1c2Vk
ClstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBzdGF0aWMgY29uc3Qgc3RydWN0IHZlZ2ExMF9k
aWR0X2NvbmZpZ19yZWcKUFNNR0NFRENUaHJlc2hvbGRDb25maWdfdmVnYTEwW10gPQpefn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93
ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wb3dlcnR1bmUuYzo2NTQ6NDY6Cndhcm5pbmc6IOKAmFBTTVNF
RURDVGhyZXNob2xkQ29uZmlnX1ZlZ2ExMOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZApbLVd1bnVz
ZWQtY29uc3QtdmFyaWFibGU9XQogc3RhdGljIGNvbnN0IHN0cnVjdCB2ZWdhMTBfZGlkdF9jb25m
aWdfcmVnClBTTVNFRURDVGhyZXNob2xkQ29uZmlnX1ZlZ2ExMFtdID0KXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5j
b20+ClNpZ25lZC1vZmYtYnk6IEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4KLS0tCiAu
Li4vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfcG93ZXJ0dW5lLmMgICAgfCAyMyAtLS0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Bvd2VydHVuZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Bvd2VydHVuZS5j
CmluZGV4IGNhOWIyM2I1YWJjOS4uOTc1N2Q0N2RkNmI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfcG93ZXJ0dW5lLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Bvd2VydHVuZS5jCkBAIC02NTEs
MTggKzY1MSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmVnYTEwX2RpZHRfY29uZmlnX3JlZyAg
IFBTTVNFRURDU3RhbGxEZWxheUNvbmZpZ19WZWdhMTBbXSA9CiAJeyAgIDB4RkZGRkZGRkYgIH0g
IC8qIEVuZCBvZiBsaXN0ICovCiB9OwogCi1zdGF0aWMgY29uc3Qgc3RydWN0IHZlZ2ExMF9kaWR0
X2NvbmZpZ19yZWcgICBQU01TRUVEQ1RocmVzaG9sZENvbmZpZ19WZWdhMTBbXSA9Ci17Ci0vKiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KLSAqICAgICAgT2Zmc2V0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYXNrICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNoaWZ0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWYWx1ZQotICogLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCi0gKi8KLQkvKiBTUSBFREMgVEhSRVNIT0xEICovCi0JeyAgIGl4RElEVF9TUV9FRENfVEhS
RVNIT0xELCAgICAgICAgICAgRElEVF9TUV9FRENfVEhSRVNIT0xEX19FRENfVEhSRVNIT0xEX01B
U0ssICAgICAgICAgICBESURUX1NRX0VEQ19USFJFU0hPTERfX0VEQ19USFJFU0hPTERfX1NISUZU
LCAgICAgICAgICAgIDB4MDAwMCB9LAotCi0JeyAgIDB4RkZGRkZGRkYgIH0gIC8qIEVuZCBvZiBs
aXN0ICovCi19OwotCiBzdGF0aWMgY29uc3Qgc3RydWN0IHZlZ2ExMF9kaWR0X2NvbmZpZ19yZWcg
ICBQU01TRUVEQ0N0cmxSZXNldENvbmZpZ19WZWdhMTBbXSA9CiB7CiAvKiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAgLTcw
NywxNyArNjk1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZWdhMTBfZGlkdF9jb25maWdfcmVn
ICAgUFNNU0VFRENDdHJsQ29uZmlnX1ZlZ2ExMFtdID0KIAl7ICAgMHhGRkZGRkZGRiAgfSAgLyog
RW5kIG9mIGxpc3QgKi8KIH07CiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3QgdmVnYTEwX2RpZHRfY29u
ZmlnX3JlZyAgIFBTTUdDRURDVGhyZXNob2xkQ29uZmlnX3ZlZ2ExMFtdID0KLXsKLS8qIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQotICogICAgICBPZmZzZXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1hc2sgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU2hpZnQgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZhbHVlCi0gKiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
LSAqLwotCXsgICBtbUdDX0VEQ19USFJFU0hPTEQsICAgICAgICAgICAgICAgIEdDX0VEQ19USFJF
U0hPTERfX0VEQ19USFJFU0hPTERfTUFTSywgICAgICAgICAgICAgICAgR0NfRURDX1RIUkVTSE9M
RF9fRURDX1RIUkVTSE9MRF9fU0hJRlQsICAgICAgICAgICAgICAgICAweDAwMDAwMDAgfSwKLQot
CXsgICAweEZGRkZGRkZGICB9ICAvKiBFbmQgb2YgbGlzdCAqLwotfTsKLQogc3RhdGljIGNvbnN0
IHN0cnVjdCB2ZWdhMTBfZGlkdF9jb25maWdfcmVnICAgUFNNR0NFRENEcm9vcEN0cmxDb25maWdf
dmVnYTEwW10gPQogewogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0tIAoyLjIxLjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
