Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A502BC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2771660EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 09:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2771660EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14236E03D;
	Thu, 12 Aug 2021 09:33:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D736E03D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 09:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHQktBNC3c3ra45OJbnHTKkMWd4FmYg+OJ42nSVeuKZ8OZNa4roghK/8QC/ZnNy1P1ilNAKuf9cW3ESYcnJjHs2z+Yxp0gng0Pw9to8v2K7JCzm5gamHfwdinrDJh/De9rrSPpkPO82mOLjrwDTTlxAO3fQX5Sfq3qX56iRr9qV/lSK/n4A4P18JzTi4nFVp1ozGLax2bo9m8oot59GN9TjiHUYwAOaEQ/Le7rbwOY1Po4x6I+jB3L6wlb1+FD5kJSQLHiRwsqRfq018tdBmXgj3Iis5+gymCBh+bT3pJdmZAmzotKeST1AqUshzv0rnIT4vufrksjToy8D0peKZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWntbpbW0coZpTp3U0+mNVFZTakYW6KA4Ib9i/THLc=;
 b=gvYYs0CkZzNT3NTbM2xzPT6mxYQRIn1X9POS9cXnUhBtP3ZDfqjyuu9LZNbugnBRs2EjhmnSdKVWaOwJcx0EtSbHvHZEGFUem4cNGun9ROzf0SdNRv3WPE7L+jYBC5ImoR6HPqmcvMqNiTtLuPiVfPrDjqmwba4aNlXRctnTNCUpTB0M0HgZEK01l5XlFfiG3ahUs4xsepjY9EAaFEFrOSr7JbOLuwLBUuWENZXcf6ziCLpHx92PhBVzHCSPNr4FXmBsd0z8DBybNf2rQVs9V1VY3cIwFBHW9aAdAy/ZKc3ZZYYsLDgHtAB3nOzWdLLUyq1X0HMIWGN4TUaPcrarGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWntbpbW0coZpTp3U0+mNVFZTakYW6KA4Ib9i/THLc=;
 b=leuqH3o/eA88LrHsHGmx9G7hDXleVtMZTl78cKK8s+p5F22t/Sf+WsoeyV4GKX9FTN7IjAU17FPIpjI65MLel8B3s50EEFZLDsMsuX3ii92wiYlN0+h9JuCh4z4+koIrfhf+164n8oqctn/6N5Zazq+b1kx29fn4BiNrOvuN6Ko=
Received: from MWHPR1401CA0022.namprd14.prod.outlook.com
 (2603:10b6:301:4b::32) by CY4PR1201MB2503.namprd12.prod.outlook.com
 (2603:10b6:903:d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 09:33:27 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::22) by MWHPR1401CA0022.outlook.office365.com
 (2603:10b6:301:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 09:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 09:33:27 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 04:33:24 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V3 1/7] drm/amd/pm: correct the fan speed RPM setting
Date: Thu, 12 Aug 2021 17:33:02 +0800
Message-ID: <20210812093308.1322342-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a46fb910-6411-4c8f-7787-08d95d743d59
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2503:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2503DCB01CCE2DF9D2553818E4F99@CY4PR1201MB2503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEqePzAgE3BaQk8K27/eo8W1gJsac4Oj/tl08mh7FSz5bhaiVB8U+tSQhHNNHNjz9QOtfIXcUgLGoDV9ZPGicjiZ/E6OcA7dMVaqCHI8mGNYZgxCF8pZTsQMhaoI7/XlUZvSgol2us0l5obYjqbM6ZGrGJg74sIMK/0a5EyhRzcaoySkTiLXRAfctqRYuaMRvk90XXLEWxGe5LTyOuKyxBtgXrrKfBvklQOrbdqBo2WElX/MsetXiorg4HRxu1bKoi25PMLFbOMYQ9fNj8JOiNKOMc6KeH086bDIW5pHpw3Khav9ItsvWC5CldNA1x8rCOLfXAeSgvsXmrqvThMN5KjNfF9wt2vdha+UGsJqEn5aEa30dVO5tXZPp1ugTn3Y7aSeOA9/erz4A6yypwkUwNsf25WK1zY0B9ualKwCkmICGzBfCylIbF/9FnuP8JF8dddX8M8NM/Z10ulf4kGdhQfY6RwkZ9tJDjHIGYWEahKjJXANsbmLXQ0pW2bggFIvU8XMULtuA2s/ZjtVra92hA/hFf1VJy8ZZOP2vBqoQQivpkEizIuRDPUhwBYV4aNUOhMDcmq/gZUgiq/PkDy3WY5MlT3gqCYPiAYsZkhJmMTQBFYLyj4KDbjL511+M7h2JhrDA6khNF0Pr6f0pwLTwn/zYA2T4Xm1ASy0X04ZUv55NkmdLjEd9Egd458UyavGutihEUaibxnsN5ko8b/jRtXssjLDwr/MxzQzhFNDKXIC1RVSbVwe7a/7TdrvSdOIJAKBFBrVQJLmhf0s0ZfD0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(7696005)(2616005)(34020700004)(2906002)(47076005)(82310400003)(81166007)(426003)(1076003)(8676002)(16526019)(8936002)(6916009)(186003)(26005)(44832011)(70206006)(83380400001)(86362001)(82740400003)(5660300002)(54906003)(70586007)(478600001)(6666004)(36756003)(4326008)(336012)(316002)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 09:33:27.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46fb910-6411-4c8f-7787-08d95d743d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
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

The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
perform the fan speed RPM setting.

Change-Id: I1afe8102f02ead9a8a07c7105f689ac60a85b0d8
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - hardcode crystal_clock_freq as 25Mhz (Lijo)
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 35 +++++++++++++++++++
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index c2c201b8e3cf..183654f8b564 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1047,6 +1047,11 @@ struct pptable_funcs {
 	 */
 	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
 
+	/**
+	 * @set_fan_speed_rpm: Set a static fan speed in rpm.
+	 */
+	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
+
 	/**
 	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
 	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 403bc1bf8a77..b9c8a924dca6 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -224,6 +224,9 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
 				    uint32_t speed);
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 71afc2d20b12..e33e67310030 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2187,11 +2187,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_percent) {
-		percent = speed * 100 / smu->fan_max_rpm;
-		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+	if (smu->ppt_funcs->set_fan_speed_rpm) {
+		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
+			percent = speed * 100 / smu->fan_max_rpm;
 			smu->user_dpm_profile.fan_speed_percent = percent;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6ec8492f71f5..f909cda86299 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2316,6 +2316,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d7722c229ddd..08b0edcbc8f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3268,6 +3268,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 261ef8ca862e..4e28a4ff1817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3903,6 +3903,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b5419e8eba89..007f84bdda6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1228,6 +1228,41 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
 }
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	/*
+	 * crystal_clock_freq used for fan speed rpm calculation is
+	 * always 25Mhz. So, hardcode it as 2500(in 10K unit).
+	 */
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_period;
+	int ret;
+
+	ret = smu_v11_0_auto_fan_control(smu, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * To prevent from possible overheat, some ASICs may have requirement
+	 * for minimum fan speed:
+	 * - For some NV10 SKU, the fan speed cannot be set lower than
+	 *   700 RPM.
+	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
+	 *   lower than 500 RPM.
+	 */
+	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
+	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
+				   CG_TACH_CTRL, TARGET_PERIOD,
+				   tach_period));
+
+	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
+
+	return ret;
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
-- 
2.29.0

