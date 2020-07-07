Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E93C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5890C2065F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjaIFjia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5890C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E991C89ABA;
	Tue,  7 Jul 2020 18:15:03 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A566E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 18:04:46 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so10978pjb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NGLKeH7lxBGIFIh5Uwk1/4lFUzdaSRuadqhx86d9Cws=;
 b=QjaIFjia0y2R68tBv6FnUb3V3xydc8ciMgzwx6V0tuBRKbhf16YZO0jyJwp84etVK8
 yApAAW9sbxLQl5UjnUXxTrFWruqu/WEHbICF+mf8aj+SydKYrKS3FiHWRaxlXDidFqjR
 dumqOjxjLmim4N3rE5tT6+7yABePQJv+nqcte3PcGs7jhsM8/UqGq3WL0cqITUnwYqDV
 cZlQllCYDS1aZMcQsaMPhC3zD3+kfMdzc+8EGYetErXpm+2kr/A0kzMRQJHGboQEkJPM
 tqcxf95ylwI+RbcS2uL47XZz4n04KK/zfDgNBg/rKnvjJo9G1vAeNGrHORjkwTJUHlNx
 YVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NGLKeH7lxBGIFIh5Uwk1/4lFUzdaSRuadqhx86d9Cws=;
 b=BG9K6pAw55zZKJeGFulkQApj02TzBbivD0wV88aBut5JaWvYLJMk7AXkazeUD2QtXz
 IEuI4m5nok7TS6kh5sWmoaRAcMyVwUAyOFtltdRx+DmmdPo1QuSgNPhI6aCYrIgwX5d8
 9xPznC02ZwOp+kPSGXs4k4V4rjkkLLbH6McSa29iwM+bHKppmPLnK4m1Z95Vf+kDzGKR
 VaCbWMNCRhSmzXmKFHEO4/dOEerdB0EGj769nTsuu/QrO0gkuWsphctBv/dVPq4fORFK
 ohMoKYYFumG7y26jvRqk35Qy7e5LgzRLrrS9pqNLClcwfY1wNjrEjJL3eebZoYGFcdS0
 aHsA==
X-Gm-Message-State: AOAM533kR06FN5IfXXAQUP+ux0RZAqKZrtNFk2AOFzoK/L1s7VW57nSK
 IlrS+/OyUjxJcXN/BPNwavbsJo3p/js=
X-Google-Smtp-Source: ABdhPJx0WsS+bh297aZqEG1qRPrdJGPXipJdiX64sHzW5o6l38qrv7zY8qvdbe8Ixgi8app/HrKeWQ==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr46579644plb.235.1594145086031; 
 Tue, 07 Jul 2020 11:04:46 -0700 (PDT)
Received: from paxos.mtv.corp.google.com
 ([2620:15c:202:201:4a0f:cfff:fe5d:61cb])
 by smtp.gmail.com with ESMTPSA id z25sm22078016pfg.140.2020.07.07.11.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:04:45 -0700 (PDT)
From: Lepton Wu <ytht.net@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix null pointer reference to adev.
Date: Tue,  7 Jul 2020 11:04:30 -0700
Message-Id: <20200707180430.2760835-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <119ce850-c07f-8a4d-ac3c-78e021b7dd32@amd.com>
References: <119ce850-c07f-8a4d-ac3c-78e021b7dd32@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 07 Jul 2020 18:15:02 +0000
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Lepton Wu <ytht.net@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I hit this when compiling amdgpu in kernel. amdgpu_driver_load_kms fail
to load firmwares since GPU was initialized before rootfs is ready.
Just gracefully fail in such cases.

v2: Check return code of amdgpu_driver_load_kms

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 126e74758a34..75bcd1789185 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1111,7 +1111,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, dev);
 
-	amdgpu_driver_load_kms(dev, ent->driver_data);
+	ret = amdgpu_driver_load_kms(dev, ent->driver_data);
+	if (ret)
+		goto err_pci;
 
 retry_init:
 	ret = drm_dev_register(dev, ent->driver_data);
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
