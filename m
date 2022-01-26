Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F33CC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFD010E4FF;
	Wed, 26 Jan 2022 04:55:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E4A10E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6fvjh6NYbNqeyjy3uHzX/4mCIBfcHelWsRaX8kMp2bAWQ7UjiU7vQBCRHcQoNO4FMwAGqUJJGWK/R7FnGrTBHEVNcgGY8t3ukT8T99obAVdkrveNIxcX82DtoD0RtW/hGCjChpTscRQyHulCJhTa02e4Tu8TKBEUm58d4pTedzMCG1Or58XMRdln4VJylZoLxFgwQiKLaLgH+DHJOnT2McsB47Q8LKCJHul4fkPU/U0VIj31stbbSyzzoBqSgvAY6yHbwGb082HGkbnsZ3c7vW2EKVD+612M7vhfmw9/oD7eLLwYAAsbj3gkor+Subf/DMy4Io+W8nAeO2Rp7t7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycStMbRfvAWdCH/r3EfHYHBdv6Zd6Mxs+SVkFCHmcJ4=;
 b=FCCjcm1FPGdGgP742WUa8laOhVCpRRKhCkYB44wEJ1Yffn/Qe5LpKqAO571i565aZyxVMc1It/YiBStL5btihyZElUDYtQeKeoVXMcv/mPSFcrlScLTKXhxMKzQg/joXj8mI+739LMEuCLcCVD2mHpAsUJo7QrwImt+jhk26egTWPvneoONwuWaiNsJwFfKoMDV4kcpkFuTis1ob2n7bucVbUsKZmBN8ZtEE9HebfzM6+PaJ2j0RQWAEnaWNCk4XtGFUQIzlrGT3GgOEW3ZkLPQcbpumBMJxIXls1tlrNCUqZ5O55i+dIoqz8mL1gaIG0SXfrfNY9XH7n4RsGoDX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycStMbRfvAWdCH/r3EfHYHBdv6Zd6Mxs+SVkFCHmcJ4=;
 b=SWu+pANoAP3IJMNTNwgtxXiksSMkzZlHSiRw+gujnMLr0CJQNGSY93GXb0Ur03irJZpaYyXNDh+fojANlGd2qH+KRovX8G5aWKSpfhEaXYpaUgbdqUUunMIm3fpxmy+1rQdAhEjXzrEyItNEwJA7P7BgLYdJsMxSeGU6arD0hFk=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 04:55:02 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::40) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 26 Jan 2022 04:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:55:01 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 25 Jan 2022 22:54:57 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Date: Tue, 25 Jan 2022 23:54:39 -0500
