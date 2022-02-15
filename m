Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E1BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 11:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693310E44B;
	Tue, 15 Feb 2022 11:30:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF1310E444
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 11:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgcfce2D/TrmRv1+nV7LYxeBMJpN4FF9sBISy4oKpRoZzbL7qepw9XcjwMzOiIMAuzBlClN+yrZDwnlsWqab5n8IyGFamjzUXjr9ynXHlOU6cArzWM8R2fJZZxFl8Oak9Gyr+QLahsAGZPdBHPT7HA1Zt6Sz37e72F6dGebcnDkiRIuXAaOjdOdxsGP2XoJ0E2KlYZgC6iwqTtdrMlobOS2Lo03wIGfWwsocLEq4NytxJBnehdCQJGutndHp8jAABibRikmf3LSdshI5AZmLNSCPyM1ELsHUQ3+4M6g8+LTn34kRbHUy46M9C2H4nQN6qQHDbsbaaOZPJDcV52/NQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXxdMLj9btXahzGwq1qQ3KKTKnpZyZSIf9gmIA9HJ88=;
 b=SbNFwvDXIDqMSrcuz67MbXN/XTfSxV+nlRHaFd/69JFBdqX6xYgVvEpZ9MidSpi0UiixkQpmULBPek9V3zzd8Y7EGvRu2AaxCxUQnD5HXrpmQfNts8QuFlWESXlFJSAd3qgrJ8f35TOr7yjkvTXB1BBkH8l6XBSgq+YkL2DuYJ719cKWXPFZK08t0dUTfH3taobl/6BmHw3vzOW1uptdrhQUZ41pVe63oPuz1FpB/+YdFCl+LavAEBfGIayHsnA7ODjJRlGO+CzkYZSO28UD6rNVCnrC1YqnQunbxGfQuMLBbv+QbBTFMxLMnjz0Dmhu3QFdyESViEd7aZiJgXn14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXxdMLj9btXahzGwq1qQ3KKTKnpZyZSIf9gmIA9HJ88=;
 b=mS4e8wu6aSzmtcPzw+j/HfqgGrkc/548/UgH1hdvGDtGCUKq0NxnDrXnLdUQ2Cvo/fkJt2/Xflbxpi7imGuDDU6j52lqfSc1onD3C2EC661Iq1R1rwYoIpVqbvienRXG3KBnbdDnTrL5s53bUrBdgINuQK7vdsWdDyZw0dUfYv8=
Received: from DM5PR21CA0064.namprd21.prod.outlook.com (2603:10b6:3:129::26)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 11:30:38 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::f1) by DM5PR21CA0064.outlook.office365.com
 (2603:10b6:3:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Tue, 15 Feb 2022 11:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:30:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 05:30:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 03:30:33 -0800
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 05:30:31 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <monk.liu@amd.com>, <emily.deng@amd.com>, <horace.chen@amd.com>
Subject: [PATCH] drm/sched: Add device pointer to drm_gpu_scheduler
Date: Tue, 15 Feb 2022 19:29:50 +0800
Message-ID: <20220215112950.13898-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e90d78e-f28a-4820-1ec7-08d9f076970d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541649FA9FFDAA1F0A70E05AF8349@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZBUqDuJ9r33e5XxOtwP+pVFmalanKOjz1RI9ubPB2KwTKhgi85gJHzT2Af+Ucz96ZE9iK/Vf+hym69NuAkDiTfATXkqU1eVRKYmDPfIXQ/A89/3kaSV8ihTl6P3zyterB2mDMzWGv6RmGUs/HpRJLBpHBTQdqLs5k/ftTjK7CG47NqtZDHnDYoIQAe0lb08fqLx6bWzWQ8a8e4PK8IlE1yt9fQflFEMQARvIEStgvg2YKhbSupM6iMgC4NbtsQCjRyyIBQFYcJd96zBfzCjCCJnmnc56lYjmUSAhpbSzSbWdvYr03jYYgQdQv/SU3ScfpJVnz/KX/ci2rl0OuDua8L2kgstxmxj2AXCHFozQiFZZau9CztJXkg5J1JXQIaCsKagYP2SNIA7wPRNTe+Z6r7T3ok05iRK29E9T1A3VslKvjQ1vccpUAQFeq83oXD9PDa9OAYOIoKE5i8+Y4ULM+f+NhraOGQwIVo9YvI+mTiq9rAH3vUhOGomnRwBpVTcHEyF5AXTbzPGALi4wYFOC/biw3bNJbxItXFw7WVVyy67jSDrjx4oVP6Peo2ww+nE5rhpXaxjCqyBgFasAjIAP3nrk29Pgm+T2zmFMPfDMyhOsUlMG5bp329Csoo2Phh99AmzXGRmyfdvskN5/5KdZBZi0xeHnGkpSKWG0ae0cfnNiXiUi++ol5XZu9AddPP191xQckcTcP3uth05JMRNsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(36860700001)(8936002)(83380400001)(7696005)(5660300002)(26005)(186003)(36756003)(47076005)(426003)(336012)(356005)(6636002)(508600001)(1076003)(110136005)(81166007)(40460700003)(86362001)(4326008)(8676002)(2906002)(82310400004)(70206006)(6666004)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:30:37.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90d78e-f28a-4820-1ec7-08d9f076970d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
scenario.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 +++++----
 include/drm/gpu_scheduler.h            | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3e0bbc797eaa..4404af323321 100644
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
@@ -846,7 +846,7 @@ static int drm_sched_main(void *param)
 int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   const struct drm_sched_backend_ops *ops,
 		   unsigned hw_submission, unsigned hang_limit, long timeout,
-		   atomic_t *score, const char *name)
+		   atomic_t *score, const char *name, struct device *dev)
 {
 	int i, ret;
 	sched->ops = ops;
@@ -855,6 +855,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->timeout = timeout;
 	sched->hang_limit = hang_limit;
 	sched->score = score ? score : &sched->_score;
+	sched->dev = dev;
 	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
 		drm_sched_rq_init(sched, &sched->sched_rq[i]);
 
@@ -872,7 +873,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (IS_ERR(sched->thread)) {
 		ret = PTR_ERR(sched->thread);
 		sched->thread = NULL;
-		DRM_ERROR("Failed to create scheduler for %s.\n", name);
+		DRM_DEV_ERROR(sched->dev, "Failed to create scheduler for %s.\n", name);
 		return ret;
 	}
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d18af49fd009..38a479879fdb 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -302,12 +302,13 @@ struct drm_gpu_scheduler {
 	atomic_t                        _score;
 	bool				ready;
 	bool				free_guilty;
+	struct device			*dev;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   const struct drm_sched_backend_ops *ops,
 		   uint32_t hw_submission, unsigned hang_limit, long timeout,
-		   atomic_t *score, const char *name);
+		   atomic_t *score, const char *name, struct device *dev);
 
 void drm_sched_fini(struct drm_gpu_scheduler *sched);
 int drm_sched_job_init(struct drm_sched_job *job,
-- 
2.17.1

