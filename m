Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA3C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759E210E687;
	Wed, 25 Jun 2025 07:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOjcBfDg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F5510E687
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRRIxsmXsVDeRTBRa/Qvj9hDGNeEglGMIxl1HvjZ7CiRjqaQKtcZ0oI6VDMa7qYSPUdTJc2v9nGo5AkMn6DrytN5OXNq1gvJJPF99MSYIishWrWNr7GGmx7Ll6xeuOKqQYAmtr9WTrOXQ+E90VDH8N5kXL3EkmAeXpSQFSyU2qzhPkn272skBh8RkYr9g4uHlRZ6BTVywFhl2Vmo55BIeCXIk31lu9Iyd88JKqtwkW48VDoLCdsd1R1TV46UPZxj4EBiyXb2fwUzpXMVdccifFCbAuUi7rquj0MgEA37Quj9r3bsdoSK3A9ODr4GL5S87ssnqTXZyT21GqnJUqiT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEhR2oZHIIIRn8kSwc0Z7Rgggq8eTi5TrPKLKXj7+Pg=;
 b=x6ixHyc5J+DfmjceXHt4klWXDz/K3jXziv1N1ALGY47zPnKyaZPLwztPk7Yy31Iem7zytuV22j3VT94Nr7xljSbwoiswA0Hzf/ZnfJ6GbbNIwsqPu/e/1zZCy9Pb+zN1YRSauqchJEFKjZfe0xAcabz2SEoQBxHVMyNrL7HYJ3FI4FifrC3/ALNOsT2OR7ewU0kajM4+maiuLQGTdwAyoLVs01OXG4eouOA4xL0qMupYIhAdl8Kh6xtgd1xFvyg1JLIRFQq1EeHr6iUR+d9ifzh9UnS7iH6thwsqZCFwg0NbivVJxivjwIitwPsjPtIk7IvZw2etLQw24GYM6DAXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEhR2oZHIIIRn8kSwc0Z7Rgggq8eTi5TrPKLKXj7+Pg=;
 b=VOjcBfDgukipasDrygDx/vet7uevYVc3wyemJku1RKRUUmlxAsnuq8+oFd3AUvLqncmqXrSQH3ebUffqQybl9BPPHL0VQeBAXQN1Nd/5Ji4YLIar612MEl00NbBIPAfJ4AaoS0TpLaZIhQkGQoLjEAk79zOqa/zUBFn8l+lHqns=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 07:53:28 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::67) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 07:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 07:53:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 02:53:26 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Jun 2025 02:53:15 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add user queue instance count in HW IP info