Message-ID: <20220126045441.3891-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126045441.3891-1-darren.powell@amd.com>
References: <20220126045441.3891-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b80e59b6-2df0-4623-700a-08d9e08802a8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4276:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4276627824D7C58D1CBF23B9F0209@BY5PR12MB4276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0I+zJvh9XV51bbCDamaGZJfCE40LoN/eBL/7O2LbXeaanDfpMOdrDKBxVGfZG4gz6+t4DNm/Y0GemOSbziBreB4FDG+6GNVKDIDiyyTbYSUBPzbyNUcVhzltxjtbqhfm5Heqwy/slat0hHiZFphghYqiGnCh45dyTft3IC8vExS9xb//2m0yHuS9uuWJGkzsfwYotG6Xxn+2g8qJl6yuQawzxxGmxnMvFT12uZ2ziXCaDvm4Mw4J/2M9oA3dQxzk54IxTnP6ULFJAFlAdFdb95eypnlQV53EuNo7ZCg4EIQfLW8wrsa8uwztmljwMs6JHR8tJfLtXNGeIjZlV77h1Sh8/p1a+S5WzssVZbyaDIEOuWcogK1Qeo3iUF1ilI5SgG4Rl0+vY+fIJ11Jyqj0NS7v3H3j13xRoYef21lHjhz3SagLl/+fQYBEhW95LoptHuU0r3hQmQ1Nvi972GmrNvZKU+7PruYxryizrf9GI6QnS3HUUWIrELYdwR7sLyKsn4Do0DYU83gvMK9tCcaouJmcAWF95zw88G5dEJQdd/pv2p/HTYqSrboldOLc3SDevVwj3X4Q0KCu5F32cX5iOQ3Kt4LTSJ/eWke4f5h8cCidzSdvnyL78Xuq67wRFLAwc1DORL74z5i+XzjilkH4fOgDOHFmECdZIRx11G/MtApvTCUnfmsa55Pdz8OpbfddAqP7fuqAC2MAcaULRbYsOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(86362001)(83380400001)(4326008)(82310400004)(8936002)(8676002)(316002)(70586007)(70206006)(186003)(16526019)(1076003)(26005)(7696005)(6666004)(2616005)(81166007)(356005)(508600001)(336012)(426003)(2906002)(36756003)(36860700001)(44832011)(40460700003)(5660300002)(47076005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:55:01.2684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80e59b6-2df0-4623-700a-08d9e08802a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   (v3)
     Rewrote patchset to order patches as (API, hw impl, usecase)

     - added API for new power management function emit_clk_levels
       This function should duplicate the functionality of print_clk_levels,
       but this solution passes the buffer base and write offset down the stack.
     - new powerplay function emit_clock_levels, implemented by smu_emit_ppclk_levels()
       This function parallels the implementation of smu_print_ppclk_levels and
       calls emit_clk_levels, and allows the returns of errors
     - new helper function smu_convert_to_smuclk called by smu_print_ppclk_levels and
       smu_emit_ppclk_levels

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 21 ++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 42 ++++++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 14 +++++++
 5 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a8eec91c0995..8a8eb9411cdf 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -321,6 +321,7 @@ struct amd_pm_funcs {
 	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
+	int (*emit_clock_levels)(void *handle, enum pp_clock_type type, char *buf, int *offset);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 728b6e10f302..03a690a3abb7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -906,6 +906,27 @@ int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
+				  enum pp_clock_type type,
+				  char *buf,
+				  int *offset)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->emit_clock_levels)
+		return -ENOENT;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->emit_clock_levels(adev->powerplay.pp_handle,
+					   type,
+					   buf,
+					   offset);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba857ca75392..a33dd7069258 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -428,6 +428,10 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  char *buf);
+int amdgpu_dpm_emit_clock_levels(struct amdgpu_device *adev,
+				  enum pp_clock_type type,
+				  char *buf,
+				  int *offset);
 int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
 				    uint64_t ppfeature_masks);
 int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c374c3067496..68430c824131 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2387,11 +2387,8 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
 	return ret;
 }
 
-static int smu_print_ppclk_levels(void *handle,
-				  enum pp_clock_type type,
-				  char *buf)
+static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 {
-	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
 
 	switch (type) {
@@ -2424,12 +2421,46 @@ static int smu_print_ppclk_levels(void *handle,
 	case OD_CCLK:
 		clk_type = SMU_OD_CCLK; break;
 	default:
-		return -EINVAL;
+		clk_type = SMU_CLK_COUNT; break;
 	}
 
+	return clk_type;
+}
+
+static int smu_print_ppclk_levels(void *handle,
+				  enum pp_clock_type type,
+				  char *buf)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
+static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *buf, int *offset)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+	int ret = 0;
+
+	clk_type = smu_convert_to_smuclk(type);
+	if (clk_type == SMU_CLK_COUNT)
+		return -EINVAL;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->emit_clk_levels)
+		ret = -ENOENT;
+
+	return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
+
+}
+
 static int smu_od_edit_dpm_table(void *handle,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size)
@@ -3107,6 +3138,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
 	.force_clock_level       = smu_force_ppclk_levels,
 	.print_clock_levels      = smu_print_ppclk_levels,
+	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3fdab6a44901..1429581dca9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -612,9 +612,23 @@ struct pptable_funcs {
 	 *                    to buffer. Star current level.
 	 *
 	 * Used for sysfs interfaces.
+	 * Return: Number of characters written to the buffer
 	 */
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
+	/**
+	 * @emit_clk_levels: Print DPM clock levels for a clock domain
+	 *                    to buffer using sysfs_emit_at. Star current level.
+	 *
+	 * Used for sysfs interfaces.
+	 * &buf: sysfs buffer
+	 * &offset: offset within buffer to start printing, which is updated by the
+	 * function.
+	 *
+	 * Return: 0 on Success or Negative to indicate an error occurred.
+	 */
+	int (*emit_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf, int *offset);
+
 	/**
 	 * @force_clk_levels: Set a range of allowed DPM levels for a clock
 	 *                    domain.
-- 
2.34.1

