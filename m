Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12D6C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501C310ED01;
	Wed,  5 Aug 2026 06:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="heBduvL1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAB110ED07
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNKr/oo6EXu2ofV05jT0nxxiAlkU4XavcTA/kciFBq59z0NHQ03MGqIQimttYgCpbwRKkLcvTtPfCDJE4mZwK4DMUbRwXodREl0KJnQyMbgXJThARJFlAh1IrAXiXk6VjL2/GH+HvE7iDm3ExQDoGJowk3CJRrTWYqzLHTU7OC2jOgKDPCjB/CXqu8DgmoAY6TW8NVTtaW2EyRefKj+SZHBZgzGnBFv7wF1pkACicnEHQrlZdLCrWnbeYAM4ZIR0wiBJ++ptOJ8dDUSqWYz3vjo1H7ywJYBSr2L2or5rPQ/XM/yxgtXtohRC2Of35L3+VX9EDOJxmQDJgN1zjHC6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd20itm1sMxjkkqdMwmRgY8l+0Uk/LiqaSKM8c8p4MA=;
 b=M12hcMKGk6Rp3vETsLn4AVh3qehE1ke2psUOIlyzKUfOU06Xc4Jnog45/8q88wJQudIEBEPMmdPlTyZ3L3GyaOj2l8ulSFcfXdeJ/8Wgu86mTDyVtkqpY4TvhtpDYm1F0MoXZAAepIpbSZjLewZ7DtIcZg7USzdWbIm5GyPsRSbcMb3yHSl6eIluKzv6r+0Rjta3h3fyVo7KmJAss0tB+tNx8+0zKksjrkNnzEdXCoor8vwQ9BF51oLPmwgcS0rhcKjUmASejZLHAumzLHMTHOUskW62S0zI7gQtlU+nEnknsiDhn54HyZrCIwNUkGjHHH44XzoZczM/dXA80eAxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd20itm1sMxjkkqdMwmRgY8l+0Uk/LiqaSKM8c8p4MA=;
 b=heBduvL1QmkQFJ/JSLhZQ/psfrlNbYI63NIka2lJYZVBDKYWKsgjMGz8rWOpc4DEyE48fCKVq0iA/M5WWoh4TAUC8Ei23HFUcXnenzok3DVr9fW/zuIn8HtMFRjYlyh4dZxoaETE4aypy5e4riDOYcCYcLywFAcLZ423IroI5rI=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:35 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::20) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:34 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:30 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 11/34] drm/amd/display: Fix HostVM init and SOCBB VM config
 for DCN6
Date: Wed, 5 Aug 2026 14:36:23 +0800
Message-ID: <20260805063937.2145774-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eedbb08-ebe8-4d48-d945-08def2bc7477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F64OAJp0Wuk6gG230OKJoc/X2cDk33ltaDveXnYEeO60sQq4UXci89M/fjmxEno02XRAtqKDB1eq/brGfBI2VcRWvpmocyGlVhH76LWD3MhtKCoM0MPMS51fGqOkeRyoDkv3K2QFlUaGnVsCEC1fPopgBI30nG/88VsjsQmNgR9Kr6jw2xHjWaRo6tZmX5iI5kAnqNTd06ANgICX4QCeuZYdL5betgMW8QfLy7D7LRPmZFz5QVe8F2k4om3eCOtDNORP9UoINhe10kCgk+2qiCBV1nLqlvC56zfUgkOQSmhyGMbsgXCYyDGUEoc6oI7B0g8Ed9d1HG+99n2+TjtQKYVHu1CuoT/2z+nkJOLe9+hhCuLprmqLPRIpxp1QZyP0WmX9YVn97L1IYoK6zfNGw9f4zO1DM5AyJxL1Wm6+OwOVFXs50CDIXF3T+nL/rP8BO4YVlCksIQ67Q8OMALtVYD+6ZzbXUCPM31FIr/gJPXI6EJDUx0A7Q+6c/CFAZ0DwEZrH5OqJ/0/VJ66XLUyiYXbA8lnuzFd+vOi2DQo8pmVxnOywoLWIadi/IeZ36Vm2AiGf1qjDYxEaXIZQ9W0GJHMxxVoVffvRxMLsQ19O2mabi/HSS6V7xbECmgLFl7gSHZDAdeHhBVMa3JfS24tfxTddpHd9ad2C19T3utTkw87/teRR1y7TqMueu+QTNdkIhCFWLpzeZOVefdOnBt+2pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GfzrrEfS6xX/do1nfvg9PTx3TrPSxRlpBtozOD2dBg7tZklC/r9/CImoF92HoY11hVCDp/ZIJ9iGYw7zDcD7JL9OiW2PAC1JzC4QmtK72pbMdMTW3WqcFr75KpiodezGi0AW+mG1BftC7BPj+rHDRM+bSHPKTNnLqylW3EABGCZgmQuCdM5rlBn2CKzQl2NBddEOAVmK0ir3mHTfed/Cd56SnuA36HcIoBqEj/CK1z7ybj4R3FTFUmR22XFwlSjUcaZIf4V25lJI9YZA1HNiZ9vEVFmjCDTKGBiftdl7NbLLYv7MOGu4SBZE2IrQu7MwYuzgDgbnKK9BL2IrznHktOvL6huS2HCmFwjuLIR6y8+uE3uli2ZO7kk/h/rHH3tRcl21T2eFkNyZAL8Z4Nzyp+YMLubROF994td/LnwxBZ4Tr2kYuQEQNtH/954feFS6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:35.3674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eedbb08-ebe8-4d48-d945-08def2bc7477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Underflow occurs in testing for DCHVM and RIOMMU interop tests when
attempting to scan out surfaces in VM.

