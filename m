Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3389C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5147D61153
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5147D61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0270089FD1;
	Mon, 26 Apr 2021 06:27:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC2E89FD1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 06:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL0hDZU/wseX4HhxBqfhpRiTTnlzNF5s8UcT/5fiZ0gp5c436GbK4e0HWjWZxiYnnbbWRNT66sckdKbkkRa4crP5yFdN7bO1S72QXmqnXD0VFtgsOAsPtclavRggSbThgJlDeTidOvIeNW+ku+j+VCNrIYVlyqtQSWxscKFuM5nyvW3gIeHN3qammJYoEcrRB1ghCdrVgheqfvi8rmOLj1dEkOE4jwbI9ygNoakLcDNKyLwBY4G9PHRMRJZ/oFXy1kIRUfmLZeB/04Zx1JyDgXI93IaFGpIizjTVS8lQWOn3J5NDyJ04i2e7vKPYV12PgZLcPR3wt6/NXylPPdnTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3rlREVo9PRJr2FFknhA0kkaolK8lbTWqjBwKi2iH48=;
 b=UEAmSBrQ+l8Jzc72NpVpxvere2DeIjOPZnI8Ww/KlpBhd0Du4IvHODpiIrEmdKEmEcohJe5jpd6N0Kx4ZGEncd/AKnQ/xsK+OC2jJG2jB9oIcbI9uRblMH1t2vMYNRy5f5N9d0BbcOvUZvPaGziC8m3oqFLDgzw3+Y9cB9gv2lE+I+hz0vLqtvk/RE01aavGhY/GnqwSo1KnuXcKfLmX1j4/bJp5n3isy/rnL/3Imrm6BXFD/G0Ee61SkrhOg16cGLMKGN/lqP7VUTf3pyuJY4XDfE25VtYGvv1+IZaTDUQ1vF9SyFzs3Ft1fWgOVA8YpRpEz14UVBEIrPJzNYeSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3rlREVo9PRJr2FFknhA0kkaolK8lbTWqjBwKi2iH48=;
 b=Sxv4IhpuOSjuJDM5AgBLw22Av/kXEwYtvS7g/R30oH97LqPQDR9fN6A4a+YEDs0CktczNFQmFexD80niDAkOllESq8vWq+h4QCvgd9OrTcAD7i61+DUxM1oVFrWGeKR1KhpFYSEvOOGqsieYpl2AWcP53P8OxXd3XlCFCLXugM4=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 06:26:59 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::39) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Mon, 26 Apr 2021 06:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 06:26:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 01:26:59 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Apr 2021 01:26:58 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Mon, 26 Apr 2021 14:27:00 +0800
Message-ID: <20210426062701.39732-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb216c4-984c-460b-6292-08d9087c4c37
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3237CBFF5B537A2FA3402DA5FF429@BYAPR12MB3237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5Y+0uTReiauAsLNfGgKcm0FmtTmqmdMAK9swV12o4ulEQjqDcKhwTFT1uN26wtGjilBUm71h3pDdA7jdGIwqamQ6CyPmrrqLjdWmB8AcSe1LFbydKIlYuo9RpbfJNF+QN4f1geZ1tBGfQ4NxfBpwuxh/Pm4Rg9KTfFUBmA1WZg+8gA1vp3lUOZg/SLDOUH9gWCuuwAcm8pMsNWWI0FBgvyCOXDfKCVFet5trDqCzoHZaj353vU/IP93Lzn83dL3PqT/yfONeBG40hkOt2BOdYwOvfIRrgvWHFIILD1qA2y5xKQ4WtLdZnOU7kqxAoLUi/0eplt7PU+bBDFPwL6xNGFfp/XN7J+S1FfFcbtm7NNYk/VZKWZPIw5z0ws8F4OuW8AMV2/0Xfm1lNruIjp7gFAX2SvGQSqwrjrPAQnIcV26i6EBgs0H3qwzpFg43scX0TavifanIUxGSS+iBzt7gh11aMbetx4UkjbweeIujoc237EU95dUtJeOObown0QeDpa/tLinmY1vcyREJ0KnWRyOIO2OkmIMhzywROeWqcrPSZcf/Ail+ah51ahbiPxUbqWolALAy8IBT8YeG+ciVP7e8QM7biXHFVriHw/Ps5naIcMmrdKy2mcVrgA+9FMW96xIU0Px2eN59b5YvYYuJ1TRjE6kBKQwYYuOgQZTAqC7DkmrJo6A9GflQIHU5kra
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(2616005)(336012)(426003)(5660300002)(2906002)(6916009)(36756003)(4326008)(316002)(54906003)(6666004)(478600001)(26005)(1076003)(186003)(81166007)(83380400001)(356005)(47076005)(36860700001)(82310400003)(82740400003)(86362001)(7696005)(8676002)(8936002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 06:26:59.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb216c4-984c-460b-6292-08d9087c4c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
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
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..f8e39ab0c41b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
 
 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jobs from pending list
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
@@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
We just need to record the scheduled time of the next job. So we 
need not to check the rest job.
+		/* account for the next fence in the queue */
+		next = list_first_entry_or_null(&sched->pending_list,
+				struct drm_sched_job, list);
+		if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+			&job->s_fence->finished.flags)) {
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
