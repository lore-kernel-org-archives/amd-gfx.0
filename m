Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEA6FB5168
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2026 21:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F3910E295;
	Mon,  6 Apr 2026 21:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKQP5QA5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EB810E295
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2026 21:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWHw3sBZ6peBYxCwrcQHyEB9ocTc28BmACNJ7ludYLXp6F/XWihXRAjA37a09AHsntGI4KLmVLtK/XmMxb0sOuKCtwOM8/mBVxuLRTbO8A/MCNrVOoGGoYEfRVoR+i1OLXnFaPtTBAV4nUJxfntZartFhz6axaTnvFoP/w0qIMHp8mdbis7O7HpAHh7ExRT+osqthSxZo5pGTPv3i0SZe056bLi91aNSRBW7yqiq9Ta4w+N3QQMrGKbvdg5Ko/M+rw1NR+qu2BL0Ymi6849BWnkdAYinurfKjQsXK6q/wTnPrv59MB6FnMSqOkuS+xjZmcQc9PyxqWqaOUigHN4HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85aZ1OqI6flEwFv5FGlZs4rCJ488rAWN4/GWSIyBdxo=;
 b=jvdxe9pwk6qNajy8FNKLhJFGH0jx1HBpXTXKxePsMgyIO21xt9DUpArbyC+PcMq0DPNxd6xY73aBcTZ9GRcuRV46hTVdytCupqnfnQltQWK/cnYIkSZ33ZhQkQT4SmEG9T3exv/2fhp8Blw/GwRlrf7s0EzhoJGL3AIiBQwQLvK5o53Dwenh2fOgcoTSrmsWHJ0c7MeUUGMqLBy8dtEbcXJLnA3IIO4f4EfcnOK2sKo4cLCBzfuEJgeItIzsrQ8JzwIje90NffonRNP4RyRr2kTYUiWk6WnSdnNvfctS/rJ0bZkqmTysHaYJyvm0/8zQRIGIARX1kBrejbOI6bsh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85aZ1OqI6flEwFv5FGlZs4rCJ488rAWN4/GWSIyBdxo=;
 b=XKQP5QA5nDSiP0yHrms8F4qcfbUOXdGJxKC9nTs4bP5u5S6SO0q0dee/zzzV7QRa8aNQUzNcqqlZhLajOwBh9ZZW50mMQHsBJ7rMlQwiyWigcTQi4TM8Ii4Ic5wOskc5hFsDOylAeTXInM3szTY5ZRhaU4qIyGgxGNdnLl6BHP8=
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 21:25:00 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::78) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 21:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 6 Apr 2026 21:24:59 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Apr 2026 16:24:59 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Ryan.Fechney@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Export ip_discovery sysfs on probe failure
Date: Mon, 6 Apr 2026 16:24:42 -0500
Message-ID: <20260406212442.2321667-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7ff7d9-528f-4031-76c4-08de9422f562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MP2AVT96nhx4OBtQU+qtsK7bR4f2gt/1qr9G83RzBEzvOwdk11yfyhuLN2rHb6hzDHWoKiVdgl1tuHkbALBM6rtO/qSgUEkQ6jpxGXNZqQd4UMwXItCwZrKMn+QRk+y+VouMlXmgOeACDr82hbQ9yoUJQGbLcdbmTzr8r974hijte8B75SJpm8fZFSfBD13NqWUOZctKUJ9A24rjrtmLk4Sdg6C43BCVdoaQMYfH67bvSZ+CFkH1C57u6pUcORHsF2hfy6FsiH4xtPxaRBOfkprFHmlCKDT+lGF5wtUhgJRvShyooulybQtcFIuOWfMaNwWs8ffCNBiprVOja+aIcjS5qQ1aboT3W6oXoqZw7wd8GEU+FKgCHnqr6hCiSuJjnT4m5Gs1CUK5viA7ybElehpMueooJgjT7adR+j8a1cDnFRg1ROyrSd+ZUawn0PBsU3SxqY0vFgtYFtWtzqEHdakpveCFrCHJBvgKzvxF9T15cjDC8JzQbdHtuqZ6OKbePNZeE/9FrW63QAGE8jWlZGdNoLjU9mIrwZDA5K3FdnRwoPJWVO4bytCflOPUeyK4SAlWMBwA3OMzumBYNi3dwRM/mjFfBHQOAi/Z7y8FR9CqaFvI+eHyWNAJDqRHJrZOVQ3QDZvniipUBiQHZdXGRAjWEM6irGZ5Tjq729ok/rD9M/LuaxbLNbUbwEZ79eZYadP6/OnKBQS57W+lm3ZYLdblDGugABhKrYpXLm6xLOQTW3gN61fzDXhfng0leMPEU96k0P0573Azf+Yul7hjnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LqTPP9hjiXx8W6lW9c9jRM2BkiftJfkb8etZ0h7jLDuxaWWxNcvPu1KIyT7tIBzANZUl2373dR/2JsMIpWT+y3Co5nPAI3l2nfiEfl9wb6mtQ3gxYkJ5PvAGnqPimMCx4PrDvIULLSAnQY2VpFDGnhgBgR2HQcBf4v84bZRt8xMcJVsDOx6xZMK8Xh56+WHA5CjEbJ0sFV4wcZzvAuMuF3WFLSNF5vGZ9irHp/g7wy4P6F1lOdUXvc26mnUE4wO7q39YAJJS3a1uzA+WLIp1brI7OYP+4Ey2v+2RTgrsrnv+Kb2RwiKjDSWCrzO/O+Xl/PK07yosJssQ3WkSeVYNhn5aLdp9JTmI6ad4zyrJF835ciJz8gyFp9cthzRdC4+e+EWuCVrSGQBiuvgGfV9VPynK6jDCYKB9v2597xNufCP617ukYGb9dNG0k1HCWIYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:24:59.8478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ff7d9-528f-4031-76c4-08de9422f562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 248 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 3 files changed, 234 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index af3d2fd61cf3f..f88cffa56c6ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/kernfs.h>
 
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
@@ -139,6 +140,26 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
 
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
@@ -676,7 +697,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
-	amdgpu_discovery_sysfs_fini(adev);
+	if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone_mode)
+		amdgpu_discovery_sysfs_fini(adev);
+
 	kfree(adev->discovery.bin);
 	adev->discovery.bin = NULL;
 }
