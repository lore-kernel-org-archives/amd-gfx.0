Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C556C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 07:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E7510E767;
	Wed, 23 Jul 2025 07:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FC7l1BeX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5A910E768
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 07:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwKftyAzu8G9LbJZK82qwpLJBIJmA6fflxuerS1BTDVR08qs4FLxJzGcBsat+juf4ZWKJdDKirDzHe/UtuEH5fmnmg/Y4INQaD+v7xp1UFH+4yVOX6Yj0Q2z7GKRIXEC7IyAAkhGOLLXtlbWHU6/jLoWKakMZqXntae0YRx09OfROSvKV+AUnNhjD5o6YKV3R35oWFvrmco2D9AXEIjqS7vuO8oNEdWyiuG6uMzFpVhhRkoAkDthNHmjwR+UGBmih9mVAJi4bE0T/qFEfxrX/H+kk743d2QFjzIuvhOtHYG8VnY4kWqHzSdxLhwyZbiNwLZz2mufWqwkwmcyajnt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t74S07tHZ7uYB1Nun3GleIb9o5moLgBKa/I/8P9sFg=;
 b=GWkA+4PYBkJXxV+Gp6b9hmU8wRsIADOGhfrxlgnfrSFbctJ2HmAXoXSO7mpYA8ztC9uE6igGTNYa8blX+9J4ljd/8SudEpXfqUcuP7RgCY1GMqUbimchlaOe+a4a0zrqTNSAQszWbIwLEQIv52KOak0APe2htC3Wkn14ZuuPur/Q3oeluHAfoXz2SWTSXQeVLsHRDnXGL5bKz8u3igJrxAxRXuaT2eateVTNH7SdO8kTBKbrzBQybIE2poJrrddCtPKzhDXoLv6hxEeGiDZtyCR1RUwzgVrAiogI8KgNbAKe1//80z0Lo9ak4yYQO6jIzKfsjjLU8ale+XAPOsDcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t74S07tHZ7uYB1Nun3GleIb9o5moLgBKa/I/8P9sFg=;
 b=FC7l1BeXbNukUYj3YavD+tU7SJ1V6pAi6/xYqE5DViw6PyWWyan3Da4FSIvGfLp0ENdaDJhGvjaFpfyRiSRl9DuCI+7oEYeAH9xgmvRQayAGfyWMo6zspm3SRKrshtVg5yv+tOTg8KivhJQ2rDfmng7HNCIjVOBzAuwxfZKc/Ok=
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 07:38:42 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::4f) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 07:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:38:42 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 02:38:39 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: support ras critical address check
Date: Wed, 23 Jul 2025 15:38:01 +0800
Message-ID: <20250723073802.1844148-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd643c4-02f3-4703-ca73-08ddc9bbf284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gvEuIHhx7l2Yl+TTINgkiVJfq78f4iiXwoAzgbc67rjERYCEy+IPalYBDQ0s?=
 =?us-ascii?Q?Je/pWleeqlIkmZmaCDqUqwCFBp30BtQl/BxIZ/FluyI8En1V1jzP7AHpIHkm?=
 =?us-ascii?Q?P5MDSERF+7slxMpPldyxXilJ1oCeDGiXI/kWhWTf83htFimU6wPHptp01VZx?=
 =?us-ascii?Q?aDgKrbhDxL6K3d0V47EV3PDhI8fmaLEIJ8cruuMvGFYveiNu85q130z8J3XO?=
 =?us-ascii?Q?AGBqhYMPj3RiJiP/6P3hL8aVPhmLHmIRk1VclV3v1sduaUPiyZRN/Z0HJz20?=
 =?us-ascii?Q?kN93JxZvH1Ya17MsF2AVbkImTfeZso4D1CKsa28Sn5ao3ebQ+SyoYRPL4Mjv?=
 =?us-ascii?Q?ny8Mqe5dxhmTSgax1/rhsN2hFv7kXTCvtJDSymOpJ+YGBMe9OrGivUUFELTa?=
 =?us-ascii?Q?61z85LNMeVgPQIi6Q5sdRmBF76WEbVUlygCpMnVK8sLENn9r7+a9bou9jdY7?=
 =?us-ascii?Q?1YgZQyGb0Z9aSSFx2YyoCW1qEzKlgAoYtkFZEGJJ2+2IoTdhynnK0r5TA2V7?=
 =?us-ascii?Q?UXRi63zB7J7YU89KmCRG7jeyJzFPTybww1X6qemOhm+0BcVrd7CrD3qKmwny?=
 =?us-ascii?Q?zOq3P4ERXCKDjZCLzNMsy4dgQu8SgDk5sOzPWFHPjqORr2yaSHPCaLo1TKbz?=
 =?us-ascii?Q?fYSBXPN4eaOJ6aq9KkwZTDkHhmh/np7QT4TgdS9UJ0r0jLkHzp8TnCP4rwYh?=
 =?us-ascii?Q?IOShuSLS4iyptJGVW+Vcwjkep01aq/zjZE9GKqfe6tJqxLHTZk1rqDak2aA7?=
 =?us-ascii?Q?NXC6nhobWiffA07Au7pm75Gl9eed5ufbEX2t1i26EAan8KS1BthZLR2/TV7W?=
 =?us-ascii?Q?Ag9tCb9AQQQLGTfX45qenJ4Spq9fhi71OMB/4KKpYyxuCqXFY5EzosUXPH6t?=
 =?us-ascii?Q?i39XHxdqO/4uCdC57UzMosE6z7oU4kPbKh1hUQmng4BJqCwLa5B1VyK3626C?=
 =?us-ascii?Q?FrpeOToQkwBoWSJciVTEkpWoCqQERdG4ucaSzSMpAs/jgbEYJQ8yy7AAvyjT?=
 =?us-ascii?Q?1N9Kx29xFd4oSp0mbtE+vApWsQvkbvQrV3hmom/nQ/GEqIuB97ig3SMwg94+?=
 =?us-ascii?Q?KplUy+9nYhiziXjdQ++lHE1eembpQwBwJOfQ7CwRWPwqLqsBVdUz6THHj+yC?=
 =?us-ascii?Q?m7smh0h0xRVuk2pgUUs8dcfSRVag6144gm5kHlEViNc41u6HkZ+j0+Ipm+lq?=
 =?us-ascii?Q?HxIC/sp5XQdhFWzkMm2foYcqHJl9bNaOihjTXaiHjb7FvToJ//KrvZA7Sojz?=
 =?us-ascii?Q?NyDVBMEV9/eRjQ3pHoeMggSI1uaiMN/VJ1Cl45f+mZ2H9TWihc077d0rdvDK?=
 =?us-ascii?Q?Lqv+cv3w4/YQbZBQmG0am4RLWkyENprBbR3gJiPwnt6aXQeIaxEw2PnIB/sw?=
 =?us-ascii?Q?jOVio5lLBUlvm4aW5jYoBaeCVMrA/0o8RvU/lrEjahgCluXvi95V/6ldocGv?=
 =?us-ascii?Q?R2lfi1bMiq6H0VldWMetYklbtlO1vGrvUnyAYaYwqlkhF6HWqgKkVoZwLyz3?=
 =?us-ascii?Q?LZwMH9es3zYJtdCV0eBJ1Bk+5Tm9UsvewgmB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:38:42.0535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd643c4-02f3-4703-ca73-08ddc9bbf284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