[How]
New registers have been added to DCN6 for HostVM to control which VFID
to prefetch by default. These need to be programmed during the VM init
sequence. The sequence validated from DCN42 is used (and xref'd with
the design documentation with hardware) with the register placed in
an ordering that appears correct.

HostVM and GPUVM are also currently disabled and set an incorrect
number of page table levels and min page size in the SOCBB for DCN6b.

These are updated, but driver also needs to select the B variant when
creating the SOC BB to ensure that they're piped into DML.

Lastly, the init function for the vm context is branched out to skip
initializing VMID 15 - this workaround should no longer be necessary
on DCN6.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  4 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 89 ++++++++++++++++++-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    | 13 +++
 .../dc/resource/dcn60/dcn60_resource.c        |  6 ++
 .../dc/resource/dcn60/dcn60_resource.h        |  6 ++
 .../dcn60/dcn60_soc_and_ip_translator.c       |  6 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  5 ++
 7 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 5f065b4045ee..53fac324748d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -143,6 +143,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHVM_CLK_CTRL;
 	uint32_t DCHVM_RIOMMU_CTRL0;
 	uint32_t DCHVM_RIOMMU_STAT0;
+	uint32_t DCHVM_PREFETCH_VFID;
 	uint32_t DCHUBBUB_DET0_CTRL;
 	uint32_t DCHUBBUB_DET1_CTRL;
 	uint32_t DCHUBBUB_DET2_CTRL;
