Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093E9EE0213
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E7F10E6F9;
	Wed, 11 Sep 2024 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBU8WW39";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447CB10E959
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTIvwsAmmNUIN5lJzFkFuM2JBVVaZAxUZjL/9h3D1ctlaG+n7K0NTCHvBWmsY8u4XX1RbkU+0F4wwiUUbWlbL6EC1UJueVxyVcXFOz9YCw+57nfGAPKZ2g88h35AQ/iv8XFSunf7TYRSjpBOJitUvF3vYFAuWRN2okK+xtDIlmvzTNle39SbHz7RCjr3AgmwfcR38kaw4f169MueBTakEQ+T6X+8wMpuD5b3Agdbj6NEp55oKLx1gtSjYL2t0ZCy2crAVVUnBBRyaMJM7gexTU02n1duPWnoSiQydOChHIU+unSx3sHNmjV/iYP+qzvg2LSi5GH6tM9R/nFKHMejZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8O1HmQAuoWdt16gbctfseuccHCwt4vx5F1AB5rVfRA=;
 b=NI37oeFvq2phWKT59xCtiEUA+C8Qlt58bkTLZQlqgywuO6dct1XSxutmyco1Jv6Tp2XwgM6Rnhw1dlC9j+V9Cb/8RS6JgOVOEMXM6Et4ContMCwf6oTgzxx5qEHJRa1W6+Nx88OLS10ZKsUg8DMjp7xOYDfjWoC/TfoqjC1/An+oODkcyiXVFxE5O7wQBHbBQsPbmAB8WMLHNiASqoem/0gwcxnC+qd5NrM1kU/x+MemRGCVCDaDDJXKiXFzPjLHqK3RpcIUzLuWwtnSNopzPuDUoRfu24THI6axW+1tlbho0XoT8WfC3GjeRmcE1gLXwk5dNBcZBnlWD13r0uB8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8O1HmQAuoWdt16gbctfseuccHCwt4vx5F1AB5rVfRA=;
 b=gBU8WW398+vsfe3Yd7XwlqS+U/DxuZnCdXh7QY8CKZBowaO3/QVXz+1HHJDsNnXUbsyfh57f2RR8jTAXSlPO8cilb7NSusfG02uIbJv8JsxcbL5UjkjLszbssaHlrG4AkSFHKMS8dxwjVKuIeaN6eorOpgW8Dc4DFFbzEOHj8GY=
Received: from BYAPR08CA0013.namprd08.prod.outlook.com (2603:10b6:a03:100::26)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 07:03:13 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::c7) by BYAPR08CA0013.outlook.office365.com
 (2603:10b6:a03:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:03:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 01:59:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 01/10] drm/amdgpu: Add init levels
Date: Wed, 11 Sep 2024 12:28:49 +0530
Message-ID: <20240911065858.2224424-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f16a8b-5e34-4580-22cd-08dcd22fcd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2KhilLtBKVZ+Bj1iJQTYHRB06zdTPe1OsZi6ipK8oWyIyxiNQPFZCnh5rrrw?=
 =?us-ascii?Q?IjTcn6mEORPc11q/JlO/R+dL+WVC2Myuvqb8OmEdQt2p4yPhOM3kpPrIBrnK?=
 =?us-ascii?Q?bTvXInHytOQPEPeZGhZUqad2rcML6dBYHfeZkdni1JKyiw28PSmlnTpraMxU?=
 =?us-ascii?Q?aU8kqcNxRZ7NUAGh4YHp5OxW+uy6b7jTLaZwybFhWDeSPIlKUSmB994pk7WB?=
 =?us-ascii?Q?RPFd/9imAHfj62yrB6T/gw0ltreNkBbBZCVOxcG1kBEuUX6EtgEvnd1kVPwL?=
 =?us-ascii?Q?txnmRn+v9mndKipvasyKa22uVoK+YeVXwYT44idpNiRn+ohIcVlDlROUdfBg?=
 =?us-ascii?Q?vWtku54ouYvHvQCyRLFl0n299HBOu5yLWoQXnEid8cW/B6iySMJVDlH0f57d?=
 =?us-ascii?Q?EplgUuGCde7sNefxYge9AvW76Klrao1mRSXL6W8Rwn0GJaLTxXHOaZqGro3A?=
 =?us-ascii?Q?LZZc48tJm+u0qlh3y8020NgdbV72jNb/9fINh6WzdWVDtPTYHAfNe6yfPfyZ?=
 =?us-ascii?Q?fhulB3ZhDxthMw+msQ3C7Wq+UlXIGZhesK5+WTsgyAKaQcbnvcUrowjcgmS8?=
 =?us-ascii?Q?o6e5Q/7H+5bo2RoHFNV5E8tVvHQMlZ4zrg0rj2oaEU3BUiaSbGoMXs6k6p3o?=
 =?us-ascii?Q?yiK2LQ9NqW9TemkzxtT42qQ41cgHhaBPoEOToxQzhBvAxYI2m2Q6CFBnW2fB?=
 =?us-ascii?Q?FBWRCtA/UwAdY+y2fJNWtjTfTEK8I/wHAy5d3nEE4T2UXtPY7GmvSwZg70xC?=
 =?us-ascii?Q?oCIszvZSilO9PKa6IMWj+LCasZRoZfoID4pgIKMIPDzj/9Nsvev3j8OWsifl?=
 =?us-ascii?Q?uKIyO6ViKOpP7rIgVQpZV6+98jIDSTFKmS2Fbwq6kgs5wuM15q8CyLSsOskv?=
 =?us-ascii?Q?Aq361UOxvNrldfchd6I3Sq3XGd2OBcop5SApCDE8jqPEEZbppUmfUWf8jWxB?=
 =?us-ascii?Q?RCSTCRKIZOItWWVakurudhD8Abx9CQXFt2d2u5Lneq+bdzIn1QcuMCUHh53x?=
 =?us-ascii?Q?YqEfz0Ty79DYDEhJNRPjYDY/y2cr+wyP1UbgTPXa0NNBmQB/UY8YKSNmpQRI?=
 =?us-ascii?Q?2UL74/rcVTynPbLfdGmxWYIIU/rEXFke3qwIe595jvAJEGaNQLastfQmwS7D?=
 =?us-ascii?Q?Z9gpeZVEVutFQs3QxpQ11onGvyb0LqI+/1FveyVJ93uNukmqa1tkZxxxMTm7?=
 =?us-ascii?Q?dl1/N/9sv1bnJKrx7UzLWqx65eLiQu/AvqAn3z0qHje4ObP+SFPDNHNgVcmn?=
 =?us-ascii?Q?t6Lu6Es9YznsxaC4l7smjpv5xHDdaCazrEfyteZyByWvw0H7WS/lA8DvGA7P?=
 =?us-ascii?Q?UnWju0X7bUFZ8q5c9iHxYzg8BFCx1XZY6sUzPrZvf0teeMeyVNR/VV3Ieb5h?=
 =?us-ascii?Q?BuSJhNg6MLyruHc4UudE67cgV7fupAnWMHV1PIX4NylJttyqdnRUMwAR0kUN?=
 =?us-ascii?Q?p9DCeiO0F/Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:03:12.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f16a8b-5e34-4580-22cd-08dcd22fcd2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

