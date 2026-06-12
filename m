Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78D0CD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 16:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568C410EABA;
	Fri, 12 Jun 2026 16:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdKbdycA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DA110EABA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 16:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO9isQLJd7r1AsYuLXbxFRqetzuqlhr3fN1YtdaJYdRJtxgF8vH7N1eNMJ1+UhNiIWB4W/RlI75uVHk+ay4Vc5CEg7ziBq6QAi6+xiR8EwTqBZl3z1oOtOotTmLIy4lrLidDWmQ5+J65HV7NTYLJUFMuZcu8x6bjolJNkmD+3Bh2mQL1HCP4EvUrxUtWuuTt+txIt3YPPnMhZxxTBmtk6/OOQJy5HWiFn80Fkb4LZTtbw5i9S6aeLekhK/V26Qegp6hJvb1jqRyMdODDX6tr5lB1/dnorg1Vu1C2E5R4WHZjdZyGht1kMnt0PaGbAjmbnc1FtP4AY1oH2R7TGQPHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktd16R/jjZRUlga1aHRx2lgxJBgMYwCCqcjkwjgD/zM=;
 b=QzLCO2cqTMkb+M9Qg1zts3g+9Wte4fL05UulW9rnUPjsQAUmDCErl+JygDWkA/jjgX8RmMrkuA9TzXIWiRoNJGL4hq924ot+vAVhJ//sD6AzHrmw7yZ2yJPxFPCrg/CBvuPi0cpjwGO1xo/ySC8I6WLuwoR3OpCjT5BWz4oQNiSd4SFWvf1UssBp2muxSGiaNqzrpgvkAC8H4TSKOnNgwVEN98kGmFNAdJ6iRU16xCI8ojQCJDhVOrSHLNhDAxENxnQmsx/QU1huU8zNb2y9KkYvs4/qj1bMJQh3MwjdIvq3oks8iIDL7NfWp8WKbbBu1yP3MwGakTWDQRj1CdGwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktd16R/jjZRUlga1aHRx2lgxJBgMYwCCqcjkwjgD/zM=;
 b=XdKbdycAKZx66aNzDLtIuQ5dqq+PuX2DRDayQkL1sRoZsEJ315mPbHMNSJt+/vzGzfTQlEhEhlMstsMUX1E114BVlVCUSQAKGRvPn9bwRyAHi46qKpXhhc20jboidaU78y9dZEWTNJFeEb86iOe4T9fhoZygSRj//bnQoeac5AY=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:44:53 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::40) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Fri, 12
 Jun 2026 16:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 16:44:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 11:44:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amdgpu: Export ip_discovery sysfs on probe failure
