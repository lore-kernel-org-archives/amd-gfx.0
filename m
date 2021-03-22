Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C20C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975CA61930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975CA61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF4E6E0A8;
	Mon, 22 Mar 2021 03:05:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0D36E07F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtS5U6rfIPWzNGn/nBUNIdDVMBohtw1dm90qQMRUuZTsbjiKB7x3QAClXkqWyK1L/B/Y8NYjm9NgZV83XIHbAJfjP2SDSjOyU8aKb/UsfTVmg9/+mBX4E4L7aUNIf5R2fF6XZCLg19xAK0w41bmpx1/sESlokJuZ1CxGf4niv43n2hlPrXT+ZBcyK/5BDA0q+gZzAXPuN7qU5aHpNlSc8fVQm4EO3tEHaPP8RNZin/dHl0zeVcuYOFxgwVoQ8vyJglMBYpEeXYQuCBfdGjprlgGNU9iVCtdQtTbYuKfWfvarqt7LUAss1v7HllJRW9inuAdJk7R0Gbxt8krfgvmTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A62ua9W4t4g9B2S8KytdBCzMM06bq+fibpcFmau08vo=;
 b=BDerx2ADnrV89WylbvpsyJv4cvLAGED2vAWqc9jDkb+klkAhNX/5+z+np4pdSQPoCZ6VGpWCabJ8/lZlHdCMjPsRd61uvtiSeTdc+9hiOUVHNrFtF1xxXKLlE46j2CkMJJUo09ZmUAChJeUV8KE2jKTr3I0b2/jwMrEzksof8+IUNQn4PnxUOGXYyh8i6wrEQnBde6xs5iRT8UxK+o+A5PLu/4xnbVpVR2XOAeW6JvK+u8FVD7WZIyy++Qcqe0xpfITw3yuq9JHdclQX6CENLksEp0FXSxXRMoPzyPRg1CoqxYw44Vvi5tiMpaB+C4yiSTucjsvpqeT/P6TiV6+64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A62ua9W4t4g9B2S8KytdBCzMM06bq+fibpcFmau08vo=;
 b=2tIVeSLYIiQI1pkRuXMaDKbT9AdMEfnYnCJOvHevkQG4BbZSosmiO43MzSfGNfasbxxuvz8E4iqqOwClp1WK/Sj4wqgNC/JyODMlR923BXDyQzBeeI0nq7sJR24WXtuXtb0EGF6IicO35Ob4kXxldSFFI2r0JdwMB6qFX5vGsqM=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 03:05:12 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::36) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:11 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:10 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm: Change scheduled fence track
Date: Mon, 22 Mar 2021 11:05:06 +0800
Message-ID: <20210322030510.31607-2-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322030510.31607-1-Roy.Sun@amd.com>
References: <20210322030510.31607-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0192b3-55cf-4d23-7344-08d8ecdf4f37
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42132AB7D8C4E52E9A45D7C1FF659@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3A4e6pNzCyt7RYeGX9DgZlnAKZ4/ra86noj4B6IjRpIsQQx10WXbscBjrpdH3RC+0AL95bO3w8UchWpsRwbSVqO2JADl7Bg7HSOICifTaXsozxxHlplD4nPTBjX19Xf6795Cu9rxzfx2EY6FWVPJyqvLeo7xe5ArP3n6G19Csz8Msfo7rP3TZ2RuMeOLbBVXxj0K0W4tyTsCzlWVeWE+CgDhAQIgniwoMTyQdmToAPhdamy08s0Mu+NKmHAzEfooJtdB+jtfEdnvsRLY0HswT++t06zOUXRdmyFqb9jgrodbTC4cMMjNofe2usyN5C5ZaVk/ElKGpKacPy66IWcndwAGZHDsxCRWhg5G6YPLXdPodGvHpx3j3uivittUVyqbU8NhXgtrg5Yf6C+pqJaUGrbQVaZKS4Vh8+KiK4W2CttxN1yjyaaneDUm2J41kt7TOWZPAzxuZmGRrFDaTc5v48MHHHZDH6jN8GlryvyPHkhZCltEJxfqWsaXW2h8uw9hR7DhOpfcKk/b6awTVxkC3OJJxxOmWt2Paia18oNzk/9kX6cOrqj+2NRO2KN/v2svnbmQ3iufIQs+U8S8PQmr8FbX0z4yn6P64r9J+BTdWqFuHSFGXUvIX1RGPBLWq0PnHi5va8Qhw//2hlN6zyiYqbAYQBN1tgqXPzpIqCvewpfSXZ1ut6fRR0HdqSiFfGj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(5660300002)(426003)(47076005)(70586007)(70206006)(316002)(2906002)(82310400003)(478600001)(1076003)(7696005)(82740400003)(86362001)(356005)(36860700001)(83380400001)(26005)(36756003)(54906003)(186003)(81166007)(8936002)(6666004)(2616005)(336012)(8676002)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:12.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0192b3-55cf-4d23-7344-08d8ecdf4f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Update the timestamp of the scheduled fence on
HW completion of the previous fence.

This allows more accurate tracking of the fence
execution in HW

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..952c553c077e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
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
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