Add init levels to define the level to which device needs to be
initialized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2:
	Add comments describing init levels
	Drop unnecessary assignment
	Rename AMDGPU_INIT_LEVEL_MINIMAL to AMDGPU_INIT_LEVEL_MINIMAL_XGMI

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 66 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6e6580ab7e04..d8299383af11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -820,6 +820,24 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
 
+/*
+ * Custom Init levels could be defined for different situations where a full
+ * initialization of all hardware blocks are not expected. Sample cases are
+ * custom init sequences after resume after S0i3/S3, reset on initialization,
+ * partial reset of blocks etc. Presently, this defines only two levels. Levels
+ * are described in corresponding struct definitions - amdgpu_init_default,
+ * amdgpu_init_minimal_xgmi.
+ */
+enum amdgpu_init_lvl_id {
+	AMDGPU_INIT_LEVEL_DEFAULT,
+	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
+};
+
+struct amdgpu_init_level {
+	enum amdgpu_init_lvl_id level;
+	uint32_t hwini_ip_block_mask;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_reset_domain;
@@ -1169,6 +1187,8 @@ struct amdgpu_device {
 	bool				enforce_isolation[MAX_XCP];
 	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
 	struct mutex                    enforce_isolation_mutex;
+
+	struct amdgpu_init_level *init_lvl;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
@@ -1623,4 +1643,6 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
 
+void amdgpu_set_init_level(struct amdgpu_device *adev,
+			   enum amdgpu_init_lvl_id lvl);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 61a189e30bcd..2ecc70f220d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -144,6 +144,50 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
+/*
+ * Default init level where all blocks are expected to be initialized. This is
+ * the level of initialization expected by default and also after a full reset
+ * of the device.
+ */
+struct amdgpu_init_level amdgpu_init_default = {
+	.level = AMDGPU_INIT_LEVEL_DEFAULT,
+	.hwini_ip_block_mask = AMDGPU_IP_BLK_MASK_ALL,
+};
+
+/*
+ * Minimal blocks needed to be initialized before a XGMI hive can be reset. This
+ * is used for cases like reset on initialization where the entire hive needs to
+ * be reset before first use.
+ */
+struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
+	.level = AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
+	.hwini_ip_block_mask =
+		BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
+		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
+};
+
+static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
+					     enum amd_ip_block_type block)
+{
+	return (adev->init_lvl->hwini_ip_block_mask & (1U << block)) != 0;
+}
+
+void amdgpu_set_init_level(struct amdgpu_device *adev,
+			   enum amdgpu_init_lvl_id lvl)
+{
+	switch (lvl) {
+	case AMDGPU_INIT_LEVEL_MINIMAL_XGMI:
+		adev->init_lvl = &amdgpu_init_minimal_xgmi;
+		break;
+	case AMDGPU_INIT_LEVEL_DEFAULT:
+		fallthrough;
+	default:
+		adev->init_lvl = &amdgpu_init_default;
+		break;
+	}
+}
+
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
 
 /**
@@ -2633,6 +2677,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hw)
 			continue;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
@@ -2658,6 +2705,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hw)
 			continue;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
 		r = adev->ip_blocks[i].version->funcs->hw_init(adev);
 		if (r) {
 			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
@@ -2681,6 +2731,10 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!amdgpu_ip_member_of_hwini(adev,
+						       AMD_IP_BLOCK_TYPE_PSP))
+				break;
+
 			if (!adev->ip_blocks[i].status.sw)
 				continue;
 
@@ -2803,6 +2857,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.sw = true;
 
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
+
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			/* need to do common hw init early so everything is set up for gmc */
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
@@ -4196,6 +4254,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_set_mcbp(adev);
 
+	/*
+	 * By default, use default mode where all blocks are expected to be
+	 * initialized. At present a 'swinit' of blocks is required to be
+	 * completed before the need for a different level is detected.
+	 */
+	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -5473,6 +5537,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	}
 
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		/* After reset, it's default init level */
+		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
 		if (need_full_reset) {
 			/* post card */
 			amdgpu_ras_set_fed(tmp_adev, false);
-- 
2.25.1

