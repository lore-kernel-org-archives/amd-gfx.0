Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD3CC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA87611231F;
	Mon,  6 May 2024 18:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s4mNgcz4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2BF112309
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m74q4C5wSlncziZR9MMoPU93jgJ6fCR0OGON/TsVT8tDLjoEFD00Bp60Tg/VPYGKTUxsJZKmCvcx5rdosBAGizKpy73SVFYIKjY9LIAc3O5RvrOHQSgbS6Iy9hRQ7pyQ2/lKwk6pyJX0Q5MqwIZTqK1upHNTB8uOhzucvVhtiZNyXdZ68G/5xOZ2bugGjLWXZ/eTyBTlovZkD0DTWseWzYiuBt/BTQhJ0qZBp/qkbc+gH4RFzrkMwetUvzKxIJv5tSEvvRz+bxWPEtMMObxWQbqms8wz6mw1ArbK7xh+rchiF/o0lFeVCXOMB78yXPyaC3V+6dM8NM51B5LYglNJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7fqmP06FSawHgCD70BR/tZCHvBoqKGzf8U0CxOJG44=;
 b=NQbdcowaVpCBFtMoP2+HVkhQSFWo29LaS9et4dMJYC71DHqje+Ybu52lwVQzCCvRimjiTSksIfwNCJkk2XhMRPYGHaGW4B3N5NZ4a2n+BQAIlTsMhhsyRzgRLrelZX4V4jnvLAUaWspoWVygNLfnJb4xusvmpFRo/A8grTLcs+Kv7tYpXqnyngcweLWIuNG6fLnyhjOMkrJskAA+KVWzCX5tiUQWs6c71TXju7iNDEhXJVD5kxU9VBa4cmSpZKoyD8G4VKIgEwGi4lHXDAi6vEtlP0K9YFmbvfxnBu+7D6ITmK7FGZqiafsAStsfjBuAnrksgks+QnRaHmImE9OKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7fqmP06FSawHgCD70BR/tZCHvBoqKGzf8U0CxOJG44=;
 b=s4mNgcz4yzHk7kx6GVwoff2ZkR1k/P9zNRwWugsATuzpaCMLhRfrp+IrM3tWm4GEEbir60Pz5lqCHIPimjMmW3k3/AQaey8tgA058Rmo+pDgzveOHD2BD+1gOg6NP8OE8htZ+jl9GRA9BZwmUrmM8ayw7Q/04nfbFn6SJ6l+rgw=
Received: from PH1PEPF00013313.namprd07.prod.outlook.com (2603:10b6:518:1::4)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:08 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF00013313.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 14/14] drm/amdgpu/soc21: use common nbio callback to set remap
 offset
Date: Mon, 6 May 2024 14:45:39 -0400
Message-ID: <20240506184539.1669157-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: e13de5ef-7afb-4148-bebf-08dc6dfccab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wnLvYREbwvdSuaSjd/SAKxzX17LQJDmxYPiWy3Hcu8In2CYkxjDFAKDJQfwo?=
 =?us-ascii?Q?W1COBJYJs/f1aRYPRoExhHrTqbGFC6QLb4hSUBL51qgDehMuqNgMkBbdtBCP?=
 =?us-ascii?Q?ipl7E8Xf9CbYrhnV6YXF4jMEEZVVPBq0Ws/dt3CJcshwqYVwyHO/5Ow1965Y?=
 =?us-ascii?Q?tgM1fCXJTxsS1WlUY5zIlYvoaDPeruusDk9fYRAbCP1Afe0Zw3s9f7KxK0rE?=
 =?us-ascii?Q?7UdvzHNtbhfTwEXbEIamBx5PrH+YfqDUVRmK06m4SytgNoM6fd1mZPgV4WiF?=
 =?us-ascii?Q?iYvv8ZLn8ScLiTTW1A/zx/pIXimQzKGbdc3+5dS0qBzy7buwYCx9qaGPBG50?=
 =?us-ascii?Q?qSn2njPkwn5fbTSuKuWg+HebLhhXcAZ41ILkOwKTZiZwurHNuGanrR8x2Chv?=
 =?us-ascii?Q?AMJnRLZS0KusuxoWyAabra8a2BddxvH9iWBWi6BMVD0Yp6sP/7oF2u/7PSQ1?=
 =?us-ascii?Q?NOrdMjHa+Luf4VnRiuqyyc4uZRwkEj/Wzi3ZZRjgG4sTxPLGjY2I1e520oCe?=
 =?us-ascii?Q?WtvSo5RhcEY/Wst4eDwsPimqEaahzsiDNBZCgNo7gqRiKuRIcH+s/k7PA8MV?=
 =?us-ascii?Q?Nj8Cg3vNQD6ODD0THkByT7DTfRmSidfE/mV8DB8zs5uBO2f+nsVAdELY3Fnc?=
 =?us-ascii?Q?B1pdlHNR3wFw5YwUiknRjmClMBBvmb5hvlMwsD5ar29ed1ACG0+KpOFs0Axw?=
 =?us-ascii?Q?qA3sL0i6Sax/FZs6x9/geygNZzja5fsr+lZcEIn8grMb/c5y3ABtEahkILPv?=
 =?us-ascii?Q?No5BAY/ngnAGsexVPsJdZYBdhZu95cmNfL987VZ8cydJjZhZjCEpU4gAiIGg?=
 =?us-ascii?Q?b0Rx/DQgzX2epieuM0usGh/VG3HRkALsROMz94hy5aCmcHKJHxdwOdgBhdyb?=
 =?us-ascii?Q?W8qtzWrpd1lDQiHAs5tWfXmp0df9XEBS/RGW+VsFu0Afz1QLLCG+iQCjj97c?=
 =?us-ascii?Q?TELUhSZWpUio+I5WygzMnV0dK9ko6gDYPTQBbESLy8T+TBP3UDKTZQVAigbY?=
 =?us-ascii?Q?yrn+01Yk8wnd0f472pMYGNk92usFmLtBkKbR77Y0kBfvl2Wak+tQWJUpWm3i?=
 =?us-ascii?Q?unR/ZvUOW3uUY5+/ZaIr6Zl30sUzCj1eSUHPSo6fjwQdHn2mB6eq/leP8rcb?=
 =?us-ascii?Q?boGXg7+8aqTJ+QgQLB9ZE/2a427jTdx7PzayUmbOa6ebDfMZbuKHgTswSlvB?=
 =?us-ascii?Q?Uw0YS93IPOp1EXh3rybDclFLupDzTn/5C8lPVYfNpZmFZsab00wx+da3lgPn?=
 =?us-ascii?Q?M7d5W0gPZfuc2+gjXammD3mR1v3k47J9jI80/RH9GB99Z5kaNtYRbn+Bcqcr?=
 =?us-ascii?Q?hPtZiIuUtNvWWaIVM3wlG5g10zbvpnFhvEj/9Lc2KtI1ckYCNc/IueaR2Hrq?=
 =?us-ascii?Q?0GqpGiaP9gLpYsovPq/Qz8uJ9nX7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:07.8637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13de5ef-7afb-4148-bebf-08dc6dfccab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

This fixes HDP flushes on systems with non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index da731a6f6c063..a54052dea8bf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -345,9 +345,6 @@ static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 		data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
 	}
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fb67974675719..15845ecca7c79 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -557,11 +557,9 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs = {
 
 static int soc21_common_early_init(void *handle)
 {
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	adev->nbio.funcs->set_reg_remap(adev);
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-- 
2.44.0

