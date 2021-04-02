Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA92C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53625610E7
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53625610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C2C6EE0A;
	Fri,  2 Apr 2021 06:44:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DE66EE0B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zw/EsvK1w7u7T2MxGulSNk8NO+nFK/ZkXmKJ8/ObxnR838KJ1rhnR1Rd0u20hKEZ/FFeZiGrv+jBEzfe7pwy6KS6IbWkuqjIFxVaqQQSJF3x6jnWjslRIYSBPiCyGiQINbUdZ+fkBxvUMGO+mCXB9ygNxjJx/u/SIAevkyBgS/9HxOURSZs8Ntn+XgduCNT9gwWgcnolbHVLZb/OO+11eaThFqG3vs2oxa1FlYQ1f3FazOJZVb24jvXriAD9qawU5dRMRo5rs1NRE1oOZk/7MJFfWEpj3ePvKy1p2+vjLempCudXpJ/a5x3YPgguzXPpthZ177ZI7XLguAle23LzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vib2mSgD0K24k9YK7e2M/bDOYwMbnkoeGZpfVVajPvo=;
 b=N4jTtcwEfo1t57N/safdIgdcy1e8YKRB1OwSlDIOHF2iLwjRj6X0WA7Rwu7wImSOYCtvhSDq2IgVOQprG/GX4ugZ9/QEngdHAiMVBdrHQoOCGzUXYwUmfG76L8ywNKfTnYaYYpDFefKd7HIEJ7DoXCiGIXNE0kXFiG2sz2EYsGISyoD1AzrOpZKXSiKvWmamfwKKeT15ojK0tPmrtL8s/Ab3Iq6C1stfEQRE4rsWtygMORAItaZ5qZ2f9VvQNfB9PLsQia54aFxerE7fpKFT1R3fc6ct3KswmmSkDy3kANd7x8xyetT0XF5EO3dtxOT9fcQxttY9BXz5igBiamccJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vib2mSgD0K24k9YK7e2M/bDOYwMbnkoeGZpfVVajPvo=;
 b=oVqdldkZ+OjwwRgmXrEtMpsNZ/002N+fkl1BiWkjO0dnEWO1uo7jmkLG/BJ6pY1UBYSyBr9IqczXxKh9fhedZpNm9KWVNU49KozI5RteNCgL8PdN0+G6UpQKp1My1COSY432fEnXcLVcKkOiYGdGWUd+y6H8uF06szhVNTUOm5A=
Received: from BN6PR20CA0060.namprd20.prod.outlook.com (2603:10b6:404:151::22)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 06:44:01 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::2b) by BN6PR20CA0060.outlook.office365.com
 (2603:10b6:404:151::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:00 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:43:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu: implement umc query error count callback
Date: Fri, 2 Apr 2021 14:43:38 +0800
Message-ID: <20210402064345.14093-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd2fc89-0cbe-43d6-36a2-08d8f5a2b2f3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53439A65ADE4001316E18FC6FC7A9@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeXy9Dsz5ml3jfxv8aCFE5zjcBuXwsQXrSBWx3zwRoUYpF29TDP5t7HnrrzMe9MHoH1BZwEFVYo47dafnuk7boJdkHexTaXinq7yTivq3TrO6A5EmAD4mM/N1vf3Uw0KPFvu8SeT+7SHrae4vMmP/hIWYPqQYC9gPwfz+3g8shBU3e13jb3APP7aB9CZy1Evn7Ccf7Rxvk2glkUhtZ4SFuVibgELqpBOLRkw7mv4nZ2Mg9fs0ukPxHVheCG9xTspGAa6QVBNI/ejLv8Jqra1jTJf1hOHWx+MRaga7yp4rv9dSWbuwEvW0ZWQDYTqGa8TbQd4ynPlovNfIFt0J+YHCLCDGjwwMKmzIiZ60W3LSbeA7i6onbgCxMHD6DYLl97/7SPHH8jYEHANQe2lP7UKAqDU8HTAa/qpjJrcw3NPXyZw/5mdU8IpAb6nbr4IYwpfkY8IpRxx/XN8I0S8hW9P/Z1frQum6R5CpeCZY5LWT5arEWdsvK0gUhAW4VUwt9iBBvPMr9OzRHz8wziY8E8zPJqmGN0AQfLMpWg0St3G6XFETLXkPfFpbRS098EmE5BL+0/FJo1ZVdPw/rmnZlAgTvr5XxgotMfuaG3r7X90RVqIaDIE4eV03u2y3F5WwyP45qYiWXaKIO03jVsfLR7qZVJM5gEOQ0Lg4245pTH/1sqFKRz0NYe62Usylkv8k0O0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(6666004)(478600001)(70586007)(426003)(186003)(4326008)(6636002)(70206006)(2616005)(47076005)(1076003)(86362001)(8936002)(7696005)(356005)(110136005)(81166007)(8676002)(2906002)(83380400001)(36860700001)(316002)(36756003)(5660300002)(82740400003)(336012)(26005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:00.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2fc89-0cbe-43d6-36a2-08d8f5a2b2f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

umc query_ras_error_count will be invoked to query
umc correctable and uncorrectable error. It will
reset the umc ras error counter after the query.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 90 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  2 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 05fec10b1ed9..fe666ac93b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -27,6 +27,13 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
+					      uint32_t umc_inst,
+					      uint32_t ch_inst)
+{
+	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
+}
+
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
 						   unsigned long *error_count)
@@ -94,6 +101,89 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 		*error_count += 1;
 }
 
+static void umc_v6_7_reset_error_count_per_channel(struct amdgpu_device *adev,
+						   uint32_t umc_reg_offset)
+{
+	uint32_t ecc_err_cnt_addr;
+	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+
+	ecc_err_cnt_sel_addr =
+		SOC15_REG_OFFSET(UMC, 0,
+				regUMCCH0_0_EccErrCntSel);
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0,
+				regUMCCH0_0_EccErrCnt);
+
+	/* select the lower chip */
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr +
+				       umc_reg_offset) * 4);
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel,
+					UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 0);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
+			ecc_err_cnt_sel);
+
+	/* clear lower chip error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V6_7_CE_CNT_INIT);
+
+	/* select the higher chip */
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr +
+					umc_reg_offset) * 4);
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel,
+					UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 1);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
+			ecc_err_cnt_sel);
+
+	/* clear higher chip error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V6_7_CE_CNT_INIT);
+}
+
+static void umc_v6_7_reset_error_count(struct amdgpu_device *adev)
+{
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							 umc_inst,
+							 ch_inst);
+
+		umc_v6_7_reset_error_count_per_channel(adev,
+						       umc_reg_offset);
+	}
+}
+
+static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	/*TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC registers. Will add the protection */
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							 umc_inst,
+							 ch_inst);
+		umc_v6_7_query_correctable_error_count(adev,
+						       umc_reg_offset,
+						       &(err_data->ce_count));
+		umc_v6_7_querry_uncorrectable_error_count(adev,
+							  umc_reg_offset,
+							  &(err_data->ue_count));
+	}
+
+	umc_v6_7_reset_error_count(adev);
+}
+
 const struct amdgpu_umc_funcs umc_v6_7_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
+	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 6b881226b4f3..e59dbdb6ef9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -30,6 +30,8 @@
 /* umc ce count initial value */
 #define UMC_V6_7_CE_CNT_INIT	(UMC_V6_7_CE_CNT_MAX - UMC_V6_7_CE_INT_THRESHOLD)
 
+#define UMC_V6_7_INST_DIST	0x40000
+
 extern const struct amdgpu_umc_funcs umc_v6_7_funcs;
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
