Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF939EE0214
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E39610EA0A;
	Wed, 11 Sep 2024 07:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T30XN5Ll";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDFC10EA06
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo9C4R4KiMKbeYt/4dBULlDwL5AXSDbXoXGzlHKKMF31an5FOBZbavnwOdGpB6PWkIRzWFwhC0A38uzaZD3OkfuE8QQMORTITlH43vdfkBaAruTTKLcUk95wmVXi7rARN47SnttWHUQi100is7jUYzuKldJ+eC2HmYWNbedQtG2pIkZi75vBfc6qteACg0d006G0KCgGPfFLjWJKRwkat/H8D2FehjyiOv6zTzoJke6rvgNM6Yt8vV1nHhHfT/hbitqfjfLQEumeRclcmoWJqPBtB+S29yLdYJ5IVH2IjsQFqOY497G2pNHEXE0WO15pPJuLtw77aiyX+UPdam+iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gea5M+EWgeS5m3UiPWrboI9VgAA9m5N3UXwjflU4eV8=;
 b=AOiH88UpWDc8QviDgwSSnSx1KmZD10A0dH9y74KVvuq9HlsUffi5H6NstGjeCpEslZ01ZsDHa/e25ypx7tmHasz4gyflGymp25yx5x9JoE0VY6H45VOPsd90hl5UHxWmfBoWdLiwk/O6rfG/ywSzDdeUhhjv0WGOb1riJAnImyQ55RaIahkFG899/2S+rmBd2DHd8tYSkNnaJbrR1/8zefwE0aV3b+PhdJVhuR7BB+RAtZrZ0iekFLY04jqeH/9KCyY6ZvjGPcChryMehOzm55L9BTaCZa4T3qQemg+fbKGEggU9pes+jm6B63gh0V6AmBzj9ZCkL7vAaFf+Sv5v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gea5M+EWgeS5m3UiPWrboI9VgAA9m5N3UXwjflU4eV8=;
 b=T30XN5LlwkjEcZtSFa7kp/SIdR1CH25VpnRaMLxT307IZMELW4Rev6cSINwIicPRo+zho7e+RyecxMl57pX1lHOg3YQFzcyLgtXExbXufD9UP0eyRkhzaf/hxL0FXNjM8hkWFNMyTIqucUaN+BVuO0m+q13NszE/imSY3nEPwoc=
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26; Wed, 11 Sep
 2024 07:07:31 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::ec) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:06:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 06/10] drm/amdgpu: Refactor XGMI reset on init handling
