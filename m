Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8892EC77B6C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACEC10F33D;
	Fri, 31 Mar 2023 22:44:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D90910F33B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abJ4n0ccoXLmIX0+HMzXLXnWiAeaCWKOCohBlFHT11d7oT8aafTPkAWEbBTVhmM4B3w0PylTjhY6KKFFi0cuM2VzhwGEd4SfP+QiLC8aGZCaU+FL8g/4B1Wg5bhS+mVf+qT9nXZIVGTykYG7zje1plL5qBZnhMcBw2crbTdtKNoTR6q6zI6g4UJKGcMiWlH3sD+sSYgHLLjZHpUCHARz7Cr7+BFPWzEXX71+kFh8e5UI43Ngp+XigCtoqI42Gt8s4HVq+tySbFQ9NWp6YR/WUKikmc9zuHMihR6kA/33vuEb48z04oNWeO6VOZYV2s31ibvyN8znJX0puEvmMqyupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G80D9j9VqDszGMdyw0Um+gxGtPBlPjSBbdOOVQqzK30=;
 b=By7UEFjY5oKxU8nRc/6ZFCztK4yEIlBF/82i1IoJAf115XARy5RG8GazyCmuwvBRPFqH4tYy27c6WzTH+T0Hw0rh9VmJw59z4lYtzaawqd4a7M3P1qko/jU38pVOvpH4Lgfj207MIhIq8dYJQ/w/k2KOFH17D+JYf9TtC/lKCKxToaSBdx2dO9RpBn2wAThEkxEVjh9+yrx2AbVJlvVguqrO6Ov2Iry8xKN8huCifDrK0PqU9hOaSniCuyuaaY7hTcsbjTeiL3nYVsrO5Wvmw8b38HcCVCoQTdu/h/9q0CiBH5EP/a3sOZEEURhLYbE4m6La6LPNBhIVMk934uzg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G80D9j9VqDszGMdyw0Um+gxGtPBlPjSBbdOOVQqzK30=;
 b=pgfhPcLNAmiyF2Wc2IwtpeiElr0dyQR/1IAQUAjmxpcy9J6XdKY6aYPIh9rGmG5TFLwzWTpjEgYNFUOa1jUV6ap8jLDSFmKYg7XiA0EhTySCFi5l40UaJDhABw2Bo0sLPZe8NLjRLD23+jhAZAk00hY40IhrlF/xL4mylTHzMH4=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Fri, 31 Mar 2023 22:44:46 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::c) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amdgpu: Add query_ras_error_count for mmhub v1_8
