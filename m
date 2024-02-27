Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA9EC5478C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 15:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C0E10E755;
	Tue, 27 Feb 2024 15:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qatQzC3H";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D6C10E755
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 15:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYjSO9bPrDur89TfeML8TbN7S86AUBkI1YuIxZmf/6yckDpwDQce7/MIzGZC5dg15MOrvjWVPHriD6dNfSNOspsx882JwOYe1z4ZUn2RxjeDZC8T/DpVMF8aWcOOgx0hQV44iJRK6Pri6RWUxEgcvgSgB+J2H2GBLDwvGpoyrfqxRYCgmZbUo7QkDmfvSGnR/RzJQQdNcVvvTrFbXzIOdyE1b4NeYrc8zUl3cfAYg71gDQGLpmUShsAGTEVIPPRFm7s3E3X+alOVHUp1ztANo5HUyTUt5FyosEoqtvG7xEvYKAAEl6CZ+yOYuHJ3wpgE963O0dI/SI9ZiarrdRhWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBljWXXDf9f7iUvVjnqltLUQmp0kipzbGumUe4MHFPA=;
 b=DEJZwAtBT0V7//ysST9VRymtbs866vjU71lEXWl+0yMKMZbW5mjBWK4Wtvwmxnt55Nl8sK01Q4RRhMlxyIGPGV66cpL54aXqIOCrUSNXDvbf6jRZo7Ns1efRxsVkeYbyWAIdnrgogPLMuH2CeTRoSCCS9Ce6MmbMuYpErh2QZtDWgI0IISNNy1Tmd2MUamJMhUie36ICR7qeOYrIDwNhrG46zpZYFbUsi6imSkpylDvrUcB0FKKLKPvvhWPnITvx/QiIFaqCqCc53pkGvoNIWsn+rLCEeYT19veHijkkqb90EEFeCXIQ4YA12hfNEOR5KWqw8O+puJziLLt82XGpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBljWXXDf9f7iUvVjnqltLUQmp0kipzbGumUe4MHFPA=;
 b=qatQzC3HboHDPFMH43gz6xipBY9kULyx+/RQD0cdOFS4nfwuUMG86CRPJzYN5g7WTrJ9eUdu1hg8h1r+kz89GCz7Xq3IF6+UQUEo+/Arp4qYaZCd2cdlZrw/sZN1q+TL6NZ9jeJOxMqaGGiK2/R71oSMsHuskBmw3pB62TpQS+0=
Received: from BYAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:c0::42)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 15:46:05 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::2f) by BYAPR05CA0029.outlook.office365.com
 (2603:10b6:a03:c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25 via Frontend
 Transport; Tue, 27 Feb 2024 15:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 15:46:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 09:45:59 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix potential truncation by increasing
 SMU_FW_NAME_LEN
Date: Tue, 27 Feb 2024 21:15:46 +0530
Message-ID: <20240227154546.2818912-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf5b381-5736-4bf7-620c-08dc37ab350c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFhtE3eMDwVwRjckOGnZuESEP4kzjH2X8Ao8rwIk70KjaD0d9qc9J1OF8ZcYjGdztOX3Yx1q1VGeCGKrrmUl1AYupxCsSOngCwIWFpJguZs/aaEdh3lZvdtN0f6aqOaVeQt1bqP5zuph5HALnvUiAWn8omybElk+CvfXvmODYDys4CcN8w09LrXt0lCrtCuHhkMtiaoa5X0v11zcTZCQUPTe6qFdcdN01uB8w8Pnc4nKTd9zMBXY960yBbBUJ5UWim06u1A4Y3OXqG0kuqrDPt1JoUjjNyzidSEvQnAtZrLD0aXUUhUENYWYhhYVtmfGmIgqNLtaptLWShEFYfRhEDYkwlWvQfyoU2oFsLziXoLSnDHtoIBX6GJOEYsaZc1qHddtl/2nlEen3I4rfsrA+PDXbHF5uOHe5flCF/F5ZkVSbuB1xzIdKTKeZzbvuWIEvwimFSW0MOgkrYNCLZpOtq/kdppqpavruFHsf6FFdH8kGc1J7huk6rKCmTJV20st2dNd6iyqH16ZCU6StMQRSkGETjHj/HxLUH4XRUCSo7JOuu4t96WPOlIP4/9k26GhltB/fCID7MPOsuYJGYuSc4VMIs6R3FrMTrRne61aoKfsXdAfo34Oiy47W9kaO/4Y03vpKd2RsC+38zXLiOPq5HOxhZbIJKjZLma/5AWPmLuoVFUT+Bs13VjoLB4/ibZRtAn54NRfPdDT/qY7VDkzxjT/n1w3ZRFedsBOrHuN4cNI/NTUbRFusbTDL/2GXGSx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:46:04.7457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf5b381-5736-4bf7-620c-08dc37ab350c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

Increases the size of SMU_FW_NAME_LEN from 0x24 (36 in decimal) to 0x2A
(42 in decimal). This change prevents truncation when the snprintf
function writes into the fw_name buffer in the smu_v11_0_init_microcode
function.

Previously, snprintf could write between 12 and 41 bytes into fw_name,
which can only hold 36 bytes. This could lead to truncation if the size
of the string is larger than 36 bytes. By increasing the size of
SMU_FW_NAME_LEN to 42, we ensure that fw_name can accommodate the
maximum possible string size.

Fixes the below with gcc W=1
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: In function ‘smu_v11_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:54: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
  110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                      ^~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 36
  110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 6b54496238cc ("drm/amd: Convert SMUv11 microcode to use `amdgpu_ucode_ip_version_decode`")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..3d98b0e0eec2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -35,7 +35,7 @@
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
 #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES	1000
-#define SMU_FW_NAME_LEN			0x24
+#define SMU_FW_NAME_LEN			0x2A
 
 #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
 #define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
-- 
2.34.1

