Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80559C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0013D112320;
	Mon,  6 May 2024 18:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fe2y6Wc1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFD2112309
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0EcoY8UDlVhGAXIRlkEBIPdhacvxe+ya12L4z0VVOyb2pUzvSIAfRgBuDe7W4dUvsUYgROUJvDlbnmuLPdR7Or6vws3Wb9M3N5k/X1fxdJfXFLzfjWOYaK/W5R49BauFzl4GcmNFLmCA8+nrD8onqgW4Dods9ONdPSgQweahknSABy2sFcGKo6sY9Y5LSCaJzGT5bTACvOuDxox6w524UzbH9GdcDAOeEYPgbn+zMXMlN+Hgdti/ehGxV4/alVBgQrXKXSKuk+gJFnIIWdu630Ol+5Jl10sXjwEwTIBz8sy/Ph/LnYKZsL9iEGKiHYZLXhNG8clCDL7oG4JZ8w4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAU8UvSACMvsXyUJlE8Qe0XbtGLudeWb4nnaz9l/9VI=;
 b=Brt3YTiFR3h6cviV7l/mJHbFkCpUTkPLhNjKMftvI6xlZbbRgjSu7LDoMY++YWRL9EbOHbM9jyT0mfKwlNdRYGjewTo/NCfuzprnlPLYgtTKvIzCWnqIbllCf5bMPd6JZn4nVGQ3HjpK7rMHb4xn2VCG8FFIPdwKSfvmGfCnTWU7bYbXFC4Pr0KO/9SgBzdPw0Q+XFbZLVvz9nHNF6mx2n7HAr+kcQPatcbeb7STa5XXSp68kkaEJOjE8fNOG6zNA3gk3lZCjNu8pwoSTILB5X53WeZ61P71kfcBWT1klaEusoYz0h8LdPYJ+tOmwjhtcz67yRqIOTEEJC94pHCPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAU8UvSACMvsXyUJlE8Qe0XbtGLudeWb4nnaz9l/9VI=;
 b=fe2y6Wc1oHQZO/R73VyIwvetGXI4sGxPtL3yYMDhEAh6U8NRmRL9idjbDiwYY8gHo2za2RWuOaBYZ3VeCuM0GOw0lRkR2GTSp4HdX7vcZzkobmeXu3nuCAp21DLMwAE0bntGfSEU618ITJaIzuwpJ4UOLuLpPRHdkDVa6qNBWmw=
Received: from PH1PEPF00013315.namprd07.prod.outlook.com (2603:10b6:518:1::8)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 18:46:07 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF00013315.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 12/14] drm/amdgpu/soc15: use common nbio callback to set remap
 offset
