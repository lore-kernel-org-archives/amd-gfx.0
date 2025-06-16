Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91635C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 11:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B4D10E354;
	Mon, 16 Jun 2025 11:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3UpJQlg/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C96E10E354
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 11:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaFISzB7cr6vgKwP7RXtNzWHH3wOMsAU3hNuITWE/Adfht2g0uN4sg/7REqAsCPTQ5X7KuoFoUJ1eErO2FNKjzpK9HHje1YQKgYJ62w8IJtxphjiPdVCE2xFK4Y+XRW0Cs6jN0zMGXl8IRkgDcX9FluAEry8r9VODdi6ZTxzKimweOxc2eWd8urpt62p+20utrU/7seIuJNKBi77NNc05eZawv69Bz74w4+HyLLwNHjpuA9PHDCQRdmWM8wQQnGKYZBW3Kk1X2Q9P6P1hfbEu6ihxx+j+QMwNIjz6W19+YSmV0CYbO2JQuBUmUJch/0V3IazXHS/g85xpb2kh8fqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B0sbNZx+UAIW8BtVb8z90Gu5tUpxQIMpeFT5HIhBI0=;
 b=G3YJo0wUxsd32+ZtywS+eTxcuufaYvWNQq0aJQXtRl+vNy4NDYRN4rUPNwd3tSd3IwGa/oFUJZS/LuUWdTeLRL1IIh/SgFeCM8IoaboBGIvuEOncEId5XfjSyZ9WT5llzmkB2a+qiMyv7DBUvaLOTJ3h/cTIrNHoNSXm6FlV5qldCIdjIggkttvAv/ZJKSbJtfye1Tp7KfNd77RuwJsXFvwqSROWA3/fzcodrfzMlha6JJv4d1BEfy49L0ciuD+PvIS4tH9X3Q2aX1P701RtNvklODcqwa3yGwfj5ZlVm78L7rvt3KEyfPhg7kZS1WaIrbHp/mlN3l8jCmIFMfWmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B0sbNZx+UAIW8BtVb8z90Gu5tUpxQIMpeFT5HIhBI0=;
 b=3UpJQlg/ek8jgGFMYnFjNCU2hSt4R5jo27fPJs2Jsobznjz8LPdYI1E3TxC2VMRCkR+Jaht6LV4iAM8jJykErdH+D74nmIga8o2N7skrOzuKOIpVp2tubgawB9YgDKjaVvUvVIwq7UWufFi1FHjJ7HvyLLCC69x6duWPPLeaiTE=
