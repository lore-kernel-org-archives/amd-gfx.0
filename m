Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0CBCCA47E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF9110E663;
	Mon, 13 Jun 2022 08:00:38 +0000 (UTC)
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AE710F63B
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 06:40:58 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id
 o33-20020a17090a0a2400b001ea806e48c6so3116273pjo.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZGrF/sve7KFTJf3GJ9QVEDMMBvkar/b8XuDD6PWfLjk=;
 b=k9YbY6DNSsjvTV5tG3MXhR727t/+sYBPmKjHpPFsVN+dZtxy2xHxJowGzIV14p6sxd
 6yspz504AGqcQ51cxaaA6cAR2kT6Mtj3FfbntyCKfFqjPcGTMwn1XLo70gs0tUTEG/CQ
 RroYT1yRa4kx3lD9IawS5oGMgp3ajq/BCgLSSuD0QCp1MAGtyDwlc/jwtkHGDft6gg8T
 ux1t6ZtKvRHuGh2LoYw41Had+hLtfOtVjl5DPkoJD02jJoNYZ/8FGY0hMYS076s1YOzp
 AvKqZ5UxGjesJww3gI73RviD7EI0Q4iimJVbm0GdR0oRMbUAVY1l0bXkkS707o30lCPJ
 s6Tw==
X-Gm-Message-State: AOAM533zrmdLiy36lseWl+Rube2BK3e85tRaaT4VK7OCu5dhh37cWoQ7
 T8thzCZxnidITecBUOAQig==
X-Google-Smtp-Source: ABdhPJwFLlxOzFRm3zYN+pfdVaQQ14/wpp5IKt/Iov6tYmXs3jpaO5Ajn67yFNmbIkCe3meGlR22Rg==
X-Received: by 2002:a17:902:d2c1:b0:165:d4cd:e118 with SMTP id
 n1-20020a170902d2c100b00165d4cde118mr54076180plc.4.1655016058351; 
 Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a056a000a0a00b0051c157f83e3sm2691628pfh.96.2022.06.11.23.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jun 2022 23:40:58 -0700 (PDT)
From: sunliming <sunliming@kylinos.cn>
To: Ramesh.Errabolu@amd.com, alexander.deucher@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdkfd: Add missing #if defined(CONFIG_HSA_AMD_P2P)
Date: Sun, 12 Jun 2022 14:40:50 +0800
Message-Id: <20220612064050.1175083-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jun 2022 08:00:37 +0000
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
Cc: kelulanainsley@gmail.com, sunliming@kylinos.cn,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The variable 'i' in function kfd_dev_create_p2p_links is only used in
codes that gaurded by '#if defined(CONFIG_HSA_AMD_P2P)' check. So adding
CONFIG_HSA_AMD_P2P #ifdef check around variable 'i' too.

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11: warning: variable 'i' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 304322ac39e6..4bfce71f7fa9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
 {
 	struct kfd_topology_device *dev;
 	struct kfd_topology_device *new_dev;
-	uint32_t i, k;
+	uint32_t k;
+#if defined(CONFIG_HSA_AMD_P2P)
+	uint32_t i = 0;
+#endif
 	int ret = 0;
 
 	k = 0;
@@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
 		return 0;
 
 	k--;
-	i = 0;
 
 	/* create in-direct links */
 	ret = kfd_create_indirect_link_prop(new_dev, k);
-- 
2.25.1