Date: Wed, 11 Sep 2024 12:28:54 +0530
Message-ID: <20240911065858.2224424-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e715be8-659d-40a0-3c20-08dcd230673e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBMd7V/luaywnWNQxFiVWeOKEPCAY4YZ0nTThdwml83r8VM3kVd0mPywo/i4?=
 =?us-ascii?Q?wP93FgZnIE7z+2BF96H28pXV81SybcwdPPuxAi96dLpAT9/MeKXwXlfU9hSF?=
 =?us-ascii?Q?qdDIIJC+8FdX3btRCpiS42W/g/Uz+NEbnDi3PZ52L1pV9rP5Q5HkhM1z1lYe?=
 =?us-ascii?Q?+5ZCuzuzcQfpuCQtbNCaZ4YOBa/5slTb2cRFp/UxsmxXKkBzJRbojCGQBa9r?=
 =?us-ascii?Q?SlalPbHzPHe6KH9BsMwjYI4nFgRj+2TIwcNHL/Bo8/+7FE741oK1ITSAzAgj?=
 =?us-ascii?Q?epf5eIuu/xjNcLtg05Cg80N3OKmBQWqGyLGcr0q98E8lYFhnFN0inhdc+2em?=
 =?us-ascii?Q?nTsI1zYuHrkO1+DhhBq4CXV1HAjvT9mD657HRavybjNlzKnzQSqbAq+/I/V5?=
 =?us-ascii?Q?8Wld/Bm75DbFziHCzunecskvNJtxDprBBRupKFADazhhke40JiaQC0UHnfgG?=
 =?us-ascii?Q?RztbtmNQLWGgOViPhFeoo2dkFtUQMabc0PWWv9v/Pct5NjPu4PhXaxzZnbFM?=
 =?us-ascii?Q?APNw01OfwjmZodtxEWUb2sNc9anq75S18K3V5g2B5VKClH9ASjqq470yp1wc?=
 =?us-ascii?Q?wq8qHL8Lq3wLfoDLw01p5HCZEGNj//UpnqSKcDiU5kUgHaci1G6dhkTINs0x?=
 =?us-ascii?Q?AABZiUVkKIXNHY9bJR3envRkm/Jh4OcJB6rD/c91kliCbTDZmGywlPvJ79Vj?=
 =?us-ascii?Q?fs7AaRFvpojGrr7ybBkdRa68Pjf1Jaz4EtG88KeJKei/wmxlfgekzS+x+o1h?=
 =?us-ascii?Q?Q/Iz+3gwEwlJOSm1KrD84/2BXiwZHE6dRy7GuWh+vZ1vzEag4Fix7GUFzLJz?=
 =?us-ascii?Q?eQmzjM6q/Fw2xKyih6ujfkuVMTP441l6xTEd3T7WXiS+X9itlsFDJJTFH8rO?=
 =?us-ascii?Q?3fDzUzGxE78cifJRpWQCqW2P3HmhuuiKU0uJTCFXS0Wjt9tWEOdQu4ek1GSE?=
 =?us-ascii?Q?aFufPraZTlS8eBEURH4BliCrSF/noGc/PrB0mnHCxDD0CDQySvkbhRmrGfoL?=
 =?us-ascii?Q?g0+AWiTnYJcOsGBIs0gJm2c9yU4mlzSK6pbn5vMtiPTLn7C1fgjlDaKYc7jp?=
 =?us-ascii?Q?8YE1v/IwwaweuPdA8Pgk+0B5J57mzBo0U0OUlLu/lPd4LWxJYXoVq7iRD42f?=
 =?us-ascii?Q?UbHorUCzANmk+GesLYrJZ3zlwmtkimJzsirIKWkSmZnEi8LikBmxgUcIPZ1f?=
 =?us-ascii?Q?/XOm9+A+57iKApWtM4NhhdWno27AR/ucgUAf1JCpoaVGsq8OTGYbf9XmMeIg?=
 =?us-ascii?Q?z3gy53wuJosznEE8OoDCL397/LA4bsxrbdobNZ/ANimNuPuCqWYN9EbpO+LT?=
 =?us-ascii?Q?MflOerAIaNpe70VMa6sg/UOtz5eUBdqmpUo0sTK/yRz7zWHLBcZTOhvC1rwc?=
 =?us-ascii?Q?JQF3s70OhtATso1cLPmONUsnTUImUqbziUXC6pODdJ4tHeaf0eKgP1863jzE?=
 =?us-ascii?Q?klSpz2mlkNe0SDCw3aEJTudQbG1o+py7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:31.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e715be8-659d-40a0-3c20-08dcd230673e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

Use XGMI hive information to rely on resetting XGMI devices on
initialization rather than using mgpu structure. mgpu structure may have
other devices as well.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <feifxu@amd.com>
---
v2:
	Use consistent naming scheme for functions/variables (Alex Deucher)
	Use renamed init level id - AMDGPU_INIT_LEVEL_MINIMAL_XGMI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  6 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 73 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 +++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  5 ++
 6 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4928881c13b2..c104076e85b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -164,7 +164,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi = {
 	.level = AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
 	.hwini_ip_block_mask =
 		BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
-		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
+		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) |
+		BIT(AMD_IP_BLOCK_TYPE_PSP)
 };
 
 static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
@@ -2840,6 +2841,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 {
+	bool init_badpage;
 	int i, r;
 
 	r = amdgpu_ras_init(adev);
@@ -2953,7 +2955,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	r = amdgpu_ras_recovery_init(adev, true);
+	init_badpage = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI);
+	r = amdgpu_ras_recovery_init(adev, init_badpage);
 	if (r)
 		goto init_failed;
 
