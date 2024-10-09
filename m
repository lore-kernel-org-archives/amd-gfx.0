Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7807FCF043B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 03:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAE010E635;
	Wed,  9 Oct 2024 03:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teL/hQQt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897A110E634
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 03:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvBDhZ0dFWqpQNCuNTt4nPgPebqrCQYmuv12W39TLsAJgRAlEJxIzLaqaPmiz2NgZF3LW+gxjOxA0KB19H+P8z5R82DfC+HjVGqTyTM3vgcLlaPeiwAiUAZWJxoK4pDs+2o9AA39wn1mVVFrPIWMQl0kvP3Wcg143JXlGeCiVZoWh3pxXPvR5L3aROXHJBTUY4iOqFHeXKavwVeaUR+qy42M5hbDKg9yjyXLuJe0jZSziGEwMa/h5eqOqWRrMYWoyLUD8bdREbnVZYdfBLmk0p1V2Yl9wcUhwRIQhSdwjTwlgxGP3JIqI2gpIZ0GkpqWGDJtofZoKvV7/CdRWpIq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Xt/nbUw7LQFD7GeUa0WyC2MGhU0PwxlKkjF2dYgPaw=;
 b=NhXjq3s5v7cV5TkEc3BLjVxJPS7dmxY9K9hYZ1y/dja1orcXZ3XCvKIB0gqLmZtWD8d16D20wMs2JX4GrC5z9dPUOTfrE+KnVKlEjUXRDNIJ8eaM/CtOy3nCJEeQSz2i8kms5qaVMfVDbGvqCxs6PmQzjve8xjAB20qdXD7FrfqupqPNcjOFXrh2U6o4XegpG++EjxxT2Wi0b7JCivGUxrDdQsTWriFS14BC0uItJSyiku0/QNVs4Rq0wmP2nWGe+9BuvTm0QLZ6WXJfnyHJngr2RjO4Q1EN8icW15V44av7WP8ViEgbGpMXy/vEEo0Bhj0UhjOp/wd369w0I2+9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Xt/nbUw7LQFD7GeUa0WyC2MGhU0PwxlKkjF2dYgPaw=;
 b=teL/hQQtIlw4pUmgKhx3gji0S1ukiqDvN9P5+vqy4v7Hb0UqKLt3s8ZZBAON3reV5zyCDcCNN5Mqk2GkthyO8OuywXNuETVVl8BNahB4OLUpuvI60+lnnW4J8IbRVyYIp2WsafdMeRsNv0P2bg6UVvfvLmE65et0fQxevRkR0Lw=
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 03:46:03 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::f1) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Wed, 9 Oct 2024 03:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 03:46:03 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 22:46:00 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 2/3] drm/amd/pm: implement dpm sdma reset function
Date: Wed, 9 Oct 2024 11:45:44 +0800
Message-ID: <20241009034545.543736-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009034545.543736-1-jiadong.zhu@amd.com>
References: <20241009034545.543736-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ddd017-f64b-422d-e1b7-08dce814e5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JEj1I5efqPxd6SWFSzJjy28yMHrw0CWiBzRyK6//+2gUUkLrtqUEkWNeR+la?=
 =?us-ascii?Q?aHxB+StQWB/9y6Yepa2IWwRi8enGiyIliI6OCL2QmOqJz7m+/mn1hB7mdkJy?=
 =?us-ascii?Q?3ZnauItlhY+Y5lI7eEQDuNZDWYv2MpyDmmtrgpUU3A9dV6q4sLOT7PaonQog?=
 =?us-ascii?Q?paOqdiEp97xTeMBMgvpnFmp6DVm+jycM548ybL9p9eSQ9kBp0ETkwX5k8Vq8?=
 =?us-ascii?Q?lXuAe9onlowngjbLPF6oZKq/CkO2RWqZpGgG7ELLEP0H7GU+jawQPZZbH+nc?=
 =?us-ascii?Q?kpKtdMUyWYom87ufdo0Al+sBNjOw3bGAV+cWP3ykpM/Bnj1SHTRKrGQMd+93?=
 =?us-ascii?Q?O9uUz+hqwFFS+o4SRCF3T1I1owmD0JRWk3IQY8Lc2xheB/efofyYmt0tIKFO?=
 =?us-ascii?Q?fLjWWNCwqSWLvZ6VJ9wohvdd2o1GMjOTPobJD9iqUHisrf3ui/JHqVSAFWJa?=
 =?us-ascii?Q?kDSdxAfMSckOZzUdqZ0z2cF1rA1FDVgLMXJOWsAoiZK5uN/ta5mxjnE+Nk+T?=
 =?us-ascii?Q?QnV6JfaeD1/Ja4EZjDfleuwHJR5ZqrmYhcnYwuOWAqvtu+X1xAqt4LhRlJvU?=
 =?us-ascii?Q?cnbF3lVRo/fcWz2WI+2V5Lxy6hjEL2N+PqVdNJGyY9VqJNqT89qmYqpqoR+L?=
 =?us-ascii?Q?6olCIzFyEnX2UpnIFWPWr7wQENgJEzaa8SimPsy6bKqj2I932CoW6C7r228T?=
 =?us-ascii?Q?PellbrRsXG3fp2ualJLA2uI2Jdap7O79MagcWXZswh3I5u40jFbZM107F8XO?=
 =?us-ascii?Q?Ca5EMVLIxHhklcS8DJtNok1FB6arapT7wYS9Qu7Nz9kPwcsc53Iebt3tMiTc?=
 =?us-ascii?Q?/E0cdNV6XlKyoPfAqmxYzT6P7lZ2SXh1RGEGXDpA6ioolESW46MBtlTaC+YD?=
 =?us-ascii?Q?b6jfE2hqSNXs1HVgpA4IRLjCG72pPIbUR6yOwIwafi04kjhcf+L3/YJQouQv?=
 =?us-ascii?Q?Nw11r6FzdIFGJDlX4ZIiGA6g/a1cz5dMWBRfR0JJbEJJSBk6CFY1oWUg4b/I?=
 =?us-ascii?Q?Pk+Cf+MnhLI+t+zeL5ElWM976IpU0qDtcHBRwa1jinZm9D0BDwU415YK9f3G?=
 =?us-ascii?Q?vsfRgA2NClvrgFG6ZuHLhZ03s7ZR7OLkV0uI1lsNLj4voXM0YIIJl7DqZczR?=
 =?us-ascii?Q?9kTvBHW0m1Y7vk5h1mjszj0s9aoeWmA5glVdaa8QCF94d46kM+QKpLCNeQbN?=
 =?us-ascii?Q?K82qn1QdldBEq68g+ZXQPro5mBulEbcvD4W74y6LAGa3iCLOsSwMUuWLi+DG?=
 =?us-ascii?Q?zQFcaoMYBf40HaY7cSRiUlE3h6rougwz3ycMwSnOB7K7MDFkvxKfkQv6spIM?=
 =?us-ascii?Q?Hke2K4Dqr03ntoEoJfuJm466znjiyG5JjXOX+6Zj5Y5JoCzPl5kgagoNC1CB?=
 =?us-ascii?Q?kYv/duZskz3CA6wLRYHoTb6bSaeo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:46:03.1255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ddd017-f64b-422d-e1b7-08dce814e5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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

v2: add firmware version for the reset message.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 +++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
 6 files changed, 55 insertions(+), 1 deletion(-)

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
index 52f3c537bb3f..42c38ced209c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 };
 
 // clang-format on
@@ -2697,6 +2698,25 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	/* the message is only valid on dGPU with pmfw 85.116.110 and above */
+	if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x0055746E)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ResetSDMA, inst_mask, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"[%s] failed to send ResetSDMA event to SMU\n",
+			__func__);
+
+	return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3342,6 +3362,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
+	.reset_sdma = smu_v13_0_6_reset_sdma,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

