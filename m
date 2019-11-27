Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93007C43215
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719D32154A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 20:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D32154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C296892AA;
	Wed, 27 Nov 2019 20:56:56 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACCF892AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 20:56:55 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id c124so16404314qkg.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 12:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=29onNt7xtfdfnht+Xeo8WEg8G3fXp4rYGeqImg+MJzE=;
 b=MVJOvMro+v0d5bVSnjBXunJTE6oRDKXGzfHCkbq/7/BPvSKyfhsPJZ7C37PX+/4hth
 kg/6apLleF9T5ktF2OSO+UCNZZDf4prKiYhg0Rdq7GMEDClien5vt9Bvz6rwcqJth2Vj
 TvzzyKEu2cOPGep4tZk7kGVayP5ZVzSKok3SvdO3HGWw7D02mQ5M0eX6uAU8aoA9A8BN
 bIqkMivxZjqFcRnU45KAyxJnDIafKOOBjplSXqzQ446M2rZMIbqsn6adLaMKa4e4vLn4
 ReWzQg5zNe48441QuuGvIRTMGdKYql+k9mzFifbw9i0ouIDGRNnSFZ8NaSfc+hZW/ovI
 WXhg==
X-Gm-Message-State: APjAAAXQeJ/lCIioW+DC+1Oa3iYsS7vbP/6kvjLV049QPHRT+ayAHDcN
 VwCi4LKnbWx+Vh/AoXdNUZylmbiw
X-Google-Smtp-Source: APXvYqxIEb2hSlXLDixKTHds95ALtfc6a+Uwfa9zHQCSw9yGhnt/nT21sViEukF+ytjbCFKHZHCoqQ==
X-Received: by 2002:a05:620a:1663:: with SMTP id
 d3mr6692604qko.204.1574888214219; 
 Wed, 27 Nov 2019 12:56:54 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id h14sm7134566qkg.53.2019.11.27.12.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 12:56:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: move CS secure flag next the structs where it's
 used
Date: Wed, 27 Nov 2019 15:56:46 -0500
Message-Id: <20191127205646.953566-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=29onNt7xtfdfnht+Xeo8WEg8G3fXp4rYGeqImg+MJzE=;
 b=irqzVmgguju60lySd0435Rg4AmLlWFdWGLa6b42PeJWPiDj5En0tQXCo4xObs/fEt0
 +vK3jwOAAY83Coao04bU6x2VSqogSXWvhGDpwmTP7u0zjQpAh73u4EZBbMoAhcRLdddA
 D2mjxCld9Ej2ER2JsnzyWVSo1PcvGiau3QODuYzWpGnfrqQXpp1TwtVXFrWv92ANx1go
 8cLD74momhUPKMjBuDP5+VquY6UflPwDcGlbzMBvKl//4hSedBWSUUdAHrOxvpPZK0eM
 JrzTFJlf5WBHbAKnl74pnrlz7HauRrW311554yyhw7bc6e5nDyBoKQ6ZZdpts3nm6gY7
 hkHA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127205646.BS0TZ0Oycw0pVdzFB-xRtIc5GMt0V5zYzZVFPactM80@z>

U28gaXQncyBub3QgbWl4ZWQgdXAgd2l0aCB0aGUgQ1RYIHN0dWZmLgoKU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGluY2x1ZGUvdWFw
aS9kcm0vYW1kZ3B1X2RybS5oIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRleCBmNzVjNjk1NzA2
NGQuLjkxOGFjMzU0OGNkMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTIwNyw5ICsyMDcsNiBA
QCB1bmlvbiBkcm1fYW1kZ3B1X2JvX2xpc3QgewogI2RlZmluZSBBTURHUFVfQ1RYX09QX1FVRVJZ
X1NUQVRFCTMKICNkZWZpbmUgQU1ER1BVX0NUWF9PUF9RVUVSWV9TVEFURTIJNAogCi0vKiBGbGFn
IHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gYXMgc2VjdXJlICovCi0jZGVmaW5lIEFNREdQVV9DU19G
TEFHU19TRUNVUkUgICAgICAgICAgKDEgPDwgMCkKLQogLyogR1BVIHJlc2V0IHN0YXR1cyAqLwog
I2RlZmluZSBBTURHUFVfQ1RYX05PX1JFU0VUCQkwCiAvKiB0aGlzIHRoZSBjb250ZXh0IGNhdXNl
ZCBpdCAqLwpAQCAtNTU5LDYgKzU1Niw5IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2NodW5rIHsK
IAlfX3U2NAkJY2h1bmtfZGF0YTsKIH07CiAKKy8qIEZsYWcgdGhlIGNvbW1hbmQgc3VibWlzc2lv
biBhcyBzZWN1cmUgKi8KKyNkZWZpbmUgQU1ER1BVX0NTX0ZMQUdTX1NFQ1VSRSAgICAgICAgICAo
MSA8PCAwKQorCiBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19pbiB7CiAJLyoqIFJlbmRlcmluZyBjb250
ZXh0IGlkICovCiAJX191MzIJCWN0eF9pZDsKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
