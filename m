Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B72CCD13CF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377D410E215;
	Mon,  2 Sep 2024 07:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1HzB6q3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CD110E215
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZV2YLAOWOMQxL62fdlDebwJT7nB7SzaTXptFoRpuPv8M5pxk9XMe0MBwgUzi0NykKvgfkQj+4vpO6uneyGDZ72il9qWhd79pZEdvpCjGjyEUpmS6S4zAYXmA2+4qWa8lrwaSEm6olzbm7JMcfUSHVx1vx03cw8uU/hrAq0cbL3w4o7oQIuTDwd6kmZsj6fjSbFp7UUwai44Cbw85BEu4eCbldCtgEITBv1dzTXShVh/3R8e7V4KX+lS12dtxlN88NoIrsQw4BvdKuKuj1N6cq36DnSSlV0u9/Hii7WkL/Gnhuiu1ZPhXlq+/j4G1tzAhfOyIy0QtWj1tSPk1Z68zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6A+WbAQ4iHVSYPoi0TJgIp5wxgnkP/7zTI6FnZo1q4=;
 b=h+xpkWwKDt5kFQf1wT9yr4yQJpd6/D0Kffar3tYY22RP7e5fg/BWTmv2IKL+foRCnj0VTYuvIw2gJ58kv8tfRt4dfOZpdVWfOjX9PSnd/1QP1rT8N/N1my37iCDy6EDAvkvGjwUOWvH7yCfY5WSu7M0rdoU5Xp/kQczbDCpbee4xM/45KFxlnMfQzec5DGfnE4nRei0Qd6P+rPwaGRftUn/HbjgtQgvAxBlfJ+jdJpKuVLSD0bOqn6mB05NBza69uQppW8APB1TvYZ8r5w6v6znEHBivzcBmtumWF6z0eWTfqVgEIwDIqisYiZBlduqmZ3YDe6TZ6f3IMiZs1L5vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6A+WbAQ4iHVSYPoi0TJgIp5wxgnkP/7zTI6FnZo1q4=;
 b=q1HzB6q39s9HgsGszxYqH9Vb3BufG34LN5r4vlj5wIefnV6+iuL6/ods1hmSr6e6nPEbcVZZsJx4wSQz0XOiHT/W3waU4RmKeHFd9BPjUaktRzfuxPxLZ0z9EWkrETOIUUamJStnpk5LMp9pYHluzrQzhrlrj7Hvhij4FodwWg8=
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 07:34:37 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::38) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: Add init levels
Date: Mon, 2 Sep 2024 13:04:08 +0530
Message-ID: <20240902073417.2025971-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da431ed-7f09-4e2e-2b6b-08dccb21b296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Am094w6m1WAlSUQMluDtAMHOupXiZ5XzZ7mVcy5lOccPWqAvSisJsRJfVmii?=
 =?us-ascii?Q?aNyz5rc9Buhn1XudVljEM2uhHQeDKKzvRa6f80hLPMFkOLkJDgKvAb9Top29?=
 =?us-ascii?Q?YGJxC+pnIYw+5SP0addFO8kNnsn2t0ISOyvSduJf4n/Jkleu9dygBn/HP6lH?=
 =?us-ascii?Q?docnSqKbx2+jsGTrb4LM2OhEX72WqGP41ExVCL+BymiS9Yg3DvVmG6HNnSST?=
 =?us-ascii?Q?9LMzjl7JmJSthINp3DYIITnUChqqbj4O0l/SJJjcA/Y3kVapwodfrKygupgC?=
 =?us-ascii?Q?Qs8rOD+Agggjr6v9Rgzazery5iEV6daer7zsXcAt3Ij5Xr6cZuMxWk1yXgbC?=
 =?us-ascii?Q?hnDmo8Xz1j/kYibYJittr36+XfZHFd0E6boORBREZj1yQApcmcquU4F3XNWe?=
 =?us-ascii?Q?JH7DVaS60LuKfpWoYMno5VzisCvkuOKPLGXdGtc03CEpSWP4RBD30imnqdKb?=
 =?us-ascii?Q?PfZJrsBsSo+WdfFt5vCieVezrwYPngIjks6m0meuId9duBdVWwEMc0CVUfwG?=
 =?us-ascii?Q?rX7WQzmZiQE87WrTyoTSEIQK2WgQT9IsGBtihsEwh1k3cjwPnEoobu5gfmtb?=
 =?us-ascii?Q?dJyJRs/5WNeLqodMQsQYosIfbrXPr06O7M+Y3+Dr6GlcDkr9aQ8fb6Ms1nan?=
 =?us-ascii?Q?cpAtI/98TlfjiDUNgalRUXnA6j3ckHly3kf0IVu6KuMbAAwdueOIGYNCruKD?=
 =?us-ascii?Q?BQ4SIc+gzeo8S2rTYjWjl1K+dwjxlIodj7EUbWVNbBD3zmnhjNMRMusB/VRz?=
 =?us-ascii?Q?h+X3SC+3PuvzPldJlIGGYzXb3IXc88Kt/jD6Waj1P/pgGJEIwDtTOWHdbqMx?=
 =?us-ascii?Q?DwAuk3q8AkwUH4z1/eOEYUUF5BjTnoQoht3O081asQW6jF0587oTAhtJpOPo?=
 =?us-ascii?Q?Dt7MwujW1rUsj90NjCfRkl9a13O2zkwX3vuyUJGm5VfDlN7iF5vTA73gh63a?=
 =?us-ascii?Q?yD7ZXhuSVhytGuUw6dx0LaNdcAGeLsZasN8FZT40gGT08W5EjiznGfOzB9cl?=
 =?us-ascii?Q?KxqRKA8yi8APZJHCZR+A/p1lHvJgPKCvi63CJG+crOFIncOvchJRL4cA7vQR?=
 =?us-ascii?Q?F6mF1NHdhzxFLDkLZ8f1t34x/wdYqu/WDnGi9n+egaQFRJFZj0piDqltacZ2?=
 =?us-ascii?Q?KZtEU+plgohAL5sGC+tyVDlXDH4dQzl6wkPUy5EEtwTeJlwVU6NVU5UEvc5V?=
 =?us-ascii?Q?wf7SiI5dX/GjHBjeYwCBaVap3DKtDKO3iNNSQXhlVIMhaJmnt5zf6v6RiqkD?=
 =?us-ascii?Q?kFh+z4y1olfukEKnJYoNLQsBqU1ozeqwZNdWt/eclomCdx3vgx1uRkoo/z1P?=
 =?us-ascii?Q?MEt01WBC4HkmiIyy3wq6eCwB9r5QT6/hT6KFJN8tlvkSyn6ZsI4fJ95LK3rZ?=
 =?us-ascii?Q?ZWXDPjCElHNsq5cqQYlXAV+DocodazLagK0dqJo1oLqivZmqotxBu5/k2SLQ?=
 =?us-ascii?Q?YnEOPoP0AOf3PP9+am+GHRJKv2K2FQ4m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:36.9531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da431ed-7f09-4e2e-2b6b-08dccb21b296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6e6580ab7e04..fefdace22894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -820,6 +820,16 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
 
