Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B277C433E2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315E5207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eYtm8Qc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315E5207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001A16E8BE;
	Fri,  5 Jun 2020 11:02:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6056E8BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzTDSCm278FmrAp1+H/xSDOg2zWCRhuw9q238Fqe6nE2w6CdjnVJ46vyrT36GcWEim2nVSV1kLW5zJn2PnAW00a2TmbPsofKUydJHBsCMSWjRPENBDiTWxmSmIF+bq/r45JV0UnHiis/+lwe1vEcm1vweNjehbYBrtZa9b5oHJfHAg7cjRDMcR5qFoZQW50beBbiKLrBr0px5P6LnzefsxWfQA6QH3OtCJ0iC9GjtgpYmyvAJV27JwqwRV/TNJcWr8xodEvmRH8cHBH4MX41zAlEOvkqftz+SKPcWp4p2thfDp4C86jQ2zFcCF8UlTr8lwphqO57cuT2kBzfPBRc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukOcfrpYTEKtOWh1TjYOFBYovdmf5IJgEaZNCnbMVoo=;
 b=VSIRKiu6V2CNSfRh4b7ReBK2t70z913C2h7onUF23DMct/pppkt3GiyPz9ls2fdVnGIl61b4tzJReTdcN0SZGMrPzXegBxerymftxHAPHCmRMvnOQa8C2c97kYIeCNNoriJrfCQoiN68ioLQLo6WjU9Cv0oINrMB8oIv3fxA28WEsMETNZ3OwWOCvKkHgFGIg047dv+IHvkqB3XDI65usb8sML20Pouh/+CGssncJ/j8ohjV+uYc4UOb0cN8pAI6AsIfMTOSMUmvpNJrQY3epfzPF0fVPlRvn78Ih/YvqHygLrkYsx3t2mLPuzm4tyTyN22/lcg++kUt+XCuB16C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukOcfrpYTEKtOWh1TjYOFBYovdmf5IJgEaZNCnbMVoo=;
 b=eYtm8Qc/Z2GrZUuRfEFYuGxNY1fX7EN/Br19qUz9K8Y3K8I2uphgLIgXaa/ZCU1QcpOd5Zs5nRgN2/Eq2MAqgjRzVm38DBw+XKjNELR8TPve54k6JIB4pyTc5MpyLX23HPsimteBBftiswTynYrTSHn+3bQzcO50g0vluIM7B+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYASPR01MB2.namprd12.prod.outlook.com (2603:10b6:a02:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:02:44 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:02:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/powerplay: add error messages on some critical
 paths
Date: Fri,  5 Jun 2020 19:02:00 +0800
Message-Id: <20200605110200.27206-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605110200.27206-1-evan.quan@amd.com>
References: <20200605110200.27206-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To BYAPR12MB2615.namprd12.prod.outlook.com
 (2603:10b6:a03:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.7 via Frontend Transport; Fri, 5 Jun 2020 11:02:42 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82b7e121-6613-45b9-5a7e-08d8093ff90c
X-MS-TrafficTypeDiagnostic: BYASPR01MB2:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB20E117E16271B2358FE69E4860@BYASPR01MB2.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHYmEzSMzHSrXRgdxhW8DdCjGKP0HsB5uy62A7DzLfKb/BTESGWgzGUvcV7LrZbVzO2bNjR2aix8j4hJd6lEdxm2gAVRWw/zxlepXEEKVEx8mtHeyBqQll3xXN+Dgs9oS5VilYqJ1bs3RDjjSp3LLAaJUfaKycnwBMM2Y/rM4aDIEgOdENSixpni2PimNV+MVkIVPOYPpAvOa4MbOpwqVFJKzAdeoJO147U6SUEXL1PWuZ+k9Wxy8mmUvZtHvL6awwMLhbfFcpEwrPR3Fsf83xEG4ET6VZt4UoQbjisNwuI28IDWWmaZvPPrxZtjiaY3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4326008)(8676002)(15650500001)(83380400001)(2616005)(1076003)(956004)(8936002)(6486002)(186003)(6666004)(6916009)(2906002)(16526019)(478600001)(66556008)(66946007)(26005)(36756003)(19627235002)(66476007)(5660300002)(52116002)(86362001)(66574014)(316002)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: A6ejLpLa1jzVpcIkdBNb/8HtFMI9pSHfRNiGAhjIOFH7Jixxsp0sKS2aKhnoRKfv/caJSn24EQT7TJVJafKRU3jvKTDefANpnupWhwUB5/dFVdol8Vn9HHUfIZRVBKgj9gvO4sOBhOZxA65JilNizElS4GLTGa+WKOdnNezsOYlG+CbKLl1WuXXw2qzfNeD/n0c97zPDUzX7mjyxmokqqdnBhiO/8t9PMhlHQ6tb1n89Ike6f18OWfv03cIMXqFJinbpiAzVqsVSg8qsIvX9IjEusyxqHkCLbb0K4C2SPQYKif+IlocoshVuHutdHQREhv1c6TuMaXILpAL7HoHjjYFPemDO8B5wfld+1oEu+YlmU/Y+du0oATg7GU2Fm7Hqxwa/WWrmOwNKH1S4k0agdjlMm97gJfUAV2JAtYkgnRG1nn7UHtjleO0k3VzTI65ONePly8gzBDwUbUf5TKDLMmoshgMGC5WKjqqEB7ng0qyu/0YTH+D04G8ovJqstFa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b7e121-6613-45b9-5a7e-08d8093ff90c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:02:44.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUDoDIviE18bEtcmOpidwq5xGAhdN5DtBJGjnbTi4IMHzgyyP3r3p7ymIF/3FXVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB2
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Helpful for error diagnostic.

Change-Id: I983ca308a2ee6ed11e16ec59ad97040d98b90512
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 118 +++++++++++++++------
 1 file changed, 87 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 0c5e062a21a7..11538477da93 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -457,18 +457,30 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 		ret = smu_dpm_set_uvd_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s UVD!\n",
+				gate ? "gate" : "ungate");
 		break;
 	case AMD_IP_BLOCK_TYPE_VCE:
 		ret = smu_dpm_set_vce_enable(smu, !gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to %s gfxoff!\n",
+				gate ? "enable" : "disable");
 		break;
 	case AMD_IP_BLOCK_TYPE_SDMA:
 		ret = smu_powergate_sdma(smu, gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s SDMA!\n",
+				gate ? "gate" : "ungate");
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
 		ret = smu_dpm_set_jpeg_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