@@ -685,15 +708,17 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
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
 
@@ -1056,12 +1081,6 @@ static const struct kobj_type ip_discovery_ktype = {
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
@@ -1077,8 +1096,14 @@ static void ip_disc_release(struct kobject *kobj)
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
@@ -1086,6 +1111,10 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 {
 	uint8_t harvest = 0;
 
+	/* In early init mode (adev == NULL), harvest info is not available */
+	if (!adev)
+		return 0;
+
 	/* Until a uniform way is figured, get mask based on hwid */
 	switch (hw_id) {
 	case VCN_HWID:
@@ -1114,11 +1143,14 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
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
@@ -1220,10 +1252,12 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
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
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
@@ -1270,7 +1304,8 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 			return res;
 		}
 
-		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips, !!ihdr->base_addr_64_bit);
+		amdgpu_discovery_sysfs_ips(adev, ip_top, ip_die_entry, ip_offset,
+					   num_ips, !!ihdr->base_addr_64_bit);
 	}
 
 	return 0;
@@ -1286,12 +1321,30 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	if (!discovery_bin)
 		return -EINVAL;
 
+	/* If early init already created sysfs in standalone mode, skip normal init */
+	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
+		return 0;
+
 	ip_top = kzalloc_obj(*ip_top);
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
@@ -1299,6 +1352,8 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 		goto Err;
 	}
 
+	adev->discovery.ip_top = ip_top;
+
 	die_kset = &ip_top->die_kset;
 	kobject_set_name(&die_kset->kobj, "%s", "die");
 	die_kset->kobj.parent = &ip_top->kobj;
@@ -1313,7 +1368,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
 	ip_hw_instance_attrs[ii] = NULL;
 
-	res = amdgpu_discovery_sysfs_recurse(adev);
+	res = amdgpu_discovery_sysfs_recurse(adev, ip_top);
 
 	return res;
 Err:
@@ -1366,6 +1421,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	struct list_head *el, *tmp;
 	struct kset *die_kset;
 
+	if (!ip_top)
+		return;
+
 	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
 	list_for_each_prev_safe(el, tmp, &die_kset->list) {
@@ -1379,6 +1437,151 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	kobject_put(&ip_top->kobj);
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
+	early_entry = kzalloc_obj(*early_entry);
+	if (!early_entry)
+		return -ENOMEM;
+
+	ip_top = kzalloc_obj(*ip_top);
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
+
 /* ================================================== */
 
 static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
@@ -1403,6 +1606,9 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
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
index 4ce04486cc319..05a19cfe83988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -47,4 +47,9 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  struct amdgpu_gmc_memrange **ranges,
 				  int *range_cnt, bool refresh);
 
+/* Early sysfs functions for persistent ip_discovery export */
+int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev,
+				       struct pci_dev *pdev);
+void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
+
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d545..acfebb33b0e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2562,6 +2562,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
+	amdgpu_discovery_sysfs_early_fini(pdev);
+
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
-- 
2.53.0

