Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44D0C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CE920759
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nv86sjeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CE920759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8206E17B;
	Tue, 28 Jul 2020 05:27:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB126E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 05:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdDWj8EPSL41rZkLSevN74uGvg63qPxCHRtPBlSk0dQriW/IVrz4b0EFZXjlP9YQLwbeLrBjniBb8NqoOMV+KPhskU8FwQhq6MaRdSlYNRX39GKkp7glK6MX+Cf3V3A+6a+hk3fAspTk8p3d486lAQga4DHNdeOehb1EHHHWVNl7Jyfsv3jaWWtkFrpzfig/dBnXQZnPQJQVq4BdlV6iDRuZhaxdB9jlXLr5AT07RkVcd+IDoO5La0f9tX6bATm2tSz0o//WB5qfUHKN+9emV7/C7t5RiOIBIuvVhV0gFSP4OQSdv3pKMe3Gd1OmFql7e56zU4dFOwd4niJG3v4dpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiC5iLgzk6kFORBOnfraRAuFxJfSsgY+I3KAx9Tv2F0=;
 b=FlW9pCj2PotOED4N2P/uyJq/zYmQRdoRAMSzD1A+tI5Sh0M27vKxzY6JssK40hx3s/SmXaUNcJPQ3N4k8qT8xNqQGDY2YwoZSsM34ADhsOiJH3YPpLcDMBTwJsFZma/lDSek7Ub5qiIHCOUDuuEZIM/h0vS2awo1yfSFEeAFFT62658E94iieBo1NTctMDKws8jc1TDZHWRxjFaYDp5GtOVFOADRIaiTu/AzHxOoLUld6A99AkXVpbKdzNYEREuOuuZnzDDd53qZWgcNAl45udB+HSMQ9pzYX9miRncYkdqi0YMq7vXuUNJVMNkhCgIuggLioEljNm8iEoI/PXGe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiC5iLgzk6kFORBOnfraRAuFxJfSsgY+I3KAx9Tv2F0=;
 b=nv86sjebdpxwHKbyLxlUuRIGZG1AM6KIF6ghy04wcZ3zlYZBOGGv+EyAiGbnH5/f/RWQvB0km7yu6dg7i/txWlgBUgI2MSm8WEY/aqZ0AtnnBH0j0Ls45l0N94JMpTy7rYWNJYsaAcDEpAhlHzFIH5ebgnlVrRb544jWivSIADo=
Received: from BN6PR1101CA0015.namprd11.prod.outlook.com
 (2603:10b6:405:4a::25) by BY5PR12MB4113.namprd12.prod.outlook.com
 (2603:10b6:a03:207::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 05:27:25 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::8f) by BN6PR1101CA0015.outlook.office365.com
 (2603:10b6:405:4a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 05:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 05:27:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:27:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:27:22 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jul 2020 00:27:20 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_golden for
 Navi1x
Date: Tue, 28 Jul 2020 13:27:16 +0800
Message-ID: <20200728052717.21071-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76767d21-980c-4f55-e632-08d832b6e8ee
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41136E116EDC4E3BC884FC2295730@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1fSH5MlvCwZra+g8eGKSMAz8x7IaC8DQMj8+7JuYHXx3UDiRGeNn0g9oSokm28xcepbckiYbZ/rztBbKoCJRcU9EKKu1/X9fD6cjSvFnhRtR+D9x5MMYSXHwgc061z3XsUcQ47F03NaLLQkwZK6UASU17PPzYGPYeD9oIMJ+7RhEbHAQLKYDGlGTe15jUD+TUQ6AfjVlaeHJyvl2hMo2Alpd2W3KgVLI+UdG1P/5kQxG9D4tFYJqH3AYAcieBWn0CqJrlnvt9p6lrjkrtkZ8eLCtb/EgoUhLEcMEnmbThctA3etuHMiaR2H+p/uJxPfuJNt0eZ2J1CLsIYUWmTj4Fq+Fs3S97ywCoij9ycJxbeZp6lowbXM4ytTpddHD3RQ1FL2fSM1sE4GjeZwIQHXjwdyFDRTJ994lmzIBYvl91o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(1076003)(26005)(2616005)(2906002)(426003)(356005)(82310400002)(4326008)(81166007)(82740400003)(316002)(186003)(336012)(44832011)(6666004)(478600001)(70206006)(47076004)(36756003)(8936002)(83380400001)(5660300002)(8676002)(54906003)(86362001)(7696005)(6916009)(70586007)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:27:24.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76767d21-980c-4f55-e632-08d832b6e8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Swamy
 Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>, Feng
 Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,
reconfiguration is needed. Make the configuration code as an interface for
future use.

Change-Id: I172f3dc7f59da69b0364052dcad75a9c9aab019e
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 34 ++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1e7a2b0997c5..a611e78dd4ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -216,6 +216,7 @@ struct amdgpu_gfx_funcs {
 	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
 	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
+	void (*init_spm_golden)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
@@ -324,6 +325,7 @@ struct amdgpu_gfx {
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
 #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.funcs->select_se_sh((adev), (se), (sh), (instance))
 #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
+#define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_golden((adev))
 
 /**
  * amdgpu_gfx_create_bitmask - create a bitmask
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index db9f1e89a0f8..da21ad04ac0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3307,6 +3307,29 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 	adev->gfx.kiq.pmf = &gfx_v10_0_kiq_pm4_funcs;
 }
 
+static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_NAVI10:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_rlc_spm_10_0_nv10,
+						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));
+		break;
+	case CHIP_NAVI14:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_rlc_spm_10_1_nv14,
+						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_nv14));
+		break;
+	case CHIP_NAVI12:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_rlc_spm_10_1_2_nv12,
+						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_2_nv12));
+		break;
+	default:
+		break;
+	}
+}
+
 static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
@@ -3317,9 +3340,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_0_nv10,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_nv10));
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_rlc_spm_10_0_nv10,
-						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_0_nv10));
 		break;
 	case CHIP_NAVI14:
 		soc15_program_register_sequence(adev,
@@ -3328,9 +3348,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_1_nv14,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_1_nv14));
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_rlc_spm_10_1_nv14,
-						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_nv14));
 		break;
 	case CHIP_NAVI12:
 		soc15_program_register_sequence(adev,
@@ -3339,9 +3356,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_10_1_2_nv12,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_1_2_nv12));
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_rlc_spm_10_1_2_nv12,
-						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_10_1_2_nv12));
 		break;
 	case CHIP_SIENNA_CICHLID:
 		soc15_program_register_sequence(adev,
@@ -3360,6 +3374,7 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+	gfx_v10_0_init_spm_golden_registers(adev);
 }
 
 static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)
@@ -4147,6 +4162,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.read_wave_sgprs = &gfx_v10_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v10_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
+	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
 };
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
