Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4EEC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC00A10FDB1;
	Fri,  3 Jun 2022 10:53:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7448D10FDB1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 10:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehF+cCFSbl0+/RJR5l5EivZz0QBsA65hDVsabctdtiKWiBemw8nWy01W+t+dGq/N73HVqGKi00tbOiQB2M/7ZhIrZHp7Z9B0cEaclh6A1TdQwhaPfCVmqEBvrnrnAUkl8vueEIKBhMDi0c1rD7827bOm6EzoNIRQj98FIGTrkPz4w0JQ5lw18lt59S1ySCzvUPzFzM+L/7bwWjbxwdyiMGkNPXm9TJUdaVZgtpJXz/mxwjnN4VNx3wkXGRGBDW1v6Yhsjk90DIqJRKBVQ9L4M45ANISjQgLB/1NiSpZQS7gy1l2B95OtauJKWhWuytonxJV5V2x3qQbj5i9+xK/ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8zNATC53hDK9pgtxMAQhoih7bpXXXe4rViS29Jc+mo=;
 b=XpvdK/ZWz9O2taN1s9CYpVc6JPlNXk5DSlMwYshuIYd0rNw1MUuYlg6NdPd1qt7tz1A99/uAu0b22ZCVtKKjUAoN9j+XKSJ5xBuCvnEYws3tcXAviZjB0sXLNNFec6vCRnMlGapNUIZpkowXcuyeh6q3gSNfs9TdkgHAQLuNmV066CwQG0tzFbVyWl5tHtySPE3pbES2SVOs77LmtTm3qLzUxM4u4/GoiGQ5NyrLiT8RMxsjO/EQoYu7zUMoz77X48LIl+upn0e0rqW/qVa1B9ayghWaknntFdigqGGcrB+vA28O2Ik/PvO1AtLDHRTpDKabOrmhdMHTn9mIyoFCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8zNATC53hDK9pgtxMAQhoih7bpXXXe4rViS29Jc+mo=;
 b=RQKMDK1ef9pisd27uvN7+GaQtgrI9+5FYB2tTtOu81aHFL6XtnHy5DcsD/MNMGuESF8XTBok2GjHcPDXo1bGZM5Ja0z3trEm0KcGzfaoUhfcOfZuxl/FTWrxjdVxKayIAnmH97jgTRcktsIIM1hJ6V+vZsx5q3jDYAAmxE9rgJU=
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by BN8PR12MB3298.namprd12.prod.outlook.com (2603:10b6:408:69::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 10:53:03 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::50) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 10:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 10:53:03 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 05:53:01 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Extend KFD device topology to surface
 peer-to-peer links
