Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9801CFC5E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 16:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B9510E021;
	Thu, 10 Oct 2024 16:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFZ2bBZf";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C5D10E021
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 16:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzTzSmlvSZsD9OYMj9eG8l8b5kokT3H5VLiAPHav+f5K2Jbtu7y0GOWArESyWB1hJzYdctd1v/egkH1SCnXwU5Y7M09m0OxDVuwTKhysRZjci0ToB8FgRhu2bJ4AKKRKXFSgRyPPwBvHGvrc5vGD5VCn38gX8jWiK6cqoQiIrzo3K/UBAC7kWNsCQ6qLzSeJN0AXtdKF1A1WRfe+7mPSZB0W5ABzvMdiOfaHU3ysLlIlQK2hna4ygrPqo73di65VxsOluCJV/4botwIjqKAAPXx7Ql4hlmT35xDrTMpOggLgTLkpf6rJhrWt/Ye5S57golaXK2fH7qjjSdUYiKOtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYZ+N3+9DW+KCCoUmMzGwdaG2c6DQKtIYWVBNyVSCl4=;
 b=axax3Ncb7TT6ZMTvCO5Wcqkqz+rsmZoOGQ9ETXy3WDUVcvqpiMQlAIr4poKeCYI5oCmXMTWAFcNbcAegMZ0MD5GEnHpRVVNor2te2/zrNCp4fhFAPEW23hIwC4Qc9516tH93Vr4XyARnIA1rJ2TMyAa1o+vGgbvZR3uIh1t/VZnBdlRVTt09OZ7CK0Oq5hWwpTRMvwjwX/8lxfStdp/jyR4IR3YplFaW4GhExYinzTMtPuHsW8sS+kzUkxoA3jXow3ZtfVK7JwQK0J++KMzWTCIxsFIxO4SjNDvMG0VNSKMYj6H9T//K23L66Lfw75wNSYZEnEp/OBYn7B528ZlYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYZ+N3+9DW+KCCoUmMzGwdaG2c6DQKtIYWVBNyVSCl4=;
 b=YFZ2bBZfV9U5tMCKKOheyixEaCu6FazScdCfXE53jb7cbnlQiaNWNkrRhCtKbJVsn92Ve41lCDsIvwIayby1ks7iJXMVWMf8PkZ5oHQjDwL9QV8XRMyBkrnb26svd3gL77hN/ZhyKKJY2ObaCTxBDmH6BHca235oKQ6kgXZTuxw=
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:10:31 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::19) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 16:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 16:10:30 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 11:10:29 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch data
Date: Thu, 10 Oct 2024 12:10:15 -0400
Message-ID: <20241010161015.624089-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 31396e65-4ac0-4db4-083e-08dce946106c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r2DvBbPlqMxp4FtQ8uuaoufB7mdo+pObKh1MvuL2RfSjlwEBFjNKtdpy+mTI?=
 =?us-ascii?Q?hFqMzk3jwKhiGZPjiET0/m/eDju6fq0kijwUSPDZNopGLQpU5p2Ni1kKFu/z?=
 =?us-ascii?Q?LwylgvX33r+WmkdaFPHxn/y2Cl4/+C47V2D0O6UgF9j2rWD2PxZjM3t7OTQR?=
 =?us-ascii?Q?dSTpMCAZszoCXhGutY4ncuFJTRLSMd6EhGXbNwwnaCmcifQRiiLv+g925Mtn?=
 =?us-ascii?Q?p/d+u+Tu119ALD2lRRMk/UTiUQQUmXcwJ7w2q8b8/JasJgp2qEckTDhBBRMb?=
 =?us-ascii?Q?+KqYnbPkq2FmwGMwcENmXjRjE2ZkC5+3zmVJ1u0uztrSlJfo7bTu1gKm0biS?=
 =?us-ascii?Q?jg8olJPWBUZ5Ouc27j1LmLPoTUmuRCQer4UjaySUfkdIbpnvkyzVV5gC7a3g?=
 =?us-ascii?Q?4Ov7S+u9B41mKjPMA/cDRZMkIryRJOETRIw680yV/ITR9fZB1jmnrBi/fPIt?=
 =?us-ascii?Q?XGukwPMxCaikzf3Te1FWAfwmuxhmuL8NjsvICThmVr9V1W3WkalPKmn8mkQY?=
 =?us-ascii?Q?YFLIL3KLRyTI8Hb60BFhxBJFdHrrJ2kwEa4LuUVKVyrL1rcm3vjiGy6pKrfh?=
 =?us-ascii?Q?7CwJgbnkzVkxhqF5I1aHpglwteCIvmwSsZOstog3LQmLAvd1lkw7TcCBOvlH?=
 =?us-ascii?Q?nFbAWZldfrtE2OxLQNPOIWlDT5fPE3N/tFNa2YfGCB7OgNC4eZGexoRTwJWs?=
 =?us-ascii?Q?whnrdw/VI2urLJmyl7pjiy6jRX/6P0Srpd5SzcVu/mDSHVK8AI2RXtLkx8cO?=
 =?us-ascii?Q?qLfb/Svvx7b2a5fqJj768oHw2qF1JXVHSY3XMPFjrxGZlh7C0cwfTR8NSl8P?=
 =?us-ascii?Q?FQM/gAkOW3I1RD3kGSz3cVixaQ9odNZBjIN6u7Y1fxmigltIo3C3gAxUdxbL?=
 =?us-ascii?Q?qtXJFYPVe+jzSN3bXuARY01cNVJhb+NW7EIlNOvDc7EvQLCXTC1jUQtvGlva?=
 =?us-ascii?Q?RURQ/XT5oRSE4RYC+751hN3Ls/n12w5Rj9gVBnVFpAgvHDtZKckSGZAn3KIH?=
 =?us-ascii?Q?ETuQ0JFjrP0d2GNVRZCjRGoQvHr03xPHTWgBZxkpFLycidbuiQ4wWhvwnW3v?=
 =?us-ascii?Q?Wxbxhpz2d2zc/GSE/P5jT1+0g1kozdBmUghOUd2wDsurBI0Y4+jQtZq+uFqA?=
 =?us-ascii?Q?hcqoY/Pq/P/X/w4An3X1s2oF8QG9/yaey9Bem7nXWJhoHUlSWp1oEFVlGTS4?=
 =?us-ascii?Q?JB2aprEmMMR6FVgMPRZY4o08MSySs3rVvdA8LZc8FryqdqoeTE4w4L29gp7y?=
 =?us-ascii?Q?GSmm2S/8HYKisqxWZkCENBLQGYtFnB/xyCvotBg82KiHJJZefI1RAq+J8PuL?=
 =?us-ascii?Q?bwtIS7HFQOZpqoBpWAt1yBfFzlt56ugy6ri4b3d2ZNbPgdjkUivTDDOcHjNQ?=
 =?us-ascii?Q?BizKiq86gtNd5DetpubPOnzRmNyYOWxpu0ZYlxWy+f65Zj/RKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:10:30.5234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31396e65-4ac0-4db4-083e-08dce946106c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