Date: Mon, 6 May 2024 14:45:37 -0400
Message-ID: <20240506184539.1669157-12-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 344e46c7-8100-41f9-b190-08dc6dfcca24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zreBh+1ZxBBiVvM3sUGcuDESnuSCB8AtunAQ9orJi5Hwh26zmOAQI5QGpFK?=
 =?us-ascii?Q?rnQH8MfECO2uFSsapYytmxhMZjMk/2iQ+Y5jSvO6CSO4Q557YzNdD054MAPi?=
 =?us-ascii?Q?OMlSXdkbB37dlJgDuzgsOgoE/u0Ky2ucL8ScZLefdZnZioS4nqTwtGIJU/Xi?=
 =?us-ascii?Q?QVFtuwsTlH62g751mJ+E54klPsbDLqTVkyoyw5SO+Fv9p2k9dYYadzNLdIdL?=
 =?us-ascii?Q?Dogb+JcqNAByileOPH95dvNYLvfykKXNko/xWadkIik2tD4UbdDu8t49FuBr?=
 =?us-ascii?Q?imn14v5lDd8uYS7IDqeWN9eWzL1qipfpB3Rh48yAIi/O5l+ILvRTz8IwON6q?=
 =?us-ascii?Q?vuD5vR+JjPECRV/D+fS/SZoOuew4EA4Pls1kIXclP0REaFXdKrCoHTIQNWc0?=
 =?us-ascii?Q?Q3kTM9gfeBUhUSqoN6QtlaG5lYiZmJ1tDOuyTLd8oOwDsp73MV6VAJPfljID?=
 =?us-ascii?Q?8XPB7vdbxIyGMUKtKrjGOj17Jry3DaLeEJIDKenEgi0cU9yX2rHt7if9M1sn?=
 =?us-ascii?Q?uGQILgWYpUZpYBpvlcFR4kcAQyFgqvrE4iIRc3QqocbCPpsPbCmxCVKBrbLB?=
 =?us-ascii?Q?7y3MsYNu1KdkMIRcMH2sqRnb4HQA67mPqQR2nlyMiQWBa4UuEfm8MFCE5gcR?=
 =?us-ascii?Q?34rxz1FQOLCNUkUQ2zzCu/wUl7vlA/CL7D34meHVMeWtzHG9T7ZNl8mDXEJL?=
 =?us-ascii?Q?F/qYmovKKlN8xA+a+SswI9e7IDq577QAY7IDG69Aon7qQwcfMg1ADIdg6y0n?=
 =?us-ascii?Q?wsMUoiT4FJA0SYxRycgTz6m90wCXjVK3fWIeTtUHOrwpeWqr7awXEnr2wTHN?=
 =?us-ascii?Q?OK/fIjekp4/efZzhJdjkeSn3lQsCO5sTdIDJpyme+KNyqVPD3FYx08HFkYCL?=
 =?us-ascii?Q?dwbUVWLUKy8MWNvwt5wBhdpXwAFo0WjIu8G0XeFa6VhIz2m3DCSgGYMeaPAi?=
 =?us-ascii?Q?zYsKY1hUXjmnR1vp/bi8dItRHyNwkhDw8NqaJ5qdRU2X+JKcO3xisqR5WPuY?=
 =?us-ascii?Q?JdnS3Bx+pWt8lscW7jiCMh0+Y5tXkD0jfQ9vqHTVjJMX5TnuqALDvo1GfD+a?=
 =?us-ascii?Q?q8uy6zLwhNeB17jK39UuL9uvvz9pEbQCTtPpmIVc/r1myx5t+rOWwH+3tkGa?=
 =?us-ascii?Q?ZxO3iIG7b7nemVRAsiCv3Ry953TzQCNCkQsTcJVwEQ9f8OO15ORgr0oeLCtP?=
 =?us-ascii?Q?WGi2zyL8+tm7kmN5H9BdzlClmtTt0reyPANk12Ht0n9LtN8nPe3cX3a0WdUl?=
 =?us-ascii?Q?pTSowhc/KLg0mWbN/+i+RjsQRH6x8N1ozCRuX4CMUPfRyjxlmTjrQa04RZ7d?=
 =?us-ascii?Q?cjZoA/XvYdjcfoRRTfXULjaOM5NnNY3jJABn8+TitvbXQmg9094Fz0ijJKOn?=
 =?us-ascii?Q?bPmjCZb23stTJLkJN3/CSaLtDmYv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:06.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 344e46c7-8100-41f9-b190-08dc6dfcca24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/soc15.c     | 11 +----------
 5 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 5dc8663a29e95..34180c6070dd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -276,10 +276,6 @@ static void nbio_v6_1_init_registers(struct amdgpu_device *adev)
 
 	if (def != data)
 		WREG32_PCIE(smnPCIE_CI_CNTL, data);
-
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 3dd743ebbc02d..b1b57dcc5a737 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -273,9 +273,6 @@ const struct nbio_hdp_flush_reg nbio_v7_0_hdp_flush_reg = {
 
 static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset =
-			SOC15_REG_OFFSET(NBIO, 0, mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index b684eb519d2a9..fe18df10daaa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -343,10 +343,6 @@ static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t baco_cntl;
 
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
-
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 4, 4) &&
 	    !amdgpu_sriov_vf(adev)) {
 		baco_cntl = RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index c2e78294c4fdc..d1bd79bbae532 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -422,12 +422,6 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	u32 inst_mask;
 	int i;
 
-	if (amdgpu_sriov_vf(adev))
-		adev->rmmio_remap.reg_offset =
-			SOC15_REG_OFFSET(
-				NBIO, 0,
-				regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
-			<< 2;
 	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
 		0xff & ~(adev->gfx.xcc_mask));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3a39a7d311891..c757d39c767a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -931,13 +931,9 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 
 static int soc15_common_early_init(void *handle)
 {
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
-		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
-	}
+	adev->nbio.funcs->set_reg_remap(adev);
 	adev->smc_rreg = NULL;
 	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
@@ -1188,11 +1184,6 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		/*TODO: need a new external_rev_id for GC 9.4.4? */
 		adev->external_rev_id = adev->rev_id + 0x46;
-		/* GC 9.4.3 uses MMIO register region hole at a different offset */
-		if (!amdgpu_sriov_vf(adev)) {
-			adev->rmmio_remap.reg_offset = 0x1A000;
-			adev->rmmio_remap.bus_addr = adev->rmmio_base + 0x1A000;
-		}
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.44.0

