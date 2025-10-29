Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01DCCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0B210E70B;
	Wed, 29 Oct 2025 07:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f49uE5gU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A6210E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLJllJUw+tJEdN86HTUHRB6wjAjgf23Yne7G0KDBhWlz8pIlnWxFS1SkHjYaYguq7sp343VbDtH0n/c65bRMolAVMBo00Yn9CGNSKW9wQ/Ryqu7QpMDQ4mkrW7UCZmfnLHoqfXN8OlDv1zAfPx2LFnMqUylR8M5d8Azh3vlS9Tqt6hVJiZfS4YIJVribwciTJcIkdKcm0H7Z/3gnHTPVsZdlUbm5IVe1rbXf66WEbTkY8/EW6OxKAIX+Cl8SmKpQdNxseiqO3RsLMsxy84+6wkrJoUTj4CcHXkEbTzHbEjnn9MIORZ4xvX2PdJAOy+yAoSNl1MshsswU+dtlTXoTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igRx3XsWurPNQM3SpJ4pNTGyz0hqQaja/V7NJM/yXi0=;
 b=Qq5RDvoZmgcmE284GmqJVT2DzMySI0UkkPaJpauSkyf+O2rUFusQ1xl5Zm521gS0iA+HWxhIjbJYDaOT384yo0IhA60tIvDh/RsAixb3tYOozkAxQ/hhpfjJvCgltdfp31J7T01sT2CLZhdRl9tYUIrBA8bOromWaGHYlnToDQKhx45/A87v1dNwKTxy2RLn1nzOYncIiiD5iRwJjWROZOKqKhCBTtw/AYBS1V/RC6QCt4AElPorMx1JnWYFsjjFZA8eOC7GT7MrUWlbBKhYyW1xmmu6G3v1dyboiIa2rHF7x1fDXPst44am5SbskTg8dRRkivanSLoKtzs6GQplAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igRx3XsWurPNQM3SpJ4pNTGyz0hqQaja/V7NJM/yXi0=;
 b=f49uE5gUPpwH9/eYqh5eRKEIIe2keVKo0zXAZuugrYC3DE1ZdCLr4X1Fs2Rf+qa6MOQyvHNsYnkoBYhxJj3dzmS+H4DAlUsNbGus81I0OcJVxR4f+h/z+HqLHzxcyajSypCUkE2pysjharRfnDSlF+PQ9+UeniinYNRAuLfcUDM=
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:31:36 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::f2) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 07:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:31:35 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:31:34 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH 04/10] drm/amd/pm: add smu ras driver framework
Date: Wed, 29 Oct 2025 15:31:02 +0800
Message-ID: <20251029073108.1698129-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 74720f75-9312-44aa-a07b-08de16bd30c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFZK2cpVgr/EslZTR9F1NDYt3NpmAxkVgjHjZUYqHssIdBiBcbYEXUQ4MLcB?=
 =?us-ascii?Q?ZIFZNL/A6GkMrd0bvgrA+ymyPwp3DyenhqUR7Ed5+DO0lpmbHdmf83NEBJ3l?=
 =?us-ascii?Q?8cnyoah7kfV8icZgpsOhArfkelP6Tac+wKw3MMKNug0Q2eWR4bCvlyLCW0b+?=
 =?us-ascii?Q?t+sPdFrr1zoXIElMR3I/lZBxCmGFjP9fTTvjUCRvpBNzrLP5u+QNTzQipvjR?=
 =?us-ascii?Q?+LIS4hXtC+4W9g4wyI685hvxEbFBJ5ryEh8HoH6MRlAWxH2pwELrVr5eDbFW?=
 =?us-ascii?Q?aDAp8hsMmGJQT3lOfsgd2jM75snPOtSaggnSAMTeyBFUwUD8kM5+ego1Yd7/?=
 =?us-ascii?Q?ww/+anACdZvIKpL1Mr/AWTJ4XZ2eM8TozEVGRRrYMKk7qUyfklT9TvF70Fs/?=
 =?us-ascii?Q?Ps16h4x8AoelsXyfnnpTwzeTgEfN5MHnNwTVb7OKcBh2Zp0kPe3wBmS6Aqm6?=
 =?us-ascii?Q?LflM3+ssQ8l/SGMDR4ZIfbY2rnNlNPO0aJA/myFZOj0Vcs3MLz6cqnnsggs6?=
 =?us-ascii?Q?O73C3EHCc04wCnJApRvg0EaoAiMlgMN7HVWm+sQODOlOc2tOZI0Az0Ao2IgZ?=
 =?us-ascii?Q?u6TuEfn+T8Y68dEplJmT6VQik6cNSoUyqs1NNbTJAodznjSoUTEo+hUnXfbk?=
 =?us-ascii?Q?djKbis0emr/2bWeSEMbG26gqiclreZMTQZB9lDugLtOKpWxHs2bq6qqA049R?=
 =?us-ascii?Q?hBZKeKTmorgy/cRwlLzjV5tmJR7nuSR6o9IUw570DB3KQt10MEL09UrqNtYO?=
 =?us-ascii?Q?Epg4vyviTDLF6IUp+Jfa8jvvw+Q2kbdiDIl3sepiwfIdnOJrm2MhZeL4VIBN?=
 =?us-ascii?Q?0jqTGdpOG0hVt8/jWAbq7KrnDiTFiE8P45WS5ibb5iFNYw3D2u0/XxeIxLUr?=
 =?us-ascii?Q?Hfeh1foCXlKbgfpHMSs3pbpdjhCyUy9DOXDfsPzHUHjez+VeE8iQe9Y2bcgT?=
 =?us-ascii?Q?CRC3rpYj/GmgSBp33DeHKpOu6kBRDWKeTrDR1YfjXHXrOZ2tWKixrPMTUDtW?=
 =?us-ascii?Q?WbMsKxGYUleFnDHJqWIQyio2ifJrJYCg2hUz/ZLddy/FgGzt3k4hw4xzGEiD?=
 =?us-ascii?Q?vzJj8q1VOLf8s/5Hbwgsy0bjzyKJbtoKoSGMhXguHRJQYyrLOHSEY9lWeOK7?=
 =?us-ascii?Q?7yYDRovqvXplzmTM40v5MJGfv4QH3lZTUzrzfK1xEy0KB+snxN9sLLWbrqmC?=
 =?us-ascii?Q?GOex6bDegcGDlYgqzUt3bq4GFt0+212U5EWHSUBvpENB+bQcdMJ3Ue4xZfVV?=
 =?us-ascii?Q?FiePvD1TA9j3CJwZM7lKpGVlsCyl6j13l4hJgrdOMl7vICaUYVlaQeUauzQe?=
 =?us-ascii?Q?7QGz3hXUNdg33dnYzHH4mWVN5oER3U4iB4GPPeeKocupRMWcCa1LDjfZTynz?=
 =?us-ascii?Q?O1KgILJwv6I+JHZYF+gVXhK2PSoSxsJgZDV/he52q/GGUpSrpPFoV2zPtkmX?=
 =?us-ascii?Q?ieWy0Hb3siSMX2REQY6b7ITmMjOYFFo16PkWrV1zQmwNS8AWj0h2/QiNx2i9?=
 =?us-ascii?Q?xmtl8pEpDgKxG1KkKz3qZq7Nd5YsxsR90/cHsmO52rNz/OqNsZ9onq3fTfv7?=
 =?us-ascii?Q?FlF0PZreOyUEl3P19qU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:31:35.5464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74720f75-9312-44aa-a07b-08de16bd30c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 +++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 7 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 076e2280d375..4564965ef5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -617,6 +617,8 @@ struct amdgpu_ras {
 
 	/* Protect poison injection */
 	struct mutex poison_lock;
+
+	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5d08dc3b7110..65cbb65b3b12 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2140,3 +2140,10 @@ ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 
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
index 3bce74f8bb0a..c15ddcef1595 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -614,5 +614,6 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
+const struct ras_smu_drv *amdgpu_dpm_get_ras_smu_driver(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4317da6f7c38..1f748ce59ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2797,6 +2797,17 @@ const struct amdgpu_ip_block_version smu_v14_0_ip_block = {
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
index 0a7d2cea7dc6..32d98a43ea3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3883,6 +3883,26 @@ static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
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
@@ -3942,6 +3962,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
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