Date: Fri, 3 Jun 2022 05:52:52 -0500
Message-ID: <20220603105252.3372797-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e227fd9f-f959-4a66-13b7-08da454f3bbd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3298:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3298AD1EDF57FCD0A329339FE3A19@BN8PR12MB3298.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQYeLzthgJGXweyaP9xE4OQoBfSD2SDPFgYpxbspV0yZ3+FKcs3mLnqSRctYwfnB/yrJfxQ0HjSRRKwvBMjW4/QifkjeWxRxGauaeEl3oFboNa4QVctIxmDHwT1SmqAfRCP3KCnxLS82s70hZ/V41SnuQjOPwmtZel4iJPqOUQqPRK8q8qgxoxkFI57kpXAnr+1APxH/JDsRups/MyHC5Tj9IMULfnLufV3iFfOoolauU2R7WqlhpcuKuurGyy7MItdqyfVvb0i4zWsPqDgx6zmcFMBSWfJqCFJT0ZU+C+VLf7zzysGxSTg34RFg39YXnFP+oOjmo7imBnFD8NSjhrUaw3M0TIo29avAoxmw0ekLb2E8eFjKy9LDi2htJTLAA1YH2oMVqPHcOraLbbqJiUJvl3EmG+REc5jgjvcLiuqhca6wlzeJM5UWNApSfkvHuiWwrK8SmvbplwqAJCmFsUNO15veerx55g9Q9SsZb3SN/D6qusVVWqbeHQu5aoJ9ZBmqnUT9KTwe521l9HNZHn6EHz1IVKHsw4509+3Pw/HVELY62bV9UxR0XfTXnHLPz80rXUZ0C/aDT9+duoWT5gBgpam4BoX6HOsI9MhKE1kF78Vzo26UwQPsOZdm78E50zhaaiIjZrZcDROnQ7AXQc8VtMr20c0TpDaBTkfEbXjQqa3EmqdoaFlZ+EeQ4xpX/2967jEUKRX9JC1yj/7tlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(47076005)(30864003)(81166007)(2616005)(36860700001)(356005)(8936002)(5660300002)(26005)(186003)(83380400001)(426003)(40460700003)(16526019)(1076003)(336012)(2906002)(6666004)(316002)(86362001)(7696005)(36756003)(70586007)(70206006)(4326008)(8676002)(82310400005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 10:53:03.1451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e227fd9f-f959-4a66-13b7-08da454f3bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3298
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend KFD device topology to surface peer-to-peer links among
GPU devices connected over PCIe or xGMI. Enabling HSA_AMD_P2P is
REQUIRED to surface peer-to-peer links.

Prior to this KFD did not expose to user mode any P2P links or
indirect links that go over two or more direct hops. Old versions
of the Thunk used to make up their own P2P and indirect links without
the information about peer-accessibility and chipset support available
to the kernel mode driver. In this patch we expose P2P links in a new
sysfs directory to provide more reliable P2P link information to user
mode.

Old versions of the Thunk will continue to work as before and ignore
the new directory. This avoids conflicts between P2P links exposed by
KFD and P2P links created by the Thunk itself. New versions of the Thunk
will use only the P2P links provided in the new p2p_links directory, if
it exists, or fall back to the old code path on older KFDs that don't
expose p2p_links.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 319 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   3 +
 2 files changed, 320 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8d50d207cf66..be4dce85e7c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -40,6 +40,7 @@
 #include "kfd_svm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_ras.h"
+#include "amdgpu.h"
 
 /* topology_device_list - Master list of all topology devices */
 static struct list_head topology_device_list;
@@ -148,6 +149,7 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
 	struct kfd_mem_properties *mem;
 	struct kfd_cache_properties *cache;
 	struct kfd_iolink_properties *iolink;
+	struct kfd_iolink_properties *p2plink;
 	struct kfd_perf_properties *perf;
 
 	list_del(&dev->list);
@@ -173,6 +175,13 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
 		kfree(iolink);
 	}
 
