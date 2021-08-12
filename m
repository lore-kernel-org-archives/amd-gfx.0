Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D488C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C302761058
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C302761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4699F6E239;
	Thu, 12 Aug 2021 04:01:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B696E239
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey1k8U9K1u3WQQ/A3PKoQeIbQE1DBeYj71fOvql8qj/XqfSqRmHcv90p4CeUo4qvHAmE+KjbW5NEJ0525oTzxndKAcdHsjEzMcNJqV6aM4UY2CYxvQhMF121DwiCAWTPqgJq3HEgPCGr9e8YSiqZhSixmsxrRFGV9Lpf3r9I/dZq2RR9ZJtk6qgPTxt7LB9UrejJ+G/siRI2Eh2U6o6VieCc14bD1Nk5r81xIfZPyQ+I3wS8S0WMupzjWOtWwhRb1fAKMi2jA7TBwAnAF7wnK1KwjQM6rH6B4GGeVcUufTVX9y/jLj+r1B2p90h1CVYhNyoqK+eSmG+/v5vdnnOG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWntbpbW0coZpTp3U0+mNVFZTakYW6KA4Ib9i/THLc=;
 b=VXqDI/LgDmpG+5dDjzb2ZJ/NvH3EeML/8P8xES5fkX7U1alG+znNrzZKympEf1oQS/Rt8rrRXXukuv7fcgrquBsuusMEv3n/Am6bupQr4Gfqg7YbXZ5O4OgCR9JItGkYsnT44wGUyW2SdGAr5paduJ5ZeCflAMDGIE2sXBmN4dwYIk+o2Bl7eEDYY+93KTNadsGLazkGH1MH4izVB7GcwcM83j5l/trJ38mifbXUoAYq+VwXsIX5EGud3YjdeKxJFgPODT2CovgbXWqnGc5RLG5/f2Z52bIpkwo8ol/reemDVolvw4x4FROQb5IVnMpfOvFcnPZOihn2ZE0Qu+JpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jWntbpbW0coZpTp3U0+mNVFZTakYW6KA4Ib9i/THLc=;
 b=wjAlRWwSf/YNvVKCg1rM59v3LYG7W4twBJT52nBA3NRdXSeeO07qduQlr3NwxlA+m2c/LM5rScsPR8Zh8prKS06xghxRZbQdzXaAc867tceGUmy5PH9cKCILiJH/F/sxyCpxMSTC4FI7j1fxhys5Qt5PL4I4Q9MZaMnyAfMPfjc=
Received: from BN6PR19CA0105.namprd19.prod.outlook.com (2603:10b6:404:a0::19)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 12 Aug
 2021 04:01:32 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::3e) by BN6PR19CA0105.outlook.office365.com
 (2603:10b6:404:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 1/7] drm/amd/pm: correct the fan speed RPM setting
Date: Thu, 12 Aug 2021 12:01:04 +0800
Message-ID: <20210812040110.1293682-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4869d38c-9568-4263-6580-08d95d45df03
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438234FC5149A2C280FC06EE4F99@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e27BpHzv+HMocfIcUr4mEfCjPn6XvrdjMCPyw/s7rfstXs6to/KT0z2k8Tm5tdvyswExK0G7MYDPFH/sw8t75+/5VB6Zh93i2EbpvYwEY/qngm6OFeuHIJ7RaQVDc3aFVeAKOCumqPmnTb0VUXcr/iqR0X9MWrp0Iae+PeUU4PXY7dtKfQK9fuNYs6ljxuvd9ANaO8deu0qZte7Qhr42GUHQ9qfCZRVPTE7UL+WN3+jiHjDndfWAYVS6sBIusBc164Ic0EJlSMqUdg3+r2ipqh70F3d+dmKhVLsFDV6o/p6iJF4NeDobA+uCZsV/owrlC8A1UX8FyBNnxd3SDCoGoRota5ueu/MVZCGvkyx1tjtsqripkbURfuNZaJL9NWDM77kwNwzkP5SczWlmeVAxgRbuBQezSaaGba7Z44BOrXEMkiEjzfDtsp7+ayfh9nn4dBBbH8eqLe5zHj9mQLrRBbWC06NhpS97A/CqUTS9NM5lSEzRHFGGB5zayZ/V4DFDfWYGEqy36GVJ5k7/zu8aBtN2ChWAgcuUkIrL2AegrtNgKXLo30X3CRqFiKol9bRyTv+ilXm8yWmO47EszowI2HRrDgWq026+mCBeabRMaO6WDD2fD6sb4fps+Se4lChXx7VFKw2xwuGY4NQ42F1sa0Hg/cKKHRw8kinzweLVIdxwsmcfsBV58Jd0YponZWyJML0qFeS7J8owpoPHyD8irQoWBhAXjnVk7Z0f7kPzI2Ykx4mduO9FLaPMZfRegQB9OMEVF1klNCgGxT6et48k0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(6666004)(316002)(81166007)(36756003)(478600001)(54906003)(2616005)(34020700004)(44832011)(426003)(86362001)(336012)(2906002)(4326008)(26005)(186003)(16526019)(83380400001)(36860700001)(1076003)(7696005)(70586007)(6916009)(82740400003)(356005)(82310400003)(47076005)(70206006)(8676002)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:32.4874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4869d38c-9568-4263-6580-08d95d45df03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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