+enum amdgpu_init_lvl_id {
+	AMDGPU_INIT_LEVEL_DEFAULT,
+	AMDGPU_INIT_LEVEL_MINIMAL,
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
@@ -1169,6 +1179,8 @@ struct amdgpu_device {
 	bool				enforce_isolation[MAX_XCP];
 	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
 	struct mutex                    enforce_isolation_mutex;
+
+	struct amdgpu_init_level *init_lvl;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
@@ -1623,4 +1635,6 @@ extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
 
+void amdgpu_set_init_level(struct amdgpu_device *adev,
+			   enum amdgpu_init_lvl_id lvl);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 61a189e30bcd..4fb09c4fbf22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -144,6 +144,42 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
+
+struct amdgpu_init_level amdgpu_init_default = {
+	.level = AMDGPU_INIT_LEVEL_DEFAULT,
+	.hwini_ip_block_mask = AMDGPU_IP_BLK_MASK_ALL,
+};
+
+struct amdgpu_init_level amdgpu_init_minimal = {
+	.level = AMDGPU_INIT_LEVEL_MINIMAL,
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
+	case AMDGPU_INIT_LEVEL_DEFAULT:
+		adev->init_lvl = &amdgpu_init_default;
+		break;
+	case AMDGPU_INIT_LEVEL_MINIMAL:
+		adev->init_lvl = &amdgpu_init_minimal;
+		break;
+	default:
+		adev->init_lvl = &amdgpu_init_default;
+		break;
+	}
+}
+
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
 
 /**
@@ -2633,6 +2669,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hw)
 			continue;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
@@ -2658,6 +2697,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hw)
 			continue;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
 		r = adev->ip_blocks[i].version->funcs->hw_init(adev);
 		if (r) {
 			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
@@ -2681,6 +2723,10 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!amdgpu_ip_member_of_hwini(adev,
+						       AMD_IP_BLOCK_TYPE_PSP))
+				break;
+
 			if (!adev->ip_blocks[i].status.sw)
 				continue;
 
@@ -2803,6 +2849,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.sw = true;
 
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
+			continue;
+
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			/* need to do common hw init early so everything is set up for gmc */
 			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
@@ -4196,6 +4246,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_set_mcbp(adev);
 
+	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);
+	adev->init_lvl = &amdgpu_init_default;
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
@@ -5473,6 +5525,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	}
 
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		/* After reset, it's default init level */
+		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
 		if (need_full_reset) {
 			/* post card */
 			amdgpu_ras_set_fed(tmp_adev, false);
-- 
2.25.1

