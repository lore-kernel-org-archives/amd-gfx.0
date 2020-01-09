Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF7FC282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 23:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D6C205F4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 23:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2q0JvyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D6C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE97E6E087;
	Thu,  9 Jan 2020 23:30:14 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF476E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 23:30:14 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id dc14so3753596qvb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MaHJDLclLWgJ8zbb+WoVO0+V6RNazq6F5xQRXNIe01Q=;
 b=S2q0JvyMkaNXGSRWqXpXyI17uMI0f0Hv1Y7gc49xJ2anbB7+zBNdCxn2utsfhZTO1+
 3EcwrjXgl8cCvElMliFH3vmJm+6Z8tfkDv8+hkzW2fMXUtdjOoYrUIqSulA5iGhDyfal
 U/lx8EjRFZYDy73hWY87oWAGH+JOEQ1PpOtr/3MwmnG431Yr7X+eBnxiALs9sEBchOW5
 zQUagbykGsD0yDFeewMRlT74gPNNpcjsD5KJr344fsmuHpY57SFkWyWuTHWBq+jiqBR7
 RoDOWjlPKFhRi9k2LVUPWINCRnkdOP51TapBJ0Nle/iK15PjJqMYr7l6ZbTWovPvIE4t
 Qpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MaHJDLclLWgJ8zbb+WoVO0+V6RNazq6F5xQRXNIe01Q=;
 b=cu5bWY+YqU+k5aCYBCXRxc79yp91Crdd9lMJBFLTDy9Sc3rBDolnCDHP6w0aPdTu2h
 7KFKtFAEuCkrjhdQt3yjFUbeDJhoA2MWPXtm4yP0LBJJBKAiwuC0f02eOjt+PCbI60Yl
 hmcjxBGGx0zscyYsFWBdGOt2w7cgjhJpP6Ng/jvSvapAMevgU4SEOnkkz6C6yT2MqTf1
 tfydvbzDdOLHesETeL7gkoeNwbk2ogtJ5aTTaJJmRGrJ/e6EoCdnT0iMWDF+niHLpupD
 g7c+FY5SbiRjYyYlnd9ymvM8O8MGXlvDC7w8PsS/HkTFTOYxE2dlmcE8ttt67qyfSOO7
 JlVw==
X-Gm-Message-State: APjAAAX6IhG6vJxF43h+nBvujoOgP8HeZxt6sh3e92punLTEr8ejJGUr
 SRteq+5gsY/yX+JbMFd7H/Y9NVZS
X-Google-Smtp-Source: APXvYqwJ7+IkWgg4MYrzBZS7o7olC9HWRe3iohzKA9LJioGMElnYBBBb6YGFSBlVfO+Rw7dhXjtZpQ==
X-Received: by 2002:ad4:408c:: with SMTP id l12mr101379qvp.164.1578612612884; 
 Thu, 09 Jan 2020 15:30:12 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id o33sm102686qta.27.2020.01.09.15.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 15:30:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/psp: declare navi1x ta firmware
Date: Thu,  9 Jan 2020 18:30:05 -0500
Message-Id: <20200109233005.28657-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

So that it gets included in the initrd.  At the moment
this is optional firmware that contains support for HDCP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a57f3d737677..685dd9754c67 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -43,10 +43,13 @@ MODULE_FIRMWARE("amdgpu/vega20_asd.bin");
 MODULE_FIRMWARE("amdgpu/vega20_ta.bin");
 MODULE_FIRMWARE("amdgpu/navi10_sos.bin");
 MODULE_FIRMWARE("amdgpu/navi10_asd.bin");
+MODULE_FIRMWARE("amdgpu/navi10_ta.bin");
 MODULE_FIRMWARE("amdgpu/navi14_sos.bin");
 MODULE_FIRMWARE("amdgpu/navi14_asd.bin");
+MODULE_FIRMWARE("amdgpu/navi14_ta.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sos.bin");
 MODULE_FIRMWARE("amdgpu/navi12_asd.bin");
+MODULE_FIRMWARE("amdgpu/navi12_ta.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sos.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
