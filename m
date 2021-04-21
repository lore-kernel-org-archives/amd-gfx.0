Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482EC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 03:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E334361406
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 03:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E334361406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5225F6E93C;
	Wed, 21 Apr 2021 03:46:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BFB6E93C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 03:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaiuMxF12TMjyWoWK5tnjbAPiRl1bIGtAQBa5UQ5BEtb2DhidnoiGcasp6ZprlOzA4LJaHhKlKcHoNuqYqDYtHE2wTVV699eb2ku0YOeKBIxJugHZv3VhU52nfCTlNyLpys2gWxZOejprCQ4H8jRyYhiN9aHFxoAENPustXKXP7nj23g70siGv2CWbHiEjerNokojxHUaBItP3SgfcvxqVlknC3ucwBSYcFDaxVDSap+oq/scZKqHi3ZMXgLvO9e32dIVCaqHCROwkKNa7eZwAcQQU2oPPvpDRBrJMJjAPb07Rfq3TfUqPUPmbUkw/adAEvuhbzNWhLHNigCxLntgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=QNwcu8jggM93fW8ZdZs4grnqTUw8HAsJpACoSkYIGoWnc2ZC2tfx3FE2wjpXPme0D/gk5FIrDOa0ZL+sK4jB3u9kE9L+MJ4KzEtaCdOygczl2L/GV0lq0/JqJijI7Z0m/LArAGCbKgz84No72a+trzhP2Gq7GyrvCv60C1zyl5f9sa6/w1eAdrwpWPbS43NojpzCBmVwfdkPd049vntiKwXQ0GYSw4OW4iYksztaoP0OZhnh+mx4rpuNtYaaW9v6XQhhJthh37uQm1sz8sHI0SngxD9HeD6txCHOBJbbR5ajHFS2hqJbiM5ZG1MajLWp4DJ0LgfRSFibZlq0WYRveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=Iwjr3/Of5liJfmz0a7S7nK9aJaBpIdt3GQDwx70XBxrvC4OdTRX23vIjrFdg5czPZT5OoZB+XdD4LTmWiX/L6xZq2uRSyog3gRmn/S5dud1mIOn4niNXhXcP36ia3EEZJvCvz0b8VQZmnjRBMe7iC03KGeNXzYwJ99/1Fb57oCc=
Received: from MWHPR12CA0060.namprd12.prod.outlook.com (2603:10b6:300:103::22)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 03:46:42 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::c3) by MWHPR12CA0060.outlook.office365.com
 (2603:10b6:300:103::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 03:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 03:46:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 22:46:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 22:46:40 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Apr 2021 22:46:39 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Wed, 21 Apr 2021 11:46:35 +0800
Message-ID: <20210421034636.27816-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff9686c1-c4b2-4088-5b1f-08d90478137d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18705C077DC83641E48F6984FF479@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IKdGJGtxiora+R0fgf3lyDUbZKuJn3B7TXsncb8q+Ccw5eBfPP1fdFilBd/kGGavSMsIoNWjbiFHTa3jDFby5IdUT23tWUSOdwVm5balG/BL5pvuYxuE0diloEY7uIhSsP97YANuLfVNV1ep4qxWBLbg6wM8Ojc17om22pevhUuMA2WlJLMnJIPZAQ3uHjPWJBsaULWFObNpXoBtnA08tLo+HUXf0e3/ZN7Ecu/jpk2h218MPFGtwGe4BH6sPdAoRgHS34E3BjYo805ickiQj49ngYPy5XBGfC6e9JlCIOUw0yD+8bKalcwfDYeHk0UJLIpRgW3XkcnTzLB4Zr4vTiyeN/NwcJOLp5E0d0c4kJomS6sgYI2LIyNMZZbyYZm3gZ68I6NxiaXWKd/zmu42gyV3BsEfyHRoHknHKoNpTG+wvnd/Mg1Wwc9JMCsSo9gxfVXkLuHu6Jc9aINsHBEB7pkHcPJ9BZepCK8n30+UizBGbqs07XT82oNh64k8rtKqTeY+ydRY/s6Lw2KJndJt5VrrzFXkjzZ33mZLPUQNjvTJ1iqtyQwp9uBAA5Qw+Gbxd8koQff9brLOM5cTQP+I/1UUkfDPXDPDhSMpsj0IzN3yYNhFyw1eAUuZxQMFc7/hUEQPsYAgdzsLKTXUQ1Rj0VXMdTcHc6iWy2lYOdFqjhSAb86qZrwf2IMHyNz2pHt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(54906003)(6666004)(26005)(2616005)(82310400003)(7696005)(83380400001)(1076003)(4326008)(186003)(36860700001)(8676002)(70586007)(8936002)(356005)(316002)(86362001)(82740400003)(5660300002)(336012)(6916009)(478600001)(47076005)(70206006)(426003)(2906002)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 03:46:41.7555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9686c1-c4b2-4088-5b1f-08d90478137d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
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
index 92d8de24d0a1..dc05a20a8ef2 100644
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
