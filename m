Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201CAD1D895
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 18:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F1210E5E5;
	Tue, 15 Oct 2024 18:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4IXeHbKJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4F310E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 18:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXUPpLCKbBpdrjVOHn5vMUCtHe5JOVx99FOBIz1o8HYgLoqDZisTyKge1G99ZnmSYszk/lm4pvUJdIzFhBPhy2PbgxDiRkY0bzeh2Db8NQuWKVjLK3KzGbIAzXaUC9y5am4+nlxeiXIasU+VAvfTCL2I8nje5MAJPMr7YUcktVeNFsWOnl56cBGfh+45S4zZVhxFy4VdN4dsmG2ho6+wj73+R82sdQeXdCuLQIFLuAKNl/2vitjXcW26xnymL1EEo9PSqWuRduVDbAs1B8j2SU5g0sOAbnrq6owqjXnU7a+ZUODCOLpRf8a44eFhIyZRHbNb2fznIW+sJBKPn+J9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va1+OKcBKglZSv2BRKPVW0kETbx2NE5wD31qDRBfCAM=;
 b=IJemnPPupNe6LqnyLGgIr3mKgDsTs/MvcuAawdKz9lrtThdiVqdMDzdPuoCO7DfRXor58Dk9MFaAA9t75VnUPxGUGZ/ajgjJPf4rtpGiCRJpIRDQQXWluhyqL0VUnmMwL6UEEnGB9ROLZBz5V/q/AZIPfXvuToHlo9OqpxN/Z/zhGyFyTQG7E205+MMQJeucXbn2dCfPU8lE/HvCr+jRVaNTywe7lax0Wev+fJmqbQqLyMFg0BLt1TiobA8IT++yRhbeGdhm9CJGEWZEGssIANhzogZWl/xJws30WvQdgipgrq29m44Z6AESRNOa4YQZ8SJJww3xaN7w5R/ukBwaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va1+OKcBKglZSv2BRKPVW0kETbx2NE5wD31qDRBfCAM=;
 b=4IXeHbKJPJUgSX+/zlHZP/f+rCDipOhtz/1+oT0/p258eqWVND3KEErj7lvtEKKv2RVXdZh0vL0wYJ+IJqGpYLZocKPx1iqdYFNtJhq0ipv+zDcusbMzTv/uaK8hSQw+gaBglyeQ2tyY1PJV8DHLhtFWBiyCSXoxVP96Qs75goM=
