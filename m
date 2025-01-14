Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2BC02185
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 19:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F290810E47E;
	Tue, 14 Jan 2025 19:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CG0r9R/0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08BE10E47D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 19:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsAgEzmuoV/QPjh9vdyq71yVOTto3vnNSLbrm+O8rhcbx654xJIY0/lYnckl0Uls9w2zTN1EkGod/zE+9WfqEQoZkBDzW/kbfCdUX7ioVy/QwcuBSONOSAH085sYS0s017YoSVbEleKDwibT7H7RyLLzZ/VX790pomjS2IPVAcUOV8gIbTG0Sc0V1VdgcagCZ+UIuyHZa9OGbMJ3D6eT4MTlP7hF00vVEso6GUoX6yiiA0hHpqa/N8sVYGVzISniArc+PsXROOV93pP3VMZxYc+TOM/hvNV3jjl9qd+aJwmIj36WGPKWEb9/3NhY/2Xx78MmTFZ6JzFyu0UfNHhsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQh/imuRsrMyoDew4u0LLYHCPobu3F2ZgZMwVxO0q9M=;
 b=Z68A6pPxIbaFJR6dBUE1UEjM8QCjFb2siVKN3ubxwDsW4oww6NZFskgJ3Jg/vXTGjkW+QF23wcN0TkijVP8RHG1nR5DZxW4VQd0yr92rEAQiWfFC/sEBz4LnCAUk8MhvRAg9kUMzoqMoiu/Fuu5yc3s34h8zcXXUmn0o9OG+qorZ4XMlZLu5ZjjJsVIjHF3Rqwryzdd80jCl3hvhfbZvdbqHil6eTEZu4Mh9bjkJvAUqNPce4J1z4dFyq2plnDuv7vBcSKKyUDASqwDRaYX+JCgd+imscJjeQvbtr5d1d3RYxcBO3am2sYY+xYHeneERdrAIkz/fhZ+adO+/sKwgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQh/imuRsrMyoDew4u0LLYHCPobu3F2ZgZMwVxO0q9M=;
 b=CG0r9R/00yPjDdInJ8mZo8mYPOLLDYTH7ZiP+0rK+VGjSWMk95OMw6YeewD45bLRLnBA1eV10iQK/YBe8V4sagoDw70nyowulZx/Um/8KtTdV4YCB/bQBIKf/BgZ+ytiA++OVp5IGTQWZo0NLQ8Om1UwCInLHA1gQ9nOcbelgmY=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:54:02 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::e3) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.4 via Frontend Transport; Tue,
 14 Jan 2025 19:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 19:54:02 +0000
Received: from elenaOnsiteDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 14 Jan 2025 13:54:01 -0600
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <elena.sakhnovitch@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Elena Sakhnovitch
 <Elena.Sakhnovitch@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Set lower queue retry timeout for gfx9 family
