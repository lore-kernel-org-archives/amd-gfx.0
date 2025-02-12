Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD536C021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 22:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4D10E9A2;
	Wed, 12 Feb 2025 22:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pF3gGw7W";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693C710E9A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 22:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3dbLdxU/eu6irXKEUSvS9fKy1pE3nwL/Khm0i/eEbQ/GTxDpShQkkxIJF5svLoyVWW0J8QY/noNJ7/4Amby/OXNpjLN21CpaoJuaaEyWqxZ6CfSZ3oXJvxFJ7GnODfQCqOAlLW/RRRTxhlINBvz3goBNFCHTpzrnGQZRPqWdo++0JAl16xbp4Rs0+U/ygR2OoWDbNDe7JnFdBU3N/MTkewp/UHOkynwrqkLRQC1WmhyboLYU5BjCMv+eL7emKzFj4yzRa37J7Lx/xw2E9RdL1VykUTRh8V7Xbao6qNwG8drTLuiHnBVO3VftNA7UQalt54zS1zpk7m+ATmxAK8S0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6V8K4gVW0g00TjZWogjvBl0iuYa9yPbbFJNVOdvkHw=;
 b=WX/hmTZ4Tau+5wOsqp0Gkt9tVv5MaVuKACI7ha7XhbAdkEfQazL0M7xw5HDJ5MkfH5bCDEF3vBawa+K++QPjG9Lx9rUJMtBWzzNPxb3jVHr6/n3b/hrvtd4p7vIgM2xPYZI6Nd5IP8oUXw0ReffVbWPULg68o2ynzWo0kSpo6xOrlfRp/QaYPdW6GfWwGnX69zggf2pAl02e/f310vbZO8hSk6zO79BzXjxH2hOLZzC6DMOfV1wL95NY/reAL5e+v890H883W6Q/b8bGKReb4aeNEpgGqQh+QR5Zo2mFUAI6YzEYp3B1ztTz7SwAT2wI8kP+7I5RL98SJ7cuAlp+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6V8K4gVW0g00TjZWogjvBl0iuYa9yPbbFJNVOdvkHw=;
 b=pF3gGw7WmLAIkPspElJimV20VkWBjvM1Ph61AUI+qKR6J9bfAuPbusVjZ+pnvdgp75LRHjmHqRNqHKsE5BO9xK6giEF7Di3LtqviHC8ETYcKwh80KK7ae2qXibd8etJZBQz1rrXii44xjHMwXb+wmomu6ehFY3EhR2K8jWa4GMw=
