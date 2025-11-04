Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51CCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB59A10E24C;
	Tue,  4 Nov 2025 06:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIrUepKz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9FB10E248
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXOvtV3Hjn4x/RSnYfGhLrMi3Fi0S7tS4sCEm/FV4+hNrb9idwiBXQytLZesYpzfSYVozV01PaHw9AYiplR36GjITcQ0kYxWWKpc0LsdC9IIpwdZgl3HvxXKCOw6utYUY5Rp4K7ekGCy18wE9/ABjgn3XTMdchbHyQyErJsqF9LAg8n/9UVLYo5lgTKDLbeEZi2U5FbEBUIYaYki6cuqBmyjxveOU9Y9u+VzjMMPGFweAq8L2whXJIaAofmTftEbOlo+Gz3mUQFF0zABiBxLXHgPNuPNJMXiDk+/XkdUELDZwKntkURJXDI9HGDFNhirtDIfiEm4XHTiJBu/wjUGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ofgD1jRpsMHwbOH4UOyYSSzir6BIQL6xAkeWPmkjE=;
 b=IIDY3R6TJxQqqX5JKVwO6AE0rAX5vcZxVO9h5uKfq1u3eIj9iGGIMpq5ovDpcXcXe0zV26U2eLsJXjnemd1KWQNeoPHeBJ7sw2wBRxoV46sM2gUV8YvFDh1PcjD40YH4LQTwLAi4ZQ6N6D6iURjvfzi9zaVvAE/v+PtXHN3Ook+hEx6gvqPjzbZwjAB0r32pSpKoTWjUU4e5OQaB7lF6PRGiuXJ2hLT5+tbf+fnlzLztmzkDWe8MN08m4Q4SDvD/bac+1A/RH05muHTKuzOgRZn/5pURA57lcK4Qq5ewNRPVIQU2frUNk/hwo9CUTbJ0r8a2xxYDery7MoFU+Bg7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ofgD1jRpsMHwbOH4UOyYSSzir6BIQL6xAkeWPmkjE=;
 b=tIrUepKzT8JSK7Hk2vBhu80btnlrCrhMhC9i0a3WsTVE3q9K78EkIo4wYHi/onYHqiMrYnbiazDqTmROjn1vk/Z9UV3vtx7Fu0tbwnfzZ4TUo4Oyyc27rR+OwZdLvRdO4/j1XUaY1Rvr9fadZB4qSCO+4x1fQMUflwjoccra+Aw=
Received: from BL1PR13CA0377.namprd13.prod.outlook.com (2603:10b6:208:2c0::22)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 06:58:17 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::fc) by BL1PR13CA0377.outlook.office365.com
 (2603:10b6:208:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:17 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:15 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 03/10] drm/amd/pm: add smu ras driver framework
