Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43A1C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5198810EA74;
	Mon, 31 Aug 2026 18:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dnxn69e3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5B610EA7A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkvyOPrGWcJybtpfSXkQrllFBkX3yVp/ovjOe0bcj6ipqw3VWzNNeeyh1QWE9oi8WS7iqsE4m0V86ftKvW8h3E40UPPpO/IZJm4i5cwHQOC5VHEsD+Blc9y0ReqG1r0kufdkyzbgMcgLWwRhEYA1P2zLCDNiYJkKM2Bllv4wA3sX2FAv6rVRf/Rqt3Ii7QCx3cT1Sl2lL/4XhUumxC+YJsdnUvlyeoyeP6WA4VZ4m5NaLb1x3m/GRUcofdTUY4uR93XmFf56SB8NPceUrZnIJJfT8AokMn492L4grelBbDWFnmO2UtSFWbh/K9J9US9862+0UzBPHd9+WXsCIaTkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDZlD/xHLJVdu5agGl+KEHu4o7Klwtc6KJGMMTx8TBA=;
 b=fAby7zgz4D+x0wEZDx+naABG3rp9ZydHzJ3XZhkrUHwCa8qBDuiwbu1WosUbxVLlGSBgaBupgGB/S0LRohW4KygKyOD1o0gcFl4AKk43nPiGs664Zeqy+U5YP+8ltUojd5OXKeJ0q2JhE1VpfoxbGyTZPvG+OaFUgdZMD5eAfU5a9+g9u2h7BTCj130RIsgTOpcncZe9uFHBph4ccVimiJkMJ0f/PcTiy9nspqwyS61xhlh2J2FsZNjonPQ7kVbdq1N+rPXFu4eMPktWQG6pBLUjMy+qvOXVZsORLQk3pQUBumlHEurdPp8jdgTHbiR7UW2t9ClUnLh+fh2cCb5GhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDZlD/xHLJVdu5agGl+KEHu4o7Klwtc6KJGMMTx8TBA=;
 b=Dnxn69e3HlDZbBZ1f+fzNcJL7rhzbJjXRusAY459Twx8lrnqm9pjFCmYOQqrJsyQO5HqObNAyM7UOXhJVgNDAOxDtqb4Z9NghXVWrPA9UDXtcN3uC30He7rOYPDPQap2lpVxDEFQJ8GXLrCRvh1zQ/Acnj2ITPEaxIFMMB7xs8E=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:42 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::27) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 18:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 91/95] drm/amdgpu: Expose ualink info under each xcp
Date: Mon, 31 Aug 2026 14:27:50 -0400
Message-ID: <20260831182754.1089811-92-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: a8729658-ade7-4eaa-f35b-08df078dd352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AwURzXdeYsxL+2tWsNIYOzEuaE0pEMY5CkNQb/7WyvLLeM8iL7an8Z4w2riS+dcSRUj2PWbg2TGabd97QKjJjUBRMQ1GO/tOB7Ck5DKssXeIhGrvds+uH2MtYOqHd0LFUKELWLVu35AaHNuECRXxlGZaltCU3xkZlKxvzf2iXlK0VmqH0XKmsfV6NgzoSY7GsD1FIwUH0/PC7F4kCh8VrbxpJatbegpPagMgCO9NXbvYh2Sf+LgKdpZV8ewAYJD1lxtyE8PIbmzrxarArF32OBQQca4+i5ZJ1McYWFSKObxBHQvXxNnDKX3j/qkQlhTaztAREGbGjHXL9zNSE+MTf8Jyo9InqCGjew6/oTNUIENiz5lM+Pfv2KadpgfFeSVjIIM4euUYjMPiUazMBe9XJiNreLXMAqUJgUR9OX0JzjYtGvdPoL4iXBq3Q8y/8kuRxW0YzIsKDpqeVSVr6MMTiueKi/tBo6bAD+d27IUC8fD7e3vQ/REG/Sxh6OeJSCQdsFOviPmXslT9gkFvF481ariF/G4KykBi7a10v7q3d8F00AScTja8v/uSTOLv8TRidErXIdBAdMkLwhbG9p3MkmZd6uxeeS7VepXX0kYjsHvfNdS12lqMclfkqA2g3BQAJAorNhc17z8eyimgHrtgM3O1+fy48Sm3ryiiw8wVCOSPLIAn+fFuqfMOMFBr8vtcn9FGAkPtFPkQcNJL6VxFSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NfVOPUl9sFPrzej0yPdfKELdl4Vk7OtfaxGO2qJOBA2Ua/m5dznJQ6JCeZWvjJMfKcdxOWg1iL6W5oeilx7euJ9/TtCqvzs+Z8D1aRBjjr6GHn6TDGENht3/LZDEBSFI1KwyGCBThfo++7SOKRTNBDXBBPdyXFrQMit6E6B2TFXZfAs7wZf4TgRGvbKmgbUNQMJ8j7XuwuCse95Vq/q96awYW2C/4UvRqIVER+5VeEMVFur4kMGI5cUkRDwiVGsI4+aTq5F82n6Rb0W0IPR3fxWwKKwbQf/sFjb9+exjBHzmhUY3QQZslWFeUNDnGlQYORgOe4b7PDlBlakHetSmW/v4SJs+hNiA7FFA1k3YSLYKpmIJzEmm4dGixMyN0YuJk0lPik4BXSG7CzIbuzXQRAy1wz+INY7cWAPE6f0lSIh3GksMsURIMd1xDrE1iPgS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:42.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8729658-ade7-4eaa-f35b-08df078dd352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

