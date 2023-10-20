Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3326CC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 06:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3FE10E584;
	Fri, 20 Oct 2023 06:13:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC4410E582
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 06:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJEg7xnXk3wwt1KCCBtB5UhQaDEzjAxk/OunOHunr2pl4dIfsCwpRNCnfeGfslgKpO5kCZ4//K4nwFpVkfNPOH+iO565Q4rgWBoaJtrJJIpwRQO0g3L4IQ6axNN48gqoOVxy73/9SHyWwVfxOeJUdABAMYChaKHyeL/Js4gfUOqgayQt2CoP5bSwOy/j0i6tjeC0v6MHH6OcmUq7WScN7g0Mr3n+YCsLIQ3PPQUPeaiEsJ5jiaa4X43ke2YeE/M7H2LPa5ew7suucRk4+CTqyfOXzVOw/38vL5dgRemD9gCKv/1yC2xb0sIR1tNWoGScDYdceTKn+2Wlvv/cx4HcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biLiRby1ia8SdZy3z5Jn92D47N4bHgUWQv/UzlksHt0=;
 b=GAh3x5mylFjKof+9IN5K2cQEmdILdoQvc+anb/kiEpIUDyyBC/E4D8lLO8ZzrX08oXIo78DflpFrcdDc5/CclIH+UryQCrF7LaJJkd4HK5NIVNHSgsKJx1D1el4xTD0cU270hhiiTemLBSqMQ2nztEhOzEfvtUwJ4GVRZ2d72+0QLjfjCVYeSpicXvMYHcWlx3g1tV0Q08WM4z1vIJAxr8UDKZMARjJ/Y2Xe2FDeTskBwukRAWVYknAA90roLAUDreMui0FwZf0bISjr+ejwvF/G5I+vJ/otMp8iCPdglyV1o9GNKjJnQCnqm208uHVy0MKvmcP7CievWiu/tS7inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biLiRby1ia8SdZy3z5Jn92D47N4bHgUWQv/UzlksHt0=;
 b=M5DVpNt8r5yvtzUyb5F9W/bNhLBWqFy2CamRQMEWsxhKJd5blp2jA1SmOpWS6s5aTJOmvBI39NS7knDisDZqRrBllUa69ry9+2DQVC6FDgNcmV+Ba497hdGnPrbbQQDTbKyJskYljpJ2yEPfKdk33Is/BGk707Dp2SffUMtm0sE=
Received: from BLAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:36e::20)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 06:13:24 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::70) by BLAPR05CA0024.outlook.office365.com
 (2603:10b6:208:36e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Fri, 20 Oct 2023 06:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 06:13:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:13:22 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:13:14 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: handle the return for sync wait
Date: Fri, 20 Oct 2023 14:13:07 +0800
Message-ID: <20231020061307.588900-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231020061307.588900-1-Emily.Deng@amd.com>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: ce862dfe-5047-4d2b-fc71-08dbd133aa9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg0oSNmuc62tt7wk1OZSL/wJnjB840m7zNbpn0OLN2AHfYEc+qXqT+LGT3CiZYpPKe32WmGsD1dT03R5+DdHcqPr8ejXsC2RVF9x7qX4kFg1N308SmwOcuuMi65oYTebWnBSaPqcJcsUo7GoNYeVPhflL0UodJMIneji9HVKTPm201ete+vEfIoYvXC+jD6wH30Ygs8JAuDwRdwbnttUlg7TkTPCWQFFXQavb5hlr/Wvaml3eDg2tFyNkOSLriw2tx+8HjL+O73tTaqsxjy11sgaEvhIBeTTs5Qg5DBkQ6nF2oMRM2sA6QhIsGC8uWDDAKCcWuiILA50ZDAP51tcNzmLKmNhADov5+R4NT4a7bMhCSj/YUo2osUUtorsfHDYjyFzl3///TH/AzbS84Ae3tfiTv9QFVZ4RQd5dquQZJiZhqvY6nf4tS8THP3gzX82ghWJApiDV1VFDx5aEjdpR/pyQaNei7xIBH3nagt5FX5FLAZgY7Ujm07eKPk8WtvC4Tf6IukaSQmg0xqP/3P7V3TJw0HEYvhH8dQ5P7rY7RTEs5zpwo20UC+6n2IsGThgONettrQUIoi78Grk9TkHKKlbqv4RjxuK3ZrrZI4QW3VsNlCGyrP3g4QRnwvYQ0rXSFEdQugr3kfe5IXW3ZjcheojaT/OrId5r5jUb1nBRtCRjqTP7K0Za+YLxxqh+oMGDCh4npgXqRAe7G703Fl7WJsWu/GG2o6bIU5CvFDeo/SrNRCqsuKhRiRgVFA3U+m7xL1+cFi1NBAzolz2ADjysA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(316002)(40460700003)(70586007)(70206006)(6916009)(26005)(1076003)(83380400001)(2616005)(426003)(40480700001)(36756003)(82740400003)(336012)(356005)(86362001)(36860700001)(478600001)(81166007)(47076005)(2906002)(5660300002)(7696005)(41300700001)(6666004)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:13:23.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce862dfe-5047-4d2b-fc71-08dbd133aa9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c          | 6 +++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..3011c191d7dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2668,7 +2668,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 
 unreserve_out:
 	ttm_eu_backoff_reservation(&ticket, &resv_list);
-	amdgpu_sync_wait(&sync, false);
+	ret = amdgpu_sync_wait(&sync, false);
 	amdgpu_sync_free(&sync);
 out_free:
 	kfree(pd_bo_list_entries);
@@ -2939,8 +2939,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	}
 
 	/* Wait for validate and PT updates to finish */
-	amdgpu_sync_wait(&sync_obj, false);
-
+	ret = amdgpu_sync_wait(&sync_obj, false);
+	if (ret) {
+		pr_err("Failed to wait for validate and PT updates to finish\n");
+		goto validate_map_fail;
+	}
 	/* Release old eviction fence and create new one, because fence only
 	 * goes from unsignaled to signaled, fence cannot be reused.
 	 * Use context and mm from the old fence.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 70fe3b39c004..a63139277583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1153,7 +1153,11 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 	}
 	amdgpu_sync_fence(&sync, vm->last_update);
 
-	amdgpu_sync_wait(&sync, false);
+	r = amdgpu_sync_wait(&sync, false);
+	if (r) {
+		DRM_ERROR("failed to wait sync\n");
+		goto error;
+	}
 	ttm_eu_backoff_reservation(&ticket, &list);
 
 	amdgpu_sync_free(&sync);
-- 
2.36.1

