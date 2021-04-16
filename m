Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B06CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 05:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED166113B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 05:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED166113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABBE6EB20;
	Fri, 16 Apr 2021 05:04:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B83F6EB20
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 05:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X48B9sVvL3TieFzdhjQKphp5WbNXgRlRgJf/ePRd4ofDnQxGcrCqI4i58Agct2qgoEmFn0VCJSkdjBlYXWSPyPunEi1yb8/a2T0UOHQXBBinlE+ra52ZvmmibKF3/dXu8Xiozs/cYfxhH3S86zi72SJBBQdMcafuMXUIdm7X9kkT9PbG5KjJtMQ7nVmxiFiWrToORY+56/e7MdocSIlSdLiCEO/GFJwQSojIYMJQYdTXd6/zXFH93m3lGoMaLDSk/QruKXRE+YDNhpQMUPpwsNd6pr0IkDuidv+OhhGDWDXIIybHHH/RGwHCuJBEagalmW3hDEtDgkKh9DbGDETNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=KgfsLOvsZqUeaFiCsH8PvFZj4HPWqBxpdORxGiArx5WrVWQrkaWrZshVYOYo+zYRENNCmQpbPM8qeUjS7G45BAx3Bv0tPl+NL0jUjuTvc87znsQYp7yV4xBGKcMtue6qZo4/Fli3+aWTmmyGGoh6ZEy4f53mOHNXeclXEXEh6JZ4xtOrIzDEE1lUkZoVTm5UxSmSbMr5ATx/GSbbHQL0opRVv2V63p9UkGVwVk0evyJiWU/+ZtsXgdU3zVTv3+nPivUYaWfZVecQvONWIq3Vo1N5bUPsukzkgCg0UttDN1vhVDJqxQc5iIIeUmvjJPEbvlVsO4d3pexj3IOHaMsplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=dHZbz3A6H0nIVrp2DwPcAtGzYR7Hjo0y/HJ2yTokyj9s3HVd7aKCgbtZ+WIz7GmTE0xOl0KLnTqPUvLeicVg+iInG7pEfiCiTrkOFlL7d2nGPPZQ4s8225iv0p7oVbSgifvjKbjP4elsJIV1gd3HfLoc0H4/Iz381iWF5SovbQg=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BN6PR12MB1873.namprd12.prod.outlook.com (2603:10b6:404:102::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 05:04:18 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::88) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 05:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 05:04:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 00:04:16 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 16 Apr 2021 00:04:15 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Fri, 16 Apr 2021 13:04:10 +0800
Message-ID: <20210416050411.29220-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a9a743-f1f7-47f6-e114-08d9009516ad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1873:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1873D91C5776EA9726D95207FF4C9@BN6PR12MB1873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rq6n1l283Cs6/D5TFjC22MRaLXjbBoUYDMCPxgAFpL5DXmlF1vrhrTH00TRwzEfcOIvX8EIwth8Z9xUmb8pGmOFnjyUfqH2MNQxxtQCdFV3lfQX/OUKgU+WzxR8hdeZedJqDNnzyd7GYObukobi68sgjTnLFFcEuCYa6It3lyR7aenaW9YNwgJuXRLr4pABs2b83m33p+SX2uxDo1I8a0oPImvuyHar5WPA+3+bAXak8E0yB05vDgidNee1zXWmwpqkcmJq4H+/vJPaxWlVYD34XXDoVFfPZ9B+tp6+ARsxChMrcZ61Xyr7OgPx2YcBBjTsguoR5DBu429pvsPCP3wJrH3dEV0wJXxJwuiFgmGck9DQhRgFCWTalTzsn1T4gX3yKSR8xJA1hpgYpN/cUrEKtVT/dBER9xov5q2kS2qYM0NkeqKMleUb3lKdxKbaP7WMsTB7vsxwK0SVqBk8nEKKhd/7i9CquM20I0d9klXxHKimUY36mhXgqjCs1BhMvREy/9PSlVY3epKbdjv7hjYAeZ0r2xMksL6D2ZIMhzGy13WEvVUjoMh+VDuhWsJMUYs/feoMu7mkIPkuAUjwIN8q58PVkS4KSecg2FysLzDX8zR3wqxlAT+MYiosp6Ex9h6iOJzz6VO8vQ5/v8g6nt0XwMjDm4GwHIZo93Ve0sg7zyY7rL2b7A3esHNS1uL54
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8936002)(336012)(47076005)(1076003)(5660300002)(8676002)(82310400003)(70206006)(356005)(316002)(83380400001)(6666004)(36860700001)(70586007)(186003)(2616005)(86362001)(7696005)(6916009)(54906003)(4326008)(478600001)(2906002)(82740400003)(36756003)(426003)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 05:04:17.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a9a743-f1f7-47f6-e114-08d9009516ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1873
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
Cc: Roy Sun <Roy.Sun@amd.com>, David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the timestamp of scheduled fence on HW
completion of the previous fences

This allow more accurate tracking of the fence
execution in HW

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..4e5d8d4af010 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
 
 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from pending list
  *
  * @sched: scheduler instance
  * @max: job numbers to relaunch
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 static struct drm_sched_job *
 drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *next;
 
 	/*
 	 * Don't destroy jobs while the timeout worker is running  OR thread
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+		/* account for the next fence in the queue */
+		next = list_first_entry_or_null(&sched->pending_list,
+				struct drm_sched_job, list);
+		if (next) {
+			next->s_fence->scheduled.timestamp =
+				job->s_fence->finished.timestamp;
+		}
 	} else {
 		job = NULL;
 		/* queue timeout for next job */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