From: Lijo Lazar <lijo.lazar@amd.com>

Mirror the read-only ualink info attributes on each secondary compute
partition as a per-partition ualink node, so a partition-scoped consumer
(e.g. a container that only sees its partition's device node) can read
the ualink identity and state. Partition 0 shares the primary device,
which already exposes that node, so it is skipped. An inactive partition
device won't be having any attributes listed under ualink node.

The per-partition attributes are served by thin wrappers that delegate
to the existing device-level info show functions. A reference on the
info kobject is held for the node's lifetime so it cannot be freed
while a partition still uses it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude (claude-opus-4.7)
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 165 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |   7 +
 4 files changed, 181 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 19c2df55581b3..a5dc6a13970f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -768,6 +768,37 @@ UALINK_ENUM_SHOW(info, addr_mode, vpod.addr_mode);
 UALINK_ENUM_SHOW(info, accel_state, accel_state);
 UALINK_IDARRAY_SHOW(info, local_accels, local_accels, n_local_accels);
 
+static struct amdgpu_device *ualink_xcp_kobj_to_adev(struct kobject *kobj)
+{
+	struct amdgpu_xcp *xcp = container_of(kobj, struct amdgpu_xcp,
+					      ualink.kobj);
+
+	return xcp->xcp_mgr->adev;
+}
+
+#define UALINK_XCP_INFO_SHOW(name)					\
+static ssize_t ualink_xcp_info_##name##_show(struct kobject *kobj,	\
+		struct kobj_attribute *attr, char *buf)			\
+{									\
+	struct amdgpu_device *adev = ualink_xcp_kobj_to_adev(kobj);	\
+									\
+	return ualink_info_##name##_show(&adev->ualink.info->kobj,	\
+					 attr, buf);			\
+}
+
+UALINK_XCP_INFO_SHOW(link_type)
+UALINK_XCP_INFO_SHOW(accel_id)
+UALINK_XCP_INFO_SHOW(bandwidth)
+UALINK_XCP_INFO_SHOW(latency)
+UALINK_XCP_INFO_SHOW(ppod_id)
+UALINK_XCP_INFO_SHOW(ppod_size)
+UALINK_XCP_INFO_SHOW(vpod_id)
+UALINK_XCP_INFO_SHOW(vpod_size)
+UALINK_XCP_INFO_SHOW(vpod_active_accels)
+UALINK_XCP_INFO_SHOW(addr_mode)
+UALINK_XCP_INFO_SHOW(accel_state)
+UALINK_XCP_INFO_SHOW(local_accels)
+
 #define UALINK_INFO_ATTR(name) __ATTR(name, 0444, ualink_info_##name##_show, NULL)
 static struct kobj_attribute ualink_info_link_type = UALINK_INFO_ATTR(link_type);
 static struct kobj_attribute ualink_info_accel_id  = UALINK_INFO_ATTR(accel_id);
@@ -798,6 +829,58 @@ static const struct attribute *ualink_info_attrs[] = {
 	NULL
 };
 
