Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679B2CD13CF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154E810E21C;
	Mon,  2 Sep 2024 07:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjQ59gUV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A645410E21C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaovxGHzwYexKysNvUUh5aOl5OBQceJAezLHBJP4h6peZiSKwh5dcZunLKk8xw2YEljltMEnABnhvBEFCcOQn1osIP2UzPPNgextmNi0zTVojt0lGXdzvridnZny3AGIY8i5qi9KcHEAnsfBeR4sEAIPvl0dyFLj3N6wrKcZc79AdCPeJ4u/Kb8LiH73XYWU0rE04nXVW6kRyfpJfQdYGu1cERyi7Z7R4I0mW5nuRCHd3dzJhvoRCudtYz+0TGHYxk+N3DV+LvRLR5X5bZtkkgyXFYF2FUO87FeJ8n0uabC2z+4H4CKxTQGc2Uu6SvMmz0q2fpr++dsulQpxixmffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czEzWJ2+dX7W9GynYQCncLLueQ9Ln0UaxhIcVHNmXZs=;
 b=Pg6ux21WDyh89s5NtI6qjMB0NKkzasNTdRcslNrexWppF47EHbxr4szyEkv3Q7Zr0EyZHpD6xde2OjcJ27+3GPrvQCfYMniGUw8aKSPP921ni61HFa6B7EjNq1vhsuuxCoK/CGkJYAVnmYDAJ4xs3+z+j9adHBXfvONBX/kqG1Y2gQWkdzeyHd9pGYGjqEwjHio/fh9S6p/RGEcbh6ExWABna5NvMbi105MHk21XrAxcRJ9PstNNulH131cJ8o9YxoMJJBD0HMKHcCgVBBzW2LFWbR71VBMeEX/7Oakgxi6JZN6ABGfA0mWTxvgc19vOFg7oHPFgljhLT++M2IQrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czEzWJ2+dX7W9GynYQCncLLueQ9Ln0UaxhIcVHNmXZs=;
 b=BjQ59gUVeBHbP2A3s2vAfVKwYWjaaVdTLQ67hKR2qrxOc+xlJQNgjOFaV5/MaFKOgAy8MyZkOETYnzYmxeWrm7jFaOB3iUk/xPwZcXxzXsPS9OapWP3cZmoy6+707oeFLKTCgv62NKtLLSpXrLKtRBoBCtvl8GNC9UlhXdEuazA=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 07:34:46 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::4) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: Refactor XGMI reset on init handling