+	while (dev->p2p_link_props.next != &dev->p2p_link_props) {
+		p2plink = container_of(dev->p2p_link_props.next,
+				struct kfd_iolink_properties, list);
+		list_del(&p2plink->list);
+		kfree(p2plink);
+	}
+
 	while (dev->perf_props.next != &dev->perf_props) {
 		perf = container_of(dev->perf_props.next,
 				struct kfd_perf_properties, list);
@@ -214,6 +223,7 @@ struct kfd_topology_device *kfd_create_topology_device(
 	INIT_LIST_HEAD(&dev->mem_props);
 	INIT_LIST_HEAD(&dev->cache_props);
 	INIT_LIST_HEAD(&dev->io_link_props);
+	INIT_LIST_HEAD(&dev->p2p_link_props);
 	INIT_LIST_HEAD(&dev->perf_props);
 
 	list_add_tail(&dev->list, device_list);
@@ -465,6 +475,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.caches_count);
 	sysfs_show_32bit_prop(buffer, offs, "io_links_count",
 			      dev->node_props.io_links_count);
+	sysfs_show_32bit_prop(buffer, offs, "p2p_links_count",
+			      dev->node_props.p2p_links_count);
 	sysfs_show_32bit_prop(buffer, offs, "cpu_core_id_base",
 			      dev->node_props.cpu_core_id_base);
 	sysfs_show_32bit_prop(buffer, offs, "simd_id_base",
@@ -568,6 +580,7 @@ static void kfd_remove_sysfs_file(struct kobject *kobj, struct attribute *attr)
 
 static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 {
+	struct kfd_iolink_properties *p2plink;
 	struct kfd_iolink_properties *iolink;
 	struct kfd_cache_properties *cache;
 	struct kfd_mem_properties *mem;
@@ -585,6 +598,18 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 		dev->kobj_iolink = NULL;
 	}
 
+	if (dev->kobj_p2plink) {
+		list_for_each_entry(p2plink, &dev->p2p_link_props, list)
+			if (p2plink->kobj) {
+				kfd_remove_sysfs_file(p2plink->kobj,
+							&p2plink->attr);
+				p2plink->kobj = NULL;
+			}
+		kobject_del(dev->kobj_p2plink);
+		kobject_put(dev->kobj_p2plink);
+		dev->kobj_p2plink = NULL;
+	}
+
 	if (dev->kobj_cache) {
 		list_for_each_entry(cache, &dev->cache_props, list)
 			if (cache->kobj) {
@@ -631,6 +656,7 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 		uint32_t id)
 {
+	struct kfd_iolink_properties *p2plink;
 	struct kfd_iolink_properties *iolink;
 	struct kfd_cache_properties *cache;
 	struct kfd_mem_properties *mem;
@@ -668,6 +694,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 	if (!dev->kobj_iolink)
 		return -ENOMEM;
 
+	dev->kobj_p2plink = kobject_create_and_add("p2p_links", dev->kobj_node);
+	if (!dev->kobj_p2plink)
+		return -ENOMEM;
+
 	dev->kobj_perf = kobject_create_and_add("perf", dev->kobj_node);
 	if (!dev->kobj_perf)
 		return -ENOMEM;
@@ -757,6 +787,27 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 		i++;
 	}
 
+	i = 0;
+	list_for_each_entry(p2plink, &dev->p2p_link_props, list) {
+		p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+		if (!p2plink->kobj)
+			return -ENOMEM;
+		ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
+				dev->kobj_p2plink, "%d", i);
+		if (ret < 0) {
+			kobject_put(p2plink->kobj);
+			return ret;
+		}
+
+		p2plink->attr.name = "properties";
+		p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&iolink->attr);
+		ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+
 	/* All hardware blocks have the same number of attributes. */
 	num_attrs = ARRAY_SIZE(perf_attr_iommu);
 	list_for_each_entry(perf, &dev->perf_props, list) {
@@ -1145,6 +1196,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 	struct kfd_mem_properties *mem;
 	struct kfd_cache_properties *cache;
 	struct kfd_iolink_properties *iolink;
+	struct kfd_iolink_properties *p2plink;
 
 	down_write(&topology_lock);
 	list_for_each_entry(dev, &topology_device_list, list) {
@@ -1165,6 +1217,8 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 				cache->gpu = dev->gpu;
 			list_for_each_entry(iolink, &dev->io_link_props, list)
 				iolink->gpu = dev->gpu;
+			list_for_each_entry(p2plink, &dev->p2p_link_props, list)
+				p2plink->gpu = dev->gpu;
 			break;
 		}
 	}
@@ -1287,6 +1341,250 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
 		}
 	}