Date: Fri, 12 Jun 2026 11:44:43 -0500
Message-ID: <20260612164443.1002712-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c230f7-4397-4251-3c33-08dec8a1ed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Nc/ubwfgeZXB5bhtsEjJ8RBNiAfocxBBWg3LwyZe5iNq/swCbo5conV5BN+ZE875OmRRawsWBbSy7wxhQ82wWm6YptnyO74edKwsds5Dh8juQO+NkFvtSPPJhGywZz2oR2WJD0HFazSxdpAjW1XmuAD6+CnXeXHyt/DU4NapKpzI1ezbLKek+XPyFdSz1pyisrynhWvH0jGO/uWqFUrl4ternZaKtuFdQVarSLGaGZnIZROCLi9tFtexfNXAkvqVtNxPOQZLHCoN2mPnevrFx5wWboHnY9GXJZoeEUDCE+WiWAvKHIkN1kgvS3xZHvm1qSNtR0KvIc5a6IaDIWpcuOmamVf5tss6tkd70Qbjyqq3j8PXcSK1k0npDJbEFmALEHdbx+nmqJmu9YUxhmVEsvISZlsrsVsOhh544/JIvzUnsuBTz2HbR4Y4faRvoTnxFMl5J4x+np6U6GpJ1dGESGMhzY/ougfK4qdUCIiUQOVEPpqoKAihOwOl6uLB7xjVnOH8i3uk82fPednnoqt6z5q//ZHvJxV+1adYt6F661GYtmb1SfMCgha0/Bp8tJYz5ZSaHAQWnQFpqprASazmBKvdLCrxW3N9ewgo2ihOUZ52U55UbM0djcRAkC5SPAFDFjqRAKMkvvBMEKVdrd04KB1q+WsKQ2sUonK3JQMgH7tLDh4sii/ZO8r3/RDmN1ZQ4yXqXGjGIsWuvPm0/hH/TKQnXBmRN6kuPWEFTzJ4d+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LMgtJz4gjQdsVNX696m7Ve0pSDkMlSoyD7uetYad1SeK0bDSL3PYNEKHLG6vv0s2j86uJ0tvrtPqLFLwuEDV/rRqu5JuoC9o0FXcgrijk0O49qk3jPBlXcKQXeHOV9QYJZ8NXeDiIGHZbMy3/2Db+XOlPFhjh0zbIfvdiQW5wWQyu+IKzEA8PMJ/KTwljSHebz7EP1gj85vlSHpvLwqeY1AdvC7Vt7Xl/dEqQ8i8e03yers2mNPtE6hWBS9aK1zT9MgL3ILqBDV33z49qvy0QFxOnwjNqmGP1/OM7Zx763gAievHyo9AWZVmPmvJqno48XG4qIFX54rTub/R5SaPj8DwkEgSfvn7ctO6z/UrD1jT5kBy7E5JE8T07yAWWAp6291oxAXLtFtm0WkdiuUnvVP+IjcbCPYPQBPLzN+9Acmnst5JTpRlG62uw105aUXn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:44:52.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c230f7-4397-4251-3c33-08dec8a1ed16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

When driver probe fails (missing firmware, unsupported hardware, etc.),
the entire device is torn down including the ip_discovery sysfs folder,
preventing users from identifying what hardware is present.

Export ip_discovery sysfs even when probe fails by creating it early
in the probe flow and tying its lifetime to the PCI device rather than
the driver. The sysfs folder persists across probe failures and module
reloads, but is cleaned up on driver unbind.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * rebase on amd-staging-drm-next

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 285 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 3 files changed, 257 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2cfcfa29204a5..49e8ed65d7a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/kernfs.h>
 
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
@@ -148,6 +149,26 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 #define mmDRIVER_SCRATCH_1	0x95
 #define mmDRIVER_SCRATCH_2	0x96
 
+struct ip_discovery_top {
+	struct kobject kobj;
+	struct kset die_kset;
+	struct pci_dev *pdev;
+	struct amdgpu_device *adev;
+	uint8_t *discovery_bin;
+	uint32_t bin_size;
+	bool standalone_mode;
+};
+
+/* List to track early-initialized ip_discovery_top entries */
+struct early_ip_discovery {
+	struct list_head list;
+	struct pci_dev *pdev;
+	struct ip_discovery_top *ip_top;
+};
+
+static LIST_HEAD(early_ip_discovery_list);
+static DEFINE_MUTEX(early_ip_discovery_mutex);
+
 static const char *hw_id_names[HW_ID_MAX] = {
 	[MP1_HWID]		= "MP1",
 	[MP2_HWID]		= "MP2",
@@ -542,25 +563,37 @@ static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 	}
 }
 
-static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
-					   struct table_info **info,
-					   uint16_t table_id)
+static struct table_info *
+amdgpu_discovery_get_table_info_from_bin(uint8_t *discovery_bin,
+					 uint16_t table_id)
 {
-	struct binary_header *bhdr =
-		(struct binary_header *)adev->discovery.bin;
+	struct binary_header *bhdr = (struct binary_header *)discovery_bin;
 	struct binary_header_v2 *bhdrv2;
 
 	switch (bhdr->version_major) {
 	case 2:
-		bhdrv2 = (struct binary_header_v2 *)adev->discovery.bin;
-		*info = &bhdrv2->table_list[table_id];
-		break;
+		bhdrv2 = (struct binary_header_v2 *)discovery_bin;
+		return &bhdrv2->table_list[table_id];
 	case 1:
 	case 0:
-		*info = &bhdr->table_list[table_id];
-		break;
+		return &bhdr->table_list[table_id];
 	default:
-		dev_err(adev->dev, "Invalid ip discovery table version %d\n",bhdr->version_major);
+		return NULL;
+	}
+}
+
+static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
+					   struct table_info **info,
+					   uint16_t table_id)
+{
+	struct binary_header *bhdr =
+		(struct binary_header *)adev->discovery.bin;
+
+	*info = amdgpu_discovery_get_table_info_from_bin(adev->discovery.bin,
+							 table_id);
+	if (!*info) {
+		dev_err(adev->dev, "Invalid ip discovery table version %d\n",
+			bhdr->version_major);
 		return -EINVAL;
 	}
 
@@ -728,7 +761,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
-	amdgpu_discovery_sysfs_fini(adev);
+	if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone_mode)
+		amdgpu_discovery_sysfs_fini(adev);
+
 	kfree(adev->discovery.bin);
 	adev->discovery.bin = NULL;
 }
