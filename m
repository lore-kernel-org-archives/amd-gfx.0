Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B647C2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 05:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0D0206E6
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cCx6ZlQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0D0206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 803AC89219;
	Thu,  2 Jan 2020 05:50:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B175089219
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 05:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1MNnRSf2kr/edFjDh5Pr81uL30qCxnxQVHmfDBSuCTOVvLkPH9mtEobVAhMbUsj4jQZ+5qNDku4hdSB+5Upi5vGC5KgPYVFxi6Qkj2sGuS6qAKUnOfhSb2cSQTR15JdfIYijhOavtYiUn1hC2NR8LTCqE3LNZXFfPsv4OlF2ftzhf9ZuvsC3lVYOKDCzLdn37PQZyYwNe9t9h8s5bTFymCQE8OQs8b5d41DICijSeeEradFFzigxMBekWWfreudUTNxib8ywzbo21nDSWHSVPuL0fgwKfpkWKU9XheoNqsTbXGHiSz7GxMjcEIS+N9OTmqUkhwZKzXPNAlnYuGDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY/hbhXngepTJRmJVwexfSiuJUO8HVGBPEtfRsG4gHE=;
 b=csv4FSIXsOXgS4pieJKAG+gU+TTLUaQsZxGYxUUb7Kyw5dG88Rq91bg/Xylqal418ny3Ol7L+FsmVXWfJa89rYVDRM8Kr85QzE/YXMnU8QLGoqbnxnqBGYUE/tyO+S60di9mcH+Wgo+JpRLrdujJOBQh/QEzMh1h9xY6Zut9gKn0g7XVvby+BGwDftJuDLEIjeg5Fk0KFKcmwQ1+qcLmQk8gfYvb4kBnQW6raLOAHYkzj1KkIjvhnm+t7jB8jNS0QsvAg66CNp00h/FAG/1mPizvzidoAPPBJamMCWCbRvn10/K0zb9zgvWAXjyC5+XTHEQk29c777ggqkgG+3MP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY/hbhXngepTJRmJVwexfSiuJUO8HVGBPEtfRsG4gHE=;
 b=cCx6ZlQhR33VgZN1BakNPnpkEInViXQGf/1k2sY4q5lC76TKF+OWPEIaBJe8+X9d/Uo/1Teo21rnmQVqCROu4/zu0HE6wNXqLuDvB9v2YIdTl1R8qCdQ60juHm0++jtowRnPXxgb+ju5lRe9ysdCbMayRO+03yN9E2hAftzr0G4=
Received: from CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34)
 by MWHPR12MB1405.namprd12.prod.outlook.com (2603:10b6:300:13::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Thu, 2 Jan
 2020 05:50:22 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by CH2PR12CA0024.outlook.office365.com
 (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Thu, 2 Jan 2020 05:50:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 05:50:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Jan 2020
 23:50:20 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Jan 2020
 23:50:20 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Jan 2020 23:50:19 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Date: Thu, 2 Jan 2020 13:50:16 +0800
Message-ID: <1577944216-32200-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(199004)(189003)(36756003)(70586007)(6666004)(356004)(70206006)(336012)(81156014)(2906002)(8676002)(81166006)(19627235002)(86362001)(7696005)(426003)(186003)(26005)(8936002)(2616005)(66574012)(478600001)(4326008)(5660300002)(6916009)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1405; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa31025-8eac-4995-fb49-08d78f47a7f1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1405:
X-Microsoft-Antispam-PRVS: <MWHPR12MB140533D3E5917CC4A29263DABB200@MWHPR12MB1405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-Forefront-PRVS: 0270ED2845
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYYrFVhWTJM3Q1buuBJDeUVxvdR07GfcM8JjOrrvRsuVE4iqQkmoEqZ5BrS0VUqDtlsnYupJBshMCJ+Wnku9CsbIJ7kM71UY1n3zaPiKWoHW/rBRcUz7bGHz82aSwi7OFMzvRFEz51xSebGQZ+L1M+c6vaUAkVZp6OYatT8D3YhOkzBjOm7RxxKmexIV5AJ9DC9J2R1NBK9/lTaF0GpgL6jOrA7tTCoyGKL0oi1sKP3Wa1pQoPIKP5toE3aTdiP+o74UaznRN1Y9cHioSZF/eQ8tRo4S7iCZ6tdhaFUdnRQFaMum5VnvKfTRbXSLnTe30Pdo8JD09pHjH/lvD3azoobZk/CyjDEj8552PGTn4CXdGoTuRWF9WViQer5gJwYBkly252gwPpIEtpeWNKRtEAz8Rogiv+CRtQE573/V0UV6BXAMMsX2TfqVhe14mXhP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 05:50:21.7713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa31025-8eac-4995-fb49-08d78f47a7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
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
Cc: Jack.Zhang1@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before, initialization of smu ip block would be skipped
for sriov ASICs. But if there's only one VF being used,
guest driver should be able to dump some HW info such as
clks, temperature,etc.

To solve this, now after onevf mode is enabled, host
driver will notify guest. If it's onevf mode, guest will
do smu hw_init and skip some steps in normal smu hw_init
flow because host driver has already done it for smu.

With this fix, guest app can talk with smu and dump hw
information from smu.

v2: refine the logic for pm_enabled.Skip hw_init by not
changing pm_enabled.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 94 +++++++++++++++++-------------
 3 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0d842a1..5341905 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1454,7 +1454,8 @@ static int psp_np_fw_load(struct psp_context *psp)
                     || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
 	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
 	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))