+
+	/* Create indirect links so apply flags setting to all */
+	list_for_each_entry(link, &dev->p2p_link_props, list) {
+		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
+		kfd_set_iolink_no_atomics(dev, NULL, link);
+		peer_dev = kfd_topology_device_by_proximity_domain(
+				link->node_to);
+
+		if (!peer_dev)
+			continue;
+
+		list_for_each_entry(inbound_link, &peer_dev->p2p_link_props,
+									list) {
+			if (inbound_link->node_to != link->node_from)
+				continue;
+
+			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
+			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
+			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
+		}
+	}
+}
+
+static int kfd_build_p2p_node_entry(struct kfd_topology_device *dev,
+				struct kfd_iolink_properties *p2plink)
+{
+	int ret;
+
+	p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!p2plink->kobj)
+		return -ENOMEM;
+
+	ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
+			dev->kobj_p2plink, "%d", dev->node_props.p2p_links_count - 1);
+	if (ret < 0) {
+		kobject_put(p2plink->kobj);
+		return ret;
+	}
+
+	p2plink->attr.name = "properties";
+	p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
+	sysfs_attr_init(&p2plink->attr);
+	ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int kfd_create_in_direct_link_prop(struct kfd_topology_device *kdev, int gpu_node)
+{
+	struct kfd_iolink_properties *props = NULL, *props2 = NULL;
+	struct kfd_iolink_properties *gpu_link, *cpu_link;
+	struct kfd_topology_device *cpu_dev;
+	int ret = 0;
+	int i, num_cpu;
+
+	num_cpu = 0;
+	list_for_each_entry(cpu_dev, &topology_device_list, list) {
+		if (cpu_dev->gpu)
+			break;
+		num_cpu++;
+	}
+
+	gpu_link = list_first_entry(&kdev->io_link_props,
+					struct kfd_iolink_properties, list);
+	if (!gpu_link)
+		return -ENOMEM;
+
+	for (i = 0; i < num_cpu; i++) {
+		/* CPU <--> GPU */
+		if (gpu_link->node_to == i)
+			continue;
+
+		/* find CPU <-->  CPU links */
+		cpu_dev = kfd_topology_device_by_proximity_domain(i);
+		if (cpu_dev) {
+			list_for_each_entry(cpu_link,
+					&cpu_dev->io_link_props, list) {
+				if (cpu_link->node_to == gpu_link->node_to)
+					break;
+			}
+		}
+
+		if (cpu_link->node_to != gpu_link->node_to)
+			return -ENOMEM;
+
+		/* CPU <--> CPU <--> GPU, GPU node*/
+		props = kfd_alloc_struct(props);
+		if (!props)
+			return -ENOMEM;
+
+		memcpy(props, gpu_link, sizeof(struct kfd_iolink_properties));
+		props->weight = gpu_link->weight + cpu_link->weight;
+		props->min_latency = gpu_link->min_latency + cpu_link->min_latency;
+		props->max_latency = gpu_link->max_latency + cpu_link->max_latency;
+		props->min_bandwidth = min(gpu_link->min_bandwidth, cpu_link->min_bandwidth);
+		props->max_bandwidth = min(gpu_link->max_bandwidth, cpu_link->max_bandwidth);
+
+		props->node_from = gpu_node;
+		props->node_to = i;
+		kdev->node_props.p2p_links_count++;
+		list_add_tail(&props->list, &kdev->p2p_link_props);
+		ret = kfd_build_p2p_node_entry(kdev, props);
+		if (ret < 0)
+			return ret;
+
+		/* for small Bar, no CPU --> GPU in-direct links */
+		if (kfd_dev_is_large_bar(kdev->gpu)) {
+			/* CPU <--> CPU <--> GPU, CPU node*/
+			props2 = kfd_alloc_struct(props2);
+			if (!props2)
+				return -ENOMEM;
+
+			memcpy(props2, props, sizeof(struct kfd_iolink_properties));
+			props2->node_from = i;
+			props2->node_to = gpu_node;
+			props2->kobj = NULL;
+			cpu_dev->node_props.p2p_links_count++;
+			list_add_tail(&props2->list, &cpu_dev->p2p_link_props);
+			ret = kfd_build_p2p_node_entry(cpu_dev, props2);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
+#if defined(CONFIG_HSA_AMD_P2P)
+static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
+		struct kfd_topology_device *peer, int from, int to)
+{
+	struct kfd_iolink_properties *props = NULL;
+	struct kfd_iolink_properties *iolink1, *iolink2, *iolink3;
+	struct kfd_topology_device *cpu_dev;
+	int ret = 0;
+
+	if (!amdgpu_device_is_peer_accessible(
+				kdev->gpu->adev,
+				peer->gpu->adev))
+		return ret;
+
+	iolink1 = list_first_entry(&kdev->io_link_props,
+							struct kfd_iolink_properties, list);
+	if (!iolink1)
+		return -ENOMEM;
+
+	iolink2 = list_first_entry(&peer->io_link_props,
+							struct kfd_iolink_properties, list);
+	if (!iolink2)
+		return -ENOMEM;
+
+	props = kfd_alloc_struct(props);
+	if (!props)
+		return -ENOMEM;
+
+	memcpy(props, iolink1, sizeof(struct kfd_iolink_properties));
+
+	props->weight = iolink1->weight + iolink2->weight;
+	props->min_latency = iolink1->min_latency + iolink2->min_latency;
+	props->max_latency = iolink1->max_latency + iolink2->max_latency;
+	props->min_bandwidth = min(iolink1->min_bandwidth, iolink2->min_bandwidth);
+	props->max_bandwidth = min(iolink2->max_bandwidth, iolink2->max_bandwidth);
+
+	if (iolink1->node_to != iolink2->node_to) {
+		/* CPU->CPU  link*/
+		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
+		if (cpu_dev) {
+			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
+				if (iolink3->node_to == iolink2->node_to)
+					break;
+
+			props->weight += iolink3->weight;
+			props->min_latency += iolink3->min_latency;
+			props->max_latency += iolink3->max_latency;
+			props->min_bandwidth = min(props->min_bandwidth,
+							iolink3->min_bandwidth);
+			props->max_bandwidth = min(props->max_bandwidth,
+							iolink3->max_bandwidth);
+		} else {
+			WARN(1, "CPU node not found");
+		}
+	}
+
+	props->node_from = from;
+	props->node_to = to;
+	peer->node_props.p2p_links_count++;
+	list_add_tail(&props->list, &peer->p2p_link_props);
+	ret = kfd_build_p2p_node_entry(peer, props);
+
+	return ret;
+}
+#endif
+
+static int kfd_dev_create_p2p_links(void)
+{
+	struct kfd_topology_device *dev;
+	struct kfd_topology_device *new_dev;
+	uint32_t i, k;
+	int ret = 0;
+
+	k = 0;
+	list_for_each_entry(dev, &topology_device_list, list)
+		k++;
+	if (k < 2)
+		return 0;
+
+	new_dev = list_last_entry(&topology_device_list, struct kfd_topology_device, list);
+	if (WARN_ON(!new_dev->gpu))
+		return 0;
+
+	k--;
+	i = 0;
+
+	/* create in-direct links */
+	ret = kfd_create_in_direct_link_prop(new_dev, k);
+	if (ret < 0)
+		goto out;
+
+	/* create p2p links */
+#if defined(CONFIG_HSA_AMD_P2P)
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev == new_dev)
+			break;
+		if (!dev->gpu || !dev->gpu->adev ||
+		    (dev->gpu->hive_id &&
+		     dev->gpu->hive_id == new_dev->gpu->hive_id))
+			goto next;
+
+		/* check if node(s) is/are peer accessible in one direction or bi-direction */
+		ret = kfd_add_peer_prop(new_dev, dev, i, k);
+		if (ret < 0)
+			goto out;
+
+		ret = kfd_add_peer_prop(dev, new_dev, k, i);
+		if (ret < 0)
+			goto out;
+next:
+		i++;
+	}
+#endif
+
+out:
+	return ret;
 }
 
 int kfd_topology_add_device(struct kfd_dev *gpu)