Date: Wed, 25 Jun 2025 15:53:14 +0800
Message-ID: <20250625075314.4016532-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: d1669e90-ce9c-41e8-2de1-08ddb3bd5f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GG+liXkgBdsIeQAmdT+1/C8kqO30oPRCckFaBMr/jg7TKv2QhM/d2AsOZJvx?=
 =?us-ascii?Q?nDqhf8ElSLZx63p5Dpx1MfEv1PAfW3PdcHCaV2tO5J8IbVYKlDeE598Tahw7?=
 =?us-ascii?Q?L4II+p08jVl1AZ8GikwBQ2+VouWsaxY0c6qxSqfotPk8uyTfelHbojttDd2u?=
 =?us-ascii?Q?/WUC8veaiI3mCwCjjRiEIHn4TiyyKF+CB9X/KyCZSbrEB2R/ngNnAQ00kxrl?=
 =?us-ascii?Q?RygJzULwy84X7Z02BQ4VgnxL3U/AFeucoGbp9OCBSyJyhp8itDp3MDTw5tNa?=
 =?us-ascii?Q?Mey5qaufbWrPnf6DkoiGozuFAsR6+pYfaL8kJ3kHAEybvyIoBzNUKT5rX/LK?=
 =?us-ascii?Q?hv1jKxiJMesyLygstbcD4F+kf2HnJHtqWH1g7x1ZRK3wegKfHq14zbMT/wy4?=
 =?us-ascii?Q?mslOU1lBtj9M5lAzgqG5z2WrTL+sniZTe12QzhGyhStlGo207qLzew40aMwj?=
 =?us-ascii?Q?HBuGRZDL7v0h0HT1f0wd6c3MCNgJBKZoQFHtwcK0Jt0P08lt6HYph3PPQAUQ?=
 =?us-ascii?Q?0ZEKX2cQXIWNhnMqv7yiA6gzYaAQL94XiJvL+zTX53oS1JnVcaJ82BTn6aSM?=
 =?us-ascii?Q?f1Z+I4YG9eNmXxbAidlqhMigrmSE/Pc/u2SGy/dzm+ka8QL+/kksV83ZbPtD?=
 =?us-ascii?Q?B4FEGQYdc+zwDvD3j2akD2zQP2nR1ltwgLPKsvb1GjZRUG4KhCnEw6RsVVUF?=
 =?us-ascii?Q?Xiztk6FDO3Xkolhkukm2vpkd3fpUXU1s29EaMlmnnYsww9snrHQp9hesoHPu?=
 =?us-ascii?Q?4SZ1xsQvcfklxPpl889GIP1Wkg3A/GWObj+0xiFsDlQtM2sdMBut+Mg94kHC?=
 =?us-ascii?Q?Tw1ZrXZSAI9lwcIztq4+N5rfYCI+X/0SnphmsTybbwAUCCChD1RBpOW9kHql?=
 =?us-ascii?Q?2auU2x1VrE8f6E4JTEY3zh/hDrmy94oYbXMbE0aKV3JQf+g4HcxhU0Sl5BDU?=
 =?us-ascii?Q?HFV5PRy72XUvd4Owlv87WtmKfXLwml72DIb1RJpKatx9HCgV1FjN6V7QJBxh?=
 =?us-ascii?Q?VgrGBp6Vt+rFnteH3B8EHtjpGaTmgP0/bXhNE1bAQKghc4jBw+JCXfLLhow/?=
 =?us-ascii?Q?rk2o9Iw9c+f90BnOmLsaKvJU7PZNvIXnI2Ygwkx8CVkF3DsNY9fzFPnA7e2e?=
 =?us-ascii?Q?27Ekwo3NzVVZtw0Rj5BhCr59kPq0LXPRjDrt16yereU5iC4IpyfWGH21o/Hb?=
 =?us-ascii?Q?fa9C5uQflcQ5VwAa8rnIacaEIcN3MMOcMuMv/EDRkYxrvb+xMredQM9X3IJx?=
 =?us-ascii?Q?/p9Abz+j2udYLQWVyEvJ8TsOjwrx2NiEylcycRDG9beLEr2EVfUXUvjyMlWB?=
 =?us-ascii?Q?D+sXNsBTQpNB/ZwAeF6fr+ERsi7IkL6xcNzc4g8Po45w62Iy3PGq3qdllfqg?=
 =?us-ascii?Q?AGQK0L+mZFdQJ0jO44wHL4Hx2tYrtvJqD5mMHerHCOO4gRWGGfEPGpvSxZQw?=
 =?us-ascii?Q?tjGnDmHuKel/9jnwlCxyet9DQXkCDFqsQULkdZQ2XTiW4O+UCZPe8DPuENia?=
 =?us-ascii?Q?kOYU9P06+bdZYn3JNhnkVCc5IXQw7V1HhO04?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:53:28.2254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1669e90-ce9c-41e8-2de1-08ddb3bd5f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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

This change exposes the number of available user queue instances
for each hardware IP type (GFX, COMPUTE, SDMA) through the
drm_amdgpu_info_hw_ip interface.

Key changes:
1. Added userq_num_instance field to drm_amdgpu_info_hw_ip structure
2. Implemented counting of available HQD slots using:
   - mes.gfx_hqd_mask for GFX queues
   - mes.compute_hqd_mask for COMPUTE queues
   - mes.sdma_hqd_mask for SDMA queues
3. Only counts available instances when user queues are enabled
   (!disable_uq)

v2: using the adev->mes.gfx_hqd_mask[]/compute_hqd_mask[]/sdma_hqd_mask[] masks
  to determine the number of queue slots available for each engine type (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 195ed81d39ff..d682a92f086b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -399,6 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	uint32_t ib_size_alignment = 0;
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
+	uint32_t num_instance = 0;
 	unsigned int i, j;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
@@ -411,6 +412,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.gfx_ring[i].sched.ready &&
 			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
+
+		if (!adev->gfx.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+				num_instance += hweight32(adev->mes.gfx_hqd_mask[i]);
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
@@ -420,6 +426,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.compute_ring[i].sched.ready &&
 			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
+
+		if (!adev->sdma.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
+				num_instance += hweight32(adev->mes.compute_hqd_mask[i]);
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
@@ -429,6 +440,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->sdma.instance[i].ring.sched.ready &&
 			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
+
+		if (!adev->gfx.disable_uq)
+			for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+				num_instance += hweight32(adev->mes.sdma_hqd_mask[i]);
+
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
@@ -570,6 +586,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	}
 	result->capabilities_flags = 0;
 	result->available_rings = (1 << num_rings) - 1;
+	result->userq_num_instance = num_instance;
 	result->ib_start_alignment = ib_start_alignment;
 	result->ib_size_alignment = ib_size_alignment;
 	return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 45c4fa13499c..8082270a7ceb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  available_rings;
 	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
 	__u32  ip_discovery_version;
+	/* Userq available instance */
+	__u32  userq_num_instance;
 };
 
 /* GFX metadata BO sizes and alignment info (in bytes) */
-- 
2.34.1

