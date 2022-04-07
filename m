Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CFBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 16:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D500D10EB77;
	Thu,  7 Apr 2022 16:16:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B3410E1C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 16:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex9R49ag4rkVVmrB7QzmNqY7apGyYgLXgdFDgHlSt3p+8SkaW3dffqc/lBbMjhnfMlRxj8X2zHY4g0TNNc1QcvUr6jlqdSpgvdsyjpc2ZeBDWPYM6UVfDJ3UWNc9LvAkgODvt7EofAckvzLe4IetghZX7DNcDSP2lOvvwuf0qZ75FkeL9c+Oy6UYZlInnLKFueO9L2eJl4BuAwULylDhDv+B1ayUp/6CTlFSyOzqi1UZSjOGWRppi/9TS8nhr0Q5Y/yaU9zx14NaeAV38qEd0sS2Vu+Ag5wFGDzBwhKpeKpfF/kExsF2oNaAwTJ7TJB25d6pNhaUKxyA3b6pN5q4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llGe5LbpfBce4FH+/tsSWd1I8cpR+Rp2sZ8vHfcJgBg=;
 b=VXhsSCCPHOlySuXraKmSWIDVU8+xlPGy8trl8OEwOwqnSuBqmwi9FRUSVdOl/egYQG0EjCDd622CTcWMuIjXfjDjuj0jOTJ6xehd8+q8WF9uGfVDvs91jgpCziQeByE9s5w3Egu704PQciRn/8EaPx2aMflXeW5EQ9rtKrAxWTSVqnp1Vmzn3oOZ1Gv99/lGoDd5tD4x2uJkVaDpSHlOapb23ZR0q22RSIm+skPz89bwln5ikGqkhZJgdXJYfiCLVEkHnjKRU0MTRxgm1hSk7ZSJzKOGgpV29pCXqphp0RetB+VgOJ2GoH5xaPK3qnnn67AOM4pV/Nctlp60m2y6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llGe5LbpfBce4FH+/tsSWd1I8cpR+Rp2sZ8vHfcJgBg=;
 b=LNfYXqC+pJC2whLZiemdlQbU7OFqaHwsiRq7bnjbj5OStFeAT6QW/RdWBhTob3feuXhCxvXm3Vl5qD8zjAimt9BuQp5d8XCgK5UsZ/wodF/6kl2+ziE2/4bjExrBIRcNRy/6o/wAVCN2yRZys4kpf8aMabdQ2NUyMAmH2lDsUgQ=
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by BN6PR12MB1636.namprd12.prod.outlook.com (2603:10b6:405:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:16:14 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::b1) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Thu, 7 Apr 2022 16:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 16:16:14 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 11:16:13 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Cleanup IO links during KFD device removal
Date: Thu, 7 Apr 2022 12:15:55 -0400
Message-ID: <20220407161555.545725-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7721a07-2733-4321-4fab-08da18b1f04e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1636:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1636AB2F3E5B9D913471B357EEE69@BN6PR12MB1636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uShgz5IrMf1QdsImX6Vpq7mXw/LfvwePT2zVEFCa1QuToscUIt3xtGR9ReFCH9oU6Z6uaJzwlYkc/Vz4m4mA+XYESTgSXiOQeVuAbIzSdvxiA+6WUorEg+tq/ptTctsq5mhkC8wpWkYnpMMaTJfecAX/EdblBJRnquamRkFfunL2atLpgAT3DOmF9sECs2RPNXd5SDahkCtSjdDxrqvDmCXFfbFXQWMnP58aZoNW7XTzbx3VeQsINRI/b2Zc66aL4apwYpfXsDlQ3PWK+uGGOyc4EQL3ZGsZz0ggaSCTVGr/OC89xXaAMKy4YRvljh2XGCdcUo+rqPQXMoTkeG9BSOs448s727J67e1KuIaP+s/Ty1tKfvQ1tI+ce4dTrmjq4I1G7UD6JU981B8CPNxa8wQ2yJaQWI6quX/rWIOmpbDwLE4pDQ8JjPsxp4/JafH6aYqvCTjOsLPeXhHOcoNXeSN3029VzwTDr7Ay9g2mbTbbr7nFuYodsWLn/mjkNxnRmy5U1kXYow1yBx1PoKzLQ7jndM0BtQSPcKyB3fAngJ+4xO7HlFdbidEHXo3GWsvGmX6slefzqaIVFZ/zkIW21SUXo+NtQCe1hbQWFQvbLE0TQgJiZ1RsHEY06ovqd2RchJglFt6KKgtZL5TLhSBVMMNxgnqZ2OZ/srYP36gSMkgWuqEj43ZdDVmBcnx4jqmQk2TmI1IOK+Fy+3l0KU12vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(8936002)(86362001)(6666004)(16526019)(2906002)(83380400001)(7696005)(186003)(26005)(36756003)(54906003)(6916009)(1076003)(316002)(82310400005)(44832011)(45080400002)(47076005)(36860700001)(426003)(336012)(4326008)(70206006)(8676002)(70586007)(356005)(2616005)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 16:16:14.5663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7721a07-2733-4321-4fab-08da18b1f04e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1636
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79 ++++++++++++++++++++---
 3 files changed, 74 insertions(+), 11 deletions(-)

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
index 3bdcae239bc0..874a273b81f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -46,27 +46,38 @@ static struct list_head topology_device_list;
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
 }
 
+
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
 {
 	struct kfd_topology_device *top_dev = NULL;
@@ -1060,7 +1071,7 @@ int kfd_topology_init(void)
 	down_write(&topology_lock);
 	kfd_topology_update_device_list(&temp_topology_device_list,
 					&topology_device_list);
-	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
+	topology_crat_proximity_domain = sys_props.num_devices-1;
 	ret = kfd_topology_update_sysfs();
 	up_write(&topology_lock);
 
@@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
-	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
-
 	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
 	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
 		struct kfd_topology_device *top_dev;
@@ -1321,12 +1330,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
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
@@ -1335,10 +1348,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		if (res) {
 			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
+			topology_crat_proximity_domain--;
 			goto err;
 		}
 
-		down_write(&topology_lock);
 		kfd_topology_update_device_list(&temp_topology_device_list,
 			&topology_device_list);
 
@@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	return res;
 }
 
+static void kfd_topology_update_io_links(int proximity_domain)
+{
+	struct kfd_topology_device *dev;
+	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
+	/*
+	 * The topology list currently is arranged in increasing
+	 * order of proximity domain.
+	 *
+	 * Two things need to be done when a device is removed:
+	 * 1. All the IO links to this device need to be
+	 *    removed.
+	 * 2. All nodes after the current device node need to move
+	 *    up once this device node is removed from the topology
+	 *    list. As a result, the proximity domain values for
+	 *    all nodes after the node being deleted reduce by 1.
+	 *    This would also cause the proximity domain values for
+	 *    io links to be updated based on new proximity
+	 *    domain values.
+	 */
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