@@ -4514,8 +4517,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
-		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
-				   msecs_to_jiffies(AMDGPU_RESUME_MS));
+		amdgpu_xgmi_reset_on_init(adev);
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f5cd91fd63ea..2c29f4c34e64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3216,12 +3216,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
 
-	/* Todo: During test the SMU might fail to read the eeprom through I2C
-	 * when the GPU is pending on XGMI reset during probe time
-	 * (Mostly after second bus reset), skip it now
-	 */
-	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
-		return 0;
 	if (init_bp_info) {
 		ret = amdgpu_ras_init_badpage_info(adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 74135d611cba..61b293c60b41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -860,8 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
-	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
 			dev_err(adev->dev,
@@ -907,8 +906,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
-	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
@@ -985,7 +983,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!ret && (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI))
+	if (!ret)
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
 exit_unlock:
@@ -1500,3 +1498,68 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
+{
+	struct amdgpu_hive_info *hive =
+		container_of(work, struct amdgpu_hive_info, reset_on_init_work);
+	struct amdgpu_reset_context reset_context;
+	struct amdgpu_device *tmp_adev;
+	struct list_head device_list;
+	int r;
+
+	mutex_lock(&hive->hive_lock);
+
+	INIT_LIST_HEAD(&device_list);
+	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+		list_add_tail(&tmp_adev->reset_list, &device_list);
+
+	tmp_adev = list_first_entry(&device_list, struct amdgpu_device,
+				    reset_list);
+	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+
+	reset_context.method = AMD_RESET_METHOD_ON_INIT;
+	reset_context.reset_req_dev = tmp_adev;
+	reset_context.hive = hive;
+	reset_context.reset_device_list = &device_list;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
+	amdgpu_reset_do_xgmi_reset_on_init(&reset_context);
+	mutex_unlock(&hive->hive_lock);
+	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
+
+	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		r = amdgpu_ras_init_badpage_info(tmp_adev);
+		if (r && r != -EHWPOISON)
+			dev_err(tmp_adev->dev,
+				"error during bad page data initializtion");
+	}
+}
+
+static void amdgpu_xgmi_schedule_reset_on_init(struct amdgpu_hive_info *hive)
+{
+	INIT_WORK(&hive->reset_on_init_work, amdgpu_xgmi_reset_on_init_work);
+	amdgpu_reset_domain_schedule(hive->reset_domain,
+				     &hive->reset_on_init_work);
+}
+
+int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_hive_info *hive;
+	int r, num_devs;
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (!hive)
+		return -EINVAL;
+
+	mutex_lock(&hive->hive_lock);
+	num_devs = atomic_read(&hive->number_devices);
+	if (num_devs == adev->gmc.xgmi.num_physical_nodes)
+		amdgpu_xgmi_schedule_reset_on_init(hive);
+
+	mutex_unlock(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index a3bfc16de6d4..d652727ca565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -45,6 +45,7 @@ struct amdgpu_hive_info {
 	struct amdgpu_reset_domain *reset_domain;
 	atomic_t ras_recovery;
 	struct ras_event_manager event_mgr;
+	struct work_struct reset_on_init_work;
 };
 
 struct amdgpu_pcs_ras_field {
@@ -75,5 +76,6 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c76ac0dfe572..cafcb24449df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2413,11 +2413,17 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+	/*
+	 * For minimal init, late_init is not called, hence VM fault/RAS irqs
+	 * are not enabled.
+	 */
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
-	if (adev->gmc.ecc_irq.funcs &&
-		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
-		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+		if (adev->gmc.ecc_irq.funcs &&
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+			amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..e60c69c5f894 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1295,7 +1295,12 @@ static int soc15_common_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_put_irq(adev);
 
+	/*
+	 * For minimal init, late_init is not called, hence RAS irqs are not
+	 * enabled.
+	 */
 	if ((!amdgpu_sriov_vf(adev)) &&
+	    (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
 	    adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		if (adev->nbio.ras &&
-- 
2.25.1

