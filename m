Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8EC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 11:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559E2613BC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 11:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559E2613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29006E7EC;
	Tue, 20 Apr 2021 11:51:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2FA6E7EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 11:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDLspMpU9sUu7e/ij+07r27aRgLTTF6hm3/efVMvpyUugjSJNX+wGvGlSVl2i2RjwPNLiSR12stVcYimVhpcs9tDygRZRx9GLNhL2Ek/8cC3BC4N9yqN6hb2HwfcCueMUFcm1Lm8rBWj7Doxu2QxsYmPU/JiuEPoOVS26dWG8JMi8I0yWxJMYf+80/L3FPQz46NEDJhKjGtnKAgPktRQh57mxkraaHXDtOnUUdtwL1kuT4uywtYt0uOLPTvTZxeRZiMElTjbSwHcCBL/2P9T14cE//C4X+WuIelZMxliVQo3BFxQmIhcgtdbKKJc/RPmjEBYvdJW/IH2qRKXEBGaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=ICrIcg5DEcPzhJ2xebAokcF1xCy5QjLdF7wlzA0xDOxx8dJ/pkIXvjIbssTKpgiqcnfbbVYDHlekv0OGQQC0euWO3bJd9KPJkr5MHs0Nj9jI4gAIpRS6v/8ry51aghRQ1i1SK0PQ60fUrHyahyBQI66GJ6MEXlXIy0QmVhEK8e1vdCP9689ksSvvqEp2+OkNpN+2i0iJwkGyc846gPrfW97ADqW64yovE2iSm/lWvWjrBb1lUZLUazyCuoJHBVcXwiUTjRY5wCEpdDwLUat4fhtmILlwv11iJtojktkOwC1SeBTRemOTJmpHx0Fx7ZxFXQ8XCOT/qX4l9hSk1ZJIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=SQD6SXw+2XDBtjpl4bpwjuWIgAW/iLgYyAGT0SspUBNYDwVeweiU2G5QsgLEA3rpeOc5Cbcta9LkiRK2VR3HUnFkpPLlV9JjRvREf49UhAZlvQ8x+0y5+Cv6gs3aUy+D6O2w9Vx2z9i7ySFK3zJbQE8B+Gb2gwwYjRwf0w0NT8I=
Received: from DM6PR08CA0063.namprd08.prod.outlook.com (2603:10b6:5:1e0::37)
 by DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 11:51:54 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::23) by DM6PR08CA0063.outlook.office365.com
 (2603:10b6:5:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 11:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 11:51:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 06:51:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 06:51:53 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Apr 2021 06:51:52 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Tue, 20 Apr 2021 19:51:47 +0800
Message-ID: <20210420115148.3652-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad805d0f-bb4e-426d-1116-08d903f2b1c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3659:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3659175F4B62A82BAB6F099AFF489@DM6PR12MB3659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAt1Rhp6Gd4nrTSxaxmMe1vyEch+sEkXele1/pusXhoJDS/5oC12XnlWD/6G3+sT3KbP98IKAA3XdajGcKiFMfPqsrk2ydhvFTtPWxRy1uiKQnLMweIuv7STUoav1/38CuwFznpjxZD3Tem0eH2S09M66C9JREBKRDAhVM9JsHRVJGgihLwa+OFY+QBjnNBQ4RZCm70RzSk0KfnSe8r1V5OR2mjA1LRec0e/fq3LgkJJIbeC+V14hVsdJ92y9IPE3Pu+zf347jSaE3kULUG/Omi38XofUDxJdfb0tKURt56NkSmvZKdi8u+zV3M4jxk0yhkz7FFbJmDCvyczz/gFbZ7KPHlO1Qo3M9tHCWqD0oaECvtR0NiAGk7pcvwlwaYkVnNpFaGFg5qNfb6qbzDJ51W2dHgMA4dJdm/KGZK267EWKoy9c4zg6xB6lqMjAZNKrtJrHvA9alEbJxcJ1ivXT3GHb5VmM5Hxdtvo355PPvNwtzB/34Mv9rumkv4xH6XACPPNtoyddcRl3Eo+s1Ok6q6l1b/74FtKtY+ryI4eJ7LPEe6zuv1hHFN+ujLZKk8J47Dgzi2zto/tt0AvvWEg3A2m+gzksD/TxG4WtxWV7TENEEQl6G5aC2F72ngVK4Ubycb0F1RSTV14mFk5OS13H6ySYJA5Sqb69b6A9OUp9ZpToVHa76bmDM/b93wThvGn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(26005)(8936002)(6666004)(356005)(5660300002)(186003)(81166007)(82740400003)(8676002)(316002)(1076003)(7696005)(2616005)(86362001)(6916009)(83380400001)(47076005)(426003)(4326008)(478600001)(36756003)(54906003)(2906002)(36860700001)(82310400003)(70586007)(336012)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 11:51:54.8208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad805d0f-bb4e-426d-1116-08d903f2b1c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3659
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