@@ -737,15 +772,17 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
 					uint8_t instance, uint16_t hw_id)
 {
 	if (instance >= HWIP_MAX_INSTANCE) {
-		dev_err(adev->dev,
-			"Unexpected instance_number (%d) from ip discovery blob\n",
-			instance);
+		if (adev)
+			dev_err(adev->dev,
+				"Unexpected instance_number (%d) from ip discovery blob\n",
+				instance);
 		return -EINVAL;
 	}
 	if (hw_id >= HW_ID_MAX) {
-		dev_err(adev->dev,
-			"Unexpected hw_id (%d) from ip discovery blob\n",
-			hw_id);
+		if (adev)
+			dev_err(adev->dev,
+				"Unexpected hw_id (%d) from ip discovery blob\n",
+				hw_id);
 		return -EINVAL;
 	}
 
@@ -1111,12 +1148,6 @@ static const struct kobj_type ip_discovery_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
-struct ip_discovery_top {
-	struct kobject kobj;    /* ip_discovery/ */
-	struct kset die_kset;   /* ip_discovery/die/, contains ip_die_entry */
-	struct amdgpu_device *adev;
-};
-
 static void die_kobj_release(struct kobject *kobj)
 {
 	struct ip_discovery_top *ip_top = container_of(to_kset(kobj),
@@ -1132,8 +1163,14 @@ static void ip_disc_release(struct kobject *kobj)
 						       kobj);
 	struct amdgpu_device *adev = ip_top->adev;
 
+	/* In standalone mode, discovery_bin is managed by devm and will be
+	 * freed automatically when the PCI device is removed. Do not manually
+	 * free it here to avoid double-free.
+	 */
+
 	kfree(ip_top);
-	adev->discovery.ip_top = NULL;
+	if (adev)
+		adev->discovery.ip_top = NULL;
 }
 
 static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
@@ -1141,6 +1178,10 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 {
 	uint8_t harvest = 0;
 
+	/* In early init mode (adev == NULL), harvest info is not available */
+	if (!adev)
+		return 0;
+
 	/* Until a uniform way is figured, get mask based on hwid */
 	switch (hw_id) {
 	case VCN_HWID:
@@ -1169,11 +1210,14 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 }
 
 static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
+				      struct ip_discovery_top *ip_top,
 				      struct ip_die_entry *ip_die_entry,
 				      const size_t _ip_offset, const int num_ips,
 				      bool reg_base_64)
 {
-	uint8_t *discovery_bin = adev->discovery.bin;
+	uint8_t *discovery_bin = ip_top->standalone_mode ?
+				 ip_top->discovery_bin :
+				 adev->discovery.bin;
 	int ii, jj, kk, res;
 	uint16_t hw_id;
 	uint8_t inst;
@@ -1271,10 +1315,12 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
+static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
+					  struct ip_discovery_top *ip_top)
 {
-	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
-	uint8_t *discovery_bin = adev->discovery.bin;
+	uint8_t *discovery_bin = ip_top->standalone_mode ?
+				 ip_top->discovery_bin :
+				 adev->discovery.bin;
 	struct table_info *info;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
@@ -1283,9 +1329,10 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 	size_t ip_offset;
 	int ii, res;
 
-	res = amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY);
-	if (res)
-		return res;
+	info = amdgpu_discovery_get_table_info_from_bin(discovery_bin,
+							IP_DISCOVERY);
+	if (!info)
+		return -EINVAL;
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
 			   le16_to_cpu(info->offset));