Support ras critical address check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 89 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 14 ++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 234f0de31917..0ad3a9eedfd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -143,6 +143,10 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
+
+static void amdgpu_ras_critical_region_init(struct amdgpu_device *adev);
+static void amdgpu_ras_critical_region_fini(struct amdgpu_device *adev);
+
 #ifdef CONFIG_X86_MCE_AMD
 static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev);
 struct mce_notifier_adev_list {
@@ -3709,6 +3713,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 		amdgpu_register_bad_pages_mca_notifier(adev);
 #endif
 
+	amdgpu_ras_critical_region_init(adev);
+
 	return 0;
 
 free:
@@ -4198,6 +4204,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	con->init_task_pid = task_pid_nr(current);
 	get_task_comm(con->init_task_comm, current);
 
+	mutex_init(&con->critical_region_lock);
+	INIT_LIST_HEAD(&con->critical_region_head);
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
@@ -4477,6 +4486,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+	amdgpu_ras_critical_region_fini(adev);
+	mutex_destroy(&con->critical_region_lock);
+
 	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
 		if (ras_node->ras_obj) {
 			obj = ras_node->ras_obj;
@@ -5433,3 +5445,80 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 
 	return con->is_rma;
 }
+
+int amdgpu_ras_add_critical_region(struct amdgpu_device *adev,
+			struct amdgpu_bo *bo)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_vram_mgr_resource *vres;
+	struct ras_critical_region *region;
+	struct drm_buddy_block *block;
+	int ret = 0;
+
+	if (!bo || !bo->tbo.resource)
+		return -EINVAL;
+
+	vres = to_amdgpu_vram_mgr_resource(bo->tbo.resource);
+
+	mutex_lock(&con->critical_region_lock);
+
+	/* Check if the bo had been recorded */
+	list_for_each_entry(region, &con->critical_region_head, node)
+		if (region->bo == bo)
+			goto out;
+
+	/* Record new critical amdgpu bo */
+	list_for_each_entry(block, &vres->blocks, link) {
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		region->bo = bo;
+		region->start = amdgpu_vram_mgr_block_start(block);
+		region->size = amdgpu_vram_mgr_block_size(block);
+		list_add_tail(&region->node, &con->critical_region_head);
+	}
+
+out:
+	mutex_unlock(&con->critical_region_lock);
+
+	return ret;
+}
+
+static void amdgpu_ras_critical_region_init(struct amdgpu_device *adev)
+{
+	amdgpu_ras_add_critical_region(adev, adev->mman.fw_reserved_memory);
+}
+
+static void amdgpu_ras_critical_region_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_critical_region *region, *tmp;
+
+	mutex_lock(&con->critical_region_lock);
+	list_for_each_entry_safe(region, tmp, &con->critical_region_head, node) {
+		list_del(&region->node);
+		kfree(region);
+	}
+	mutex_unlock(&con->critical_region_lock);
+}
+
+bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint64_t addr)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_critical_region *region;
+	bool ret = false;
+
+	mutex_lock(&con->critical_region_lock);
+	list_for_each_entry(region, &con->critical_region_head, node) {
+		if ((region->start <= addr) &&
+		    (addr < (region->start + region->size))) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&con->critical_region_lock);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9faedfc494af..9614cec7c3c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -496,6 +496,13 @@ struct ras_ecc_log_info {
 	uint64_t	prev_de_queried_count;
 };
 
+struct ras_critical_region {
+	struct list_head node;
+	struct amdgpu_bo *bo;
+	uint64_t start;
+	uint64_t size;
+};
+
 struct amdgpu_ras {
 	void *ras_mgr;
 	/* ras infrastructure */
@@ -574,6 +581,10 @@ struct amdgpu_ras {
 
 	pid_t init_task_pid;
 	char init_task_comm[TASK_COMM_LEN];
+
+	struct list_head critical_region_head;
+	struct mutex critical_region_lock;
+
 };
 
 struct ras_fs_data {
@@ -977,6 +988,9 @@ int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_
 
 int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);
 
+int amdgpu_ras_add_critical_region(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint64_t addr);
+
 int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block, uint16_t pasid,
 		pasid_notify pasid_fn, void *data, uint32_t reset);
-- 
2.34.1