Received: from DM6PR14CA0045.namprd14.prod.outlook.com (2603:10b6:5:18f::22)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:43:34 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::6e) by DM6PR14CA0045.outlook.office365.com
 (2603:10b6:5:18f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 11:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 11:43:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 06:43:31 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 06:43:25 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
Date: Mon, 16 Jun 2025 19:43:24 +0800
Message-ID: <20250616114324.3495363-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0925f908-eeda-41c8-cddd-08ddaccb05f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r4DwS+TSEMdvqD6ao2iYCyQpFDpRkVxR3eCmPp4MFk7z2uEtz4W0jg8hZwTZ?=
 =?us-ascii?Q?+QRal53lrtSvfgaRNGz5o1uGQRmgxv1+6Thyl8U+9OiRql2AgtNA635Tor3H?=
 =?us-ascii?Q?qZa9Pb4nLpT0J/0Jp6rQq9EYpsNbXYbAiuGokzuF6CEC0LRaYs4P0r2MUeNK?=
 =?us-ascii?Q?Z2S/E1jhLMCw6gmdqs9bX/jhN2m7SBj1muOba3gEzdRqhs1loPpt416OjeQo?=
 =?us-ascii?Q?MzTq5o89vFrNV8zt1UzBKq8pSapI/g4xLJ/tVkVlbxJQo5wTpx37+t8k9AD1?=
 =?us-ascii?Q?CxvRzxHY1nsn4BfVcnJZkIw6zPIvZ80Qkxs9Yy61CgISLu0mB/G0Q2p4HLvy?=
 =?us-ascii?Q?jEj8wjTDhg/rMaXWqTIQSdlP4n4Gc25Jj34HA8SEk0dmn79PrOpyuhMUFJnx?=
 =?us-ascii?Q?/kS9J+wYTlIfwW76RZk/SYV6o2ilWOUDJPhNBz/R8X6gGbPKZq5onBx5clbK?=
 =?us-ascii?Q?RgN3e89XLebnFRwC7V5ix7xNrQ+o2KMtsjWXzVMa/67s9PFgJdzCkD0/kLQb?=
 =?us-ascii?Q?eaygtHQ4Y7oQQ7KRv3nXQIkTYyjeAoLOgzcPHJO3t0JzqjH6frGY8boR4Up9?=
 =?us-ascii?Q?wx5qHbqXvH8H6UXqsWAvDj6EEoAmttE0nYnIYuYEaM8kdMjT/qcjRWlQ0/W5?=
 =?us-ascii?Q?jJshLSDUME749A7mfISMrXJ9CntRBV6SYS5UDCJXIjtUg3Ljbb3NrdKWJVFU?=
 =?us-ascii?Q?HEc3+ymoHyvRXiyycqu6pWiElSmnHXKNZ54EyFz31rLltwv9xTh78zTD8xG0?=
 =?us-ascii?Q?WvpGvDNOp9fJQQzd4EJbWqXXXQ3kEim+92msNGeR2uXW9fSU7xPM6Dda5OFf?=
 =?us-ascii?Q?tpwUgs93tqlvjDEm7SIYvKo15s54D0MdQuK14iQTcuTgCGD3/fGhuxJIDoqn?=
 =?us-ascii?Q?cibTLf+IAJRsaxJcDhDGh0YU21lsYi8+1L1wjiQihoVXh254ZnwN40xBn/3d?=
 =?us-ascii?Q?s1Wcd0k0leS4wMDAZy/4a2jTSSbuCjmoBZ2+z6R1/q7/N/6BEGCP2PhMqZb2?=
 =?us-ascii?Q?nN36LMoRr25nsncqlaPHlyD7a6fmq5Q3vkjg0oXs04Hda5qggK507rTcRErC?=
 =?us-ascii?Q?X4UpLWzRWeFItSSxFeOj/H1NXEuoE7OLHRzeOHzytnAUOpiEhPYjYbkwmFfn?=
 =?us-ascii?Q?WBXPV/0lx5cKlYYQlvJXZ1IrKApAfLf1VdO04Fh7ollde1J/8MPTXJO3M7Fb?=
 =?us-ascii?Q?Rwz7qM9sIPaVOAqbXFQ7KXPJzXAEMg/U3a8fZDemqIqTfV+8Z4AHRvF8twRP?=
 =?us-ascii?Q?gtIxz4+0ZXBfzwcwzllew/nlFeOTmJG0lxpSS/uaMPSNG/+iGeJYBOJnb8pA?=
 =?us-ascii?Q?Ft1ioAcAXlAlR3S3tMoPoz8qxFbHvp2aFi1detDFRaEg6SGtnCD2KdIbWzv1?=
 =?us-ascii?Q?hPU09xGC/riTw+yC3EcZxXkxvE3z+hsNkBRyzHzxMxD+FweikgPIzKC6ovq/?=
 =?us-ascii?Q?8AxEWVqa5eTIlgRGseKxChWCOEbTaxaJegHo9wOMAMHKsrlcwqjFqNyys5wQ?=
 =?us-ascii?Q?WarmGiL+pO8xK6DpLEwKK7ds1iHpP44dFmkU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:43:33.4073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0925f908-eeda-41c8-cddd-08ddaccb05f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

This commit makes two key fixes to SDMA v4.4.2 handling:

1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
   by reading the current value before modifying UTC_L1_ENABLE bit.

2. Ensure UTC_L1_ENABLE is consistently managed by:
   - Adding the missing register write when enabling UTC_L1 during start
   - Keeping UTC_L1 enabled by default as per hardware requirements

Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
Remove sdma halt/unhalt during frontdoor load") by maintaining proper
SDMA controller state during initialization sequences.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index e6af50c947a1..1f6a8944b1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
-	u32 rb_cntl, ib_cntl;
+	u32 rb_cntl, ib_cntl, sdma_cntl;
 	int i;
 
 	for_each_inst(i, inst_mask) {
@@ -504,6 +504,8 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
 
 		if (sdma[i]->use_doorbell) {
 			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
@@ -997,6 +999,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
+		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
 			/* enable context empty interrupt during initialization */
-- 
2.34.1

