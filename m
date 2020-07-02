Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36000C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0827520760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BltHiZQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0827520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC64A6EABD;
	Thu,  2 Jul 2020 09:47:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760050.outbound.protection.outlook.com [40.107.76.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345456EABD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq0gMVljnTiOj88fHn3LRc0PeTv/PhwUKSORY3SACO6RUeLFXwpnpuaRrRXdKS8dbAWUNAu6TgXkfr4rB5Nu5r8YpvNu4q7VRNvrRfOqSQ+a7svweHJHDZL6NyFP28F35U5v3r4l+L2J0sPEVQCPGqeSJVcQFSptf1pUzkJtL8MQfyXm3+Qw4v77b3Xix53XP2+ILNzwhaHdjkBJTYXLcaJ7JQ7dkxzlsmpVQAkEViXvSYKc2WELjpZq9unKTTfG/SUOOHGsykqB615K6M0vl8WZXuY8OIZcA5rg0l4aWLnUUVztwmBxOLN+EClQfien93sS7z0DFjkwyXtqm6CQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErGkTp7JklG5ZV+yj9fN1OFVGIl+1CzBBG5XVUAz7oU=;
 b=Gh7aXhYGAwUXIuCp9378uDQcV1/joZXaxVsgu/MHB0dCi8pgH9uslMFiOcfuj7bO5+Sn1eMG2jP2wiXLtseLBQ2E3X4tX4hF4ewQUDJiSu48zHu8ntVf5n1VPKvLtDNdFp3435wx6mmdO6BIw6neRuCdS/E+k8U4quoRvtxgBFbwg3C88Gybg7JCvUgwCu357T6847Ub5W7mH9BZ4POLjlEI7DBRZAlsuUYXDz5OOKJNBqS81hbYDjQ9BAjlfRHe2MLfeNcHXKuu3OEWOCOAMHWuUuJ2EmhaM0ds8zeS6bFYvAHtSYQ2XJpSOcMAtynurcLTsytC3fqIcpSg2lmgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErGkTp7JklG5ZV+yj9fN1OFVGIl+1CzBBG5XVUAz7oU=;
 b=BltHiZQCfwXfpurkTz963AabAX6mJuF8o74OuE7nmJxIH66m1zsHq9u+LlH4VULcCTh3ysAiwJygLUxo1Dg93oXBFKGi33xAVu2l9fZNba2rHeM4nDY4C1cnKbuIww0tEOAQfXt8+bWHtb6rGZSZ4SHOXIO+fSxj7OkN1vHBAMs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:47:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:47:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: revise calling chain on setting soft
 limit
Date: Thu,  2 Jul 2020 17:47:00 +0800
Message-Id: <20200702094702.8223-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094702.8223-1-evan.quan@amd.com>
References: <20200702094702.8223-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0051.apcprd04.prod.outlook.com (2603:1096:202:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 09:47:28 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e31f59f-2b99-4526-8a48-08d81e6cef6f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021937F61C4000498EBDAAAAE46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebnh1vNiK408yMBzaVwxICwgrNnfUAYoA0wD1noNOV/63lIMnay9d0hqcXfeQ6teC6u93uVFASSyka82IEGBy/AJw8JGx1UnoWiqTzq2BOgUlC690siSp9cJqd8EQROXTZk1wMu7vGov2OrSSBWWgf8dwHySrpxQa93564hbKVk64PadDv3CbwNop1HPySyX+4MrOCdUSeJVX2E7JKlHNeGEZuPu5/KESWAWA3rgJVqcTas8mMQIMHLNdq4aDmPxBarlcMwC/8o01sGmVusMEEcewpgQf1Bbjp+Uw0xHBEv2Cgoor00ircyShPxgjpCXayMJwkJ7OOebLB9UKiiPxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66476007)(66556008)(2906002)(66946007)(1076003)(44832011)(8936002)(4326008)(6666004)(478600001)(26005)(186003)(16526019)(8676002)(7696005)(52116002)(5660300002)(83380400001)(6486002)(956004)(36756003)(316002)(86362001)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9gYUIu2I3AJljsxfGMRVNUUvXjrbxOE1jj4dgVL/UoNYHxvOKP3mWN4V2lf1hTwLx3I1vdPiqJTAfygA2k7Y6ZGaNPX0J3NPDGObg5xVKNLzK/4AKUvsUU+HEXtkLvIYkT2sjU3QpQbvh+BwWjmZgFQh6pqR64V/aIhhRR6xQT0Rni65L3JLT3DHs6JFaE1RO27LSgA0xR6VFA+WyEU5M+WaB7fTOFBtpKCllijuSG3BWfSH8sQv5SgwURLglWxDk/p5Y0UHQFZkaKBDrmWqapFQQlmf2reEQgpvIpczTxNHdmabFLg+STxFfoHkskV/zLHyft+7kZkYPdPFL3jI1H3LPm+i26bTKuvKN49vYqkUe8QirZ6gRYWJrCtkC+8cA9ON63N2yy2KXYVa9Apg5IezO8JvnclTCQNbZsCX0CFyXtuyKUsbDV/6otUzAycfGdtZS7IYHjPTHU4A4kwFwNCUA4JUYq3M56YU+WScv4Xt4YwDtCpMvqpr+HTGW1on
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31f59f-2b99-4526-8a48-08d81e6cef6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:47:29.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsXsIQbjfupJCuPgibh5kgk5bPOm7A8tfR+elIMZmiZyJuPbEqi5eJz+FtbUJZ95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

This helps to maintain clear code layers and drop unnecessary
parameter.

Change-Id: I2d27547414d964552d0515e76e165d34c8ce0132
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 20 +++++----
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 14 +++----
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  8 ++--
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 42 +++++++++----------
 6 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeada7c9fbea..fb89204c0070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1464,7 +1464,9 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
 		if (ret || val > max_freq || val < min_freq)
 			return -EINVAL;
-		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val, true);
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
+	} else {
+		return 0;
 	}
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fac5288f1502..560df8593d32 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -238,19 +238,25 @@ int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t
 	return ret;
 }
 
