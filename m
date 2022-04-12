Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C8FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 02:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AAE10E09C;
	Tue, 12 Apr 2022 02:16:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F238D10E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 02:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORSbnqmVQ6jd9BdUjIXvrOEwBmWQvUrcdxs2sb4gWxZiDVw+ds3yk1lkpDE/sAivXSiZXfM4WfN8ZsIRfPsFoNDuxWa2wKkWRfKFkYcC+5jq834tyPm9E+BCi3i5cZsOz/lUjb4ZKIe5PoenDPaF5z5oz9N4xIbT5VBaigIVyLMLyf9YjNUWed3E//6Sr5RF5GYdzsM11MiHx/oubdJAMvxsfB31ycPgZbTVoio83wve3oAvQzG0ezZJrj5QapbMeWiX4hF2a5LzmWhGhecen97tocyJju2VJC4kloGWPak273wQlQa1wnv2Q62MI+TXXsVCNJxvP+hjVo7RJZ3/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmRCrbC/qHpJ2ysfEiqZrBQyC4ML1peUd+Oj/wY9DDM=;
 b=JiPM80bEyUURIb3laurqKO8ohSFs0gumAyu/Axrc2N54JUCkTAOhkTnOE9SnKEUXnVpiQRSuDphm3maEdaWj85SYl4BHG+f7qVhYMkOrRsLOj7/vixIzNo4+HwkP50psls7nxtAfHKTxUqnKMDl7uWtLPsP9thlFmlP/QRX0WfSvlLJ5r6/LMMxarowZqD5xLlX00FAOkBJAnAb0gTvFyUEHabxB7/hloPyFmTE0rgy6LTm0zhDBN00MNpkbbXtAPmTd8JCMmxsyhxJng+8NNF3hBeH58XLI+09Re46UjeTbq2GyhjcjSrE8OAZRSU6upPv2PhwhIcrlY4tPPy021Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmRCrbC/qHpJ2ysfEiqZrBQyC4ML1peUd+Oj/wY9DDM=;
 b=hgC2jNvs9lZcIC/GR0GX/0Z5n+dRiDakUltIefdINpZeKB59AklktVqZfdcL7aclqyxGJ5H8atQGBCutQRfS4EUvLp+O08EtkY9DQDdJiRR66+JgAODEglOa9jtZK1ZizaZ5YcyMRrGbMSBk2x0ttwOiru39T4UPIW0Z2FzvTO0=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:15:56 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::71) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 02:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 02:15:55 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 21:15:54 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdkfd: Cleanup IO links during KFD device removal
Date: Mon, 11 Apr 2022 22:15:31 -0400
Message-ID: <20220412021531.822370-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d71c3113-2c20-4151-bcbe-08da1c2a6064
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27760C59BFF892B3950BCBEDEEED9@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a53tgo/tvMWWxQTmL3QLRN7iRDMTu61pVir2AREiblrBbfxzPyLtfaeQbM8HiTZQQ5HGm6LyEfRkojgFrXaISOD4cOUkDMU5saNlMXqCfgwc0kbzVhWJ6H1W+7t56IbKnT1ktfq4s11gf37z5/VVonaLjIEDMaAAB9l3Xo3HC9LmnqRA74z1pfAb3R0r06cui51M1L3j9CaJH/VU/aEBxyybcbBjN4G+PYwMx03W7mvG0UHCop478G4JQwDOz9yDGqw/6q1Ll/AqvXxUSwczAYHxHFlSjHniyuKcV+S5QliSCycOr5EIKyls/qMfY45azotscmmZfDIuPBUaB5lsCHRhyD91Im4ydf1Fk5myYYqgr3LaTqyLRLCVuhfiyjGvKkviZlCbP4yK8cy+rw1LA5kZOtNHbb+97G3kGBsKX4iPrieFKgg8jdrE81xC5jfx1QgBi2wRmZ24CoGsMP7ub5fzQ3YJx8xh10juVkCm3Pdq+hHFeNYfiu3Yju3ydXNnYEDwXEZlN5+FsY0ySuYRh9QQurzXhuYD/lr18VUk2HWMpIaAA6jx56p3DvzwKEYHYMdj547PT8zGroewSK2/UW6F4lZpaSn1mU2tDanBoujKDouLZbSDPLR8gGWOe7rq5bG92QuWweWNRoPSL+bgFeXNOCZdcbPKtW6Hmw1/mi5RYIaArFgmVwllPXGboPiu9VtaL857ZiR+zPqS9o1uoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(44832011)(81166007)(356005)(8936002)(186003)(6666004)(2906002)(40460700003)(6916009)(316002)(7696005)(36860700001)(45080400002)(1076003)(4326008)(2616005)(8676002)(83380400001)(70206006)(70586007)(5660300002)(36756003)(508600001)(54906003)(26005)(426003)(16526019)(86362001)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 02:15:55.5890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c3113-2c20-4151-bcbe-08da1c2a6064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 Shuotao Xu <shuotaoxu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, the IO-links to the device being removed from topology,
are not cleared. As a result, there would be dangling links left in
the KFD topology. This patch aims to fix the following:
1. Cleanup all IO links to the device being removed.
2. Ensure that node numbering in sysfs and nodes proximity domain
   values are consistent after the device is removed:
   a. Adding a device and removing a GPU device are made mutually
      exclusive.
   b. The global proximity domain counter is no longer required to be
      an atomic counter. A normal 32-bit counter can be used instead.
3. Update generation_count to let user-mode know that topology has
   changed due to device removal.

