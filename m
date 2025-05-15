Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F63C3DA6D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7342B10E910;
	Thu, 15 May 2025 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YuMJSqQ9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9371210E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVMIXsKSg5kksOICI/fs7kGNAnLILJ23F2Oq8KFvH8GZt5RmT4RhwE6RQA4c4ve6LK5glDJcgvdPBCmx9Xph7KUxuASzrydv7Jlm0+aH7661Ej2lY1bljvFFMfZWGRrrjRUxBCCLUDbn9p+j3R/I0TCVzEC5LalPdB9z9TxKZIg8s0vuDzwjReNAQqEhnlzmPQ55Ge8sHuLCQhwEmy8M3qN9YlSQDOUKnAche9gVoTLpZR5pciZFja3aWVCJHHU26zw5eAPFXOXbzsZHl9r/CM33pQ3C0TwKjTjJJ42CHoYukBbav3L9W/h/CWhHjLRm8trS6lTv2nUqO4Oj0QeFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XktlD4mnT83EWmcmuwgoDeHGmf6l/Hw+wbnXyM0G3pM=;
 b=rxJQvKNKBZWY+3XgX7WvvA55dttOUf+YjCpyqPaSYGm1UKZ6D5OpyuiLSN50LE5Ya+BkB4volUzWVZeBTnOAYQfB7IUNhqBqFq2gczoBvIY6jUNU6QI4anwuJhQ43f95zVLy2vSkx1Z6jpvAkqwGiGBxVdqyYsLNhh3K6QMy5dH5hwgKl6peLJ57yq2giNqV4qVV9aF1bT5pYI9oTf5wNQaRA2VqOYOaymvm1OnvoFSZ561H3UFYI+kBymH/m1Eo8WHJRfshGuzgCtUjnHnrogEzDMVIiqi//kS6bvb7FZImlb+wFGk+RkWmzMWfwO22RIDINR0t2M7VnyiFYHLtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktlD4mnT83EWmcmuwgoDeHGmf6l/Hw+wbnXyM0G3pM=;
 b=YuMJSqQ9RBG1gZTwOfUQR9DMyXliQJ9unHVzyygfZr0/FHIXmReUdrmp1nAl1INxFrNkIpF1E0xcVB4H9XP7nwGOMBFs746Tz2otCxr2zOVocTjNrhjF17k7SpdYMhCWPaItGZtdYPwJnGOK2fpHO2rNRikTYq8H0qbfMws/iNc=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:41:18 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::4f) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 15 May 2025 16:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:17 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:16 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 2/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:55 -0400
