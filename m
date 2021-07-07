Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE9C07E96
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C972361CB7
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972361CB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D186E7E6;
	Wed,  7 Jul 2021 01:59:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15536E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwMAzC9KgX3TmPt/TQ6widlcNFpLuwM6UsuY6TCIPJ7Tj6wZQH8l+nluWGcPzQzl0MSjFeAqtU5swddsAgFxCiOkoCXr8bKcVtlV1JLyl4aZaOBV0Wepx8BFS0LQKmmG5k1cTOBoLk5OlfTN7dvOwYBuFQFEuZe7Asi0QXiI6sE2JaS/NUVgSyMT6pfpWM8NuSexyvYSa5Z1sUbYzXnsWsOLB1HoFnjZxOBf3Uwxfueh5+u0zSE8xMqqMLwqf0CO5TF4ouAbNW2l3LpD+ajXIqXzZpPPiuLWZafeEuL3gfdpg9FjZ8iZ2L6dBCoeioiGdY2nz2FHYbHz3TFMXwkUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6vB2tKD2tafuwUwHOrZC3725bMb9WPBhBpKOzls9pE=;
 b=Db/lPS/pc3f8YajMrBkTp8IFu1X96rd7wJ08W4m7Y2Xphn21jOykCNrVGj03PZRlMSTkEj6+/rt1VNVZaEycF7WFFVap9u8vbiweTBpTONi1V2Dp/pWL1l/RDvilIK2BtkyzSZGFoB9E2nsnukqbs+yI5SzTQVnScU+OQYJ2AI7YR/Gd4R2FASSd9wunbbncVIwH6/xy2Iy0sP0ky7XgJdEEew4uRNGMaH7pKD+YXy7iUWc3vY2wveYXSSNo2pY1eSFnBwPnhrV0EffNRXE7z8jZ8HfnrfJuvY21Aex+G4q1v/YiTK1HyhEb68QVBtrRKMhCUhaarVRCrsSQX9mjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6vB2tKD2tafuwUwHOrZC3725bMb9WPBhBpKOzls9pE=;
 b=ZF+4e8R9bCVjnxvMPJdt1SQeQSY7RhDxCRiavhiiRGHeZj8DTiPOL/HDqPp0ix3Eeo+Je4jUpvuRJTuXgjN1X7/sm96efI3E9InBYglqv0aJQTSG4AOp69/scw/LzemVqyvDz8T/brwlK3uQ6mL+bmQTq/9euaFylJp9+GPueVI=
Received: from DM5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:3:23::34) by
 BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Wed, 7 Jul
 2021 01:59:17 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::42) by DM5PR13CA0024.outlook.office365.com
 (2603:10b6:3:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 01:59:17 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:15 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
Date: Wed, 7 Jul 2021 09:56:41 +0800
Message-ID: <20210707015647.139127-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bdc3587-c0ec-4658-dea5-08d940ead412
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0019897B21C930117AAA39A7E41A9@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17f8naH9oI1lRSdBqmXEKe+MYafAKxM8ouBmOk5Z4SmcaT9PaUeaQWjZKTNWzXHq5PRjAQ51UDSndg0BlMLK0HythLWOhKWUM1ij2Xt7YaXFZieQXI7aNqs1ZzCgM813akYp5+qPF41SWWDyJUTi3Xxp+TheQHAbGvrkMuGNT+JrKDPDavpP5pj//qUghM5x3nOHGL1qEvMYVrntk7tx2z+K2oz49Z6KNO8OCX7+d/3tQq3jdRwuBIaciU6mIj/T2Rs7GKmfsJo1ehJ+qYhVxgh/eevI5BP98s8ZhlZPcbDhP/0GxN7Ewsk6z/QPB8k+gwwiGDKRvpDEN7EDYoGAr33l7gvwO2wk5oGdhVIwyRwLkH27v0rfB+Jj39BrumpZA7GSoKeiuD4r/BE5OuUCbv2BX2X96DuCZgo05BolmB+KEhkSaj8bzZ5t0IB5Eio50tX0CVl93bQya0XIqvUBEu/RonTeURdcUb3t0ZWy1ncoFxdCABYVeHZ3u7R7wGNW4yx8I1j8FtNR6LAH0Ek4G7isTx0h7VbfMnSw7XSdxTVe8F612iSs1AcPYCDS9ojPapnIwy3FJs8X3PRL1ENakbzrAPzpAKkV/xbDrKqS5WX+fv0P1MJutmZeKTPTTPtWP6oQfuqXbsorTdMp/rOQwovlICNz6+7KU1yu3GviXedChLQRxPS0d4fVV/Dy12tTCNHlqLjWGWw/VAoEO7qO7jWL1Girxi/PzhKgzGoH8Jc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(478600001)(426003)(16526019)(7696005)(86362001)(2616005)(336012)(186003)(5660300002)(2906002)(83380400001)(8676002)(81166007)(36756003)(4326008)(1076003)(356005)(6666004)(44832011)(26005)(6916009)(36860700001)(82740400003)(70586007)(8936002)(316002)(70206006)(82310400003)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:17.3097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdc3587-c0ec-4658-dea5-08d940ead412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
perform the fan speed RPM setting.

Change-Id: I1afe8102f02ead9a8a07c7105f689ac60a85b0d8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 36 +++++++++++++++++++
 7 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3e89852e4820..6301e4cb3c2a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1039,6 +1039,11 @@ struct pptable_funcs {
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
index b89e7dca8906..134a33e3de91 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -223,6 +223,9 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
 				    uint32_t speed);
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed);
+
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ebe672142808..576e9ea68fd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2174,11 +2174,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 
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
index 6b3e0ea10163..047adf6dd444 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2314,6 +2314,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59ea59acfb00..d8a011483dcf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3248,6 +3248,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 83d8e53ca1f8..dad120294c19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3886,6 +3886,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
 	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
+	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 388c5cb5c647..fefc8e93fdc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1213,6 +1213,42 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
 }
 
+int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
+				uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t tach_period, crystal_clock_freq;
+	int ret;
+
+	ret = smu_v11_0_auto_fan_control(smu, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * crystal_clock_freq div by 4 is required since the fan control
+	 * module refers to 25MHz
+	 */
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
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

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
