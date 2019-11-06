Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E84C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3F22166E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3F22166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3996B6EDA2;
	Wed,  6 Nov 2019 15:21:36 +0000 (UTC)
X-Greylist: delayed 935 seconds by postgrey-1.36 at gabe;
 Wed, 06 Nov 2019 09:30:31 UTC
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
 by gabe.freedesktop.org (Postfix) with ESMTP id ED20A6EC75;
 Wed,  6 Nov 2019 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [202.112.113.212])
 by smtp2 (Coremail) with SMTP id GtxpCgCXOxEGj8Jd3sZmBA--.31S3;
 Wed, 06 Nov 2019 17:14:48 +0800 (CST)
From: Pan Bian <bianpan2016@163.com>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] drm/amdgpu: fix potential double drop fence reference
Date: Wed,  6 Nov 2019 17:14:45 +0800
Message-Id: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgCXOxEGj8Jd3sZmBA--.31S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWfKF1xur1kCrW8Zr47urg_yoWDCwb_uF
 WUXFn3Cw13CFn0gF17Zr45Za9rt345Za1kWr1ft39YyryUZ3yjq34Uurn5Xa18uayxWasr
 X3WqgFyYkwnrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjXdb7UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAhlclSIdIDGYwAAsS
X-Mailman-Approved-At: Wed, 06 Nov 2019 15:21:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:Subject:Date:Message-Id; bh=sVdTflIE+iXOvcN6Wo
 Co4qaadEnEkJvxlkUvIsF0664=; b=LuKoXVvYBTHDB35390tz/PmzS63L14Czxp
 YffOwccsl12O3nTXjjBNyxg1uUOghBPiyU4jOs/3x/3/eAfI/4nsDVEg8E85ko55
 Uxigc19ZUFHZy0yBILc9qstlxkVmXQTLDCnia55Ax4zKX4UO8m0mFrWuqim1tRWe
 zxuTErRKQ=
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
Cc: Pan Bian <bianpan2016@163.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106091445.aKx2AJujnX3lrqBuJ7JxXrSE9gdPv1gojTR2AGBH5YE@z>

VGhlIG9iamVjdCBmZW5jZSBpcyBub3Qgc2V0IHRvIE5VTEwgYWZ0ZXIgaXRzIHJlZmVyZW5jZSBp
cyBkcm9wcGVkLiBBcyBhCnJlc3VsdCwgaXRzIHJlZmVyZW5jZSBtYXkgYmUgZHJvcHBlZCBhZ2Fp
biBpZiBlcnJvciBvY2N1cnMgYWZ0ZXIgdGhhdCwKd2hpY2ggbWF5IGxlYWQgdG8gYSB1c2UgYWZ0
ZXIgZnJlZSBidWcuIFRvIGF2b2lkIHRoZSBpc3N1ZSwgZmVuY2UgaXMKZXhwbGljaXRseSBzZXQg
dG8gTlVMTCBhZnRlciBkcm9wcGluZyBpdHMgcmVmZXJlbmNlLgoKU2lnbmVkLW9mZi1ieTogUGFu
IEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Rlc3QuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYwppbmRleCBiNjZkMjlkNWZm
YTIuLmIxNTgyMzBhZjhkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Rlc3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVz
dC5jCkBAIC0xMzgsNiArMTM4LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RvX3Rlc3RfbW92ZXMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCX0KIAogCQlkbWFfZmVuY2VfcHV0KGZlbmNl
KTsKKwkJZmVuY2UgPSBOVUxMOwogCiAJCXIgPSBhbWRncHVfYm9fa21hcCh2cmFtX29iaiwgJnZy
YW1fbWFwKTsKIAkJaWYgKHIpIHsKQEAgLTE4Myw2ICsxODQsNyBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfZG9fdGVzdF9tb3ZlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJfQogCiAJCWRt
YV9mZW5jZV9wdXQoZmVuY2UpOworCQlmZW5jZSA9IE5VTEw7CiAKIAkJciA9IGFtZGdwdV9ib19r
bWFwKGd0dF9vYmpbaV0sICZndHRfbWFwKTsKIAkJaWYgKHIpIHsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
