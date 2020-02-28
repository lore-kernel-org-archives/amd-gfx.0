Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C7C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3788C20578
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VmX8MBjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3788C20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCF76EE92;
	Fri, 28 Feb 2020 09:00:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D646EE90
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnjZHqPH5Wmha7pemteWSaq85QwxGdN8nJCw5e29eyuxCoclt9OsYSR/pxin8+I77CXTChnXYxeNrhUVpbnhbLl664BFih9jlJZB5Ls31vjv3ykj4N7WQXZ9NHpIN6vpDG94NggCXCtTLeQ3O9khvtO6KlhWIiT/FHsjW0D3RiT7g1FE+ok5rGaLX6t4iVhTYNafLjYChABHY/Ntql0nnM9bAlIjiZOyFrh5D2rgQq+DJngGIRxkjGyDX0pVsu2bzy0FXEfY7gpE9M4bA0mz/r359tCdgsKrbVc6B+fdT5M/BGW67BGDZgYZMgzoCAu1hAG37X2sdIAI64I0ql52HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8z9aeybZQF/rnFnhXPug0CXJS1+iDx+wX11FjjjR9Y=;
 b=IKxh4JzrGgDbP1eAXHDGdn0EL4rdYroKHAU04t+BVN9aX4mqzPv1k0e/3xqGGNRYhnRpAFQ73wkUTz7ZyW+W4yRUzAFCkvJNe0CUAe5M4hpNUAo7ZyDBOH861nzzy9M/eMtEA56jcSo/qBAbstp+rJclsnNEmJr567PHw8RxIxfI6Ovr5jljuxJyh//x0ZC2P3c2diYKfMksb4MkA5Su4Tf4c23eFhsnpVmfDcMK53fwxHm2PueYAjZGQaspG4SU7dV320R9BoVXcqpKDT8dTskSu5dv0nrKdXbDbOaR+LzfL3KkFmcGLUVqnhOTtFCtWVguN++EXK0fKO0/ankLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8z9aeybZQF/rnFnhXPug0CXJS1+iDx+wX11FjjjR9Y=;
 b=VmX8MBjSL1ShfA9KgWIPp0/jniud60CPgm5ZcsnINV8faPbPwygwpZQEzEuOJijDTWsjZrafIDgnk5euUVorG6O0f10A1tq3Wwi8eVgHfIJE5UPR//shw81EvxLWA/jZBkFLTEBEkeT61PLu4IEZnrgfnatCjl12ApYJUakhtg4=
Received: from MWHPR20CA0010.namprd20.prod.outlook.com (2603:10b6:300:13d::20)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 28 Feb
 2020 09:00:35 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::44) by MWHPR20CA0010.outlook.office365.com
 (2603:10b6:300:13d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 09:00:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 09:00:34 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 03:00:33 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 28 Feb 2020 03:00:31 -0600
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add lock option for smu_set_soft_freq_range()
Date: Fri, 28 Feb 2020 17:00:09 +0800
Message-ID: <1582880410-12400-1-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(428003)(189003)(199004)(356004)(86362001)(5660300002)(316002)(8936002)(54906003)(81156014)(2616005)(6666004)(186003)(2906002)(26005)(81166006)(8676002)(4326008)(70206006)(36756003)(70586007)(336012)(7696005)(426003)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3594; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93a7b04-1d8c-42e5-1596-08d7bc2cabe8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35942F0DC4F02D7824E5F0438BE80@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYfjOxI/ro9u9fC/6catHlR91D+A+cpkbsoXy7x64tW2qwfT/UObqV+rKQv50dmBEhbTFy9qfvngVYdD4E7bPOrB8TevwCtK6kzNwxPhI5PsV0Ft/b0g+RPz0oH1Jgesg6eyofZ4kZWaHD0Wz5xCHte9Tuiobm0eteguyYUd4Nds1Ac+zHlTQshw3/nmDSstpyr/e63krqFMAp/hbRaCsQLL29DiSAwjoZMZ5BLjnltLMnYbpyEkEFICfqpNPVmqVWY8tnBbedlX+2gf/W4GHMEBYC0seQNhsurEjGUOJbNZcvyuH1sX6sqtSM51MJSvNK5D69IY77ARIXx6LAPyhFIBapTNiTVTiBWdOd+sbr2dL2wDDsYb9vtFz6YbK/0pKnqxJBjAlZl/g23+f2bLE+Fp9xzqf7cD05Z+fnJEkgGfTLYJFmHjNRILgdHQ9IV4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 09:00:34.3302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a7b04-1d8c-42e5-1596-08d7bc2cabe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: Feifei.Xu@amd.com, Evan.Quan@amd.com, Kenneth.Feng@amd.com,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add lock_needed param for smu_set_soft_freq_range()

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  7 ++++++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 14 +++++++-------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  8 ++++----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9f6da26..e3398f9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -210,7 +210,7 @@ int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t
 }
 
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max)
+			    uint32_t min, uint32_t max, bool lock_needed)
 {
 	int ret = 0;
 
@@ -220,7 +220,12 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
+	if (lock_needed)
+		mutex_lock(&smu->mutex);
 	ret = smu_set_soft_freq_limited_range(smu, clk_type, min, max);
+	if (lock_needed)
+		mutex_unlock(&smu->mutex);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index d652f920..c8e72c7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -707,7 +707,7 @@ int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max, bool lock_needed);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max);
+			    uint32_t min, uint32_t max, bool lock_needed);
 int smu_set_hard_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 04b569d..6e41f3c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -970,7 +970,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			return size;
 		break;
@@ -1094,7 +1094,7 @@ static int navi10_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq);
+		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -1120,7 +1120,7 @@ static int navi10_unforce_dpm_levels(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -1680,10 +1680,10 @@ static int navi10_set_standard_performance_level(struct smu_context *smu)
 		return navi10_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
 	}
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
 	if (ret)
 		return ret;
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -1748,10 +1748,10 @@ static int navi10_set_peak_performance_level(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
 	if (ret)
 		return ret;
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 2ad6d8e..cca4820 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -423,7 +423,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq);
+		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -456,7 +456,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 		if (ret)
 			return ret;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
 			return ret;
 	}
@@ -704,7 +704,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
 	if (ret)
 		return ret;
 
@@ -712,7 +712,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
+	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
 	if (ret)
 		return ret;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