@@ -1323,7 +1370,8 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 			return res;
 		}
 
-		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips, !!ihdr->base_addr_64_bit);
+		amdgpu_discovery_sysfs_ips(adev, ip_top, ip_die_entry, ip_offset,
+					   num_ips, !!ihdr->base_addr_64_bit);
 	}
 
 	return 0;
@@ -1339,12 +1387,30 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	if (!discovery_bin)
 		return -EINVAL;
 
+	/* If early init already created sysfs in standalone mode, skip normal init */
+	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
+		return 0;
+
 	ip_top = kzalloc(sizeof(*ip_top), GFP_KERNEL);
 	if (!ip_top)
 		return -ENOMEM;
 
 	ip_top->adev = adev;
-	adev->discovery.ip_top = ip_top;
+
+	/* Check if ip_discovery already exists before creating.
+	 * This shouldn't normally happen but handle it gracefully.
+	 */
+	if (adev->dev->kobj.sd) {
+		struct kernfs_node *existing;
+
+		existing = kernfs_find_and_get(adev->dev->kobj.sd, "ip_discovery");
+		if (existing) {
+			kernfs_put(existing);
+			kfree(ip_top);
+			return 0;
+		}
+	}
+
 	res = kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
 				   &adev->dev->kobj, "ip_discovery");
 	if (res) {
@@ -1352,6 +1418,8 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 		goto Err;
 	}
 
+	adev->discovery.ip_top = ip_top;
+
 	die_kset = &ip_top->die_kset;
 	kobject_set_name(&die_kset->kobj, "%s", "die");
 	die_kset->kobj.parent = &ip_top->kobj;
@@ -1366,7 +1434,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
 	ip_hw_instance_attrs[ii] = NULL;
 
-	res = amdgpu_discovery_sysfs_recurse(adev);
+	res = amdgpu_discovery_sysfs_recurse(adev, ip_top);
 
 	return res;
 Err:
@@ -1480,6 +1548,150 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
 	spin_unlock(&die_kset->list_lock);
 }
 
