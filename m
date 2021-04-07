Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A86FC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB0E61363
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB0E61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DACE6E0FD;
	Wed,  7 Apr 2021 13:31:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FE26E90B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 13:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc+0t8ahseFJgTp2p/o4Ndz3HENhVGM/2vS8eX/3vNZx9dgFFIQ45AfblUgwY7nQtJ1PC2UwlE43I3md3zUgoQ5w3fLAUE4YqcZ+i7hMSdp19b8XBq9jHLp/o82IrHer5GHSC5ThlXyo7rCHenzJsnTHTC/AZwNn71v4p6Souvr2LI2lCRFYIV3EYLWteT8lIzIfy+DpIv5LEum8TBKTC5/OrJ8Ca9p6g3QPk71Tp5yBVgc6JzOgNG8y8O0pjvnTKND8ApUlr1KvTEuFgbx2Zs+UbysKHTV6j70FSArV/kxAhc5U60zbCuuohcP8zsrbrU0eQFNDsiX7jG9NlitGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=C932ae9lnM7xHpcHvLljEexocRHwFOpyQ07DK5x6xS1kMZFQpxS8pwhSf6YkgrCZyBiTimGH1BwzG0rTaxtpRZtTFmfv+jPETgg382RiaF8KBF6wIpGXjnZwgLjyd6hQRLSZzlN8NuR1PKjSrB+o0GkJ8NJVitD0zjLFA7DYx9cyiyDr5AlkW0x7eVxLBE8u72H+qfYUXwS5j7hrfl25Vo76Ej6MilyQlb0ejAmIAt4h/dz8RS1GQuqJqfUJU9DKC8ZztFWi+uugpvdcTjhk17hKYKefgpYXLo690xToqeCZbjVBRsTX8QShhQTuuaLjAZW78BjGppRQAdNhKY1h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=ePX1Be1wzCL4Or7NgNaEWWR49yuxQ/56ETHvNUVObXfMSxuTgOTkSeOen+Kpv/fsodTHE13drX3VJju506uRsLoyJYTxSQf6EBJo0L4ui3ZToH1QpSCOuSYHyEj2TitttJ/v0JlPhReyfPF8RKfCryYd5VR1nP14myiBJ2rrnmg=
Received: from MW4PR04CA0027.namprd04.prod.outlook.com (2603:10b6:303:69::32)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 13:31:22 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::79) by MW4PR04CA0027.outlook.office365.com
 (2603:10b6:303:69::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 13:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 13:31:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 08:31:20 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 7 Apr 2021 08:31:19 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/scheduler: Change scheduled fence track
Date: Wed, 7 Apr 2021 21:31:05 +0800
Message-ID: <20210407133105.39702-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407133105.39702-1-Roy.Sun@amd.com>
References: <20210407133105.39702-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37b8672-6942-4f41-6ac9-08d8f9c96f23
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12884FC1EB8C5E0C5585AD21FF759@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlmVketJDhSqYSy3pKEtqoB1q1uCR5o2rl9LET0Jzwef/tw/2XfqweAM55+2faecK/IfvnAJPU+9tBL75bTaV+6CBPzX4Y3K788nO/iuN3WVtzXgqXDrsATbkqMUO0VSM5SHXkx0MwpVl8I76pg7h5TRLE0PEwa1tKALue08PNDusrGWEk7/P+d76i5gp7tLHut9Kdiu3Y0Af8+yJpiThD/4XLWdKtnzb7G4ygChAtZq0sBo0UlgiqpZUJBPx5us0oQFq5H26XtDz6MxLKi7Im74/C+wnykBF+U9cBDMECpIYYtRU/3EfHkhYQS98DQgoGZYwbPQkVmtQ7UTY4rFzMDeeQXP8dZtsqbksc/q0igxjbIGczGM0zBF6J5nz+nEU5EzA6pYxylRu1Q05euO30tYVXV8NbwBj7GTjbNgTjlJ0L6H3ofJ0xXG4Xig1RRNYKVLq/DwCPh3Gtvrttfn26+2TmxOGmRD+7YT3eKwHOqRZulDKQ+eDZXw+Npq/HmHQr4/3qYlb5wUHGzXYDRd4MFz1D6u2ByYxsfdY+ikr7b+qn0SuFN5rGamJWIHZg5QqCrfC7mwRDMBndHXKOFIDB1qMCAI+IzxcUGBKqJEXtlwco/WB8ezT/ePSMWVMODMnCKUOEHN4Y1Kztlwqw4bY5gGuYf3bjCPraHNospJcPwwGCrrhcG+JmSqh4RhyVMv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(8936002)(356005)(36860700001)(81166007)(8676002)(26005)(82310400003)(82740400003)(426003)(336012)(86362001)(54906003)(6666004)(2616005)(36756003)(316002)(1076003)(4326008)(47076005)(186003)(7696005)(70206006)(70586007)(83380400001)(2906002)(5660300002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:31:21.9650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e37b8672-6942-4f41-6ac9-08d8f9c96f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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
Cc: Alexander.Deucher@amd.com, Roy Sun <Roy.Sun@amd.com>,
 David M Nieto <david.nieto@amd.com>
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