+				gate ? "gate" : "ungate");
 		break;
 	default:
 		break;
@@ -788,8 +800,10 @@ static int smu_late_init(void *handle)
 		return 0;
 
 	ret = smu_set_default_od_settings(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup default OD settings!\n");
 		return ret;
+	}
 
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
@@ -797,20 +811,28 @@ static int smu_late_init(void *handle)
 	 * type of clks.
 	 */
 	ret = smu_populate_smc_tables(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
 		return ret;
+	}
 
 	ret = smu_init_max_sustainable_clocks(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
 		return ret;
+	}
 
 	ret = smu_populate_umd_state_clk(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
 		return ret;
+	}
 
 	ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to get default power limit!\n");
 		return ret;
+	}
 
 	smu_get_unique_id(smu);
 
@@ -954,6 +976,8 @@ static int smu_alloc_memory_pool(struct smu_context *smu)
 					      &memory_pool->bo,
 					      &memory_pool->mc_address,
 					      &memory_pool->cpu_addr);
+		if (ret)
+			dev_err(adev->dev, "VRAM allocation for dramlog failed!\n");
 		break;
 	default:
 		break;
@@ -1147,27 +1171,35 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	}
 
 	ret = smu_init_display_count(smu, 0);
-	if (ret)
+	if (ret) {
+		dev_info(adev->dev, "Failed to pre-set display count as 0!\n");
 		return ret;
+	}
 
 	ret = smu_set_driver_table_location(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to SetDriverDramAddr!\n");
 		return ret;
+	}
 
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
 	ret = smu_set_tool_table_location(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to SetToolsDramAddr!\n");
 		return ret;
+	}
 
 	/*
 	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
 	 * pool location.
 	 */
 	ret = smu_notify_memory_pool_location(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to SetDramLogDramAddr!\n");
 		return ret;
+	}
 
 	/* smu_dump_pptable(smu); */
 	/*
@@ -1175,8 +1207,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 * SetDriverDramAddr and TransferTableDram2Smu.
 	 */
 	ret = smu_write_pptable(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to transfer pptable to SMC!\n");
 		return ret;
+	}
 
 	/* issue Run*Btc msg */
 	ret = smu_run_btc(smu);