Date: Tue, 4 Nov 2025 14:57:38 +0800
Message-ID: <20251104065745.1737050-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3643e867-a5f8-4e7e-44a3-08de1b6f884d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1BxDCwiOMAL3KxShknjVXcQ0l/hPwa2L7FoyudhINkpSWJmI3g68QxgBxxxm?=
 =?us-ascii?Q?WzjynqTBo4CpQPkFH+z1i8vnoOfWIbtwwYvVEZnbs0XKyftyUGH7sJ10PSCz?=
 =?us-ascii?Q?IF61317fPDBg8TMU6QeWD+6+F9PmsC6rcvka0K60XRv4CsdDmx2FkJkHzxnV?=
 =?us-ascii?Q?XSXZsV0KGUw0IwEun/VAwa7Zyks0P4+49zPbiwkdsRPzik9jleZORIrm6mLM?=
 =?us-ascii?Q?KFDpxjnAj0KajE5Kc3sX8/8FvCDCzNTtnM8e2VEm2IBZATgiZKLHXSz+CbTB?=
 =?us-ascii?Q?OcfO6XTKdjkXYaPqjHy78bIiHhFrGfQh4KFeDyk8ejebx6OwzlMvzGa2my7i?=
 =?us-ascii?Q?mdz7sGpEQTINuDdyXKj0Tqc4NifrBH9SrW+S0nT7kIFNpyL9WmK+8HYHq2bO?=
 =?us-ascii?Q?G1n5y6WHFOqusq5+reWSGOOwR2gfjog9Xmfe/KGheM+/2lNLR0/3Tg+pnmEQ?=
 =?us-ascii?Q?1iPIDsUDjjEXnmtu8PQtt81j9wrdFb/s73Ze2VLREw+Q8FSPD2AoMIa5x3R1?=
 =?us-ascii?Q?cOk5wsdlQJ5ykjOPwElOBUIM4BCDYHSJ1FN+naEEgQtSHPb2IgqSRhM+VsAp?=
 =?us-ascii?Q?Ubo0V9A73FsDWh6xMq1qGWeQMCU+rswWTGRjPP3z40r5R7fZROkopMkIK+U4?=
 =?us-ascii?Q?5GONvYyw1rD/5lfZL6r8yud1l6tgyhfagF0Otlmy/AgLP7qgPQT5QJdYJiAs?=
 =?us-ascii?Q?A0iG1/q63EHa5eVifqO4aVz8tAE2Il4SQKl0WWKcMtoMrBzGPZvO2CHJ2iev?=
 =?us-ascii?Q?qYkP4TdM2M9M/lNxABUCdoyZssZyA2sAe9pH04vS3VztDmBXTm0GVVGsx40I?=
 =?us-ascii?Q?ocfBkq1CWsT31m7VuHhuLUxuxGYRcO7BwmOiTK3TDshTxg2vNPJoebx3RO8B?=
 =?us-ascii?Q?nwERkNCL+KJ8LVLNpqvqxAeO+9r/oTGRqfWKH1ANunbbxRM3VIJAiFiqLnXM?=
 =?us-ascii?Q?ThIOl6f2Mk98JRWnAVYEvfD1v8Rqa/YyRGQAtBnSm7/kQKmUJ71uwNQrL46z?=
 =?us-ascii?Q?i8RvArVuphhkKsRHWhBKVm5LaJ/tvUmyOGF6GkFcFOgQ3PTBumQ+M+PjnMxT?=
 =?us-ascii?Q?CwWQ+CugqC1ChzZ1uDH5oOgjc1W1IBJh3CeZcDxESu4C+0qtvo40wY5rjcJ7?=
 =?us-ascii?Q?EFtK7t5gahspSW7YE+gGs0NEuGLs8M0c+scHUikrEQBvqdN0v9A50hhGug6N?=
 =?us-ascii?Q?P919Aydzo4P0yoZwR+diIdQy81OjmjvczJ/ZR82hj2OvuUcH4DTz0HeYA/22?=
 =?us-ascii?Q?9VW4hFNoX3nPcdSelJ5wg9DGoaWjk7tBmR0YQWj9Qk4DU8xAf4HYC9c/FM7I?=
 =?us-ascii?Q?R2L7yO/DQqTnIjP1TKOcspt4jnCzAbn4qisoAIwSGOWNsl7r2dgdEeJwq910?=
 =?us-ascii?Q?ko1fMg1yPWQcaVSa6brdGXU657T8LHKI/YkSujpEZt4zAcq767F/mrPxvlrF?=
 =?us-ascii?Q?q6bw5WRDvINLyexreAvRwYUVxgEIgYgDGIuACUfbSDByMvgJyUmp0RCWrgfF?=
 =?us-ascii?Q?8wKkQyLtLqCcaVXESjBYhlQnl6tfbhWZYIUACJklvHCbPQTVMzMKXbEJxZE7?=
 =?us-ascii?Q?/SQnmNTROyJoX6KVD28=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:17.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643e867-a5f8-4e7e-44a3-08de1b6f884d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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

add functions to get smu ras driver

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 +++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 7 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3c0b36dd37bf..674bcd3c814c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -620,6 +620,7 @@ struct amdgpu_ras {
 
 	/* Disable/Enable uniras switch */
 	bool uniras_enabled;
+	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5c4d0eb198c4..c6f55d3522cd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2122,3 +2122,10 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 
 	return ret;
 }
+
+const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev)
+{
+	void *pp_handle = adev->powerplay.pp_handle;
+
+	return smu_get_ras_smu_driver(pp_handle);
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index c7ea29385682..aa3f427819a0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -612,5 +612,6 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
+const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b3510345a32a..c0e7c45ac0e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2803,6 +2803,17 @@ const struct amdgpu_ip_block_version smu_v14_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
+const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle)
+{
+	struct smu_context *smu = (struct smu_context *)handle;
+	const struct ras_smu_drv *tmp = NULL;
+	int ret;
+
+	ret = smu_get_ras_smu_drv(smu, &tmp);
+
+	return ret ? NULL : tmp;
+}
+
 static int smu_load_microcode(void *handle)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c48028abc8c4..8815fc70b63b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1531,6 +1531,12 @@ struct pptable_funcs {
 	int (*ras_send_msg)(struct smu_context *smu,
 			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 
+
+	/**
+	 * @get_ras_smu_drv: Get RAS smu driver interface
+	 * Return: ras_smu_drv *
+	 */
+	int (*get_ras_smu_drv)(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv);
 };
 
 typedef enum {
@@ -1795,6 +1801,7 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
+const struct ras_smu_drv *smu_get_ras_smu_driver(void *handle);
 
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			    uint32_t param, uint32_t *readarg);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index de4c944885f6..095f54b7e9e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3905,6 +3905,26 @@ static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
 }
 
+static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras_smu_drv **ras_smu_drv)
+{
+	if (!ras_smu_drv)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(smu->adev))
+		return -EOPNOTSUPP;
+
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 12):
+		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
+		break;
+	default:
+		*ras_smu_drv = NULL;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -3964,6 +3984,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
 	.ras_send_msg = smu_v13_0_6_ras_send_msg,
+	.get_ras_smu_drv = smu_v13_0_6_get_ras_smu_drv,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c09ecf1a68a0..34f6b4b1c3ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -100,6 +100,7 @@
 #define smu_is_asic_wbrf_supported(smu)			smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
 #define smu_enable_uclk_shadow(smu, enable)		smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
 #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
+#define smu_get_ras_smu_drv(smu, ras_smu_drv)			smu_ppt_funcs(get_ras_smu_drv, -EOPNOTSUPP, smu, ras_smu_drv)
 
 #endif
 #endif
-- 
2.34.1