Date: Mon, 2 Sep 2024 13:04:13 +0530
Message-ID: <20240902073417.2025971-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd43a93-e4b7-47e0-47b2-08dccb21b80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ObD54DVo/CsPWKnlU7lszHW4gMExfSNOuvBap34F+xdXZeV7rEtxlbvzZZpj?=
 =?us-ascii?Q?LNUShhM65ZOVJcHsn5IyJkncIPN1j9NIxkAyK/sz7zLqvfI71mKzT6inVTYU?=
 =?us-ascii?Q?l7+qjAftwFCY4/WX436iZAdErf8fRBYaN3jBOb1Q3rDCYu1Seiz+ZwD0+w82?=
 =?us-ascii?Q?zzBmmIMxKpKPeb0BRjeIW8UNinbwI9aQhg+UfmR5xF0c8SPGO1OFPBvSeGes?=
 =?us-ascii?Q?DdKSqtLEd3oF1cXkSAuvUHapPj66HlGWMBs0yJPx56CiLEi5TubrmQzA6hI7?=
 =?us-ascii?Q?xPugrIGngw8aRS0jDveVFrmdmLUx8osS2sSfB96fNn7dJk9qUdmfIZCFk1KI?=
 =?us-ascii?Q?q3Qqihj6EI6/TAQVmZMjlqn5vSU8DBLP6jCtkm8UZuQ4IcX4JkUgJz0XDE67?=
 =?us-ascii?Q?4GNTYmPyJAu5jm644K53B8HqyrUsAw9Agy9crOaHUB9Rv97F/yXtQes38I1b?=
 =?us-ascii?Q?/r+IdVLd1UzsDqK1osbBBhDLdNRFQceGK2JaG8+pG1pJxcEcjTXYh2e4NQm0?=
 =?us-ascii?Q?QhsMAUG2kpGPN8w2tA2eY5jsnfYQji4U8J5qZFI7mVpc5Pxp78vA/OsDPxjf?=
 =?us-ascii?Q?KBkwSS09QFzQE+BLdggDtPAgtxiwZRTWli6c/ufLlAa9yyzemVFNUAz5I8Dj?=
 =?us-ascii?Q?8L7SdDQx+OEpp5ym1SpdzMuoLTqsswi6FhVHHiXxOxXUWVuWkXMiMl5Gsenh?=
 =?us-ascii?Q?I7s4RFXArshKYIoKZrN1GThiP96yNxOAtTqFsymhBYjJcjpO2cree2lYSSzn?=
 =?us-ascii?Q?xH6JsGr+RK3iAm3aCOtmozX3LLVp3C3RhMtCH+Q1yzZfpyI9zkkCDSDJiYd/?=
 =?us-ascii?Q?tLLG86Z2uQEs7DB48CL2m/Dqi98hEf7N6f5hoF9MUc+4rBdl9JqvQdRBVEMX?=
 =?us-ascii?Q?MQg/Hl/fac/yd2Iuw3UBz/whLM2A9Hb72QIGNd+fhfXk5SFttMRlBlW2WZHz?=
 =?us-ascii?Q?olF7d4gg5E9HQZnJ8eD2hmCCjr7u9XBW0/NKL1c9ScVr7MGwfzoAggmlik1u?=
 =?us-ascii?Q?Vgz0tUsdjHmexbztyMFYlS/zT8y7sri7dLost6N673IDxXfsYOYEnrizsNST?=
 =?us-ascii?Q?rls8dztUWfKmlEPTCUX0DBgBHcnRQulJ9R58BU1hxK0/m7meUXYewf4ozQFm?=
 =?us-ascii?Q?PdxQcOvSj6PSXmwsm+6jDkC3ditfx85pyPdDNto0cdG0omjnHFbYIu2Q0FqO?=
 =?us-ascii?Q?eOYJXD006DmiubQ3A1k3LRAZltGWJuCxWgwNfkkL+gvvp4XSyUHZDJT9bzQm?=
 =?us-ascii?Q?lKM0qnQqb1Z383wVluFqLBFhuKrRFSN4OVwQGqKWjKLGuTkeImEw6QqD9xuk?=
 =?us-ascii?Q?Xqu1OHax3pWn0a7DnTDp+Z+MaTkd9w+TB6ho1viSB8OY4q+RvWEN2tfWMqzU?=
 =?us-ascii?Q?IHS5Go9f2uBz+eqQbEK3U49aIHW8pZK7qLGmW73FRQj4fQVXwm34Pt4yduVt?=
 =?us-ascii?Q?MNarrxtSiALkW2zV78laxGH2puGI9VVh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:46.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd43a93-e4b7-47e0-47b2-08dccb21b80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  6 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 72 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 +++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  5 ++
 6 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 468c4f590183..9f33de7ab656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -155,7 +155,8 @@ struct amdgpu_init_level amdgpu_init_minimal = {
 	.level = AMDGPU_INIT_LEVEL_MINIMAL,
 	.hwini_ip_block_mask =
 		BIT(AMD_IP_BLOCK_TYPE_GMC) | BIT(AMD_IP_BLOCK_TYPE_SMC) |
-		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH)
+		BIT(AMD_IP_BLOCK_TYPE_COMMON) | BIT(AMD_IP_BLOCK_TYPE_IH) |
+		BIT(AMD_IP_BLOCK_TYPE_PSP)
 };
 
 static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *adev,
@@ -2832,6 +2833,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 {
+	bool init_badpage;
 	int i, r;
 
 	r = amdgpu_ras_init(adev);
@@ -2945,7 +2947,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	r = amdgpu_ras_recovery_init(adev, true);
+	init_badpage = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL);
+	r = amdgpu_ras_recovery_init(adev, init_badpage);
 	if (r)
 		goto init_failed;
 
@@ -4501,8 +4504,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
-		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
-				   msecs_to_jiffies(AMDGPU_RESUME_MS));
+		amdgpu_xgmi_reset_on_init(adev);
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 65c891b6b999..2c29f4c34e64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3216,12 +3216,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
 
-	/* Todo: During test the SMU might fail to read the eeprom through I2C
-	 * when the GPU is pending on XGMI reset during probe time
-	 * (Mostly after second bus reset), skip it now
-	 */
-	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
-		return 0;
 	if (init_bp_info) {
 		ret = amdgpu_ras_init_badpage_info(adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a7a892512cb9..6a473a4262f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -860,8 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
-	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
 			dev_err(adev->dev,
@@ -907,8 +906,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
-	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
@@ -985,7 +983,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!ret && (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL))
+	if (!ret)
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
 exit_unlock:
@@ -1500,3 +1498,67 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static void amdgpu_xgmi_roi_handler(struct work_struct *work)
+{
+	struct amdgpu_hive_info *hive =
+		container_of(work, struct amdgpu_hive_info, roi_work);
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
+	amdgpu_reset_xgmi_rst_on_init(&reset_context);
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
+	INIT_WORK(&hive->roi_work, amdgpu_xgmi_roi_handler);
+	amdgpu_reset_domain_schedule(hive->reset_domain, &hive->roi_work);
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
index a3bfc16de6d4..902c2f928653 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -45,6 +45,7 @@ struct amdgpu_hive_info {
 	struct amdgpu_reset_domain *reset_domain;
 	atomic_t ras_recovery;
 	struct ras_event_manager event_mgr;
+	struct work_struct roi_work;
 };
 
 struct amdgpu_pcs_ras_field {
@@ -75,5 +76,6 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c76ac0dfe572..bc30bc3b7851 100644
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
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) {
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
index 8d16dacdc172..7901b3fbc127 100644
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
+	    (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
 	    adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		if (adev->nbio.ras &&
-- 
2.25.1

