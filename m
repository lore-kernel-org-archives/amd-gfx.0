Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E210CC4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F8F23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyXZY9Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F8F23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9786ED6B;
	Fri, 25 Sep 2020 20:11:24 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFA26ED6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:22 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id db4so2043648qvb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hc3w66p7RObQH95t+ur7uBsDisFKgJhR2LHCyQOttu0=;
 b=QyXZY9TqxYapeVZgNurlU+VJC+wM3KqGJsn8YINinZv32zsBUAa0KODeNJBh2uNXjF
 zMVv9aS3rxYlLYhCgt52wrlDaNhPLaaJGTbKWv+43gyMzNQJ+++5SEmUNvAKztechw28
 zadxuXvQSYzGneTcVWSDQVlPOwh/ZoSPUwHd5QsSE86Cl6WmcfU1Mg4Ty7/Z2QRamEAR
 rCaZnDWS7lwymNqz1qY1xkOBl9vOL19LtLt6lQIYwJSY2o7MC3iQVpQFOLtrVB9isvGE
 N33g8+NZ7xsDVn1olTWPwKGeB/d9ctjrata5RQhAUilJ4fLrdMBw2s8fMWDx1TzuPmA1
 4XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hc3w66p7RObQH95t+ur7uBsDisFKgJhR2LHCyQOttu0=;
 b=tXY1HpzlZuaq8p+xG4d+ZP0ko+xS44Ys3b8J+GjB6BetCL0cDrO+PIcnsKqB1VBwDy
 kHmfDxM0lihynThawTRKfN2mV6Vs7WPJnwOLXwLc5uA4jczweDBrBzzyZUJF4PZg1oZH
 j/hUlL+DEYwhalSPyT8Mm6J63WK6mE61DIka3xHqJk7rfqpB74dqUrF5A9uy9z1XtMmT
 RaAadkJ9RrwExwUTyAocGuxNlRkjaiFqtvHD3+46vbK20xwkeO2AFw7bzK3XpNIg248X
 hJ8bNDt+b29pxM/gHfY1mAY4Kr0GOWyFq9L9addM3DCNt8VUWUii2WBQESSpHMvyFr2+
 HMEw==
X-Gm-Message-State: AOAM5315r3mDCpvHu3Huvz9kcy3F//PIcQlxK8HGbVB2OrzdlDV0CkIy
 fvi5QQ34oA8yBTE+Nur0zoXfoIT5zGY=
X-Google-Smtp-Source: ABdhPJzAh0HNzaDYV1emnsRGoiEYYIWMF/Fhw3qHu0cd+ld3ErJpZXqer3Canm5XIZ9Fy1G1+kghqQ==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr355954qvv.3.1601064681779; 
 Fri, 25 Sep 2020 13:11:21 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/45] drm/amdgpu: set ip blocks for van gogh
Date: Fri, 25 Sep 2020 16:10:04 -0400
Message-Id: <20200925201029.1738724-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Enable ip blocks for van gogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8616d397da00..df94f72e017a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -604,6 +604,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
+	case CHIP_VANGOGH:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
