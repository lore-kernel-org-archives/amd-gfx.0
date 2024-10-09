Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7716ECED614
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 07:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4A910E5BF;
	Wed,  9 Oct 2024 07:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qafZfcfk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0128A10E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKPS+1Ds8Zvfr5XSqkNkurnuc+iHTHukQ/SXX5092fHOb86GGyV+pthCf48Psd1UvVG5zitrUM4P1UxTDI36ymYj7/DAsm2x9aLs0hV6oszMadxrVpGpQF9I9hsBDgmAZGJakwZMcSqDA94Az3/a+3vQRjkS/teXFZcaS9IhA2vsHt4EGVbSW6e2ReoZ2kmut75aQ1Ng7LiJpM1XQYxqj+uHFOhJQyBHiozKxZfvLTHXFFmLUvRrlmK2GNMYIWODCC3v03l175FT/7lj8sNct4oRmPzSTPOwP1BhQgQ3lat+BkBZtquvZZLBN4nhoZ6UzMsuc6OFX0z++SVjiXL6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRecryg+YKmoWIVga1na9RIh4440sMyR9yrQI4gVqdY=;
 b=rRIDIGMV+ufsxA8U/w18P9uY48dA9DykhS+aFgBpCQ50DEMGW2Jo8FV+EwW8lfP0nycxE6evI2MfpoEsq5KHV8dZM0mo2+rqaHcRmnNAa5uQggIAofWIbdnPloRknuCkRHQb5rJTN9yWUiRSoAUmEbXL2IlhRdJzfHXf0R94JwFGC31qhn70/pIWuMyB/AfuIPJy2ya+pCZ4Xm6AJsgazj9cPnn7aQW6mSmdygGp345l2OzYwTjb9PEKEWbyxNfZNo4kq+CFfYs/ZrVGB7C4UgQUz/P0jIoKBWO3MUeM+pwLrQJfBFj4uk+XA7pyBAWX2AD0KDg0T7th7XPIXeg4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRecryg+YKmoWIVga1na9RIh4440sMyR9yrQI4gVqdY=;
 b=qafZfcfkgd/BxnLw21+nS0vArNDfPPJlwU+ORu22Uf6auBEYTXf/KLmEZ4tqyGQoi/Ngf/J9aNiOfSBMr+XoM8tlK2IxNmCvVBNjAuiQMjO2W7hQdGk0S1LOLQ+ipxY0v1PBB9jI8bSX60OiOzvHxYEAotruzImlkaecMdkk4LI=
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Wed, 9 Oct
 2024 07:23:56 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::b4) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 07:23:56 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 02:23:54 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v3 2/3] drm/amd/pm: implement dpm sdma reset function
