Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B164FC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE2410E31A;
	Thu,  8 May 2025 05:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPwca36m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73D510E2F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gweeNtstJGKXAE5YxfhD1GmBxqtrsasiMmrZ5L58wJh4H8+szDY7TUYKw1hCMDLEcNu0wBhRhwmtPnDKQ0LWZp0sY+SUuW5RJDKo8EsSYlmePn+zsn9CfuC8tC8nbyFgZycdqwgFDTzAPUP/AXDjl6TKY7mLCzt2/hfq/su8FeB2o1vAkkZAcs0Gden1/LX7pv4wDgo8DF8QANL/k/oqyktFrFcbKV/ydnfuK7KUQZYDE3o2PlhR6luYIWwhHiQJKExYq89RMQZrzyiUwtXW5xmAsX0ZAEptVCvNb0FUQSPDt9+NYSgzqfccnQNlgppCiDLyvjcMGBOYDKqRlrq2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANIbU67jx9RfHJziRkQtMPbmBPqbYTypUhyp1eqHpas=;
 b=M6b2O+OD1SyX8kAg6tQBJweneeZrEC/f5WaqcR9Wn8APWw2W6Rek12akWcdL9x4qeFrLPNTxJ60O/69adBWNTIMez4qOExEqwOs41ozR8R+n5UT7V8Z27Jr8MxFelWU/lmv2FU1UFFt4V1+i9zSHsFhFWHmGtMkUdgPzbi8Iy7tkYLiVqJfuP1p28UjnkfykBqjFRwwtS7uTe25S/5hTwnfkyttgueK5P5Mtt3gyTmlTRGJHSDM+BYqLE6E21XdaD03Dkmo2Xa0shXgu3FYr26GLghz3Ad14JKSu9SYqV8hFw9+rh2YLyHW8cSr2v81MnkCCSW0TBJ8YS0jrUj5XBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANIbU67jx9RfHJziRkQtMPbmBPqbYTypUhyp1eqHpas=;
 b=aPwca36mlMev7YY43uAx0phjMu0MDRRVBOPzLJoudTzI8KRnWpo2nCzNPKQK6z1u4WkIz+j3NP5ZpHHZHkAmQRLLLMouySpfM5Db92JjJWCqj/aUchjDHh/4jA0NMf4/by2RwO4uITkMtZ+vWr/JEPOjARzT3nNgU02e0QBKeI0=
Received: from PH8PR05CA0008.namprd05.prod.outlook.com (2603:10b6:510:2cc::19)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 05:10:16 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::80) by PH8PR05CA0008.outlook.office365.com
 (2603:10b6:510:2cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:15 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:14 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v4 7/7] drm/amdgpu: remove cached gpu addr:
 psp_context.cmd_buf_mc_addr