MES internal scratch data is useful for mes debug, it can only located
in VRAM, change the allocation type and increase size for mes 11

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 83d0f731fb65..bf584e9bcce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -104,7 +104,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT,
+				    AMDGPU_GEM_DOMAIN_VRAM,
 				    &adev->mes.event_log_gpu_obj,
 				    &adev->mes.event_log_gpu_addr,
 				    &adev->mes.event_log_cpu_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 45e3508f0f8e..79f13d7e5e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -40,6 +40,7 @@
 #define AMDGPU_MES_VERSION_MASK		0x00000fff
 #define AMDGPU_MES_API_VERSION_MASK	0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
+#define AMDGPU_MES_MSCRATCH_SIZE	0x8000
 
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 03bf865fbdd4..aa2e9ef4ff12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -913,6 +913,16 @@ static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
 	uint32_t pipe, data = 0;
 
 	if (enable) {
+		if (amdgpu_mes_log_enable) {
+			WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+				lower_32_bits(adev->mes.event_log_gpu_addr + AMDGPU_MES_LOG_BUFFER_SIZE));
+			WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+				upper_32_bits(adev->mes.event_log_gpu_addr + AMDGPU_MES_LOG_BUFFER_SIZE));
+			dev_info(adev->dev, "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
+				RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+				RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO));
+		}
+
 		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL,
@@ -1375,7 +1385,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
 
-	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE;
+	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE;
 
 	r = amdgpu_mes_init(adev);
 	if (r)
-- 
2.34.1

