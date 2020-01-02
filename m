Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542BBC2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 07:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F2F21655
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 07:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hd3ioHai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F2F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A807E89CC4;
	Thu,  2 Jan 2020 07:43:58 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8D289CC4
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 07:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaNcoqyO4YTOp0UAqUN3DV/SkCaCbYiSrnfgxYpvGJQ5py1JX57zAZA+X7jsC1auTcYTIUiPizxgsobNdgc9+ZZKfs3nBM1ED1ywUcyBO+7Rt7HsfPhFcBWGxkgJRmD47Q3KKkEhy+/6YiSupex2cAdxPsZ/qQrAQv9dw3fuyLumA1BYtDXHuQLAQh64MHsR3qXGpsj/UbDmGzHeaQ5i73Z1KsxqI6ZYPrfh/r4EUGX1SBBjhDuOZ/hq9jX37Ibnf7/aJjbV8Xa4drzTOjJzO0Vu4M4Fu5g5ue3ZBQNewAS8ui0OgogKia/Ar6+ndItHNNx/egvOKooj0DqDrGex8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcvLqORqiZkVvvagNiq3YHP6E3TbUx9Jwp6imIISHQk=;
 b=JJqxfGjIqe4LvFvTOcZsvq8aquig8Zi6QStbVG4Er5Nvd8Ib+iyk4Y2NIlU3uPgxT3CijyB1Zpa06qFp36QqvbQ2OP7u2ObmugTHpt1yaI62Ekg1skT7xccyqDcOJ0U1tGFhwkGOqWEhA3403BSe6iDvJ1fpcFmky//GGBzXXxvRS2takxJTZi/rAPg+26eYtV6MqACPbHz1ehni9jQpz2esPY7IB+HaP6Ubn//iKRMUDXVQ6uIY9+sPyAu+3NenhosLRHfEZE35B9DoWjNkFpGVrAZjadtVTTScMDEruDwtLSuZ+XQS2wsoFF5UhDUXO82T4gQQzgKq7fgzyqWdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcvLqORqiZkVvvagNiq3YHP6E3TbUx9Jwp6imIISHQk=;
 b=hd3ioHaiNL+bUljtxVwWmPISj3VrZA20a2+wN4LFAFUaTRLwPkyVHuByaw2YRABJpvC73Qrx3A050/Jg1EcsXD51GIbcL8GsrA8pPTk9JzYRFtna/mVoLLS6XP5YujclTcFsej48ugGbfURw+KSdfDSs72K/M9QMlvlYzm23t6E=
Received: from MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) by BN8PR12MB3252.namprd12.prod.outlook.com
 (2603:10b6:408:69::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Thu, 2 Jan
 2020 07:43:55 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by MWHPR1201CA0007.outlook.office365.com
 (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Thu, 2 Jan 2020 07:43:54 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 07:43:54 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Jan 2020
 01:43:53 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Jan 2020 01:43:52 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Date: Thu, 2 Jan 2020 15:43:48 +0800
Message-ID: <1577951028-3033-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(189003)(199004)(7696005)(70586007)(478600001)(8676002)(6916009)(70206006)(81156014)(5660300002)(81166006)(66574012)(86362001)(19627235002)(8936002)(2906002)(36756003)(426003)(336012)(26005)(356004)(2616005)(316002)(186003)(6666004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3252; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49506a24-f65c-4b44-7025-08d78f578497
X-MS-TrafficTypeDiagnostic: BN8PR12MB3252:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3252DF2868D2BEF3F0C9BF15BB200@BN8PR12MB3252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-Forefront-PRVS: 0270ED2845
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahFxHvBezqOl2CBerSbLThpiPSoYj+5/sPwgmk0yCDzu1cIRI6EWAWKWVTECk9OA9b9KSRH6xYeAEKbNK19Tg+CjLrdAHEsdY1ZQh7sediXyQOMZFhh87P5nmrdpGhWeb+VacdLZb2z/6jgeX2jqcdwl17/RCHGFs8NnqmSaGAObQqfX/I7BeOUVt9/1Pv6EM446stbKYmJK8wBaMuJvomYSqIyz9IdVG0HcKyQmkFvRXMpJYWqlX3pJ0fVHFj6Ivoiq9BnPHOxqU7Zqp4ez9+LWJccOOmdwQNxtGGfXe99DFXTkGSDjzfiwshn9aed/aWVF42Nef8dcaasq6BAGuU1OEi1h73e2lYGCUO5l9gR16mpRSiqO4dPUYbR31iIGEVmNb3Bz0WPTjG2r0cj2TaG5ajBbYvoT3FIlJUX8qg+72yIM1hu2rvdell+fZBaf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 07:43:54.4812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49506a24-f65c-4b44-7025-08d78f578497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3252
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
v3: refine is_support_sw_smu and fix some indentation
issue.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 98 ++++++++++++++++--------------
 3 files changed, 56 insertions(+), 48 deletions(-)

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
index 4ed8bdc..4b96937 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -531,7 +531,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
 			return false;
 		else
 			return true;
@@ -1061,28 +1061,27 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
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
-	ret = smu_feature_set_allowed_mask(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_system_features_control(smu, true);
-	if (ret)
-		return ret;
+		/* issue Run*Btc msg */
+		ret = smu_run_btc(smu);
+		if (ret)
+			return ret;
+		ret = smu_feature_set_allowed_mask(smu);
+		if (ret)
+			return ret;
 
+		ret = smu_system_features_control(smu, true);
+		if (ret)
+			return ret;
+	}
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
@@ -1135,8 +1134,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
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
 
@@ -1248,6 +1248,9 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1300,37 +1303,42 @@ static int smu_hw_fini(void *handle)
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