Message-ID: <20250515164102.808954-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abe1811-e5df-4396-f3b9-08dd93cf50c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BAictPOPTf0b94Tz09yN604udIEE8ibMgnip0m2h8dxO0+5GzQcV4JJWqJZX?=
 =?us-ascii?Q?xmBUC/Y0O5tdSeQRVWo7GwPZY95/4zVq+O13CUPrrfi8y2hMrm2k4cnsH9rz?=
 =?us-ascii?Q?OV1r9FjWHsaQugYkNwily/VFyljkzKkNbhzgOmywUWM+Sn2txCanOEuurm3o?=
 =?us-ascii?Q?rUu6GuRWuoSfGo2s6yS7yaUTBamxchkM92VE9520+c1u79sM7HJIv1q/sFlI?=
 =?us-ascii?Q?moN6+1WuTQ4PVuAoXmiFg5ECJD6hVIt2dRfyJqYRwMloW73WD2BPpgEZ3Ka+?=
 =?us-ascii?Q?5C3vICAI8XO1IY++sZPcb5YBv0K+8T6YQHwij1Ihvom7ao03mgio8slHcfhP?=
 =?us-ascii?Q?j1sdZRj2wcwC1hatpGlA2rtaDy90JU/ZcsVTzB5lXQ7pByivxgimGQC6hWrW?=
 =?us-ascii?Q?OzhJl9AFGGSuPGYyh1h7k+dqhsyARrc9B6cTLFBBaPrljS1Tc8/8kZ6lEbxG?=
 =?us-ascii?Q?0U+KYVAGAm8500VCeSYRfyfMjRGFHWM+ByxIHgfoYIr8dqVMJn5XQAq+ZUL4?=
 =?us-ascii?Q?nIHbn7z17wmjYE9BGGkg0CaMmVIk2IRB1RnhktUkChJE+oWQk9eypPhgRfHs?=
 =?us-ascii?Q?Gfs60WsbtImdpYwrlxVUqmxFbxXRvPljJxybmHorLI2yAClLLYH8mFs9Lii/?=
 =?us-ascii?Q?5rWX8xDHNyhvdbcN9TENkYKIMbsZgo2qMySszfEhroDN6Jjejohr9lkNZU3o?=
 =?us-ascii?Q?LypWsmOUiz+v05MlK+x0ElMBE62aKYz0VbT/LfKnmGHYtnx9v6A6T4mS9ibA?=
 =?us-ascii?Q?4VfFA2yvDTb1MRz1wDpJSvEFQhS/dH73Q0wLLkwXdyOfOByB1SzT9d9fJjvu?=
 =?us-ascii?Q?kgpFj9zXw2r5v9q2fE/wXTZNfKyhb1eYerxCA6LfuoC8qLd4dLUE8Kcn+0UH?=
 =?us-ascii?Q?JIRGaYE7M8hc7Igg51RFLkCrQakyPuGuIrEpS8L9zXc1B6wvxJd3Org7FtxY?=
 =?us-ascii?Q?XgexBSlRTbgamvBAU3u1MrrklyPBJ/Zl+ffBGUsuNjLsVIydCC4bv7C7iA2/?=
 =?us-ascii?Q?xbGEBeQxBMILfjdqgPi8yY4aXhw2C6QWRR9NsaiZw1+SRgWGk2IkRxuOw2qU?=
 =?us-ascii?Q?Yx3lnryw1Df7c9d+sLuGdomWDIXxcPREwbBuX0iiBxzcJNKwRIb1hZvydHFC?=
 =?us-ascii?Q?DAXrTvKf2oYe4jAkddQN5XsESSTLSjWOHxWcLEl4aDikN0IXGNAMpFetRJrF?=
 =?us-ascii?Q?AcIEWLLmVU7W429Z0lMzk12qr1z1dwuO+NLh3KVZBGPefEpXqhMemSPPkbZy?=
 =?us-ascii?Q?jkAdWtJ+rUQK+pMsyPZqgkXt5v7bqiq57Mo0eheXBxowrCV242YaEXqo0AY/?=
 =?us-ascii?Q?Odix+xAXP395NuxwKOXxJSQoBCcSNjrL5VLzmrbw9N/NOlMOGfaMOYE2T4Te?=
 =?us-ascii?Q?GbzT7sj9FkU4AzSA+/pWBF1qQoTieLrSLXzc2meoZTKsR9mvjepNRoDcFJsQ?=
 =?us-ascii?Q?+guM9L+bESHLplWNpMUsvw59b9BjRi9pyflfJLyEZDxIj1xNWbIFAORPuX/6?=
 =?us-ascii?Q?tDmHUtMYKs2q1L7NiB1zpX4NrioL3ZxWecjV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:17.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abe1811-e5df-4396-f3b9-08dd93cf50c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

The addition of register read-back in VCN v2.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b8d835c9e17e..148b651be7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,6 +978,12 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1152,6 +1158,11 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1183,6 +1194,11 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1248,6 +1264,11 @@ static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 	vcn_v2_0_enable_clock_gating(vinst);
 	vcn_v2_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, 0, mmUVD_STATUS);
+
 power_off:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, 0);
-- 
2.49.0