@@ -1305,7 +1603,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	INIT_LIST_HEAD(&temp_topology_device_list);
 
 	gpu_id = kfd_generate_gpu_id(gpu);
-
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
 	/* Check to see if this gpu device exists in the topology_device_list.
@@ -1362,6 +1659,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->gpu_id = gpu_id;
 	gpu->id = gpu_id;
 
+	kfd_dev_create_p2p_links();
+
 	/* TODO: Move the following lines to function
 	 *	kfd_add_non_crat_information
 	 */
@@ -1507,7 +1806,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 static void kfd_topology_update_io_links(int proximity_domain)
 {
 	struct kfd_topology_device *dev;
-	struct kfd_iolink_properties *iolink, *tmp;
+	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
 
 	list_for_each_entry(dev, &topology_device_list, list) {
 		if (dev->proximity_domain > proximity_domain)
@@ -1529,6 +1828,22 @@ static void kfd_topology_update_io_links(int proximity_domain)
 					iolink->node_to--;
 			}
 		}
+
+		list_for_each_entry_safe(p2plink, tmp, &dev->p2p_link_props, list) {
+			/*
+			 * If there is a p2p link to the dev being deleted
+			 * then remove that p2p link also.
+			 */
+			if (p2plink->node_to == proximity_domain) {
+				list_del(&p2plink->list);
+				dev->node_props.p2p_links_count--;
+			} else {
+				if (p2plink->node_from > proximity_domain)
+					p2plink->node_from--;
+				if (p2plink->node_to > proximity_domain)
+					p2plink->node_to--;
+			}
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 4f80d2ea1000..2fb5664e1041 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -38,6 +38,7 @@ struct kfd_node_properties {
 	uint32_t mem_banks_count;
 	uint32_t caches_count;
 	uint32_t io_links_count;
+	uint32_t p2p_links_count;
 	uint32_t cpu_core_id_base;
 	uint32_t simd_id_base;
 	uint32_t capability;
@@ -131,12 +132,14 @@ struct kfd_topology_device {
 	struct list_head		cache_props;
 	uint32_t			io_link_count;
 	struct list_head		io_link_props;
+	struct list_head		p2p_link_props;
 	struct list_head		perf_props;
 	struct kfd_dev			*gpu;
 	struct kobject			*kobj_node;
 	struct kobject			*kobj_mem;
 	struct kobject			*kobj_cache;
 	struct kobject			*kobj_iolink;
+	struct kobject			*kobj_p2plink;
 	struct kobject			*kobj_perf;
 	struct attribute		attr_gpuid;
 	struct attribute		attr_name;
-- 
2.35.1

