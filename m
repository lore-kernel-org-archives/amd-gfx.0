Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01359C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860E510E478;
	Thu, 28 Apr 2022 21:30:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F10610E1A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIolQXxiNPMbLr5xDh+UT9n9oP1au/VDsONGMfBmCSdsigVkwes9g0eE62HEToJ2sZmCmKrW2mu/t9o+kE9UKTlZ0zRtUKHMO7fQGY/AbpaAtB5I4Wh078uuYQWkM5tN9P4OIdor54Ow+fvZ33tsPT5pOqkqZsQqngMtRPQnWAfZNV3Vi5TFfSovksRu4UqViqNvbVszzmA7gV7yItvbqzdsmosKq6uu5XZQeEUPy6sSAXjIWXN052y7OF0rAqqG0S1CeOwhDAtssZNXiNRIWHqIKnXABDj0EHhjaHxWOyStS0VqkU28HWZ6MurH8BtwncdM5Omx+q0LUGAwFOq5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JprGHf17x4bYgA/Em/3umtng5bboIIGe4TzN96fr6lw=;
 b=ZXj/GKHu3pNYMiah+VzTloRkqh0sg5C340oXmm61S8SqzGIDHzpdENGRY9rNaD6Y+1yPjZ7KWDA8tkiumHyh1JTIa4B/Rv5jHKRt1Kqb+aSt6VqyjO9i5YzSeWBasr4ULU804ks8wwSyHvK7w28nuibNYNAzIfdlF7aiXCwE7o3LzwBQxCg8E6Awh6lqqkQc3qQVHjYYDCWGjxhY202wz9GxF3jHWhLaQ3L94df13DQbenT2TComhyp6d64CaCq6FUsg+F4WgSuGx+cxSfESFegYVxyEofBPCM2XJcLbWHZR8gWMowUKllXhkBwlaoI8ltoNi8+42d7pi8qDGCqJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JprGHf17x4bYgA/Em/3umtng5bboIIGe4TzN96fr6lw=;
 b=TxGKlVUEJyaJgCKgPR8Ao/YRWvJAtKplqVule7IacOLHowZ2q3jzJDiC1j4pD7KcCZ/zMsl2I/u1jkB+H/qN3vUSVOxnqG4drFSptg1hjFdHbkFjGCLkUFOzcCP2j+9vC9skBkcuo6IKtZESGkvMP+WJq6J0AWPdhosiBSHwDJE=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 21:30:01 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ac) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:29:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add updated smu_info structures
Date: Thu, 28 Apr 2022 17:29:36 -0400
Message-ID: <20220428212946.700296-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbc9d51-f3d9-42b9-5489-08da295e404e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5283:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5283A438136072EB8FE9A7B4F7FD9@CH0PR12MB5283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oj3UEW0c3UtM6C6941KAeyBcM1ZtgWkl5w2V8mJb9YMqpKW4ngHUnB1AgHFXDIFrlzWKKoY1SFpPrhiIZ3V3RwwRLYn1b4JpjGTDG+JQqEUCBtEtU3Bl0AeW+YymfLPrHW5MMh/tmG5Ag2fu+dwJ9r3Cd2Rapn0qWDI4GHJd7vlBdaaQxkOjT0LpWZ063sf20n4Veux+NaNclXLl1MMaG9ZcTwqmJV0e9+r/J4Ttk3vXcgFpkqTjO1cO5qNt61P8wEtbxKpjmG2E2DQAKuxcOAJQIFZzisbTzjb2mXFF037mXEIB2B7FcHtjR4JE2qEiLZgiF3oM7u1CUpSG7W+njgxF5fsZGSUSRm7DrmLyLV3sYy0/Yn0DxSunL9NQ4AsnCW1CaBTD6wISesX1Eg+68iravQK0GG20Yu1eJwvEDskpZd9jYBJRBdz/uuKI/jq9NQ5DyAd7DlOpw8g8uhR96oPj7BjFEg246WcQw0PhMxhy9fsW/sQvTVKPzzWenUAwwPlDGHR24Qg6x37b2AAJiflxnGvsJzhiqLPWWUo6C23MDyyEUfNGNrbKibR9HZ1dMPHUJFdEXE+Jlj2XYiyesgBzh/Yta4CBr+eZ4wm5IQs6QW9oCLrqfocGpQ6WPvuglLSOdaNLqEh+QzxGJzg/fbE92Srq+VkQL8lqVzzkK754rnjcJ2EXDqgQbATDnmY/yHF2Arc9ML/Uip5wQgiEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(82310400005)(508600001)(2616005)(336012)(86362001)(426003)(47076005)(26005)(1076003)(356005)(81166007)(6666004)(316002)(36860700001)(70206006)(7696005)(2906002)(36756003)(5660300002)(16526019)(186003)(8936002)(70586007)(54906003)(6916009)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:00.5292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc9d51-f3d9-42b9-5489-08da295e404e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5283
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To match with smu v13_0_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index d516de41e6a9..ae8f6d299ed9 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1806,6 +1806,130 @@ struct atom_smu_info_v3_3 {
   uint32_t reserved;
 };
 