Date: Fri, 31 Mar 2023 18:44:22 -0400
Message-ID: <20230331224425.8755-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 77746242-086d-49db-f0a6-08db32398753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpPPNHPePjqiKZHveYq0MhHyH5U5DGX+GvzExShCsREhQi2FXENip1kNeBd0x4v/sYT66dcLnwW5+CP4ET3pPsfK01JuQD/2qanHx6uaTxKXp58UDIPyAnf5hwRvBvD0YKHlfe86sio/iOzPxYGYwcBXaP8UEwYiEahOGQwRga8ShZ3G61ZxXTbAaAjWEywrTZhk+OEkRfsxTdB+epkfRGLb+Z5vS3CDYWaEQQPi/EibP2jhb9eODMHE2xq3nhaSNQ3IXUAejcW9MMx/JnO0/BCU9COF906diwdiz/dAEV7lj5wvg/FBpbF8Tk9vX8ixfYR7cn5BT8Vx/dPTbbdrN61DGunegVQT54S2h/cpbBxOic4+Z+8VIsITKJFJ2/GQOW+c3fQrzv7DtXG8EdXK/fTXq/8NZfWvJMR4derMEsdD7J0lqvCTTEcn57QdkvFTKf+lKGThPwOBxOz1DekXaZCPPcM7Rvz5XyB151HHPomeQpEluLLfiCG7TYiv776g5nyLMXW9gVjfMJX4x1SOistaafrU8mhfhyEKoPzMWKGFCP+sCxLRqeqInyZ+0M6tQRzL7IGCXVcHfTju1NEaEyd9N7koI7YHcc5GdpBN+sNO2QNQXvWFLSRmvyK8gqLm9A/swJdas1GwgvABRDJs11W6O4AXvYkMvUwDXQa1U7WrysAKfSvB4OndJTujYflCroqpkgxIroouK0uo652k0BEnkhVvcMyu/qx8k3sJ/z0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(2616005)(47076005)(6666004)(316002)(426003)(83380400001)(336012)(186003)(1076003)(54906003)(40460700003)(7696005)(16526019)(26005)(36756003)(82310400005)(478600001)(5660300002)(8676002)(86362001)(81166007)(70586007)(70206006)(82740400003)(4326008)(41300700001)(2906002)(36860700001)(6916009)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:46.6444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77746242-086d-49db-f0a6-08db32398753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add query_ras_error_count callback for mmhub v1_8.
It will be used to query and log mmhub error count
and memory block.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 23 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c   | 93 +++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index d21bb6dae56e..1ca9d4ed8063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,6 +21,29 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
+enum amdgpu_mmhub_ras_memory_id {
+	AMDGPU_MMHUB_WGMI_PAGEMEM = 0,
+	AMDGPU_MMHUB_RGMI_PAGEMEM = 1,
+	AMDGPU_MMHUB_WDRAM_PAGEMEM = 2,
+	AMDGPU_MMHUB_RDRAM_PAGEMEM = 3,
+	AMDGPU_MMHUB_WIO_CMDMEM = 4,
+	AMDGPU_MMHUB_RIO_CMDMEM = 5,
+	AMDGPU_MMHUB_WGMI_CMDMEM = 6,
+	AMDGPU_MMHUB_RGMI_CMDMEM = 7,
+	AMDGPU_MMHUB_WDRAM_CMDMEM = 8,
+	AMDGPU_MMHUB_RDRAM_CMDMEM = 9,
+	AMDGPU_MMHUB_MAM_DMEM0 = 10,
+	AMDGPU_MMHUB_MAM_DMEM1 = 11,
+	AMDGPU_MMHUB_MAM_DMEM2 = 12,
+	AMDGPU_MMHUB_MAM_DMEM3 = 13,
+	AMDGPU_MMHUB_WRET_TAGMEM = 19,
+	AMDGPU_MMHUB_RRET_TAGMEM = 20,
+	AMDGPU_MMHUB_WIO_DATAMEM = 21,
+	AMDGPU_MMHUB_WGMI_DATAMEM = 22,
+	AMDGPU_MMHUB_WDRAM_DATAMEM = 23,
+	AMDGPU_MMHUB_MEMORY_BLOCK_LAST,
+};
+
 struct amdgpu_mmhub_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index b18bb3773f77..650f9351182e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -29,6 +29,7 @@
 
 #include "soc15_common.h"
 #include "soc15.h"
+#include "amdgpu_ras.h"
 
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
 #define regVM_L2_CNTL4_DEFAULT	0x000000c1
@@ -579,3 +580,95 @@ const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.set_clockgating = mmhub_v1_8_set_clockgating,
 	.get_clockgating = mmhub_v1_8_get_clockgating,
 };