Date: Tue, 14 Jan 2025 14:52:51 -0500
Message-ID: <20250114195251.42661-3-Elena.Sakhnovitch@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b0d040-b61d-444c-e7fb-08dd34d531d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tO83uMhP2/FF5urU9X/e4jSou6Oa1nP3o77mBXZqIkDr8fIHIW1hRKAytClx?=
 =?us-ascii?Q?MK//ySzSFvFUUi2t7w9TPs1hmy3Ay1RKmL8ke0I1zpdRIL/Reth5TaDxk71+?=
 =?us-ascii?Q?NjhmeYRPUXu6buH6+NCOAozMOWibQpUqEfN4FuvKnlaBKV5IgW3UU8WNaJii?=
 =?us-ascii?Q?51fYm5ct54E7Q7dVLsNovdmrFVXE5rzTRhWoG/QLMmRYP+FgDU1WxZZkoMEz?=
 =?us-ascii?Q?e6sRHFgNRKxvRFZZ6mB+jFzuC1NHFoq2HQmE6UXwXd1dkwcLz8riQtN0RFWx?=
 =?us-ascii?Q?rdvZ+O5ml/4W5lt+bQUVH3CsJd5hVSQU6YXG2/8huVODbg07Cw9zTXqoG3rK?=
 =?us-ascii?Q?OJY4t1JXgyoxQEdbXlsTPzf90Vygg5//MiFj5ZnxSLwiNxXdSjqGlKqLY3Yu?=
 =?us-ascii?Q?07RC8CADRVYEFOFSvlLAQqgw7NTb7hL2DqTdde72syOSY92MEuHh3BPC+XO+?=
 =?us-ascii?Q?No13L8CCIpqwgny8Zf+QzFmQY0go2ceiEq/bOwtbeAhIwGY9w2nga3kGjHNn?=
 =?us-ascii?Q?XzRM9L0TPz8Lxpr6ZlboFPlI2TC3mUQ1/R8Qipknqa16Jo6nCcrS01eeYDm6?=
 =?us-ascii?Q?m/1J/XuGXisIPfpX+YI1hgVGHn+xIO+7PqMA9B88zKON5hZ5oDoZ5brBHmW0?=
 =?us-ascii?Q?Xm5CVESrDmIqb7VUgbUlRemQofczEgKH1HJnpxBIBoCG9Br9wQvHzs+i4ZgU?=
 =?us-ascii?Q?SfAls+Mhf6jO2iX3VtX+Y9gCxqHihgxsBNfg/lJaHCvD6hraXNXx/P7UATrp?=
 =?us-ascii?Q?9P5N6LwLhNjgMt7D9vmv/JfK0eQk3FgZ7zGOePFCF+xFCpgNJpH344zZM0a3?=
 =?us-ascii?Q?gfJypTupaeuLgwUW+qChlsilvNpvG8wAQElUZvfZkwV7NhT/D13SKCD4bxbY?=
 =?us-ascii?Q?/RxA+TwdxJqWFeF8bU+lPspON+JLDBIvKOOoPAbcWPwwXSMpYHYSTbY5jvPh?=
 =?us-ascii?Q?e8oQI3ZYfG26t9mPJYXvtxYWOi4a6I2Wx+qIVEOzPw4j+ugXlgNogNYXTvFJ?=
 =?us-ascii?Q?UNg1gFZbNUV1o8tfJ8ip/oipD7hbbJIx+CAGh0EHpAksDWJkKikz/nHfhmKs?=
 =?us-ascii?Q?K/Sy9QxE6qXBgggDpoT9A+wFPPSybcNZuRYg7Y0p81V+iM06v7CVdpDEKid2?=
 =?us-ascii?Q?kIymN9wOLt3Ct+ikQrR4CgTZgFswOVDK3PTSCvKoMWBWwdDpyvg27Efuqd+z?=
 =?us-ascii?Q?71ujZQ6Mf2oE++OoUKYqRFXMaRuOwXgqjFTaRPCA7FxANzK8/3ESqr4sFIJO?=
 =?us-ascii?Q?374ovO8eDPddBoPy9vC2tMKPrfRYSmg2xnWZ4dCh7EA7eNaTjud8dBoxyecb?=
 =?us-ascii?Q?zNgqsuNcJpvh5LDkZRtanmsA+Heitgl60njPaZDvTkja8v7EEWa76hIizFOw?=
 =?us-ascii?Q?/XfXY15FpkIHRa3n6ZSGf9+XNUObiqog3Bn9BLmKqNoYVKCHhHhC5YsFGjeA?=
 =?us-ascii?Q?e/Sii/zkPW6O9hfh85ZkT9+KC5hJrE47TdIuepTcA97/hAPNbdhKsfBmAxub?=
 =?us-ascii?Q?3a5dN2PSjGyQKVw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:54:02.3499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b0d040-b61d-444c-e7fb-08dd34d531d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Set more optimized queue retry timeout for gfx9 family starting with
arcturus.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |  1 +
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8e72dcff8867..652c695d04e2 100644
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
index 04c86a229a23..d93a0285f225 100644
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
@@ -1092,6 +1093,13 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 				grace_period);
 	}
 
+	if (que_sleep) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
+	}
+
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
index adc7f7c78a18..4de8106d14ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -305,6 +305,7 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	struct device_queue_manager *dqm = pm->dqm;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
+	uint32_t que_sleep = 0;
 
 	/*
 	 * The CP cannot handle a 0 grace period input and will result in
@@ -319,18 +320,29 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	}
 
 	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
+		/* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		 * On a 1GHz machine this is roughly 1 microsecond, which is
+		 * about how long it takes to load data out of memory during
+		 * queue connect
+		 * QUE_SLEEP: Wait Count for Dequeue Retry.
+		 */
+		if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 4, 1) &&
+		    KFD_GC_VERSION(dqm->dev) < IP_VERSION(10, 0, 0))
+			que_sleep = 1;
+
 		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
 		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
 			grace_period = 1;
 		else
-			return 0;
+			grace_period = 0; /* 0 will keep the default value */
 	}
 
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
 			pm->dqm->wait_times,
 			grace_period,
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