@@ -1184,12 +1218,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 
 	ret = smu_feature_set_allowed_mask(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to set driver allowed features mask!\n");
 		return ret;
+	}
 
 	ret = smu_system_features_control(smu, true);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
 		return ret;
+	}
 
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
@@ -1199,8 +1237,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 
 	ret = smu_enable_thermal_alert(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable thermal alert!\n");
 		return ret;
+	}
 
 	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
 	if (ret)
@@ -1284,7 +1324,7 @@ static int smu_hw_init(void *handle)
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-		dev_err(adev->dev, "SMU is not ready yet!\n");
+		dev_err(adev->dev, "SMC engine is not correctly up!\n");
 		return ret;
 	}
 
@@ -1300,29 +1340,32 @@ static int smu_hw_init(void *handle)
 
 	/* get boot_values from vbios to set revision, gfxclk, and etc. */
 	ret = smu_get_vbios_bootup_values(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to get VBIOS boot clock values!\n");
 		return ret;
+	}
 
 	ret = smu_setup_pptable(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup pptable!\n");
 		return ret;
+	}
 
 	ret = smu_get_driver_allowed_feature_mask(smu);
 	if (ret)
-		goto failed;
+		return ret;
 
 	ret = smu_smc_hw_setup(smu);
-	if (ret)
-		goto failed;
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup smc hw!\n");
+		return ret;
+	}
 
 	adev->pm.dpm_enabled = true;
 
 	dev_info(adev->dev, "SMU is initialized successfully!\n");
 
 	return 0;
-
-failed:
-	return ret;
 }
 
 static int smu_disable_dpms(struct smu_context *smu)
@@ -1395,13 +1438,15 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 
 	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
-		dev_warn(adev->dev, "Fail to stop thermal control!\n");
+		dev_err(adev->dev, "Fail to disable thermal alert!\n");
 		return ret;
 	}
 
 	ret = smu_disable_dpms(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Fail to disable dpm features!\n");
 		return ret;
+	}
 
 	return 0;
 }
@@ -1493,13 +1538,15 @@ static int smu_resume(void *handle)
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-		dev_err(adev->dev, "SMU is not ready yet!\n");
-		goto failed;
+		dev_err(adev->dev, "SMC engine is not correctly up!\n");
+		return ret;
 	}
 
 	ret = smu_smc_hw_setup(smu);
-	if (ret)
-		goto failed;
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup smc hw!\n");
+		return ret;
+	}
 
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
@@ -1511,9 +1558,6 @@ static int smu_resume(void *handle)
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-
-failed:
-	return ret;
 }
 
 int smu_display_configuration_change(struct smu_context *smu,
@@ -2589,6 +2633,9 @@ int smu_set_xgmi_pstate(struct smu_context *smu,
 
 	mutex_unlock(&smu->mutex);
 
+	if(ret)
+		dev_err(smu->adev->dev, "Failed to set XGMI pstate!\n");
+
 	return ret;
 }
 
@@ -2660,6 +2707,9 @@ int smu_baco_enter(struct smu_context *smu)
 
 	mutex_unlock(&smu->mutex);
 
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
+
 	return ret;
 }
 
@@ -2677,6 +2727,9 @@ int smu_baco_exit(struct smu_context *smu)
 
 	mutex_unlock(&smu->mutex);
 
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
+
 	return ret;
 }
 
@@ -2694,6 +2747,9 @@ int smu_mode2_reset(struct smu_context *smu)
 
 	mutex_unlock(&smu->mutex);
 
+	if (ret)
+		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
