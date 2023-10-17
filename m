Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE9CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0087E10E2E2;
	Tue, 17 Oct 2023 12:46:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5A810E2E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLCUEsfdJn4CXWqbPakNo6UMcD0SYFPJfAZdqkAh5ZcjuwmmO1B0XVWh/BQgP3o5r3Y3533maVK4xnxZoSHHd9D4WnYvcI/WHUB+Hcm7hNhERyLRHlhhZSRb+jQPhq5x9NaqB/6Z5LOmOiIUD4bse0ZS3hqZs5MX57adfo+Kdfz/lA/cRRXz04y4MZYOLpno3JXpwJIAmmTHNwxmViXkxRRV/54nzsBzi4ifJFzbrqoNoSF5OVIH/0WNd9IvKdr1K0cGzxjp8HRyS0qGULnutq5Ri9KjvFe2l9i+Se5Yu1j3JooCga21+1HBHEeM/UTqmgMDLm2QchguxN89nZKINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3GgUN5uGOf6QozgnFL0b1i5eAcD2vEQl7Q4pyh1e8A=;
 b=iNQOOWmhXG7keMGFfYTPscacj3FCFg2AKKROYQqflbRE1DbzP33Sj5l6M+HzhzsOUkc40g+1g5yKT+PtAmfQI7s59Ym6Aq8tNP44YguykqRoL7aoGX2p/UPy0VTyuXTQQ9a2aR+P2ngH16qC/edkU5f4i/w6AFVWBXprXjx7umRW9twQSy8fPmpRs8BSCJM2opl/zZNLmQ87G5m1Gft8aCEvW5VycvsYtO5kzIij7Q4ouAxpkgSNWvd239Nn7tDx4PDt5sWHMcbgyF3deWRe2rzh8i1Nujo+5awDKgczZLc4KwbxYvJ4yDKzpm6Zjtm96XxS7bYhVY4j/le2jwDPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3GgUN5uGOf6QozgnFL0b1i5eAcD2vEQl7Q4pyh1e8A=;
 b=iSvEyCnUgGaBpm86MvaWCUhw95OX/anKPjGq6VkUlpWt7oTq4ntpA+FVlGIGXIz24H8KY2tkTO8tQy1WgJrkoFwwq0CSfOr2ZXImX+aRWnUsysGYDLdYYiRVgSDqakRa3zvNWEZHrr4xCrGryfQu+yYZPTFEUJuKdGD1fscJKU8=
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 12:46:19 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::fb) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.5 via Frontend Transport; Tue, 17 Oct 2023 12:46:18 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:16 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: drop status reset for GCEA 9.4.3 and MMEA 1.8
Date: Tue, 17 Oct 2023 20:45:52 +0800
Message-ID: <20231017124552.27509-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231017124552.27509-1-tao.zhou1@amd.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d32552-38e4-44bd-5123-08dbcf0f0f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjJ5mtJ7KXgU7Sgg+rMpJ5318QFVhFGnvFAMrqxCcFTiDPPH/Z1ayW2JOQlKRd1/u8177bp9jnZBSWmU5Fid0F7i4xWN4b+kZ4c+jZQSZGqKbUVkus/f9RSc5gqdpjqTpqhe6gwns/mESLY67y0pDfKuHsM5RE/9OoItq/CEJ5nOYBdTuwM87JngC+pGOSmZHH9bvlaWkxRl17AKdz945y1zsTZGQdD2PCV1qhPX8RUzVAh+yxHzklaxggpacJKjFFH8WK3oIu55abc6zH7f79vaTSVX+eoFz5pxqO/39qo4ChQ8DgKED+pqDH0mvInQEQ00Y6nF8MH2Tbkp26ZYQ2BmSee2rTq1ZKMVM6tuD5RmE+ihoXKYK8Socqql6rYmXCVypogx6lElhu9eok4K36OBMRLJQ3cPm4LZGvb46BW6jZfUiz7Gdr3fNErgBTAoP38QNBxFX0awOFIXkhnnDqLa3qsXg1oycifty754Z+j57hsuW1O/nkUxm3NYsreVSwoAUQYwgWmgEJqmsPdXsp4M0VZmaPS2gmXp3v7Es75hrV8xnFfWxnxHJlA5j5LAPJBColQDVTStGQmiRyC8bDd2oMGfeN0W6pBBwjbXzboKzNh7+JksgGedigL90F2xDGIANNIDYTR84szpxxR7zonW2iX4WQIlm0bKwCZ34TYdkUHT6uSQSjj09GVSSAnyCVsWNLR715p9yZ5nEyWehovSBKCidDZiwkqH8b/2JSk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(1076003)(478600001)(41300700001)(4326008)(8936002)(110136005)(70206006)(70586007)(316002)(6636002)(8676002)(5660300002)(7696005)(40480700001)(47076005)(81166007)(86362001)(82740400003)(356005)(2616005)(426003)(36860700001)(26005)(36756003)(336012)(16526019)(83380400001)(6666004)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:18.9154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d32552-38e4-44bd-5123-08dbcf0f0f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW will be responsible for it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 22 -------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 86 -------------------------
 2 files changed, 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a1c2c952d882..65da72735e52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3996,27 +3996,6 @@ static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS, 0x3);
 }
 
