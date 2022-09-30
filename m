Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5D1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 22:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CFB10EDD1;
	Fri, 30 Sep 2022 22:18:19 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D032610EDB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 21:41:44 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id y136so5326396pfb.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=U12h1tulyTWLbCHo9k/gp5lmN36RncBZG5run1h1B84=;
 b=c5qcuCBUlxRFF84dbaO4liM94ZnRawB2C6yLVtW2P6S93M1xGvvZaQgBSRuGXhVJyY
 B44/Z9SqsMfKyz9LeV5CtczacVV/jeQ/4pFNlX7YoSbJHvIs9S/7p3G7VSLT68O5V3m5
 VTLzYbxJsnEwTuOXQh6+NDNZUkLFEE4ht42hiHl4rZcFdGBij5EKLTgG30o1JVslbNzB
 Q8eWJqh+XdvHUWDma9jPtnVwvg1z4QiJv3Tb3EWiXO+KdNbrSja+dyPvcvtj1jDwIDSx
 notfSPuVfhYYvUQUlLrbssaCZK1ZGyqhGcMn6Zouc57KlLkYT7RhySj9R2kK0TwrLEf2
 xoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=U12h1tulyTWLbCHo9k/gp5lmN36RncBZG5run1h1B84=;
 b=PDbDn9Uf+GzBf84b3UJAtVYhlz0f18UAMoytPp5TkGQLL1mDXD1RnRbe0i7GPHsD5B
 ylz+D6wAauJT02QMkeZdn+PSqFzGiYX0H8hjJsMd8RZJzKr9FqNE2/R1QVgzxxsWuDYP
 PYRaCoJnBqD4lAgwVXaVemiP8Tg3UajK9SPTXPT6JmPV5vIEtgoJo3bk1oKEyneedOQy
 zo855Wp00T//qHQhKV3DZV9cLJM2JLy+p2pzQ8JdoFrdQWwtLpPzP1lGV64DdJQPDvdw
 ZLlnh02zrkc5DfAdbT4lLYIctIYMZMFKPgMx+vCkh5nPk42OHWRj58rqeafpn4LbXdoW
 pm3w==
X-Gm-Message-State: ACrzQf01mELKY2oNAE/fUC2Zny8S561czgJ5i4Oji9CVyNLIK9PrGApT
 0C2hIJ/j9X75lqFAUgcsPNE=
X-Google-Smtp-Source: AMsMyM76iIPtlpcWQVZOjeTzjaEHIhP9J5ITCRQx9Mm7wYnAABGcO3Y9OQ3yYCtYQk7vXKKHjeeHPw==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id
 k8-20020a056a00168800b0053b42397c5cmr11114917pfc.81.1664574104246; 
 Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
 by smtp.gmail.com with ESMTPSA id
 p124-20020a62d082000000b0053617cbe2d2sm2281711pfg.168.2022.09.30.14.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/1] drm/amdgpu: Fix null-ptr-deref in
 amdgpu_device_fini_sw()
Date: Sat,  1 Oct 2022 05:41:10 +0800
Message-Id: <20220930214110.1074226-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
References: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Sep 2022 22:18:15 +0000
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
Cc: Steven J Abner <pheonix.sja@att.net>,
 "David C . Rankin" <drankinatty@suddenlinkmail.com>,
 Zhang Boyang <zhangboyang.id@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After amdgpu_device_init() failed, adev->reset_domain may be NULL. Thus
subsequent call to amdgpu_device_fini_sw() may result in null-ptr-deref.

This patch fixes the problem by adding a NULL pointer check around the
code of releasing adev->reset_domain in amdgpu_device_fini_sw().

Fixes: cfbb6b004744 ("drm/amdgpu: Rework reset domain to be refcounted.")

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
Link: https://lore.kernel.org/lkml/a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com/
Link: https://lore.kernel.org/lkml/AT9WHR.3Z1T3VI9A2AQ3@att.net/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index be7aff2d4a57..204daad06b32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4021,8 +4021,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if (adev->mman.discovery_bin)
 		amdgpu_discovery_fini(adev);
 
-	amdgpu_reset_put_reset_domain(adev->reset_domain);
-	adev->reset_domain = NULL;
+	if (adev->reset_domain) {
+		amdgpu_reset_put_reset_domain(adev->reset_domain);
+		adev->reset_domain = NULL;
+	}
 
 	kfree(adev->pci_state);
 
-- 
2.30.2