+struct atom_smu_info_v3_6
+{
+	struct   atom_common_table_header  table_header;
+	uint8_t  smuip_min_ver;
+	uint8_t  smuip_max_ver;
+	uint8_t  waflclk_ss_mode;
+	uint8_t  gpuclk_ss_mode;
+	uint16_t sclk_ss_percentage;
+	uint16_t sclk_ss_rate_10hz;
+	uint16_t gpuclk_ss_percentage;
+	uint16_t gpuclk_ss_rate_10hz;
+	uint32_t core_refclk_10khz;
+	uint32_t syspll0_1_vco_freq_10khz;
+	uint32_t syspll0_2_vco_freq_10khz;
+	uint8_t  pcc_gpio_bit;
+	uint8_t  pcc_gpio_polarity;
+	uint16_t smugoldenoffset;
+	uint32_t syspll0_0_vco_freq_10khz;
+	uint32_t bootup_smnclk_10khz;
+	uint32_t bootup_socclk_10khz;
+	uint32_t bootup_mp0clk_10khz;
+	uint32_t bootup_mp1clk_10khz;
+	uint32_t bootup_lclk_10khz;
+	uint32_t bootup_dxioclk_10khz;
+	uint32_t ctf_threshold_override_value;
+	uint32_t syspll3_0_vco_freq_10khz;
+	uint32_t syspll3_1_vco_freq_10khz;
+	uint32_t bootup_fclk_10khz;
+	uint32_t bootup_waflclk_10khz;
+	uint32_t smu_info_caps;
+	uint16_t waflclk_ss_percentage;
+	uint16_t smuinitoffset;
+	uint32_t bootup_gfxavsclk_10khz;
+	uint32_t bootup_mpioclk_10khz;
+	uint32_t smb_slave_address;
+	uint32_t cg_fdo_ctrl0_val;
+	uint32_t cg_fdo_ctrl1_val;
+	uint32_t cg_fdo_ctrl2_val;
+	uint32_t gdfll_as_wait_ctrl_val;
+	uint32_t gdfll_as_step_ctrl_val;
+	uint32_t reserved_clk;
+	uint32_t fclk_syspll_refclk_10khz;
+	uint32_t smusvi_svc0_val;
+	uint32_t smusvi_svc1_val;
+	uint32_t smusvi_svd0_val;
+	uint32_t smusvi_svd1_val;
+	uint32_t smusvi_svt0_val;
+	uint32_t smusvi_svt1_val;
+	uint32_t cg_tach_ctrl_val;
+	uint32_t cg_pump_ctrl1_val;
+	uint32_t cg_pump_tach_ctrl_val;
+	uint32_t thm_ctf_delay_val;
+	uint32_t thm_thermal_int_ctrl_val;
+	uint32_t thm_tmon_config_val;
+	uint32_t bootup_vclk_10khz;
+	uint32_t bootup_dclk_10khz;
+	uint32_t smu_gpiopad_pu_en_val;
+	uint32_t smu_gpiopad_pd_en_val;
+	uint32_t reserved[12];
+};
+
+struct atom_smu_info_v4_0 {
+	struct atom_common_table_header table_header;
+	uint32_t bootup_gfxclk_bypass_10khz;
+	uint32_t bootup_usrclk_10khz;
+	uint32_t bootup_csrclk_10khz;
+	uint32_t core_refclk_10khz;
+	uint32_t syspll1_vco_freq_10khz;
+	uint32_t syspll2_vco_freq_10khz;
+	uint8_t pcc_gpio_bit;
+	uint8_t pcc_gpio_polarity;
+	uint16_t bootup_vddusr_mv;
+	uint32_t syspll0_vco_freq_10khz;
+	uint32_t bootup_smnclk_10khz;
+	uint32_t bootup_socclk_10khz;
+	uint32_t bootup_mp0clk_10khz;
+	uint32_t bootup_mp1clk_10khz;
+	uint32_t bootup_lclk_10khz;
+	uint32_t bootup_dcefclk_10khz;
+	uint32_t ctf_threshold_override_value;
+	uint32_t syspll3_vco_freq_10khz;
+	uint32_t mm_syspll_vco_freq_10khz;
+	uint32_t bootup_fclk_10khz;
+	uint32_t bootup_waflclk_10khz;
+	uint32_t smu_info_caps;
+	uint16_t waflclk_ss_percentage;
+	uint16_t smuinitoffset;
+	uint32_t bootup_dprefclk_10khz;
+	uint32_t bootup_usbclk_10khz;
+	uint32_t smb_slave_address;
+	uint32_t cg_fdo_ctrl0_val;
+	uint32_t cg_fdo_ctrl1_val;
+	uint32_t cg_fdo_ctrl2_val;
+	uint32_t gdfll_as_wait_ctrl_val;
+	uint32_t gdfll_as_step_ctrl_val;
+	uint32_t bootup_dtbclk_10khz;
+	uint32_t fclk_syspll_refclk_10khz;
+	uint32_t smusvi_svc0_val;
+	uint32_t smusvi_svc1_val;
+	uint32_t smusvi_svd0_val;
+	uint32_t smusvi_svd1_val;
+	uint32_t smusvi_svt0_val;
+	uint32_t smusvi_svt1_val;
+	uint32_t cg_tach_ctrl_val;
+	uint32_t cg_pump_ctrl1_val;
+	uint32_t cg_pump_tach_ctrl_val;
+	uint32_t thm_ctf_delay_val;
+	uint32_t thm_thermal_int_ctrl_val;
+	uint32_t thm_tmon_config_val;
+	uint32_t smbus_timing_cntrl0_val;
+	uint32_t smbus_timing_cntrl1_val;
+	uint32_t smbus_timing_cntrl2_val;
+	uint32_t pwr_disp_timer_global_control_val;
+	uint32_t bootup_mpioclk_10khz;
+	uint32_t bootup_dclk0_10khz;
+	uint32_t bootup_vclk0_10khz;
+	uint32_t bootup_dclk1_10khz;
+	uint32_t bootup_vclk1_10khz;
+	uint32_t bootup_baco400clk_10khz;
+	uint32_t bootup_baco1200clk_bypass_10khz;
+	uint32_t bootup_baco700clk_bypass_10khz;
+	uint32_t reserved[16];
+};
+
 /*
  ***************************************************************************
    Data Table smc_dpm_info  structure
-- 
2.35.1