Date: Thu, 8 May 2025 13:09:26 +0800
Message-ID: <20250508050926.228674-8-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8ef464-f685-483e-c05d-08dd8dee9f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HQtgL1nWv3oUvGZzaaM+355tgBGACiafbVPSthBeh6nCSmBoLP1k2cno7k6X?=
 =?us-ascii?Q?D5Zel2+B1FLJDO3ML8ad5/YANHTHBEqmhI1uNPvxWAlzNam6dEc7rVeU+u3e?=
 =?us-ascii?Q?zd+MuFSoGSnPunDVMjssSQgTgs6/Mdl+votWXRbClHO2azV6UfAfaAsBrtiT?=
 =?us-ascii?Q?zLe0qgdxCMQbs216MHyI48MMLjs7SHqwDvHtnDojEtEk18+PrQZ2E/qY8kGm?=
 =?us-ascii?Q?akCOZyQYLgaG7BbjFcwgznIXU+lPC2qigdox2DfZfOspIhGXCh1v7io1UflT?=
 =?us-ascii?Q?QdGuYmsHwikEFo80d94Jhsnl+9Db0JQRrIeRmo+HBtNCHNOFJCT9v9xw6BVw?=
 =?us-ascii?Q?565dm+AbQfA1hrY0xuMp+FeRPz6KVxedzE8dP8bsT1FgK+b8RRhKxi1Ayke+?=
 =?us-ascii?Q?J7zkuZOZF4xOghu7bMHk1815AZNxtYrxZfw8fvEQ7CMGUgEWkFbUCf6hAuMi?=
 =?us-ascii?Q?2Wc21/jQQfTifRs64uiubUN/dfdkXDifvJfGXVRsu4EIVF7YlFTwMtsVl9PG?=
 =?us-ascii?Q?tCLqcO9jKeUrZ1cT1k77AnvBd/wM2RwwjCuZFwEz0a3o/R5QPeNgS/MZkx6t?=
 =?us-ascii?Q?M5vumsHWYEduGqUtoFpnifY9XraXGV4c94OZsOG0ag4niI1w7mxn1eeRK1BX?=
 =?us-ascii?Q?r4m3+GFWB+qzix5IRVhxy9+Eo5PToi0BYRZiXqYW7t6kScrwOyMOoy05Fn6K?=
 =?us-ascii?Q?Tpc/CpCyAK25GSq+5iSca0W/xQO1VjTfigK5eCNJD83ex+uVTHm7ll8Kn5LJ?=
 =?us-ascii?Q?Ke1eCKbJk/CqRc1bSMK3E8PgtktPAcDc4of9Xte49avI7D/ib98OHUNVfULx?=
 =?us-ascii?Q?GwinJfigvoLonu7i4AKkzWjJLXHXJCavwdAOELY6yRIfGjXqZ6wFhnQXuzp6?=
 =?us-ascii?Q?L4UBdIll8augPbsNJsPaHGMcf/TInMr0O9yr+Zn5SMu5XlBb2Sn5dpd/+Htv?=
 =?us-ascii?Q?UTP0XI+veH4WpZqIsg/S7wqmN0hmHDJi9Zui5zw4wuT2NqSlRJ+avBberDKw?=
 =?us-ascii?Q?Qbx5S7Ik7soXYNBWj6ukM61L2TezYEjEDC0bbJ8rBYQfWyrTlY8MqpE+QCMe?=
 =?us-ascii?Q?jbhETGBjE/BPrySfgICpN4fESsJZmqCohzT8zm+9hXZpdlRpX4a0RoqMC6U9?=
 =?us-ascii?Q?XxHOr1LY2znEX5b4vY/xa98HFWHYo/jlS8mXm8T8AqaswAW68vQ5KCJfXtYe?=
 =?us-ascii?Q?lHQZO0pLQiZ45qH3DtH673Oq8RALA8fURQb7xguT9KP26CAV/FcSbPaLAKoG?=
 =?us-ascii?Q?hiQO7pc2KiAfCx0EbpD9tI+3c9+KG+MmZqbavtpVuu32x4yh/1a721nzZeqf?=
 =?us-ascii?Q?sv9CoXoD432fI80RXVGib0VKoErwU3FpTksOhLa4IAlQuUb10HJ0DArE/DJR?=
 =?us-ascii?Q?RpCK9EcDitXgwFGW6e7JjW9iecdgtwkXv6H0bTm4ayKsc3WrpcRr6Y+JO75H?=
 =?us-ascii?Q?eTa/z5a95Tx9Jn+qu+X3dzUwwW3mwTJ0VfzKoaPXXcSDFA4sxvxe9yIeLX2Y?=
 =?us-ascii?Q?cxR1B2Ll3IE+oBsibCqU5dbNMxgHff/OozTJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:16.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8ef464-f685-483e-c05d-08dd8dee9f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3b71ff298f21..c89e593d4819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -524,7 +524,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
-				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+				      &psp->cmd_buf_bo, NULL,
 				      (void **)&psp->cmd_buf_mem);
 	if (ret)
 		goto failed2;
@@ -567,7 +567,7 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
-	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, NULL,
 			      (void **)&psp->cmd_buf_mem);
 
 	return 0;
@@ -682,6 +682,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = psp->adev->psp_timeout;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	uint64_t cmd_buf_mc_addr;
 
 	if (psp->adev->no_hw_access)
 		return 0;
@@ -691,7 +692,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
 
 	index = atomic_inc_return(&psp->fence_value);
-	ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr, fence_mc_addr, index);
+	cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
+	ret = psp_ring_cmd_submit(psp, cmd_buf_mc_addr, fence_mc_addr, index);
 	if (ret) {
 		atomic_dec(&psp->fence_value);
 		goto exit;
@@ -2344,7 +2346,6 @@ static void psp_update_gpu_addresses(struct amdgpu_device *adev)
 	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
 		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
 		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
-		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
 	}
 	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
 		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d3f5c17ead7e..491697e1f141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -365,7 +365,6 @@ struct psp_context {
 
 	/* cmd buffer */
 	struct amdgpu_bo		*cmd_buf_bo;
-	uint64_t			cmd_buf_mc_addr;
 	struct psp_gfx_cmd_resp		*cmd_buf_mem;
 
 	/* fence value associated with cmd buffer */
-- 
2.43.5