+#define UALINK_XCP_INFO_ATTR(name) \
+	__ATTR(name, 0444, ualink_xcp_info_##name##_show, NULL)
+static struct kobj_attribute ualink_xcp_info_link_type = UALINK_XCP_INFO_ATTR(link_type);
+static struct kobj_attribute ualink_xcp_info_accel_id  = UALINK_XCP_INFO_ATTR(accel_id);
+static struct kobj_attribute ualink_xcp_info_bandwidth = UALINK_XCP_INFO_ATTR(bandwidth);
+static struct kobj_attribute ualink_xcp_info_latency   = UALINK_XCP_INFO_ATTR(latency);
+static struct kobj_attribute ualink_xcp_info_ppod_id   = UALINK_XCP_INFO_ATTR(ppod_id);
+static struct kobj_attribute ualink_xcp_info_ppod_size = UALINK_XCP_INFO_ATTR(ppod_size);
+static struct kobj_attribute ualink_xcp_info_vpod_id   = UALINK_XCP_INFO_ATTR(vpod_id);
+static struct kobj_attribute ualink_xcp_info_vpod_size = UALINK_XCP_INFO_ATTR(vpod_size);
+static struct kobj_attribute ualink_xcp_info_vpod_active_accels = UALINK_XCP_INFO_ATTR(vpod_active_accels);
+static struct kobj_attribute ualink_xcp_info_addr_mode = UALINK_XCP_INFO_ATTR(addr_mode);
+static struct kobj_attribute ualink_xcp_info_accel_state = UALINK_XCP_INFO_ATTR(accel_state);
+static struct kobj_attribute ualink_xcp_info_local_accels = UALINK_XCP_INFO_ATTR(local_accels);
+
+static struct attribute *ualink_xcp_info_attrs[] = {
+	&ualink_xcp_info_link_type.attr,
+	&ualink_xcp_info_accel_id.attr,
+	&ualink_xcp_info_bandwidth.attr,
+	&ualink_xcp_info_latency.attr,
+	&ualink_xcp_info_ppod_id.attr,
+	&ualink_xcp_info_ppod_size.attr,
+	&ualink_xcp_info_vpod_id.attr,
+	&ualink_xcp_info_vpod_size.attr,
+	&ualink_xcp_info_vpod_active_accels.attr,
+	&ualink_xcp_info_addr_mode.attr,
+	&ualink_xcp_info_accel_state.attr,
+	&ualink_xcp_info_local_accels.attr,
+	NULL
+};
+
+static umode_t ualink_xcp_info_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	struct amdgpu_xcp *xcp = container_of(kobj, struct amdgpu_xcp,
+					      ualink.kobj);
+
+	if (!xcp->valid)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group ualink_xcp_info_group = {
+	.attrs = ualink_xcp_info_attrs,
+	.is_visible = ualink_xcp_info_is_visible,
+};
+
+static const struct kobj_type ualink_xcp_info_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops
+};
+
 static void ualink_info_release(struct kobject *kobj)
 {
 	kfree(to_ualink_info(kobj));
@@ -1495,6 +1578,9 @@ static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
 	return r;
 }
 
+static void amdgpu_ualink_xcp_sysfs_init(struct amdgpu_device *adev);
+static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev->ualink.info;
@@ -1541,7 +1627,9 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 		goto err_config;
 #endif
 
+	amdgpu_ualink_xcp_sysfs_init(adev);
 	adev->ualink.sysfs_init = true;
+
 	return 0;
 
 err_config:
@@ -1560,6 +1648,7 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 	if (!adev->ualink.sysfs_init)
 		return;
 
+	amdgpu_ualink_xcp_sysfs_fini(adev);
 	kobject_del(&adev->ualink.stations->kobj);
 	kobject_del(&adev->ualink.config->kobj);
 	kobject_del(&adev->ualink.setup->kobj);
@@ -1567,6 +1656,82 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 	adev->ualink.sysfs_init = false;
 }
 
