Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612D6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 02:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C8A2177B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 02:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hm3SXjjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C8A2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3D76E03C;
	Fri,  7 Aug 2020 02:36:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56DB6E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 02:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5aaReRxYQqYz3hFfYun31tdVed2uF8cpKV2gC+ABgHsXGt2w7gY9t/CjSJlYHDgbpZ9RCETMqG0KQ/tkLk4xsUDorNTYMV9VMBgsARKBLuYLYeLjJNynwFLnqv8ZL/lkqkZ3a6gU2db+PSkhF6Gb17HJYVOSeiZKbCkMOFAaRKNG3dXN5nXcQDu2QXeaDf/uHaS9TcJ+nF3BxPhxG40lHIPA5Dz0R8viziO3RhlofIlNByeicoCzB5JUlQJY5n44dJyFRfvzpEv5P0HKFB8ZPQSo97V2SBG0jap/uEpzd0DO2bOZvvQYwc6rHEn6Pd4DT3tELJnU2zuD59JGSn6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsiuhAZNqnRcbsVWZRAu82vu9F7GiXvTlp7Sk+UGgc8=;
 b=e3JdVqlE2Kx+jlvBQt+1ujEKXIOwI0X9AyCv0Umkuub3sDXxlP+acb9UN0jCyp3J8BSfpGsnvnB1OHd3zQOe46dEmaeUK3XG//Q1HTKNvamJvUTO38TkLs6USyxP7PzBhxSrgvMPwogFO/MmexzEqGS2ZeJhrME66oeTeOaco7ws3fY41PYeQ9YZFCyhA3gIXVCq7/QZM+I6zCY9QI+39mz9mEJyD/EpdDS+Uf2B/VfBj/wMbRSD1CuAMoJTBJl9L85wREzFPmyOZq9xh0LnHcvu/lMY5fv6FnFuuyCnbTUCtIMqn5iIuNcLXEJwn6zmH7Pmekol8Pjc9AX6H75ShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsiuhAZNqnRcbsVWZRAu82vu9F7GiXvTlp7Sk+UGgc8=;
 b=Hm3SXjjHUTCRxAPTxqZ7eJf6/kXJYWjWC3/VvcGw9XJmcu2yr4bxldH9VSzzOELVTdu9ulpJQmUb9VOb8gPNdBZGyMJ1XuPbBDUE2fzb7XjV4GBDVo/BLBdaioXmP0p+oeZM6FyFeN0UEPJmq9NrU4RHTfWpSJ8vGNMFy4Sh+44=
Received: from DM5PR22CA0011.namprd22.prod.outlook.com (2603:10b6:3:101::21)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 7 Aug
 2020 02:36:44 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::8b) by DM5PR22CA0011.outlook.office365.com
 (2603:10b6:3:101::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17 via Frontend
 Transport; Fri, 7 Aug 2020 02:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Fri, 7 Aug 2020 02:36:44 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Aug 2020
 21:36:43 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Aug 2020 21:36:40 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add interface amdgpu_gfx_init_spm_golden for
 Navi1x
Date: Fri, 7 Aug 2020 10:36:32 +0800
Message-ID: <20200807023633.5949-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec32d1e-2c89-4037-4c37-08d83a7ab949
X-MS-TrafficTypeDiagnostic: SA0PR12MB4398:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4398634A4EEBCBFF55CC746895490@SA0PR12MB4398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKFQz+jKzeRbSBO1HGwlF+/th1ExbuEkRTQWGtZOheaUpQlrjIX1+q/u6snGQVUctYZCi4En6QRCT7Ev08NjZMViy46aumLT5km+gTVOJG27ImTD6Qj5C4cqEnZP0iP8qfCxirGCUDt0RSEpkWkaeN8hYyJPprwKlt8Q8l24L3l3C/eehva+I5nbn/8kfkNV5IR+enMhrx9az2sUNBq352dYdhyl3+MAdALPOa/sdgp2ncv8lNNuHme0ZUNesU82Pm8gav8tC9pZIiXymk6weHwjUOMKVGYyWuD/MT8KltaDN4Zcfj8n0cw3VyBMmjaLvJlWbL/M+UXz8iV6dHsnCAPcheJ7Y2lLr3io4lBetW+4mdEzFuIcDrlAdSF4e9iVRZ/ihFC2ukuMgE8yrC0FuHr6HPSDvfTMg//ugFEWNX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966005)(7696005)(70206006)(36756003)(86362001)(70586007)(5660300002)(186003)(26005)(2906002)(83380400001)(1076003)(336012)(47076004)(2616005)(6666004)(426003)(356005)(4326008)(44832011)(8936002)(316002)(54906003)(81166007)(8676002)(82310400002)(478600001)(6916009)(82740400003)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 02:36:44.1105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec32d1e-2c89-4037-4c37-08d83a7ab949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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
Cc: Chen Guchun <Guchun.Chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Swamy
 Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>,
 Feng Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings are lost after GFXOFF
enter/exit, so reconfiguration is needed. Make the
configuration code as an interface for future use.

Change-Id: I172f3dc7f59da69b0364052dcad75a9c9aab019e
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
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
