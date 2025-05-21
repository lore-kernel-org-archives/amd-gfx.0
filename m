Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB32C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AFE10E7EE;
	Wed, 21 May 2025 20:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ShIO3b9Q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED51B10E724
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ1DXOAYQHUpVA98wwGJtH0376ReUf8C9MRcZk/gTDQkIOLGRgwjBK/6snAAhbyvJL5yhdpHuPHjZQa3iUv3MNEVS7f3hz1koB6vINzJuPRLD+JoEOD32cnxFDmjtaGS0YZjialDnLmMHAjj6mObXBY2305sV4EEVXqXoTsm1zRUMoebZZyUQcEAGa+NjiUR2+FDWn/WKy/UdMwv0NhhyX5x+7h9n6743iZKCC0ToSrwoVi0tIPCASVpJdlPRY8OXSYoZOXnV/zaIVSYmWW9lUnHUXyltipSjVB0hlnBBhDPjE5u+sY56dNNxM7gvyRcyZX2ApFgH4Mw8WbgP/5qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/q1eOuJK6kXZeLFvjTaudKs7012gHwBrukuf7P+I4c=;
 b=QXHGMpimrIo8RRx7+TJUCP+ObVIr0cmT6qu+6GckkWeegQzX6yfVWJFxBDVxiTBq5f0KaHUWfyEYpWXgLwSKSE90ioj6kwcqvKYZFAu9VWrRhin8EcHDGO8qa/OvUaUmD1FESG+lPcZVaHpHRdR/VAFfPs3fJ7SgyKdfjQP/I1ST50Gp9+Dyqh7HPcHekBpfModV/br980N9hodium/WHTVUEPfa/+mTe/TLOrrj7o0kqdrRqswPDr6aXySQoeOEMcGk/2XAo/ETFq893i2CGorvMO4WGd76sZSXLvoYakWJs/+nsUj9j2zyzXBPKaFVn+Mk++hs0fGvzrkFwJKR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/q1eOuJK6kXZeLFvjTaudKs7012gHwBrukuf7P+I4c=;
 b=ShIO3b9QfyvIL3Amd7VvaSyXb/dAzPuieF2clGh8j9Vk+mRloAZ+gKjOJVeLW4m+Wxn8FXrTs+85sC8YPStL/rLjSswndykOaLC7MeeoUax/Aw21P0HWQcW9QELJnT/heo6v4iFmCNBDu+OHgP9O5o1NgBTIFkHJjK8QKorfCLY=
Received: from SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.33; Wed, 21 May
 2025 20:24:33 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::ce) by SA9PR03CA0029.outlook.office365.com
 (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 20:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:32 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:30 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 8/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:13 -0400
Message-ID: <20250521202414.18251-8-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 14121135-b1d5-4967-a83b-08dd98a57f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPx661F3UheWx98dlKXEMKHjYmmXvmoLlqPYRowaoyqU3yVxOY79ovttn+2+?=
 =?us-ascii?Q?TJTJCeIUJR/N+CWcfvPpK27b8ld22u0womvRJNcG9z9VM1whEFSw682731mb?=
 =?us-ascii?Q?m7/Q8Pw99r/l1j3awRRBo0gfIBtvydbKSjRnqa7jolPN6k+hDOAzIdMoQpf5?=
 =?us-ascii?Q?qEHtFQBgpNU07e7JuGJCWa1qZa4tPg05dwDjm4JEt7IbcikpB75Eef1UqRXm?=
 =?us-ascii?Q?AdehlD3gTxncJlDCLWyAN67yuTY4Pg8gy3b/blxtIkx4w3iYnWY7yPOPaga7?=
 =?us-ascii?Q?MpfQ64hRjg1MwzJL9bvINKxd1uOIsWZNsjw+cJRA4gI8ZtH388lmSSYIGVMB?=
 =?us-ascii?Q?3GzOW3FWhDVHbrqVUyKD6m35N3ThYPzViDYsVHQwtjJTHtsug+MgsfyT5iWA?=
 =?us-ascii?Q?IiB9FZaMCBRb6Oyoubh5ied1/7ghGnYFu3gqNsWgnMzRFAhXkxw5Sfu/uxUN?=
 =?us-ascii?Q?PP4UvIzNJnQrb+Zsw1aNXI4waJoSzYceVx5NCAFUthp3ikws2qSGTqtPn7uu?=
 =?us-ascii?Q?kq+gQXCnLERZJYveBzn63PHHxpVW2omywniUlE6CHMlI40t2+lMsS6G3TC1f?=
 =?us-ascii?Q?GyuPezkqUdhaKNjz96f8UC4RD9jrQIj4y5pr8ibFgsqkYu8qQ8tBypR2ND3y?=
 =?us-ascii?Q?ND1YuudlMZytjAapFP72ysabInHCeTL2/j5WFM3SVoSkh+y5cLWfVvl2QL8u?=
 =?us-ascii?Q?Xq8vsNMhNDo+N4yskhSibkG37XDe6h36dOCuojOYQoNnaWKBRvHXHjV0nz6K?=
 =?us-ascii?Q?/hlN8Pjmt8EGh/oth7Xbyb3YaXUcC4L1Wfc1XrwXC745p7YqeZt7vM0Hsw7L?=
 =?us-ascii?Q?BvmlSYQme59UL+iK2dfERv4rGoTrHF8wGMAWIlDeK1WSPepcr/HKH3zL7cVh?=
 =?us-ascii?Q?G+wfc2HFWSDJHB423+2NsI50tJn0r673EjfcHfxl19YhhSh2RVuFyql66AWL?=
 =?us-ascii?Q?hXoyieCXkzLgMFiXjQfNZOvK9qkikOfr9R1IBD6EX3tp/fpNQVGW8Lsrfotq?=
 =?us-ascii?Q?hZzfzI2NXvkrlv3XG2oI5xlyPCHuFNrim1H2ggEShZSFEKx4zhnWTNUwkDl5?=
 =?us-ascii?Q?xQ4gyxBuSpB+AitG2os3JNLAAOmbITsaRYMhIWMrGEQ2gfR70If5CZmavuoQ?=
 =?us-ascii?Q?9WyLdhqTjTLFOB1UV+uxCjsQib3CV5WjH4kuhnDrgrXDFhJKt7dmapWHf96S?=
 =?us-ascii?Q?TTBdX355uiNVGOIA+1dB+Zyfa0U2WlI59yxRNCoE9grfnF5ia9vKasYMuHgw?=
 =?us-ascii?Q?ZAMDG43EdAw1tgd9NGX7le7aWe9uNFVVIS7M8f4gXdcOib0/rL8FKZVqzM8V?=
 =?us-ascii?Q?SIqoaCZvu5wIPisdQwtQBYXF9H+2uqDVjqGwvtlT8OiB/ucbCu8Gm7UrJCS3?=
 =?us-ascii?Q?VG3f07m62rEh3dthTbMtrwuejjS0rqZJA3AUjUupOe1IR3PtuTOUb5FEDlZZ?=
 =?us-ascii?Q?npbyB7/oaLpkEBT0QAsKxowSgycWUk6Z2M3yW2iN4gXQlILJc1ktSzSVY9JL?=
 =?us-ascii?Q?wKekrWE5iSd+zBU1/Gadd3ffVC0H2pBaPZ1I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:32.8548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14121135-b1d5-4967-a83b-08dd98a57f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

The addition of register read-back in VCN v5.0.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a730..f8e3f0b882da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,11 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -946,6 +951,11 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -977,6 +987,11 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
+
 	return;
 }
 
@@ -1058,6 +1073,11 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v5_0_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.34.1