-static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t i, j;
-	uint32_t value;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j++) {
-			gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
-			value = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS);
-			value = REG_SET_FIELD(value, GCEA_ERR_STATUS,
-						CLEAR_ERROR_STATUS, 0x1);
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS, value);
-		}
-	}
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-			xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-}
-
 static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device *adev,
 					int xcc_id)
 {
@@ -4042,7 +4021,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
 	gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
-	gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
 	gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index aa00483e7b37..616d75add087 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -756,96 +756,10 @@ static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_query_ras_err_status(adev, i);
 }
 
-static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
-						 uint32_t mmhub_inst)
-{
-	uint32_t mmea_cgtt_clk_cntl_addr_dist;
-	uint32_t mmea_err_status_addr_dist;
-	uint32_t reg_value;
-	uint32_t i;
-
-	/* reset mmea ras err status */
-	mmea_cgtt_clk_cntl_addr_dist = regMMEA1_CGTT_CLK_CTRL - regMMEA0_CGTT_CLK_CTRL;
-	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
-	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) {
-		/* force clk branch on for response path
-		 * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 1
-		 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_CGTT_CLK_CTRL,
-						i * mmea_cgtt_clk_cntl_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-					  SOFT_OVERRIDE_RETURN, 1);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_CGTT_CLK_CTRL,
-				    i * mmea_cgtt_clk_cntl_addr_dist,
-				    reg_value);
-
-		/* set MMEA0_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_ERR_STATUS,
-						i * mmea_err_status_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
-					  CLEAR_ERROR_STATUS, 1);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_ERR_STATUS,
-				    i * mmea_err_status_addr_dist,
-				    reg_value);
-
-		/* set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 0 */
-		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-						regMMEA0_CGTT_CLK_CTRL,
-						i * mmea_cgtt_clk_cntl_addr_dist);
-		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-					  SOFT_OVERRIDE_RETURN, 0);
-		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-				    regMMEA0_CGTT_CLK_CTRL,
-				    i * mmea_cgtt_clk_cntl_addr_dist,
-				    reg_value);
-	}
-
-	/* reset mm_cane ras err status
-	 * force clk branch on for response path
-	 * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 1
-	 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-				  SOFT_OVERRIDE_ATRET, 1);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-
-	/* set MM_CANE_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ERR_STATUS,
-				  CLEAR_ERROR_STATUS, 1);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS, reg_value);
-
-	/* set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 0 */
-	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-				  SOFT_OVERRIDE_ATRET, 0);
-	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-}
-
-static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device *adev)
-{
-	uint32_t inst_mask;
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-		return;
-	}
-
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask)
-		mmhub_v1_8_inst_reset_ras_err_status(adev, i);
-}
-
 static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops = {
 	.query_ras_error_count = mmhub_v1_8_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_8_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v1_8_query_ras_error_status,
-	.reset_ras_error_status = mmhub_v1_8_reset_ras_error_status,
 };
 
 struct amdgpu_mmhub_ras mmhub_v1_8_ras = {
-- 
2.35.1