+
+static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ce_reg_list[] = {
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA0_CE_ERR_STATUS_LO, regMMEA0_CE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA0"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA1_CE_ERR_STATUS_LO, regMMEA1_CE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA1"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA2_CE_ERR_STATUS_LO, regMMEA2_CE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA2"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA3_CE_ERR_STATUS_LO, regMMEA3_CE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA3"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA4_CE_ERR_STATUS_LO, regMMEA4_CE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA4"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMM_CANE_CE_ERR_STATUS_LO, regMM_CANE_CE_ERR_STATUS_HI),
+	1, 0, "MM_CANE"},
+};
+
+static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ue_reg_list[] = {
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA0_UE_ERR_STATUS_LO, regMMEA0_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA0"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA1_UE_ERR_STATUS_LO, regMMEA1_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA1"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA2_UE_ERR_STATUS_LO, regMMEA2_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA2"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA3_UE_ERR_STATUS_LO, regMMEA3_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA3"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMMEA4_UE_ERR_STATUS_LO, regMMEA4_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "MMEA4"},
+	{AMDGPU_RAS_REG_ENTRY(MMHUB, 0, regMM_CANE_UE_ERR_STATUS_LO, regMM_CANE_UE_ERR_STATUS_HI),
+	1, 0, "MM_CANE"},
+};
+
+static const struct amdgpu_ras_memory_id_entry mmhub_v1_8_ras_memory_list[] = {
+	{AMDGPU_MMHUB_WGMI_PAGEMEM, "MMEA_WGMI_PAGEMEM"},
+	{AMDGPU_MMHUB_RGMI_PAGEMEM, "MMEA_RGMI_PAGEMEM"},
+	{AMDGPU_MMHUB_WDRAM_PAGEMEM, "MMEA_WDRAM_PAGEMEM"},
+	{AMDGPU_MMHUB_RDRAM_PAGEMEM, "MMEA_RDRAM_PAGEMEM"},
+	{AMDGPU_MMHUB_WIO_CMDMEM, "MMEA_WIO_CMDMEM"},
+	{AMDGPU_MMHUB_RIO_CMDMEM, "MMEA_RIO_CMDMEM"},
+	{AMDGPU_MMHUB_WGMI_CMDMEM, "MMEA_WGMI_CMDMEM"},
+	{AMDGPU_MMHUB_RGMI_CMDMEM, "MMEA_RGMI_CMDMEM"},
+	{AMDGPU_MMHUB_WDRAM_CMDMEM, "MMEA_WDRAM_CMDMEM"},
+	{AMDGPU_MMHUB_RDRAM_CMDMEM, "MMEA_RDRAM_CMDMEM"},
+	{AMDGPU_MMHUB_MAM_DMEM0, "MMEA_MAM_DMEM0"},
+	{AMDGPU_MMHUB_MAM_DMEM1, "MMEA_MAM_DMEM1"},
+	{AMDGPU_MMHUB_MAM_DMEM2, "MMEA_MAM_DMEM2"},
+	{AMDGPU_MMHUB_MAM_DMEM3, "MMEA_MAM_DMEM3"},
+	{AMDGPU_MMHUB_WRET_TAGMEM, "MMEA_WRET_TAGMEM"},
+	{AMDGPU_MMHUB_RRET_TAGMEM, "MMEA_RRET_TAGMEM"},
+	{AMDGPU_MMHUB_WIO_DATAMEM, "MMEA_WIO_DATAMEM"},
+	{AMDGPU_MMHUB_WGMI_DATAMEM, "MMEA_WGMI_DATAMEM"},
+	{AMDGPU_MMHUB_WDRAM_DATAMEM, "MMEA_WDRAM_DATAMEM"},
+};
+
+static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
+						  uint32_t mmhub_inst,
+						  void *ras_err_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+
+	amdgpu_ras_inst_query_ras_error_count(adev,
+					mmhub_v1_8_ce_reg_list,
+					ARRAY_SIZE(mmhub_v1_8_ce_reg_list),
+					mmhub_v1_8_ras_memory_list,
+					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
+					mmhub_inst,
+					AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE,
+					&err_data->ce_count);
+	amdgpu_ras_inst_query_ras_error_count(adev,
+					mmhub_v1_8_ue_reg_list,
+					ARRAY_SIZE(mmhub_v1_8_ue_reg_list),
+					mmhub_v1_8_ras_memory_list,
+					ARRAY_SIZE(mmhub_v1_8_ras_memory_list),
+					mmhub_inst,
+					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+					&err_data->ue_count);
+}
+
+static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
+					     void *ras_err_status)
+{
+	uint32_t inst_mask;
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		return;
+	}
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask)
+		mmhub_v1_8_inst_query_ras_error_count(adev, i, ras_err_status);
+}
-- 
2.39.2