Date: Wed, 9 Oct 2024 15:22:48 +0800
Message-ID: <20241009072249.546857-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009072249.546857-1-jiadong.zhu@amd.com>
References: <20241009072249.546857-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8058ee-9f05-4c8f-8eba-08dce8335619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KixzzutIza2fE6sqhVP20Kbt63fDm4WHLsdfrFWih8WisWhJ+3ZC4ROGE5Wk?=
 =?us-ascii?Q?In4M/W20Wazy4Ar4lDSOgYpVafs7a+3jP9icmvb5JdP+FZngFlRVEu+uhPkH?=
 =?us-ascii?Q?4JkCi1ij3PblT+FhL4Luwp/edLqFEBBcJTse6SFdMtsEGTPyR26qQ7Gt4rZ0?=
 =?us-ascii?Q?zneTOKMXeeclIwtmPpka8FoPvmq25sJSdlv+RnKHPN1ooQYtYovGVEvO4zek?=
 =?us-ascii?Q?6lI1aWUorj3oeQCNjOL3rAQedHPuyhPoJzkLw1BLoI3BpjDe62nNHLKuVq76?=
 =?us-ascii?Q?KvfNeIE4WoI4eEFGZgYMkcC2YKR/f/CeLUcZJ0cZmZ+JAdRkHpZKOiHUS8IV?=
 =?us-ascii?Q?VRMwNkn037XfmLzpMeJsrd09u8yi5SQ0RVuG8TlzAUvqANtgHU+3snTuKs7J?=
 =?us-ascii?Q?hX8kO7YScvnm5MN/63gQX4xHYe0KEZ81QrEJ5xpPwg0qiXnT4P4HHpm9EVse?=
 =?us-ascii?Q?pkUXQ6kUqX0KPskhYXiPTmIf8Wxz41O7YqEkqJk67G3KF3wIb6GuBe6ut1Q9?=
 =?us-ascii?Q?Tb3hwwGifoVL6CwCye2eT41YloiD3vgbGu4I08M1dXEO7z10UnPUF1oT8vhV?=
 =?us-ascii?Q?V9UQ8uJ67RcK37/rWpeEW5+wqMqLJJmyfTEvsLLyRXewF/EZ7fxM910tS5z/?=
 =?us-ascii?Q?D46ZGQTWbCBGX1qsKDbx84OlKypSxsStw3OOm1ApGS0+gdyMUUNu+LLJLm52?=
 =?us-ascii?Q?h6GE0QIXWLILncnhW9x0ssQGT+ZhRXWTJA1aUyHVxVQwdZVqOntvlnXi0KPs?=
 =?us-ascii?Q?nQys7qq39uhsMsFHfxY5n3doLw12RWPf+KE/HQVxYRbFPHKbGHv+N6YO9ey1?=
 =?us-ascii?Q?2H9yGGDO340ORHgCs840FiqbpeuIJ65L+V18TcIK4pcVhD7+aadjhrQg28ff?=
 =?us-ascii?Q?o2ox+MvS6U9wdIgdTN8oZeKd0suBKEk0BWXERyO/uLM387hhPymSXvwVU9zY?=
 =?us-ascii?Q?vQHxSy/L9dv6a4aNDB3ANxwvl2oS6EORvtpkewOI1csLWyZ2rkg4Ygl378BL?=
 =?us-ascii?Q?AgVBdsg05BXpfwJXE93xQiEHieFTaSvoZL60Wwe9ks985W9Bba8eWDzv6c+h?=
 =?us-ascii?Q?BpdLBDqm4bUA5nPTUw0bXqHtuDPHXCX5VndNhiQtjofQUABMK5WAKGwbd3t7?=
 =?us-ascii?Q?y4DfZeAFtaS5aOye8dLh20XMSLpBRzWQ8gmcP0Ikzu+V7j0YEmUS0N5B54Jn?=
 =?us-ascii?Q?hWvf1JO1cliJTLX1LKrfljcRfTkBMyu9S1Xg5F0/R0P2WK9LE6Vz4gKRqjqE?=
 =?us-ascii?Q?3bMCEnAYxUqOCytxPnZtVPKijzVVGvzOkMJQyMYKg03hbZeFxWE+GHvSmeKe?=
 =?us-ascii?Q?gOqTxoQpDnsqQwNQfT/6gn1ZiCE+7WdLr+2VJNCnckr1nkgfQRd1hipwc+Fp?=
 =?us-ascii?Q?cRey0DR4ud/GmvoCp8ejBH1pgssN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:23:56.4478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8058ee-9f05-4c8f-8eba-08dce8335619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma soft reset by sending MSG_ResetSDMA on smu 13.0.6.

v2: Add firmware version for the reset message.
v3: Add ip version check. Print inst_mask on failure.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 ++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 +++++++++++++++++++
 6 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..9e7a652d119b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -700,6 +700,21 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_sdma(smu, inst_mask);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..41fb6ef984bf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -597,5 +597,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 			     int policy_level);
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4a6b4ad97f06..590d004046ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3820,3 +3820,13 @@ int smu_send_rma_reason(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma)
+		ret = smu->ppt_funcs->reset_sdma(smu, inst_mask);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b44a185d07e8..5487d9d84a4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1371,6 +1371,11 @@ struct pptable_funcs {
 	 */
 	int (*send_rma_reason)(struct smu_context *smu);
 
+	/**
+	 * @reset_sdma: message SMU to soft reset sdma instance.
+	 */
+	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
@@ -1630,6 +1635,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e71a721c12b9..855eb57c734d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -275,7 +275,8 @@
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
-	__SMU_DUMMY_MAP(MALLPowerState),
+	__SMU_DUMMY_MAP(MALLPowerState), \
+	__SMU_DUMMY_MAP(ResetSDMA),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..0e4e0a5f2e9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 };
 
 // clang-format on
@@ -2697,6 +2698,27 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	/* the message is only valid on SMU 13.0.6 with pmfw 85.116.110 and above */
+	if ((adev->flags & AMD_IS_APU) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
+	    smu->smc_fw_version < 0x0055746E)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ResetSDMA, inst_mask, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"failed to send ResetSDMA event with mask 0x%x\n",
+			inst_mask);
+
+	return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3342,6 +3364,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
+	.reset_sdma = smu_v13_0_6_reset_sdma,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

