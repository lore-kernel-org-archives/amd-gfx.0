Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F18FC43461
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A43610A6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A43610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3E66EAE2;
	Thu,  8 Apr 2021 13:13:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD666EACB;
 Thu,  8 Apr 2021 12:41:44 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGLRK5HsYzpVbR;
 Thu,  8 Apr 2021 20:38:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:41:34 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH -next] drm/amd/display: Fix the Wunused-function warning
Date: Thu, 8 Apr 2021 20:41:58 +0800
Message-ID: <1617885718-2697-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 08 Apr 2021 13:13:52 +0000
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Ma <hanghong.ma@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmM6OTQxOjEzOiB3YXJuaW5nOiDigJhkbV9kbXViX3RyYWNlX2hpZ2hfaXJx4oCZIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0KICA5NDEgfCBzdGF0aWMgdm9pZCBkbV9k
bXViX3RyYWNlX2hpZ2hfaXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpCiAgICAgIHwgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKRml4ZXM6IDgzYjM5ZTFmYzNlYSAoImRybS9h
bWQvZGlzcGxheTogTG9nIERNQ1VCIHRyYWNlIGJ1ZmZlciBldmVudHMiKQpDYzogTGVvIChIYW5n
aG9uZykgTWEgPGhhbmdob25nLm1hQGFtZC5jb20+CkNjOiBEYW5pZWwgV2hlZWxlciA8ZGFuaWVs
LndoZWVsZXJAYW1kLmNvbT4KQ2M6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQu
Y29tPgpDYzogU29sb21vbiBDaGl1IDxzb2xvbW9uLmNoaXVAYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogU2hhb2t1biBa
aGFuZyA8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGRhYWNjNWNjOGQ1MS4uNTI5OGU1
ZDQwNzViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKQEAgLTkzNyw2ICs5MzcsNyBAQCBzdGF0aWMgaW50IGRtX2RtdWJfaHdfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlyZXR1cm4gMDsKIH0KIAorI2lmIGRlZmlu
ZWQoQ09ORklHX0RSTV9BTURfRENfRENOKQogI2RlZmluZSBETVVCX1RSQUNFX01BWF9SRUFEIDY0
CiBzdGF0aWMgdm9pZCBkbV9kbXViX3RyYWNlX2hpZ2hfaXJxKHZvaWQgKmludGVycnVwdF9wYXJh
bXMpCiB7CkBAIC05NjMsNyArOTY0LDYgQEAgc3RhdGljIHZvaWQgZG1fZG11Yl90cmFjZV9oaWdo
X2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQogCUFTU0VSVChjb3VudCA8PSBETVVCX1RSQUNF
X01BWF9SRUFEKTsKIH0KIAotI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfRENfRENOKQogc3Rh
dGljIHZvaWQgbW1odWJfcmVhZF9zeXN0ZW1fY29udGV4dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGRjX3BoeV9hZGRyX3NwYWNlX2NvbmZpZyAqcGFfY29uZmlnKQogewogCXVp
bnQ2NF90IHB0X2Jhc2U7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