Received: from PH7P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::13)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 22:04:13 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::cb) by PH7P221CA0050.outlook.office365.com
 (2603:10b6:510:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Wed,
 12 Feb 2025 22:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 22:04:12 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 16:04:07 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Set lower queue retry timeout for gfx9 family
Date: Wed, 12 Feb 2025 17:03:41 -0500
Message-ID: <20250212220341.373072-4-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 490dd0b8-fe4b-4c1c-361d-08dd4bb12f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4HbE5XFIDRyHB5wWjT9pqvitw1PwlNRCe3we0/bzsIpvQgpDAU2ODmGa+56o?=
 =?us-ascii?Q?2SZQhshXPKvQzETv/LvwaKMQQ7T3KiTnpusD8GnnCnjK/+e2Q+IF/GWtqJ5s?=
 =?us-ascii?Q?eM72XpemUO/ePMcrSKuT7/DowYayOXBebWexO4mCA3lNmNznb+G1w3Gh+Uhy?=
 =?us-ascii?Q?qZIFFauk0QJnvSwvXJl83t1ZAo780GXLGGRgmIlVRZF9yo68Ke2bzyaVj+vm?=
 =?us-ascii?Q?kcLq/UgB7tV8/zAtHdOCIU4xEiGwHSGa/mYHoe8J3GAu8KBiuPSLc/4Nvlfa?=
 =?us-ascii?Q?X3K2c9Axd5B7tlVb6ZO1NEPxs4YMAlPFihsZseFgeJweT/FIev5BI7zXsT+J?=
 =?us-ascii?Q?TdmM1dcNfeYOV+J2eq8fJ0TeK6PkSbAlO3/nk4njHvt5WXl0Aikxuob5Y6dw?=
 =?us-ascii?Q?Zg6CSPKdCUV7aZi1IHmxo8sIYNJ/vs5J1de8gwB7LlqADRWc/TdDSssAZvhS?=
 =?us-ascii?Q?6HsmjzfUUnAZP9j+1N89cbysCrcSJ8yrjJ7jRJ5bHrpSjHRyrzSmsbtlFXiV?=
 =?us-ascii?Q?wy5KlUXfcvO07Qj8MDX8nnCiaLzbgQl0EdeLxnXaAazmccvDm5VxaEuB4Oaq?=
 =?us-ascii?Q?4zFLpkeLP/hErwu0D8Ovui3i6groxJKPo4Njf03+jVLKiNRNGYSOq3et5+Ci?=
 =?us-ascii?Q?U6BkSGCG0W5rdtHCT16n4nxSvcsZOAcHO566cO1fHyXKR9A5cpP+BlYouOV0?=
 =?us-ascii?Q?6dtywAtAWHp5HfVq0+J6EpOnC+aapPt7IH4XdAdteH4c1w/4hhVBA1Imyriz?=
 =?us-ascii?Q?8l3kD+wOYI2pFkOW3wqcRznmK0tXSjuSaHEtFe3FcuH933lMw7mYcOOeLK+H?=
 =?us-ascii?Q?rBOOel4lO/AGoicinZtDmSMyuVl9AGAiwZcbbsjfrxA0KOaqc3AuYF1eOFSi?=
 =?us-ascii?Q?X1Pji4PNR5v9GJFfRX7fJfZSQ+b/bbOkUSzM91OdMlFbPr4g333zLitkAayS?=
 =?us-ascii?Q?9LEpNo1PddC70asxOro8InEUgg1vLQ88ousZ2HtOAj+VhkLVBY5oJBUF3rhR?=
 =?us-ascii?Q?5JGzzUiQnWc1vqcMIIR/sGPqcPBWFlsrooIHDRxmqB2ygOK6BoUvsMzmaxGe?=
 =?us-ascii?Q?11fq/OSAIxoWtpVEkLRf5/KUKEtuL/zWdjIGa4+6ZwfG6oFrxeogarwSTUJL?=
 =?us-ascii?Q?lfL9Ug230eASQVpCNFkIee3iLryFvXI8bgooGwTWvL47cr5l+VC5gm94N1sx?=
 =?us-ascii?Q?PfCJ5mniCu5WHUWtrH4+7KeF2PRbehQeqC6waWGk07jTjaGPSGZBjMIj2BsF?=
 =?us-ascii?Q?bU5zmYwVsahfDLa7M3H/IbhttaK1qC7HemHUIb4NSMsyvL26zgoYyvRLePPI?=
 =?us-ascii?Q?t3YXtX9VIoOeapXKwvjkzR2CFetnrThqgK/jpVyqCSbsre0F8uqheFXLUSyi?=
 =?us-ascii?Q?n/SMMQaew/x1mBP7b2sjdZHgiiTLS7WLyexUw0JdYmP6wRyuZzsn0q8hOKSY?=
 =?us-ascii?Q?cDSvxaeJd0CTihf1wPEWrB+9miHcHi7Jry63fzXQwh7QjZoiUNNIs1tnJBPt?=
 =?us-ascii?Q?MNezCHa6WAZHQD0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:04:12.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490dd0b8-fe4b-4c1c-361d-08dd4bb12f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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

Set more optimized queue retry timeout for gfx9 family starting with
arcturus.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  7 ++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  8 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 25 +++++++++++++++----
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
 6 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8e72dcff8867..e62f5dc2529d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1024,6 +1024,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
 						uint32_t grace_period,
+						uint32_t que_sleep,
 						uint32_t *reg_offset,
 						uint32_t *reg_data)
 {
@@ -1035,6 +1036,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 				SCH_WAVE,
 				grace_period);
 	}
+	if (que_sleep) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
+	}
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 9efd2dd4fdd7..11aedaa8a0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -54,6 +54,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 04c86a229a23..3f74307d466d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1080,6 +1080,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
 		uint32_t grace_period,
+		uint32_t que_sleep,
 		uint32_t *reg_offset,
 		uint32_t *reg_data)
 {
@@ -1091,7 +1092,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 				SCH_WAVE,
 				grace_period);
 	}
-
+	if (que_sleep) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
+	}
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index b6a91a552aa4..3f159d477f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -100,6 +100,7 @@ void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index ecabf95d972f..a1b615dc9a19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -305,13 +305,27 @@ static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm,
 	struct device_queue_manager *dqm = pm->dqm;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
+	uint32_t que_sleep = 0;
 
 	if (wait_counts_config == KFD_INIT_CP_QUEUE_WAIT_TIMES) {
-		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
-			wait_counts_config = 1;
-		else
+		/*
+		 * For all GFX9 ASICs -
+		 * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		 * On a 1GHz machine this is roughly 1 microsecond, which is
+		 * about how long it takes to load data out of memory during
+		 * queue connect
+		 * QUE_SLEEP: Wait Count for Dequeue Retry.
+		 */
+		if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 4, 1) &&
+		    KFD_GC_VERSION(dqm->dev) < IP_VERSION(10, 0, 0)) {
+			que_sleep = 1;
+			wait_counts_config = 0; /* use default dqm->wait_times */
+
+			/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+			if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
+			    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+				wait_counts_config = 1;
+		} else
 			return 0;
 	} else if (!wait_counts_config)
 		/*
@@ -328,6 +342,7 @@ static int pm_set_compute_queue_wait_counts_v9(struct packet_manager *pm,
 			pm->dqm->dev->adev,
 			pm->dqm->wait_times,
 			wait_counts_config,
+			que_sleep,
 			&reg_offset,
 			&reg_data);
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index e3e635a31b8a..1ed3fbedf50b 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -316,6 +316,7 @@ struct kfd2kgd_calls {
 	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
 			uint32_t wait_times,
 			uint32_t grace_period,
+			uint32_t que_sleep,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev,
-- 
2.34.1