Received: from SN7PR04CA0161.namprd04.prod.outlook.com (2603:10b6:806:125::16)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 18:15:55 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::e1) by SN7PR04CA0161.outlook.office365.com
 (2603:10b6:806:125::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 18:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 18:15:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 13:15:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add ring reset messages
Date: Tue, 15 Oct 2024 14:15:41 -0400
Message-ID: <20241015181541.2457526-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 62638600-129c-43cd-edc9-08dced45690e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xef37apWm1JSdbCh4cy+paBMIxzUBOFVJqepqMYVEZq5lILcd+44vUVJEGzE?=
 =?us-ascii?Q?VEwNvQPQ2muaIdup24z6K4b9En0y2jcul9wTNyhTIl+KBpnVPBTrB2ka7HnS?=
 =?us-ascii?Q?pDXYbFjQ2mVKSYHVv5J2Wu+3ONNAiTIwfjGxbQj8hz9bngmj5d1tGhFXx0be?=
 =?us-ascii?Q?+9szAyHC+7o4Nqe9zQs4AYBR3R2LbXYgZ8odM4i5gkz1AkAD2iRFy6npCFGA?=
 =?us-ascii?Q?SbCJn0ScY69oEw4mY8GGNIiegFK91zFldfUg0+DV43CclYuvG17Ikry9cN/M?=
 =?us-ascii?Q?y+ACjwFsmA7Z6Lpjf+Yxv6wrKapPBe4ztsUMzY1KSsaEyeX/p7MJIXC5ooPj?=
 =?us-ascii?Q?zS74e0pnWatzzLudHVVMH4FJVK/gDGhSR9AXQSE3eN4p9GOkWylO1ijDVZYy?=
 =?us-ascii?Q?v2cok5o1t67vlEeibNeHKNDvrF4ZOB3HHwnA/WKgX1HNgojNV74CvHe0fU7L?=
 =?us-ascii?Q?7vfQrie3J+5EsxfqDAph7q1xoFXXyVQ/QyI8h29MoH2rqaN/O1k9oWJBv2Dx?=
 =?us-ascii?Q?S76350yT1dX8JcAuc2RBEmSp4fif2bnaT6DSo+6f6B2Rw+Srwe+35ZzKY6pg?=
 =?us-ascii?Q?11gN0Ms0oITqVENdfsWgsP9Vb6VuCRvSx6LiMri4dAK6F1bj+zgz4EBSnTF4?=
 =?us-ascii?Q?HEBygtJNuhJ4MitQ6be8loU7CVhuXCBT35Q+qqTpbo17kY/aSkQxslFw5PgW?=
 =?us-ascii?Q?zhhOR+wyAJX9I4wRh3xXdiQPDNaZRHjAZy9iaAlMqR7NflInlovwBfHzWYFw?=
 =?us-ascii?Q?ClqnNA9huqHDAeciLQpm7Mbc3bbfy9dlU2zOtm34VRdjv3s21xDTRjucHT7O?=
 =?us-ascii?Q?sDPXA8Sh3BteQDqooN377WCtgoodB40igSTqLNKuy6s9trfiA7zNmpgn/idy?=
 =?us-ascii?Q?bkiNAAbnRL8A+byvHTRqIAy48qBX7KnD+jzCrlzim26uGNdJWAh3A2imwI7U?=
 =?us-ascii?Q?0W/0RbbUnrJIdLwTJg2bLZ6kC0mZMfyEzP2RiapQkSPwQPD3uR1qjMv6PyGj?=
 =?us-ascii?Q?axzCiWMgxlpOT8HF7RdY+svBdROCFXlVPXKLIU2k7DRpSkAdxDcKC3fFbLd+?=
 =?us-ascii?Q?14XPPT1HFxukCaCQ7OQSuWsaseBs2O0+KeYCmQ+qTFMdrq9iORtfWzfi7BgU?=
 =?us-ascii?Q?kemI5wzoTv4SsD/csu8V5+L6NHd5x86Z5XN4/HRFR+P9lXvEpfHbKuVAkRNg?=
 =?us-ascii?Q?1YH8z+2Ev9BpKdJNuQa7U1X0AsS3TpDY+zDCu/z0xOkl5Q005hEBcr9u2k+V?=
 =?us-ascii?Q?/MBCRnQMMbxj9cRRoq4KzZ60YEGGDsIMy97d9wrsVGDSs+x+XyxHVLpHJcWW?=
 =?us-ascii?Q?kewSotfbh2jDbX2obnIhbsJRSwO+j7AU9rnsdTlKPXf6oZYZV0UnM3rmmtZR?=
 =?us-ascii?Q?Jy2lN3TS8dYke5+883uHMUX3KOpS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:15:55.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62638600-129c-43cd-edc9-08dced45690e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add messages to make it clear when a per ring reset
happens.  This is helpful for debugging and aligns with
other reset methods.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 102742f1faa2..2d60552a13ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/* attempt a per ring reset */
 	if (amdgpu_gpu_recovery &&
 	    ring->funcs->reset) {
+		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
 		/* stop the scheduler, but don't mess with the
 		 * bad job yet because if ring reset fails
 		 * we'll fall back to full GPU reset.
@@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched);
+			dev_err(adev->dev, "Ring reset success\n");
 			goto exit;
 		}
+		dev_err(adev->dev, "Ring reset failure\n");
 	}
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-- 
2.46.2

