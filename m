Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1467DC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A983710E1CE;
	Thu, 17 Apr 2025 08:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9k35fHN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4684810E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeSohZzg9HLEN82iGrNeZO9yC7PMnIAnaJQjoHt5O0Q5cb0eiJm46JZEQ30ErxkiGe6VRyl6XyEByzTW1sse2L3i3eo5/2w6+dHZUX0JJePk3BjT4nXks6yoyTeChqDFyUimTEuE4TDPxWoyZmihlSMbKz+gHTV+1OHUd2QxJM/kP3I1FN0JRRpJ4zQR8gDJAR6x1surwZqO40t9Dckc3nYTnS7BwLRUjoRHCedONUqZ2fTsiK2lk1ckDenSpF/NulCkw9dNaPPnkpa5YvkmJ8hi9fcgMjzJNx0GnUXCpPniUyyR4dFUUzjLBAn1k2wLsQ4DeYEVwvIOpCEPdt74tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUgMmUKY8+P6zYet2uL5EtGmyw485wH6AZ612KOemZw=;
 b=ZJZbSIGjpUYTRzKWVW+CE0Bla/HyI0DdakD8ZBlJREIIgx0mXtwbWqMULXSErKA1bSb8CNgEkDfsDBbxnKB2LZuSFFrQlBjWbKufgfvLFubO/XWLjujh/MuK8hf0fDxkzJRVnISmUqZTfNmc/H8RYUow/oUhotWUBO/O/l5dmLuA56632pFYxtqrfoswouj1XlmyU2WNDtszA+i2RmafRlvu/SDcU4dmS3Oqw/2vexJv36sMhVYilMvDxc2mChdCxWNZIc07620PwS5pkUl6jN45YG/Ex0drasqi9nw3PxjyYqUFenxvwwaN9Npxy7nQyLwW6ke7sh00+bcyeJP/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUgMmUKY8+P6zYet2uL5EtGmyw485wH6AZ612KOemZw=;
 b=W9k35fHNL5M+Lp1lqbdQjk0kCRuYBxlvRKq/UfNnEnOF8Q54mUEjDQbtHyJdYsWtudVRqBWlVle1juV0O7B6QqxX2tX7v/9RZZj0Z4h3boLBo+tfhiFxCDro7GjC1MRtF/M7dRQgSo9JWr2O1qf7g8hXr7mY4ZCzz487IAD+x1Y=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 08:58:52 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d3) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 08:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:51 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:50 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: set flip bits for RAS bad pages