+static int amdgpu_ualink_xcp_sysfs_add(struct amdgpu_xcp *xcp)
+{
+	struct amdgpu_device *adev = xcp->xcp_mgr->adev;
+	int r;
+
+	r = kobject_init_and_add(&xcp->ualink.kobj, &ualink_xcp_info_ktype,
+				 &xcp->ddev->dev->kobj, "ualink");
+	if (r)
+		goto err;
+
+	r = sysfs_create_group(&xcp->ualink.kobj, &ualink_xcp_info_group);
+	if (r)
+		goto err;
+
+	/* pin info so it outlives this node regardless of teardown order */
+	kobject_get(&adev->ualink.info->kobj);
+	xcp->ualink.sysfs = true;
+	return 0;
+err:
+	kobject_put(&xcp->ualink.kobj);
+	return r;
+}
+
+void amdgpu_ualink_xcp_sysfs_update(struct amdgpu_xcp *xcp)
+{
+	if (!xcp->ualink.sysfs)
+		return;
+
+	sysfs_update_group(&xcp->ualink.kobj, &ualink_xcp_info_group);
+}
+
+static void amdgpu_ualink_xcp_sysfs_remove(struct amdgpu_xcp *xcp)
+{
+	struct amdgpu_device *adev = xcp->xcp_mgr->adev;
+
+	if (!xcp->ualink.sysfs)
+		return;
+
+	/* group is only populated for valid partitions */
+	if (xcp->valid)
+		sysfs_remove_group(&xcp->ualink.kobj, &ualink_xcp_info_group);
+	kobject_put(&adev->ualink.info->kobj);
+	kobject_put(&xcp->ualink.kobj);
+	xcp->ualink.sysfs = false;
+}
+
+static void amdgpu_ualink_xcp_sysfs_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_xcp *xcp;
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		xcp = &adev->xcp_mgr->xcp[i];
+		if (!xcp->ddev || amdgpu_xcp_is_primary(xcp))
+			continue;
+		amdgpu_ualink_xcp_sysfs_add(xcp);
+	}
+}
+
+static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_xcp *xcp;
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		xcp = &adev->xcp_mgr->xcp[i];
+		amdgpu_ualink_xcp_sysfs_remove(xcp);
+	}
+}
+
 static int amdgpu_ualink_npa_alloc_va(struct amdgpu_device *adev,
 			       struct drm_mm_node *mm_node,
 			       u64 va, u64 range_start,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 8ec0bc80a0f7d..1bd7181147dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,6 +31,8 @@
 
 struct amdgpu_device;
 
+struct amdgpu_xcp;
+
 #define AMDGPU_UALINK_ACCEL_MAX 256
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
@@ -402,6 +404,7 @@ int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
+void amdgpu_ualink_xcp_sysfs_update(struct amdgpu_xcp *xcp);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 18f4455ef0a8f..a8c79a66df1d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -1061,6 +1061,11 @@ static const struct kobj_type xcp_sysfs_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+bool amdgpu_xcp_is_primary(struct amdgpu_xcp *xcp)
+{
+	return xcp->ddev == adev_to_drm(xcp->xcp_mgr->adev);
+}
+
 static void amdgpu_xcp_sysfs_entries_fini(struct amdgpu_xcp_mgr *xcp_mgr, int n)
 {
 	struct amdgpu_xcp *xcp;
@@ -1110,6 +1115,7 @@ static void amdgpu_xcp_sysfs_entries_update(struct amdgpu_xcp_mgr *xcp_mgr)
 		if (!xcp->ddev)
 			continue;
 		sysfs_update_group(&xcp->kobj, &amdgpu_xcp_attrs_group);
+		amdgpu_ualink_xcp_sysfs_update(xcp);
 	}
 
 	return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 878c1c422893c..33157409eda0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -100,6 +100,11 @@ struct amdgpu_xcp_ip {
 	bool valid;
 };
 
+struct amdgpu_xcp_ualink {
+	struct kobject kobj;
+	bool sysfs;
+};
+
 struct amdgpu_xcp {
 	struct amdgpu_xcp_ip ip[AMDGPU_XCP_MAX_BLOCKS];
 
@@ -115,6 +120,7 @@ struct amdgpu_xcp {
 	struct amdgpu_sched	gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
 	struct amdgpu_xcp_mgr *xcp_mgr;
 	struct kobject kobj;
+	struct amdgpu_xcp_ualink ualink;
 	uint64_t unique_id;
 };
 
@@ -191,6 +197,7 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
+bool amdgpu_xcp_is_primary(struct amdgpu_xcp *xcp);
 
 static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
 {
-- 
2.55.0

