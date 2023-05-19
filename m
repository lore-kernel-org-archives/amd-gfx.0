Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69737C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 10:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013D410E080;
	Fri, 19 May 2023 10:59:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B5610E080
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 10:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juHo79+s7ap7bn4hXVfetkps/Kq0jRs7LYaR69MKEkvLG2F0zy3bp5lwrQiA40GO9xxSWwvZg3hqiCvMly10STvu9EyZoRObgQacDflhcZaSzD6d4fjMnif2kdx6C9olxH5Dtbpy9ed0zC6qVfrLrTAnMWWASWqS/X+TAwez/YFUei0SuELbkojZQqX6rRgAeavi/W+qE+oMgLeX4VjLUrzFmr3sdMeeqM3nzHxHMGmjY7rioDMyXXeyRjllRmkm8BrWt6Bw9oqm7hslfEY594FKAxk4xyJlTnxKMLUl1rJc6lIh23NuFpfBMfg7PEjKhI6nA81AYkeRiV27HdyqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oPRhGGv16gVu1tQuUMBToLnpLej2apwvIutYycNZaM=;
 b=Wz0mRmRsedM3F2BIsW3CpJ17hhJnp1/GwaXvnHcghJ5pSCL4XJHDG3oSD+0rCF5BIDYfPIMc2nq5CWxKeqasP7/0F8kr/xPAnM7UbWW6R+EQ0ncekrMYQYiwI2U3LLzwj6UwOZs6FjHXzkG/MOfGnUaXLNBF4t4STPGtvHxuPfiQHuWKdwsL//SSjjwnqsoZ40gFZbpChnJIka7UbM8ZmnRWs+uobPWkLHpU6jmFmmmyAqUruL2C6PJNtWMwrSXRHDpka9OvVDLhKb3q2Xx1d23VlpxYQxrpCuBEtzVpv8VSTXjvSFZ+3SOHoRdgQGzvQRp5jygldK73Lg5WwIr9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oPRhGGv16gVu1tQuUMBToLnpLej2apwvIutYycNZaM=;
 b=rUvKYnOL7kLuDEqtfLpiwPW85hBYCvUhTY0gxxz0s8TtforCvsfVSyPujH2nUOjxUWWklvHBwHBo72JHPwXwh2GK5HXFGMZbtHd69kBsNZayu1B1z9FaGiD1X3GwZD1GmCzPIBRgvp24azUwiBQHGPQleOybArFr33/85Shl8pw=
Received: from DS7PR03CA0348.namprd03.prod.outlook.com (2603:10b6:8:55::8) by
 DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 10:59:12 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::24) by DS7PR03CA0348.outlook.office365.com
 (2603:10b6:8:55::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 10:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 10:59:11 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 05:59:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix errors & warnings in mmhub_v1_8.c
Date: Fri, 19 May 2023 16:28:52 +0530
Message-ID: <20230519105852.247254-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb99f3a-a48f-4d12-caa8-08db58581402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDThy3dO7gnR94V7pP7NxrOd2u2lZXSX91nAea9VC4zRQ+u5WXqL6G98Nr2MH5TlGJtX/cEx5G6TJo/FeEyzdVHCGOnmAzOlcIbtZjX8gOdHppE8HtINqR/XlwNZngV3OsZ3+CpW26ab24io0kcNPQgSGy7EvZHepQwf02BymIHb4U2qPsgMaDps+4hcPPJ6ifHeg9kXtlLECYjupz1LY6yLdCIL8sUtmakJIMiIz9ZVkF4FXVYGHl/tyw9Rdwiy0tZnLc4doCw2sTs7+BLmVByz6XGYLyG83/LHw6Du+FsQP+DAfSvkHf+PSos+E72V98MdZcshd+CysUYAawivarfXj6YUqpKT+KEu5wTMErc1yF9w+vwQVPL7PHBDzZV9lydZeIOQC5Z7wTKVOKlEOllpmei+HX9qFL3R5D21imAKphigHafK5aMG+QP6KJzg68kqtbaQ79B/3lBmJ7ybFRp98n1sCxgfRSVqGYerrHVZcnhAaB1SeJUjnmGu6DNcRgIIC/dnuVmx5Bzehy9fw3dQGplr9hoGxE5TmAcfySrLTbGKr/nH6EyMZqe6dPAXSnRNNw2OYRIaDrnrFDo/X/R7plbULw4yyXNUz3a0H1PewI0LLbAuCy5iRf5PNKoh71jDLWyL8wocOWdxn7cNJ7/bgWjuUJ4vd0hHLgc85shyPRGlK2sO/AMdrTjb/E5HfoOOXz43eJmHvaR+IJ3k8Bp3KucFQo6+WbQC5ZT9/WglUo8WAov4lBLh7pmTymMBHYDl/51KAq3ZNjFHg3E5OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(70586007)(82740400003)(54906003)(110136005)(44832011)(2906002)(5660300002)(86362001)(41300700001)(36756003)(6636002)(356005)(316002)(81166007)(82310400005)(4326008)(8676002)(8936002)(70206006)(40480700001)(478600001)(336012)(426003)(36860700001)(83380400001)(2616005)(186003)(16526019)(47076005)(66574015)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 10:59:11.8369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb99f3a-a48f-4d12-caa8-08db58581402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below errors & warnings reported by checkpatch:

ERROR: code indent should use tabs where possible
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
ERROR: space prohibited before that '++' (ctx:WxB)
WARNING: Block comments use a trailing */ on a separate line

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3648994724c2..8600e42434e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -271,7 +271,7 @@ static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
 		}
 		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL4, tmp);
- 	}
+	}
 }
 
 static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
@@ -328,7 +328,7 @@ static void mmhub_v1_8_disable_identity_aperture(struct amdgpu_device *adev)
 static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
-	unsigned num_level, block_size;
+	unsigned int num_level, block_size;
 	uint32_t tmp, inst_mask;
 	int i, j;
 
@@ -776,9 +776,10 @@ static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
 	/* reset mmea ras err status */
 	mmea_cgtt_clk_cntl_addr_dist = regMMEA1_CGTT_CLK_CTRL - regMMEA0_CGTT_CLK_CTRL;
 	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
-	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i ++) {
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) {
 		/* force clk branch on for response path
-		 * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 1 */
+		 * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 1
+		 */
 		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
 						regMMEA0_CGTT_CLK_CTRL,
 						i * mmea_cgtt_clk_cntl_addr_dist);
@@ -814,7 +815,8 @@ static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
 
 	/* reset mm_cane ras err status
 	 * force clk branch on for response path
-	 * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 1 */
+	 * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 1
+	 */
 	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
 	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
 				  SOFT_OVERRIDE_ATRET, 1);
-- 
2.25.1

