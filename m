Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42836C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1996A20756
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ7ISMVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1996A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C1E6E241;
	Thu, 21 May 2020 20:23:19 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43E96E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 20:23:17 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id g185so8591867qke.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=68M3iGlBAHgF85B2izwod0k6auippbzR7IzH/9mJ0Rs=;
 b=PZ7ISMVPEUsxaDqtxGSkpU3+CgYuyw45+MonrP7V32+zzjNKhwxP94AWy0Wz2PFqge
 J2czhu8YNFrv8hCazuyPgX+Ic9SfJo6H1w8vxRXeHfwjuZ93O4U5ZlfToCXm/MP/75ZB
 HIwxc19Ykuu3bpTnt8JFEwLlqXfyoGqTJzYaIBtSMCsOkbn/YNH+UhvBb6Y25mXq0u1J
 T4XDLIuA77QBNZjkY3dPFvVzZRf0qeZ1e0Fr0SwxReMjq1Uo1AbgfNomJfPYF1AMXe7L
 yazTO1DG1F7g2X8KEsl48IWydk9Z35bXnOjL5PoyEecsgI6wHUT9thD2Z18ZWIU4EoIM
 dajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=68M3iGlBAHgF85B2izwod0k6auippbzR7IzH/9mJ0Rs=;
 b=dJzNMS8pN2UMW6mcjdwINf9H751NVL5dqaMWAgaxMXd397K4yJQYhigtOfaur7rTma
 5H5DBW1OyvWKkCj8mnW3FWpJkLfXyw8WhV56hyNtQ2NxnVDkoorkkWniQzIV2OZFL+4B
 LthiKinwzcaPKefFhGdeUhDyCb87c5CdX6BxVauFqB7T5uLbjoce2j0nJL0T+uBADm9C
 5HL55WCfWQQukcgfothFw1rB7AdcfcuUPXHAtcWrKf1sZRFXbzSScKktAI6r4UXMQCJS
 7IjzNOtk0g/ZSMZUddNKqdAMfLLeP3hLGPnd+a09p5F4RnwY3/vCrHns4oS5ZfG0X5BG
 2qnQ==
X-Gm-Message-State: AOAM532pmE2Tv1WCz9YjjOK4qnWa/5d2l5Gt5lOKpqrnmxrTAq+P6khZ
 u+AdCW3eO7KM82Tbefr6laV2TKsw
X-Google-Smtp-Source: ABdhPJyuA9EWv1otN9DH/Lerps+saYNwdZ0fywF4lcKEOCCZc5gTOjrZjbLLsdaVnMgh09oyQf/jgA==
X-Received: by 2002:a05:620a:22c9:: with SMTP id
 o9mr11866645qki.292.1590092595653; 
 Thu, 21 May 2020 13:23:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t130sm5543470qka.14.2020.05.21.13.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:23:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] Revert "drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling"
Date: Thu, 21 May 2020 16:23:06 -0400
Message-Id: <20200521202308.1996496-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit b41d9df2b680b96913cc3ccf929252e2dce71b24.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 2fc51f815eaa..72bbb8175b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1843,8 +1843,9 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 	return 0;
 
 failed:
-	while (i--)
+	for (; i > 0; i--) {
 		amdgpu_device_attr_remove(adev, &attrs[i]);
+	}
 
 	return ret;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