@@ -398,7 +399,8 @@ struct dcn_hubbub_registers {
 		type HOSTVM_PREFETCH_REQ; \
 		type HOSTVM_POWERSTATUS; \
 		type RIOMMU_ACTIVE; \
-		type HOSTVM_PREFETCH_DONE
+		type HOSTVM_PREFETCH_DONE; \
+		type HOSTVM_PREFETCH_VFID
 
 #define HUBBUB_RET_REG_FIELD_LIST(type) \
 		type DET_DEPTH;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index e2a457ab13bb..820b156474e1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -18,6 +18,92 @@
 #define FN(reg_name, field_name) \
 	hubbub2->shifts->field_name, hubbub2->masks->field_name
 
+static void dcn60_control_dchvm_gating(const struct hubbub *hubbub, uint32_t disable_gating)
+{
+	const struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	if (disable_gating != 0) {
+		REG_UPDATE(DCHVM_MEM_CTRL, HVM_GPUVMRET_FORCE_REQ, 0);
+	}
+
+	REG_UPDATE(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, disable_gating);
+
+	REG_UPDATE_4(DCHVM_CLK_CTRL,
+		     HVM_DISPCLK_R_GATE_DIS, disable_gating,
+		     HVM_DISPCLK_G_GATE_DIS, disable_gating,
+		     HVM_DCFCLK_R_GATE_DIS, disable_gating,
+		     HVM_DCFCLK_G_GATE_DIS, disable_gating);
+
+	udelay(1);
+}
+
+static void dcn60_dchvm_init(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t riommu_active = 0;
+	uint32_t prefetch_done = 0;
+	unsigned int i;
+
+	/* If already prefetched return early. */
+	REG_GET(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, &prefetch_done);
+
+	if (prefetch_done) {
+		hubbub->riommu_active = true;
+		return;
+	}
+
+	/* Init DCHVM block. */
+	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
+
+	/* Poll until the rIOMMU and main IOMMU are active. */
+	for (i = 0; i < 100u; i++) {
+		REG_GET(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, &riommu_active);
+		if (riommu_active)
+			break;
+
+		udelay(5);
+	}
+
+	if (!riommu_active) {
+		DC_LOG_ERROR("Timed out waiting for DCHVM RIOMMU_ACTIVE\n");
+		return;
+	}
+
+	/* Disable gating and memory power requests. */
+	dcn60_control_dchvm_gating(hubbub, 1);
+
+	/* Select the physical function's host table for the initial prefetch. */
+	REG_UPDATE(DCHVM_PREFETCH_VFID, HOSTVM_PREFETCH_VFID, 1U << 31);
+
+	/* Reflect the power status of DCHUBBUB. */
+	REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, 1);
+
+	/* Wait for power status to propagate to rIOMMU before prefetch req.*/
+	udelay(5);
+
+	/* Start rIOMMU prefetching. */
+	REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, 1);
+
+	/* Poll for prefetch to be done. */
+	REG_WAIT(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, 1, 5, 100);
+
+	/* Re-enable gating and memory power requests. */
+	dcn60_control_dchvm_gating(hubbub, 0);
+
+	hubbub->riommu_active = true;
+}
+
+static int hubbub60_init_dchub_sys_ctx(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config)
+{
+	int num_vmids = hubbub3_init_dchub_sys_ctx(hubbub, pa_config);
+
+	if (hubbub->funcs->dchvm_init)
+		hubbub->funcs->dchvm_init(hubbub);
+
+	return num_vmids;
+}
+
 static void dcn60_init_crb(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -1752,7 +1838,7 @@ static void hubbub60_override_utm_client_qc_profile(struct hubbub *hubbub, uint8
 
 static const struct hubbub_funcs hubbub60_funcs = {
 	.update_dchub = hubbub2_update_dchub,
-	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
+	.init_dchub_sys_ctx = hubbub60_init_dchub_sys_ctx,
 	.init_vm_ctx = hubbub2_init_vm_ctx,
 	.dcc_support_swizzle_addr3 = hubbub401_dcc_support_swizzle,
 	.dcc_support_pixel_format_plane0_plane1 =
@@ -1768,6 +1854,7 @@ static const struct hubbub_funcs hubbub60_funcs = {
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub60_init_watermarks,
 	.init_crb = dcn60_init_crb,
+	.dchvm_init = dcn60_dchvm_init,
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = NULL,
 	.set_request_limit = hubbub32_set_request_limit,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
index 03b5182d233c..ed47c462e8fe 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
@@ -16,6 +16,19 @@
 #define DCN6_0_CRB_SEGMENT_SIZE_KB 64
 
  #define HUBBUB_MASK_SH_LIST_DCN6_0(mask_sh)\
+	HUBBUB_SF(DCHVM_CTRL0, HOSTVM_INIT_REQ, mask_sh), \
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, mask_sh), \
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_FORCE_REQ, mask_sh), \
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_POWER_STATUS, mask_sh), \
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_R_GATE_DIS, mask_sh), \
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_G_GATE_DIS, mask_sh), \
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_R_GATE_DIS, mask_sh), \
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_G_GATE_DIS, mask_sh), \
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, mask_sh), \
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, mask_sh), \
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, mask_sh), \
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, mask_sh), \
+	HUBBUB_SF(DCHVM_PREFETCH_VFID, HOSTVM_PREFETCH_VFID, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_SOFT_RESET, DCHUBBUB_GLOBAL_SOFT_RESET, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL, DCHUBBUB_ARB_WATERMARK_CHANGE_REQUEST, mask_sh), \
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 1cbff128789d..2dac5f7486d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -1962,6 +1962,8 @@ static bool dcn60_resource_construct(
 	struct ddc_service_init_data ddc_init_data = {0};
 	uint32_t pipe_fuses = 0;
 	uint32_t num_pipes  = 4;
+	bool is_lite3 =
+		ASICREV_IS_DCN6_VARIANT_LITE3(ctx->asic_id.hw_internal_rev);
 
 #undef REG_STRUCT
 #define REG_STRUCT bios_regs
@@ -2341,6 +2343,10 @@ static bool dcn60_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 20;
 	dc->dml2_options.det_segment_size = DCN6_0_CRB_SEGMENT_SIZE_KB;
+	if (is_lite3) {
+		dc->dml2_options.gpuvm_enable = true;
+		dc->dml2_options.hostvm_enable = true;
+	}
 
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
index 913f049deeb3..b1a802f9f4b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
@@ -59,6 +59,12 @@ bool dcn50_program_mcache_pipe_config(struct dc_state *context,
 
 /* HUBBUB */
 #define HUBBUB_REG_LIST_DCN60_RI(id)                                         \
+	SR(DCHVM_CTRL0),                                                         \
+	SR(DCHVM_MEM_CTRL),                                                      \
+	SR(DCHVM_CLK_CTRL),                                                      \
+	SR(DCHVM_RIOMMU_CTRL0),                                                  \
+	SR(DCHVM_RIOMMU_STAT0),                                                  \
+	SR(DCHVM_PREFETCH_VFID),                                                 \
 	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A),                               \
 	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B),                               \
 	SR(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL),                                  \
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
index c26ad0903975..f1ee2225e9b8 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
@@ -5,6 +5,7 @@
 #include "dcn60_soc_and_ip_translator.h"
 #include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
 #include "bounding_boxes/dcn6_soc_bb.h"
