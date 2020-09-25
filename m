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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A1C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BC52399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNW09w/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC52399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3BB6ED7B;
	Fri, 25 Sep 2020 20:11:43 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1516ED7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:42 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id q10so2059422qvs.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GVPzixfwzb/5MaQJnnAaZmNXIPcYRHJ2CyYOxkuCq4w=;
 b=qNW09w/zLXlBc4WLjTxqTqlMRhKxj1PaqNs7R8o+zH3Th1rqkttTupSwwXYlhD9r1s
 nZN3oBMf8Jx76KV7XBb5VA1LEuCuR37UkHI14xHIRLiGM5dhRzPE9TGnpPmFd8YocEkS
 Bg+m6LNKrP0kGUBzyxtnXRTuhJVOaR0aONqCyoJuWOjZhSYvBjlvz2/Sp9SaV/vvip8+
 jW3h+KWRytTlhdivrHfrLIIE6tyIjest8irDiB5P7kec3w7X0ugzQSc+l5S3jHr3QofU
 /JHG3PoMCtPljv6LFiKVBnKhCagoyGa5/iCFWqWz8CvV1LNyvDKUPFDb1OqkmwIZLaPW
 RK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GVPzixfwzb/5MaQJnnAaZmNXIPcYRHJ2CyYOxkuCq4w=;
 b=gcPdqVLXsALl8grkfZOmpvIKPVLOE2e4KFGvvDFraP9rUYWNGcUiAVBLpX9D/jA9XV
 GLWfUKqTlw8+WZQgaMsmHjIlNRJQb7v/ydtAipndcPitWb0uL2tbG69WpP9kcwkDv45L
 3H9p6buwvkpbTMT1xXjAkxcu26YngU+LckpI05izNQs8bFHggzRY32NC9C6XExpWvUS6
 AVw5G6fKA5+x+oZJrGrylXtOL1/bJcZDl8WokNWg34QuUNxlTbBvSkt/evwS7SR3fb32
 F07NYuF0wGSBuC7PggM3Zx7p88OBwpaeL8r5RHNU+PAEwYA1uVX3A8J7i0GnEMmqkOeX
 MF2A==
X-Gm-Message-State: AOAM531PK3y4bdJ5yiT1MdRBxODr/KCe3jaG9Czf80unYYPGqMgwQK7N
 +UKRXOEJlyfBwWbBkOVLeG2V0c7/Sew=
X-Google-Smtp-Source: ABdhPJwZixcPKpnrrwAdSkwoZAS/Gj7eO6mY9Ggwwm+vfAKk9pj56Bzv00dMkj28CHF+aeB5k9IbAw==
X-Received: by 2002:ad4:4e8f:: with SMTP id dy15mr307211qvb.45.1601064701880; 
 Fri, 25 Sep 2020 13:11:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/45] drm/amdgpu: add smu ip block for vangogh
Date: Fri, 25 Sep 2020 16:10:18 -0400
Message-Id: <20200925201029.1738724-34-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to add ip block for vangogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3ac89109ea3e..4fbf3f6640e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -644,6 +644,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
