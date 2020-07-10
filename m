Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61EDC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9081206A1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNampb8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9081206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CD16EC72;
	Fri, 10 Jul 2020 14:48:46 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC1A6EC72
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:48:45 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b4so5421359qkn.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CwRtWNwLFNlKDvHIp5GPE+CVeLHux7e3G/IqGD+IVyQ=;
 b=pNampb8H7E/oaMkbiPFZD0+a/6ejwS3mF5CtWRxBXSiO59VwrlRBEX4T5NJtHEP9L9
 InynOujTSSi4LM/fv1bat+Vzz8H5yDkAO8vMy3rB045WGVi6FHp6WD7MQ15gLzquLXaW
 61HFvO1feT2EWSnguqrHxakAiw+NSDYn4myaHA3NXXwnd8lzUnp0HQ4bm/8Mpgtkaik1
 hsHZP8oHwJS1N8OrPJEbkX7t8PfWrwS2FKK2RqbFg7yDudwAisuwz9ZWuhAlBUMAxRcu
 0IMRvpLTgd7D3sV+/qYWCd1bcbFuOcj18YROYYj1o3DphVJ+OtEQ4H1F+3NlMhA4TvmU
 h4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CwRtWNwLFNlKDvHIp5GPE+CVeLHux7e3G/IqGD+IVyQ=;
 b=Cmm7+jLTKE8IyYr642TLs2ziD0qz3qcPf2FNsQvaV7DTvxQyWCd4t0o5pBTYBPj0Dd
 GcZI5gmc7MxJSednE30qhlJqoTnS/G34p2e43tgPcSW1KDlci2u5NvSQxRxxEA+TjdQk
 Kzenq4d3QWXM/C/4i1NXewoFAQE7UK1Aysr0oJB2cyuEcYThdLcJrZtCx1ZNsgmMohJi
 fUP8NOufCbYZ4F5Tpe23v5HHutjkFLS3ghoIMf3LCKyDMHVU8Hq4QtEbFbjin6s9v9Kj
 o1Cz54y4NI4iFQYg1SXYDvRp3n0IXGNMz2Ih20QEPNnKHbtyqiW7SqvuvZIGjR7Pt1Wd
 Om9A==
X-Gm-Message-State: AOAM531MEib+ZGEeCs4E0RM2oEzasQf4RODcqch9IJNi+arzpJcdhimQ
 PbsUPWc7pWEIxTUxd9jC3eN9wNBqACnQxg==
X-Google-Smtp-Source: ABdhPJxIALmeY80qTaSF4O3gpU2UskneeNryfa147hnNgVJGJ6RhjlC3AP2vhzH2hpLh+2c4qnuj1w==
X-Received: by 2002:a37:6d46:: with SMTP id i67mr64803027qkc.404.1594392524006; 
 Fri, 10 Jul 2020 07:48:44 -0700 (PDT)
Received: from brihaspati.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a3sm7636825qkf.131.2020.07.10.07.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 07:48:43 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
Date: Fri, 10 Jul 2020 16:50:47 +0200
Message-Id: <20200710145047.52383-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: alexander.deucher@amd.com, evan.quan@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For passthrough device,  we do baco reset after 1st vm boot so
if we disable SMU on 1st VM shutdown baco reset will fail for
2nd vm boot.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d1adbc45d37b..07be61ce969a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 * unfortunately we can't detect certain
 	 * hypervisors so just do this all the time.
 	 */
-	adev->mp1_state = PP_MP1_STATE_UNLOAD;
+	if (!amdgpu_passthrough(adev))
+		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 	amdgpu_device_ip_suspend(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
