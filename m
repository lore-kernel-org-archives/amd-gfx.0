Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 08:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C5F10E051;
	Mon, 25 Apr 2022 08:56:20 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D979510E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 08:56:18 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id j8so25493871pll.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=nTikMFNvmRkqRzBP3pzt0Tft2QZ8Ti1O8GBBlN6MPrE=;
 b=GRZiGYxgAMrVd5a0RLPWGGYZIJnDDrZ2vvbkLZVlrsxk1esgKgMS+RI4N3ljqNaJNo
 laArTzYOODeKAEY6zTEp9Vfm2GA2EZSX/8rF+mPQhmFekyOutZyjKp98VNPgHdx+YB4e
 6MgGpJNVcpipFL3OhfHsCxR09OsLoxDO9pAeELysdFBG/+pU5YeJxdrpNqQ8StBhMVII
 h91x78YJcyQRUFUJ42h9Vi/aqa7BsLCSHaEQTnfNDXUSXLCXuCISYlO+mDYkizTR5E1+
 gC+JcS+A0yE6cXOjQok22iN+EOUQ5r2/6IHJGylZpx5RIdUPGdLn4Z8rBwO5wIpAeryq
 Eezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=nTikMFNvmRkqRzBP3pzt0Tft2QZ8Ti1O8GBBlN6MPrE=;
 b=P6fvuw/foFd9nAErd3taN0hMHxhsa0N7OT4HvfFFfQoiSsvS6La7yim634Mhv8p8zj
 7vibXjxcXJ0w73NHPpQ2NJBqBp8Gjhv75SWOtzNaiMhmGMo1GDGnOSzYok/FdCLMN+FY
 /hw09SIslq4TYw+UzgqQT4Ume7RLV1vvqrHHdtGwJlKcUHU7APYb3tyVNbvVPHLZAcOj
 DNf1vuWetp4M4CKf0kS1XrqDhlNlJ24rNBvZtsQ9aGMNsZsWfn0QTLI3yfxAl5/SWPUp
 4Vp5qC1JAWP1MW92OqLnJ3liIRXozkFJjz3gBftDdskxuB2JhToFM5dyh5EQ4KtAs1zv
 +dXg==
X-Gm-Message-State: AOAM533E0mMJycdiQe7181C8aCKO1j1bMqkqB5ZChOsEgOAwddb6MeJZ
 +Z4zJBO3s8hNlGBYHPkTsVpRt72sd8C8tPNMTdm/03esOPk=
X-Google-Smtp-Source: ABdhPJzHCmjOr696cLesQ1RqGP8wIp6s/DLZXQ4qe/CrfMfBC8/IMX8cJKPAIwA4EP2xZJ07itBp4Msx9yRI2gyK0CU=
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id
 bj6-20020a170902850600b001548692a7acmr17030966plb.10.1650876978261; Mon, 25
 Apr 2022 01:56:18 -0700 (PDT)
MIME-Version: 1.0
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 16:56:05 +0800
Message-ID: <CAHpOOhHucS2QJSW3-jyGg8v8AMoCp2nV0h7T2rL_TQf6EHRvaA@mail.gmail.com>
Subject: [PATCH] Fix out-of-bound access for gfx_v10_0_ring_test_ib()
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: emily.deng@amd.com, ckoenig.leichtzumerken@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gfx_v10_0_ring_test_ib() function uses 20 bytes instead of 16
bytes during the test. The patch sets the size of the allocation to be
4-byte larger to match the actual usage.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9426e252d8aa..b131235826b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3830,7 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
amdgpu_ring *ring, long timeout)
        gpu_addr = adev->wb.gpu_addr + (index * 4);
        adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
        memset(&ib, 0, sizeof(ib));
-       r = amdgpu_ib_get(adev, NULL, 16,
+       r = amdgpu_ib_get(adev, NULL, 20,
                                        AMDGPU_IB_POOL_DIRECT, &ib);
        if (r)
                goto err1;
--
2.25.1