-int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max, bool lock_needed)
+int smu_set_soft_freq_range(struct smu_context *smu,
+			    enum smu_clk_type clk_type,
+			    uint32_t min,
+			    uint32_t max)
 {
 	int ret = 0;
 
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
-	ret = smu_set_soft_freq_limited_range(smu, clk_type, min, max);
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->set_soft_freq_limited_range)
+		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
+								  clk_type,
+								  min,
+								  max);
+
+	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 1070fa414f70..ceabce4b4a5f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -722,7 +722,7 @@ int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max, bool lock_needed);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max, bool lock_needed);
+			    uint32_t min, uint32_t max);
 int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t *min_value, uint32_t *max_value);
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 47c708cc6817..1da4f6fc3e7a 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1066,7 +1066,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			return size;
 		break;
@@ -1190,7 +1190,7 @@ static int navi10_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq, false);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
 		if (ret)
 			return ret;
 	}
@@ -1216,7 +1216,7 @@ static int navi10_unforce_dpm_levels(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			return ret;
 	}
@@ -1772,10 +1772,10 @@ static int navi10_set_standard_performance_level(struct smu_context *smu)
 		return navi10_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
 	}
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
 	if (ret)
 		return ret;
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
 	if (ret)
 		return ret;
 
@@ -1840,10 +1840,10 @@ static int navi10_set_peak_performance_level(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
 	if (ret)
 		return ret;
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 00fac13f06d6..0da8dc3fb7b9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -439,7 +439,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq, false);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
 		if (ret)
 			return ret;
 	}
@@ -472,7 +472,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 		if (ret)
 			return ret;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
+		ret = smu_v12_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			return ret;
 	}
@@ -720,7 +720,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
+	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
 	if (ret)
 		return ret;
 
@@ -728,7 +728,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
+	ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 1684a364f2e2..3a2f8c696ac0 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -858,6 +858,22 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
+				      enum smu_clk_type clk_type,
+				      uint32_t min, uint32_t max)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	return ret;
+}
+
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
@@ -893,7 +909,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
+		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			goto forec_level_out;
 		break;
@@ -991,7 +1007,7 @@ static int sienna_cichlid_force_dpm_limit_value(struct smu_context *smu, bool hi
 			return ret;
 
 		force_freq = highest ? max_freq : min_freq;
-		ret = smu_set_soft_freq_range(smu, clk_type, force_freq, force_freq, false);
+		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
 		if (ret)
 			return ret;
 	}
@@ -1017,7 +1033,7 @@ static int sienna_cichlid_unforce_dpm_levels(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
+		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			return ret;
 	}
@@ -1568,10 +1584,10 @@ static int sienna_cichlid_set_standard_performance_level(struct smu_context *smu
 		return sienna_cichlid_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
 	}
 
-	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
+	ret = sienna_cichlid_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
 	if (ret)
 		return ret;
-	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
+	ret = sienna_cichlid_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
 	if (ret)
 		return ret;
 
@@ -1751,22 +1767,6 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
-static int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
-				      enum smu_clk_type clk_type,
-				      uint32_t min, uint32_t max)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	return ret;
-}
-
 static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
