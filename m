Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358EAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B953D10E53B;
	Wed, 25 May 2022 19:05:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E2410E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz4swzkKVK57dHTSpiArOejygY1+SkJiDyfKR8C9tqRqVU3V3QQF5Onrh0nKviWDRA5Lf77BRixuUgpw3dibO5CXhGxME7vNyilTvVnv0+TC+y3MFSX/vFRd10tFwQCdu11fQ6AsDUIQDy8gCDl4gx6JzNus7QfvdRfDmYx3/AIIttSO+zNz6Q/F/l4YW4TtxiV9AvFtS0T+qPrew8v9IjRnMqZ5tU6uqlhXHRcw0r6Atn7Mwt/cf4PZebKv4EDQS2MoR4xW3lh7u9EDg+syGtXPcZl4MnH4VNIy/FE9xI+pYQDnhkqmueFIDrLkjaT0VuNOKJ91v8rJNoR+pBPnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3VlkF6Wy8Khmxj0eMfEGCfzQF++Y3qhV4SfE+b8giI=;
 b=gVcE61xVCnsbotQM2Eruf43kBcJxs14OQ/i/399kNfEXGUVC28+zwL9InPgMnzsWNakDtjahnG7WgmKd50LiJqjDMqGEfTD0WWBBXIL6CN65YFDUYeZIIXVKYBa7x7BbW/wT8sNmD98HHXQsOqhCezNQieYGLhys49i8nhBIMZ+oGXs3ZsqmKPJ9iZvRuJkqu/1ZAPThz9hsRrkulAfaKecFboJZo7eMU2eIuCNt0H34osqBQFLJjTjbhNmoerENsEWplxQ1Rv+MCQRPAQWYal9arSe5DutivFxd07VGAvmhcbllZaXeLXQFE4hDZ6YVCxSIB8xUEo76ZOZ0rGb8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3VlkF6Wy8Khmxj0eMfEGCfzQF++Y3qhV4SfE+b8giI=;
 b=3GOeWifOBkdrUnuiVdqAgFvqjfXHcEi3uSelOYCo3KHwYZRpF6XtTDIs/nDxOc4DIPLV21gMEDf6nZ+TcHECh/Xx6d48rVnlkh5pCsKr0ooQc81t0T7iMQA0uY2+ACgcPBeuAUWwwqQwvFV5M8xs+B1dIRMyZmULvSO6A+2Il9M=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 19:05:15 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::29) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Wed, 25 May 2022 19:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:15 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:13 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/7] drm/amdgpu: Add work_struct for GPU reset from debugfs
Date: Wed, 25 May 2022 15:04:44 -0400
Message-ID: <20220525190447.239867-5-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20119f45-9436-4a7f-18ba-08da3e818078
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2876042EBA1EEB54F5FD74D2EAD69@DM6PR12MB2876.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIf+hxeSk40SYdOv+oeQa4ZTxalv0homAE/qjYtJvjRWYNb7FHLBAhfWTMZ+U9fuJFHhOnq767eRgy7KEkgWCojTJ5/6Y1XAwNPmgo1bDKYb7nGUTQhEXGlwKIso19ijIwybUN1Y+jqxIWuKWdzwf+rjF9KsVGIX7zCSYVwdSNbXteE+e4iLsQQzqQ3QacD+Ev5dlHFUo4sdizKqUBP7kZo2mCt9eTW1LU8Ajvr9gOaaPqOWAhXMaIOJ226Ntcda8OA8E3JptcQh1Wr9VuRidFcAMQW22ContLgqrzlRAsLVKi72USGnDfzcYW2yc7rmHO7L+8iTyaPwDsAogK9DIks7EgIKmrLnNq7RqIbhdIEqFxsT/dcBug8iRtvAsRiFvgRbJTMUDmIOgvpxdxTejjUYMjVXJt7brhwaETcrN2ctivzI+kEaOjJtbUsxpOfAYWfoL0umAai6slKtoSOovkVVKMQpTyr1zbgs2/lYP3hmUe6tjEvIG45pKfvWUl9F5dIikS8er0AtaOL0IjJqln2AuXa1ZG3WCFiaeNdXXIQXaTpsop1sZRxHH4PcC3ZFQk5FaqGuUzT93yVk1gwDb6PLItyIsAO/SnbxDiIi8ICvbAS5a+5j9ne6YXXNYd3pIVb3f6/+frSGgOrrPVBsTA7Aiznh5ToM1Q650sZwDfu/X10DsdM4os9uhw5vOshiUHuyD/CxewuLO2q5nCJKvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(70206006)(82310400005)(4326008)(316002)(83380400001)(8936002)(16526019)(186003)(81166007)(47076005)(36756003)(336012)(86362001)(426003)(1076003)(40460700003)(5660300002)(356005)(7696005)(36860700001)(2906002)(6666004)(508600001)(44832011)(2616005)(54906003)(26005)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:15.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20119f45-9436-4a7f-18ba-08da3e818078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2876
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to have a work_struct to cancel this reset if another
already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 76df583663c7..8165ee5b0457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1048,6 +1048,8 @@ struct amdgpu_device {
 
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
+
+	struct work_struct		reset_work;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d16c8c1f72db..b0498ffcf7c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -39,6 +39,7 @@
 #include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_reset.h"
 
 /*
  * Fences
@@ -798,7 +799,10 @@ static int gpu_recover_get(void *data, u64 *val)
 		return 0;
 	}
 
-	*val = amdgpu_device_gpu_recover(adev, NULL);
+	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
+		flush_work(&adev->reset_work);
+
+	*val = atomic_read(&adev->reset_domain->reset_res);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -810,6 +814,14 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
 			 "%lld\n");
 
+static void amdgpu_debugfs_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  reset_work);
+
+	amdgpu_device_gpu_recover_imp(adev, NULL);
+}
+
 #endif
 
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
@@ -821,9 +833,12 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
 			    &amdgpu_debugfs_fence_info_fops);
 
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev)) {
+
+		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
 		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
+	}
 #endif
 }
 
-- 
2.25.1