+#include "dal_asic_id.h"
 
 /* soc_and_ip_translator component used to get up-to-date values for bounding box.
  * Bounding box values are stored in several locations and locations can vary with DCN revision.
@@ -94,7 +95,10 @@ static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc
 static void dcn60_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	//get default soc_bb with static values
-	dcn6_test_initialize_soc_bb(soc_bb);
+	if (ASICREV_IS_DCN6_VARIANT_LITE3(dc->ctx->asic_id.hw_internal_rev))
+		dcn6b_test_initialize_soc_bb(soc_bb);
+	else
+		dcn6_test_initialize_soc_bb(soc_bb);
 	//get default soc_bb with static values
 	apply_soc_bb_updates(soc_bb, dc, config);
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 7ed785be8473..f4c6ddb6378e 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -275,6 +275,8 @@ enum {
 	DCN6_VARIANT2_B0        = 0x11,
 	DCN6_VARIANT3_A0        = 0x20,
 	DCN6_VARIANT3_UPPER     = 0x2F,
+	DCN6_VARIANT_LITE3_A0   = 0x50,
+	DCN6_VARIANT_LITE3_B0   = 0x51,
 	DCN6_UNKNOWN		= 0xFF
 };
 
@@ -284,6 +286,9 @@ enum {
 #define ASICREV_IS_DCN6_VARIANT2_A0(eChipRev)     (eChipRev >= DCN6_VARIANT2_A0 && eChipRev < DCN6_VARIANT2_B0)
 #define ASICREV_IS_DCN6_VARIANT2_B0(eChipRev)     (eChipRev >= DCN6_VARIANT2_B0 && eChipRev < DCN6_VARIANT3_A0)
 #define ASICREV_IS_DCN6_VARIANT3(eChipRev)        (eChipRev >= DCN6_VARIANT3_A0 && eChipRev <= DCN6_VARIANT3_UPPER)
+#define ASICREV_IS_DCN6_VARIANT_LITE3(eChipRev)    (eChipRev >= DCN6_VARIANT_LITE3_A0 && eChipRev < DCN6_UNKNOWN)
+#define ASICREV_IS_DCN6_VARIANT_LITE3_A0(eChipRev) (eChipRev >= DCN6_VARIANT_LITE3_A0 && eChipRev < DCN6_VARIANT_LITE3_B0)
+#define ASICREV_IS_DCN6_VARIANT_LITE3_B0(eChipRev) (eChipRev >= DCN6_VARIANT_LITE3_B0 && eChipRev < DCN6_UNKNOWN)
 
 enum {
 	GC_12_0_0_A0 = 0x50,
-- 
2.43.0