+	            || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+	            || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
 			/*skip ucode loading in SRIOV VF */
 			continue;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6129fab..26e1c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -826,8 +826,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 
 		if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT))
 			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4ed8bdc..fa17265 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -531,10 +531,14 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev))
-			return false;
-		else
+		if (amdgpu_sriov_vf(adev)) {
+			if(amdgpu_sriov_is_pp_one_vf(adev))
+				return true;
+			else
+				return false;
+		} else {
 			return true;
+		}
 	} else
 		return false;
 }
@@ -1061,20 +1065,19 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	}
 
 	/* smu_dump_pptable(smu); */
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * Copy pptable bo in the vram to smc with SMU MSGs such as
+		 * SetDriverDramAddr and TransferTableDram2Smu.
+		 */
+		ret = smu_write_pptable(smu);
+		if (ret)
+			return ret;
 
-	/*
-	 * Copy pptable bo in the vram to smc with SMU MSGs such as
-	 * SetDriverDramAddr and TransferTableDram2Smu.
-	 */
-	ret = smu_write_pptable(smu);
-	if (ret)
-		return ret;
-
-	/* issue Run*Btc msg */
-	ret = smu_run_btc(smu);
-	if (ret)
-		return ret;
-
+		/* issue Run*Btc msg */
+		ret = smu_run_btc(smu);
+		if (ret)
+			return ret;
 	ret = smu_feature_set_allowed_mask(smu);
 	if (ret)
 		return ret;
@@ -1082,7 +1085,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	ret = smu_system_features_control(smu, true);
 	if (ret)
 		return ret;
-
+	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
@@ -1135,8 +1138,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
-	ret = smu_set_tool_table_location(smu);
-
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = smu_set_tool_table_location(smu);
+	}
 	if (!smu_is_dpm_running(smu))
 		pr_info("dpm has been disabled\n");
 
@@ -1248,6 +1252,9 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1300,37 +1307,42 @@ static int smu_hw_fini(void *handle)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (adev->flags & AMD_IS_APU) {
 		smu_powergate_sdma(&adev->smu, true);
 		smu_powergate_vcn(&adev->smu, true);
 		smu_powergate_jpeg(&adev->smu, true);
 	}
 
-	ret = smu_stop_thermal_control(smu);
-	if (ret) {
-		pr_warn("Fail to stop thermal control!\n");
-		return ret;
-	}
-
-	/*
-	 * For custom pptable uploading, skip the DPM features
-	 * disable process on Navi1x ASICs.
-	 *   - As the gfx related features are under control of
-	 *     RLC on those ASICs. RLC reinitialization will be
-	 *     needed to reenable them. That will cost much more
-	 *     efforts.
-	 *
-	 *   - SMU firmware can handle the DPM reenablement
-	 *     properly.
-	 */
-	if (!smu->uploading_custom_pp_table ||
-	    !((adev->asic_type >= CHIP_NAVI10) &&
-	      (adev->asic_type <= CHIP_NAVI12))) {
-		ret = smu_stop_dpms(smu);
+	if (!amdgpu_sriov_vf(adev)){
+		ret = smu_stop_thermal_control(smu);
 		if (ret) {
-			pr_warn("Fail to stop Dpms!\n");
+			pr_warn("Fail to stop thermal control!\n");
 			return ret;
 		}
+
+		/*
+		 * For custom pptable uploading, skip the DPM features
+		 * disable process on Navi1x ASICs.
+		 *   - As the gfx related features are under control of
+		 *     RLC on those ASICs. RLC reinitialization will be
+		 *     needed to reenable them. That will cost much more
+		 *     efforts.
+		 *
+		 *   - SMU firmware can handle the DPM reenablement
+		 *     properly.
+		 */
+		if (!smu->uploading_custom_pp_table ||
+				!((adev->asic_type >= CHIP_NAVI10) &&
+					(adev->asic_type <= CHIP_NAVI12))) {
+			ret = smu_stop_dpms(smu);
+			if (ret) {
+				pr_warn("Fail to stop Dpms!\n");
+				return ret;
+			}
+		}
 	}
 
 	kfree(table_context->driver_pptable);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
