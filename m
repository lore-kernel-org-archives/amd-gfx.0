Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81653C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 07:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7B310E70B;
	Wed, 16 Feb 2022 07:22:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF5C10E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 07:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U16C1Ujq4JsL0bnq5Ro1iQN588w3HVTiY6M0iY4MENDUK0BREOLh4t/9yI2kVnNz6lpj4K2hfx1d2iXzV8efmApLucD4nK4PsfVb4xuSl/fZTWvOMeVzsSJhAOVJlDWvUbM1VTz2UOtHZz6ZwCVx/qn03IYO8hC9gQHWmVz5swUQa6oDmkFkUCndUSemojUVYBBgGDif3ewwv/NaNJ7sT+YB+vPBIZmlrvCDHuV7ge853hk1g3jFAgSPTDgma6xvZZGd1G+Vbo5b9JxUDrj8aAWw+Xn+vq99DyJqNi4QhFgR5eJcg4JOyDQ/X52vMTLzm+Jaye77f/Ov+e2J1vEaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4RT5mulhlZq6DgZCL23RRYUv9wpAJqVoJab7w2qKdM=;
 b=Mn4Rt3uhrSTcWHNAa6yXcgRJcmwGTLxtuUmk38BNX5K117UqpYB2qkmdv8hGL2fhPWMRae7ROhpsQ3pyx0VHRA6IO4Q2sh/7CMtzKlkamIW6oUMt1unvc+MU1XFUGzTXHiRW+mGDcO5bKQr5zaOthpuimYkljAprFglYTiH+1ahxGzOIsIPCupaUvEOhx7FTq3/o0hcDBtbjR2Dw4mZnd4afiownnluLrvyST0dojF9yIUCPOcTAqUDyA8v2oAuzeonbip5pzmbjIXo/TZlFIRi+gyxp6jAP/y35ihdbT20HQZ08YsQl52oQ2mKSGfHb+hmBWK26H7zasRpFZVdeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4RT5mulhlZq6DgZCL23RRYUv9wpAJqVoJab7w2qKdM=;
 b=qUzFrU2a4sRSjaxPbSO/4S8FYlfJDty0LgU3npr/POCDDGJ44AZnVdPcSKNFhtUdGXObZtjtwf2KUPCcEuD1uJtpqZ8XRr5DSzEaummF3UZRy7liI19tx2ehkm+s57xpkLb/Oj/idz1jxmqgOjLeJojAfUTURXVpRAckIQULpDo=
Received: from DM5PR21CA0010.namprd21.prod.outlook.com (2603:10b6:3:ac::20) by
 CY4PR12MB1207.namprd12.prod.outlook.com (2603:10b6:903:39::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 07:22:45 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::36) by DM5PR21CA0010.outlook.office365.com
 (2603:10b6:3:ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Wed, 16 Feb 2022 07:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:22:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:22:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:22:44 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:42 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Andrey.Grodzovsky@amd.com>,
 <Monk.Liu@amd.com>, <Emily.Deng@amd.com>, <Horace.Chen@amd.com>
Subject: [PATCH 1/2] drm/sched: Add device pointer to drm_gpu_scheduler
Date: Wed, 16 Feb 2022 15:22:22 +0800
Message-ID: <20220216072223.8394-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17478eb-51bf-4b15-9fc0-08d9f11d20d3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1207:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB12073FBA9FE6C8B6BA21F220F8359@CY4PR12MB1207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZv/5cp2hK9DNzZP/wxvp8b+m+44s83Lu0U9rXptn8dKwMo4ddBIa5NmtQ3VdJfb5jKbSUNct+iOzoaqz6g4c+ShXkSjN61yl0f/t2B8rqcYZzchY2z/KRXpO2F5hh7mnUFq/dMrE3iL/rvqTqa4fnY+Rq91B7H8Fif3pSNxUkQAcf/S4UO5Bhj1ka3SPD0L/GHihuA840I/i4szUHpqYwEu2fL656M2VVz7qqOjpVjvWY/TmXkRHVA/YjRHFvm6LQagqqYrZ/ZiJ8aSgM4uB1iG+FDfWcVzyGSkGGLStU3gXwvsBXYOPQEXPKGVv5xFPloxMH9pEkVYWfHjT4dWZbXGnV2vzBursNe+cOaFrSPry1ayPoE8oE+MqGdddBPPKSz76yG6UqzN7mFdVcPViu8e+oRpIPatoh18+JthBor3fZbHXAYbJDEVX06chsBNwex5RdPOIOeUgEfOw8tQQr/XFLy4n8uUwgwJg9DVII5YSDXNp2dsDPMBxSxAVNuw/myfA7ZCswOaATIQY9LmJMGd2Dji/qpUiTIxZ/1rBfFqtmkQW865pqnlWCZQoKCxNzckCd3rlU7G34t6xlVrQOHdsI6w227RqPhP+z6s7Qqjm1jbBaWvv0tlGpAxZiJ4H5Tzuaqf6wYoY6OQc2u81Uca7hNlcGV0V6psSEICpMfr7sA4Wjq2ex72hyyRfh5p9qiCRjduetqfDp30aoI+Yx0t/4BruEp6COr8/aJJ2sM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(36860700001)(2906002)(81166007)(356005)(2616005)(36756003)(8936002)(40460700003)(47076005)(5660300002)(86362001)(336012)(508600001)(4326008)(70586007)(7696005)(70206006)(426003)(8676002)(186003)(1076003)(110136005)(26005)(316002)(6636002)(83380400001)(6666004)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:22:45.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17478eb-51bf-4b15-9fc0-08d9f11d20d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add device pointer so scheduler's printing can use
DRM_DEV_ERROR() instead, which makes life easier under multiple GPU

v2: remove drm_sched_init() interface change to avoid compatibility
issue

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
 include/drm/gpu_scheduler.h            | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3e0bbc797eaa..83bc3fc2ad53 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -489,7 +489,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
 			if (r == -ENOENT)
 				drm_sched_job_done(s_job);
 			else if (r)
-				DRM_ERROR("fence add callback failed (%d)\n",
+				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 		} else
 			drm_sched_job_done(s_job);
@@ -815,7 +815,7 @@ static int drm_sched_main(void *param)
 			if (r == -ENOENT)
 				drm_sched_job_done(sched_job);
 			else if (r)
-				DRM_ERROR("fence add callback failed (%d)\n",
+				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 			dma_fence_put(fence);
 		} else {
@@ -872,7 +872,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (IS_ERR(sched->thread)) {
 		ret = PTR_ERR(sched->thread);
 		sched->thread = NULL;
-		DRM_ERROR("Failed to create scheduler for %s.\n", name);
+		DRM_DEV_ERROR(sched->dev, "Failed to create scheduler for %s.\n", name);
 		return ret;
 	}
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d18af49fd009..2d034c9a9299 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -302,6 +302,7 @@ struct drm_gpu_scheduler {
 	atomic_t                        _score;
 	bool				ready;
 	bool				free_guilty;
+	struct device			*dev;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.17.1