Date: Thu, 17 Apr 2025 16:58:32 +0800
Message-ID: <20250417085832.36455-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085832.36455-1-tao.zhou1@amd.com>
References: <20250417085832.36455-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 599ef6c3-ab83-47d1-3809-08dd7d8e1357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHjk7pyDWVvRTandrthuCnD3NjYBt3Qxu2g7SFc45p/2KRB7bEdPDQQQPoLv?=
 =?us-ascii?Q?cbHqc2N/0O96zdcN0xltjuuvtPdYRNpOm3fKO/F1ALf2+5z/zU7jOkKuSRq+?=
 =?us-ascii?Q?a8TbIH1fjwbSWPf7gU9qCRJ2G96h/kGCnEFSM+kVD0lQYZEX8MUFiSRoY3vk?=
 =?us-ascii?Q?K1fiIu4p2T6qEwrviMiUQhOcfGZS6BMLUsGst2jvRNiQFXAwBUXmEtrvj31y?=
 =?us-ascii?Q?tPWOaO42IxHl4J4S84to3EvKKFUCXLQ/q0FJVE/D7Qq5oOK68gcpyJVegZ85?=
 =?us-ascii?Q?+x0kBvfuwQLW4XhvZYTI+PtoP5QOUU4unkKUyrD6wbGPhSHpuveaN0hhVc3P?=
 =?us-ascii?Q?Mp+gr5eyKBVmMPKrjD//wHSGYSBDyLfGV9c/BMTizOFbgkfjeiLeT0WSn5Az?=
 =?us-ascii?Q?Gb5VeiJhAk+pgkWRw3xUkbAHz6NcK3yuP5lDz+HsU+eFl5HfQZUaxSwEdnOv?=
 =?us-ascii?Q?XWDxCisHezYp0YEWgaZjjrZXrkK3XuzPKhwgtcXmdbNJ/lSaqykw/5yQLKD2?=
 =?us-ascii?Q?OZICdYqeqKC64R9yAhZx7CHvMNUohfhBU613U+uBh4q845Z+3WD9+xc6BAxA?=
 =?us-ascii?Q?jKOsLHZPMMLYJ9juaKj1Oyba8kbjzBmm5lX2KJhLeDFBNsWtOwJCwgqOUrWD?=
 =?us-ascii?Q?OB4rwAH2oREmsnaoqW2LDALc5otwm8nF9Vo99GLZBfSaKQpQgQQwy9XgtdcS?=
 =?us-ascii?Q?ujeFGpdQOTXtRcc3IYmr3x0WWv20lb7kGluBcE8K5d5l+KfpT4Xv9nXCevL9?=
 =?us-ascii?Q?qW6Q6pSWD9gGSYJl9Pql7PR3Rynf9O1pss5iwm0nFQ2Jj6XbqHkmfJci2Wo9?=
 =?us-ascii?Q?vGhWoL9DMU38wbtef1722i31jTbOIAhtQY26D9V3rPmKo99hb7FutqJLk1c6?=
 =?us-ascii?Q?NA3Lb32m5cASWM03O6h6DV4YVbfkyMby6XKqUE5ldBU2buKQNXNGKR+kh3f5?=
 =?us-ascii?Q?TGrkDs8sReta8+Mt/iFJ142f1DjBRz/CGJFl4BWI1TNzqRptRX5yC5/la4uK?=
 =?us-ascii?Q?0DIROWOmEe5LSutps2oayMXRee7X837a/ynxknQnlyl7YvHC4yGQdY0RfZhx?=
 =?us-ascii?Q?2dsEIhulrEmQPylsDIqZj8QdmUa7ELEn70D2121QevgasLwpen333vYTHV+e?=
 =?us-ascii?Q?VGXqO3cA6klnso6bcdqbXHbfcPyY/mnlRvbrZ98d3jMAdNRE9Zf3hHHhIcBu?=
 =?us-ascii?Q?4LcGV7cUPld32V+ZD+xL1DSDaJP2n52d1RUDcqXcK9Od1u+G380nWS4/u5UM?=
 =?us-ascii?Q?QBiA0bOoocZYFNLjN3NO2GUNFuZYai0oDcKYCylWmskfSHP4q6czb8jlCfOp?=
 =?us-ascii?Q?c9x/ns6P7c358Fim6j/5LBWVD6Ihx+u1mLtll3h65xFANdXXk/PHcK0wtBUn?=
 =?us-ascii?Q?/yLx3NO0+zL9iWLfPRLuisZ7s1h0MP+ZFetsOtgWC1Fbn89RfCcGxFbB5BHH?=
 =?us-ascii?Q?+qaCV1q81zFFXCabuN/UDjMNoBDJzmXTROT7n43APOHrWqgrvB21YU07ACL8?=
 =?us-ascii?Q?VDhUD0rbUQtXkwKSBtS076TWM9OJdqfzHlH4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:51.8852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599ef6c3-ab83-47d1-3809-08dd7d8e1357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
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

Make the code more general, user doesn't need to pay attention to the
detail of flip bits setting.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index b24229701fd7..9d280b74cc3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -309,9 +309,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	col_lower = (err_addr >> 1) & 0x3ULL;
 	/* extra row bit will be handled later */
 	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
+	row_lower &= ~BIT_ULL(adev->umc.flip_bits.flip_row_bit);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
-		row_high = (soc_pa >> UMC_V12_0_PA_R13_BIT) & 0x3ULL;
+		row_high = (soc_pa >> adev->umc.flip_bits.r13_in_pa) & 0x3ULL;
 		/* it's 2.25GB in each channel, from MCA address to PA
 		 * [R14 R13] is converted if the two bits value are 0x3,
 		 * get them from PA instead of MCA address.
@@ -329,8 +330,11 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits[i]);
 
 		col = ((column & 0x7) << 2) | col_lower;
-		/* add row bit 13 */
-		row = ((column >> 3) << 13) | row_lower;
+		/* handle extra row bit */
+		if (bit_num == RETIRE_FLIP_BITS_NUM) {
+			row = ((column >> 3) << adev->umc.flip_bits.flip_row_bit) |
+					row_lower;
+		}
 
 		if (dump_addr)
 			dev_info(adev->dev,
@@ -550,7 +554,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	struct ras_ecc_err *ecc_err;
 	struct ta_ras_query_address_output addr_out;
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
-	uint32_t shift_bit = UMC_V12_0_PA_C4_BIT;
+	uint32_t shift_bit = adev->umc.flip_bits.flip_bits_in_pa[2];
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -598,11 +602,6 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
-	if (nps == AMDGPU_NPS2_PARTITION_MODE)
-		shift_bit = UMC_V12_0_PA_B1_BIT;
-	if (nps == AMDGPU_NPS4_PARTITION_MODE)
-		shift_bit = UMC_V12_0_PA_B0_BIT;
-
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
 		ecc_err->pa_pfn = BIT_ULL(shift_bit) >> AMDGPU_GPU_PAGE_SHIFT;
-- 
2.34.1