+int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev, struct pci_dev *pdev)
+{
+	struct ip_discovery_top *ip_top;
+	struct early_ip_discovery *early_entry, *tmp;
+	struct kset *die_kset;
+	uint8_t *discovery_bin;
+	int res, ii;
+
+	if (!adev || !adev->discovery.bin)
+		return -EINVAL;
+
+	if (adev->discovery.ip_top)
+		return 0;
+
+	mutex_lock(&early_ip_discovery_mutex);
+	list_for_each_entry_safe(early_entry, tmp, &early_ip_discovery_list, list) {
+		if (early_entry->pdev == pdev) {
+			adev->discovery.ip_top = early_entry->ip_top;
+			early_entry->ip_top->adev = adev;
+			mutex_unlock(&early_ip_discovery_mutex);
+			return 0;
+		}
+	}
+	mutex_unlock(&early_ip_discovery_mutex);
+
+	discovery_bin = adev->discovery.bin;
+
+	early_entry = kzalloc(sizeof(*early_entry), GFP_KERNEL);
+	if (!early_entry)
+		return -ENOMEM;
+
+	ip_top = kzalloc(sizeof(*ip_top), GFP_KERNEL);
+	if (!ip_top) {
+		kfree(early_entry);
+		return -ENOMEM;
+	}
+
+	ip_top->discovery_bin = devm_kmemdup(&pdev->dev, discovery_bin,
+					     DISCOVERY_TMR_SIZE, GFP_KERNEL);
+	if (!ip_top->discovery_bin) {
+		kfree(ip_top);
+		kfree(early_entry);
+		return -ENOMEM;
+	}
+
+	ip_top->bin_size = DISCOVERY_TMR_SIZE;
+	ip_top->pdev = pdev;
+	ip_top->adev = adev;
+	ip_top->standalone_mode = true;
+
+	/* Check if ip_discovery already exists (from previous probe attempt).
+	 * This can happen if the module was unloaded and reloaded but the
+	 * sysfs persisted (tied to PCI device lifetime).
+	 */
+	if (pdev->dev.kobj.sd) {
+		struct kernfs_node *existing;
+
+		existing = kernfs_find_and_get(pdev->dev.kobj.sd, "ip_discovery");
+		if (existing) {
+			kernfs_put(existing);
+			kfree(ip_top);
+			kfree(early_entry);
+			return 0;
+		}
+	}
+
+	res = kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
+				   &pdev->dev.kobj, "ip_discovery");
+	if (res)
+		goto err_put_kobj;
+
+	adev->discovery.ip_top = ip_top;
+
+	die_kset = &ip_top->die_kset;
+	kobject_set_name(&die_kset->kobj, "%s", "die");
+	die_kset->kobj.parent = &ip_top->kobj;
+	die_kset->kobj.ktype = &die_kobj_ktype;
+	res = kset_register(&ip_top->die_kset);
+	if (res)
+		goto err_put_die_kset;
+
+	for (ii = 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
+		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
+	ip_hw_instance_attrs[ii] = NULL;
+
+	res = amdgpu_discovery_sysfs_recurse(NULL, ip_top);
+	if (res)
+		goto err_put_die_kset;
+
+	early_entry->pdev = pdev;
+	early_entry->ip_top = ip_top;
+	mutex_lock(&early_ip_discovery_mutex);
+	list_add(&early_entry->list, &early_ip_discovery_list);
+	mutex_unlock(&early_ip_discovery_mutex);
+
+	return 0;
+
+err_put_die_kset:
+	kobject_put(&ip_top->die_kset.kobj);
+err_put_kobj:
+	kobject_put(&ip_top->kobj);
+	kfree(early_entry);
+	adev->discovery.ip_top = NULL;
+	return res;
+}
+
+void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev)
+{
+	struct early_ip_discovery *entry, *tmp_entry;
+	struct ip_discovery_top *ip_top = NULL;
+	struct list_head *el, *tmp;
+	struct kset *die_kset;
+
+	/* Find the entry in our tracking list */
+	mutex_lock(&early_ip_discovery_mutex);
+	list_for_each_entry_safe(entry, tmp_entry, &early_ip_discovery_list, list) {
+		if (entry->pdev == pdev) {
+			ip_top = entry->ip_top;
+			list_del(&entry->list);
+			kfree(entry);
+			break;
+		}
+	}
+	mutex_unlock(&early_ip_discovery_mutex);
+
+	if (!ip_top)
+		return;
+
+	/* Clean up sysfs hierarchy */
+	die_kset = &ip_top->die_kset;
+
+	spin_lock(&die_kset->list_lock);
+	list_for_each_prev_safe(el, tmp, &die_kset->list) {
+		list_del_init(el);
+		spin_unlock(&die_kset->list_lock);
+		amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kobj(el)));
+		spin_lock(&die_kset->list_lock);
+	}
+	spin_unlock(&die_kset->list_lock);
+
+	kobject_put(&ip_top->die_kset.kobj);
+	kobject_put(&ip_top->kobj);
+	/* ip_top itself will be freed by kobject_put via ip_disc_release */
+}
 
 /* ================================================== */
 
@@ -1505,6 +1717,9 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	r = amdgpu_discovery_init(adev);
 	if (r)
 		return r;
+
+	amdgpu_discovery_sysfs_early_init(adev, adev->pdev);
+
 	discovery_bin = adev->discovery.bin;
 	wafl_ver = 0;
 	adev->gfx.xcc_mask = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index e0010f6a3eda5..edc78184e0f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -53,4 +53,9 @@ int amdgpu_discovery_get_gc_major_minor_version(struct amdgpu_device *adev,
 
 void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p);
 
+/* Early sysfs functions for persistent ip_discovery export */
+int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev,
+				       struct pci_dev *pdev);
+void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
+
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 503bb64c1e55f..63ca6bcde57ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2552,6 +2552,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
+	amdgpu_discovery_sysfs_early_fini(pdev);
+
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
-- 
2.43.0