CC: Shuotao Xu <shuotaoxu@microsoft.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Shuotao Xu <shuotaoxu@microsoft.com>
---
v1->v2:
- Remove comments from inside kfd_topology_update_io_links()
  and add them as kernel-doc comments.

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 83 ++++++++++++++++++++---
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1eaabd2cb41b..afc8a7fcdad8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 	 * table, add corresponded reversed direction link now.
 	 */
 	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
-		to_dev = kfd_topology_device_by_proximity_domain(id_to);
+		to_dev = kfd_topology_device_by_proximity_domain_no_lock(id_to);
 		if (!to_dev)
 			return -ENODEV;
 		/* same everything but the other direction */
@@ -2225,7 +2225,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 */
 	if (kdev->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
-			peer_dev = kfd_topology_device_by_proximity_domain(nid);
+			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
 			if (!peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->hive_id != kdev->hive_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e1b7e6afa920..8a43def1f638 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
 int kfd_topology_remove_device(struct kfd_dev *gpu);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 						uint32_t proximity_domain);
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
+						uint32_t proximity_domain);
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3bdcae239bc0..98a51847cd8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -46,22 +46,32 @@ static struct list_head topology_device_list;
 static struct kfd_system_properties sys_props;
 
 static DECLARE_RWSEM(topology_lock);
-static atomic_t topology_crat_proximity_domain;
+static uint32_t topology_crat_proximity_domain;
 
-struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
 						uint32_t proximity_domain)
 {
 	struct kfd_topology_device *top_dev;
 	struct kfd_topology_device *device = NULL;
 
-	down_read(&topology_lock);
-
 	list_for_each_entry(top_dev, &topology_device_list, list)
 		if (top_dev->proximity_domain == proximity_domain) {
 			device = top_dev;
 			break;
 		}
 
+	return device;
+}
+
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
+						uint32_t proximity_domain)
+{
+	struct kfd_topology_device *device = NULL;
+
+	down_read(&topology_lock);
+
+	device = kfd_topology_device_by_proximity_domain_no_lock(
+							proximity_domain);
 	up_read(&topology_lock);
 
 	return device;
@@ -1060,7 +1070,7 @@ int kfd_topology_init(void)
 	down_write(&topology_lock);
 	kfd_topology_update_device_list(&temp_topology_device_list,
 					&topology_device_list);
-	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
+	topology_crat_proximity_domain = sys_props.num_devices-1;
 	ret = kfd_topology_update_sysfs();
 	up_write(&topology_lock);
 
@@ -1295,8 +1305,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
-	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
-
 	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
 	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
 		struct kfd_topology_device *top_dev;
@@ -1321,12 +1329,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	 */
 	dev = kfd_assign_gpu(gpu);
 	if (!dev) {
+		down_write(&topology_lock);
+		proximity_domain = ++topology_crat_proximity_domain;
+
 		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
 						    COMPUTE_UNIT_GPU, gpu,
 						    proximity_domain);
 		if (res) {
 			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
+			topology_crat_proximity_domain--;
 			return res;
 		}
 		res = kfd_parse_crat_table(crat_image,
@@ -1335,10 +1347,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		if (res) {
 			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
+			topology_crat_proximity_domain--;
 			goto err;
 		}
 
-		down_write(&topology_lock);
 		kfd_topology_update_device_list(&temp_topology_device_list,
 			&topology_device_list);
 
@@ -1485,25 +1497,78 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	return res;
 }
 
+/**
+ * kfd_topology_update_io_links() - Update IO links after device removal.
+ * @proximity_domain: Proximity domain value of the dev being removed.
+ *
+ * The topology list currently is arranged in increasing order of
+ * proximity domain.
+ *
+ * Two things need to be done when a device is removed:
+ * 1. All the IO links to this device need to be removed.
+ * 2. All nodes after the current device node need to move
+ *    up once this device node is removed from the topology
+ *    list. As a result, the proximity domain values for
+ *    all nodes after the node being deleted reduce by 1.
+ *    This would also cause the proximity domain values for
+ *    io links to be updated based on new proximity domain
+ *    values.
+ *
+ * Context: The called must hold write topology_lock.
+ */
+static void kfd_topology_update_io_links(int proximity_domain)
+{
+	struct kfd_topology_device *dev;
+	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
+
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->proximity_domain > proximity_domain)
+			dev->proximity_domain--;
+
+		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props, list) {
+			/*
+			 * If there is an io link to the dev being deleted
+			 * then remove that IO link also.
+			 */
+			if (iolink->node_to == proximity_domain) {
+				list_del(&iolink->list);
+				dev->io_link_count--;
+				dev->node_props.io_links_count--;
+			} else if (iolink->node_from > proximity_domain) {
+				iolink->node_from--;
+			} else if (iolink->node_to > proximity_domain) {
+				iolink->node_to--;
+			}
+		}
+
+	}
+}
+
 int kfd_topology_remove_device(struct kfd_dev *gpu)
 {
 	struct kfd_topology_device *dev, *tmp;
 	uint32_t gpu_id;
 	int res = -ENODEV;
+	int i = 0;
 
 	down_write(&topology_lock);
 
-	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
+	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
 		if (dev->gpu == gpu) {
 			gpu_id = dev->gpu_id;
 			kfd_remove_sysfs_node_entry(dev);
 			kfd_release_topology_device(dev);
 			sys_props.num_devices--;
+			kfd_topology_update_io_links(i);
+			topology_crat_proximity_domain = sys_props.num_devices-1;
+			sys_props.generation_count++;
 			res = 0;
 			if (kfd_topology_update_sysfs() < 0)
 				kfd_topology_release_sysfs();
 			break;
 		}
+		i++;
+	}
 
 	up_write(&topology_lock);
 
-- 
2.35.1

