Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D2C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C5710F461;
	Fri, 21 Aug 2026 19:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fb/5saRb";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C9E10F459
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFBEOJ/U4SpQvKG8jMhY0MoGcAYONiM+ozWxXiGVsLi64WQp+G7zr70mEFgQLQMqS6vASl0H+D34OOt0oVYUn5A3pvVuiljZcoT5qeQ2zYesiCmtDpq4p0Bya+bkQkGEqhuBgEQSZKN6HVhxs73L6h2m+W3mvVk4R6JRUjZulC2KY3454Wej/T3X+dvFbHMC0ozLpitOFlfpM/0K/B7DDDIjnHQ+sq0PfE+NEB4nCaFzNz1lgq5+KsMaVPKrAEZZNAdDc6WZ0gj9nhPGdXr20upE2ksdqWScS6cfp2aZgMccZwGamcHee0M92qmryt3aJYc/0JO+gPVBLTyAkEYG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOQ8F1DpQBk+0X8fVwiOSE8r9G/ZMbyyS14ntvB1AWQ=;
 b=VhdzFOeJH/JRb3FWSMobdgqsmXOCQ4izZR/8b7HpRnj/Dv7qfrPymqlDJGA53tO2sY3rZ32H36ua+2Xw6hToEcoepnGE+PzbUuWPy/Gpc9VtaAG9LonZ8XBYdACCVN1M2ZuVMTJDH7QRDYjCjZwQddVQ7cZ+fbfpgbgk2ypxVVYvnIB+VG1KnNy3hhjKrp7Efh1LqzIc5Oa1NVlZlUDca1H2y2cDydi9Cx5DsaXwA6vei9FsdEXGdHvBO/LU+v8LBvDNWak48U+xfvBl3yVYXD7lRxbwDVNsXZYHe6BRyoE0T4ULgjqReFTrcbA5in5ZvhwI1FwyMxFWg2Zi4yMcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOQ8F1DpQBk+0X8fVwiOSE8r9G/ZMbyyS14ntvB1AWQ=;
 b=fb/5saRbcC4bRbGWfdAukUNZiS0FcALxy2QIBxvVhmLSGq6tAMRRqewveMYRDM0TUPWzV/yiIw4QOULqt5JPUIBjkZLzAZOTSjJJAtMS6F3+Q64xTwZU39TIDkJC+p2w9QODKCeewitrWoWbxJxijAZDqMRRtNeNBL4FEBNJ+8I=
Received: from CH0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:76::31)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:13 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::a6) by CH0PR04CA0026.outlook.office365.com
 (2603:10b6:610:76::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 91/95] drm/amdgpu: Expose ualink info under each xcp
Date: Fri, 21 Aug 2026 15:34:54 -0400
Message-ID: <20260821193458.808626-92-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e57fbf-3f9c-48ba-bf20-08deffbb7503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: zo527osDVbWUw6Ct5leWqBbQNRELhazotMczZB09Vtk1u4gStb+VJ6CXy+uzlOz/aTP2o1kagFTCI8475JiYSi3ABE1bMJzw7UR2fjB9gTr66QSBai8UBh2ERX3UYcridcl3cxM95FFSnr9Cbb+hl6UJ54I1Oc3+AQmYX5HKJW7n4vyWNtG3wVamVqUWJWxBtnph0Ny3heSq+eAA8Zbmi+cFq2araIaG1tjq7NG3/HUdesW+x3E2PedJYkAX4IBtty3Pgl1iy/ApEFoGvo3ma4AdUFyv+s8iOilLE3j/rbof5rlOz/mPsQsLFB6bgUdmn0N093LHq+yODlNmasco5BQteHNrBASaLEk82F/BuJS0y2Vel1ZesYIA491cz3xvRripRT+fYDRJ9CqFiOvoNZY4ysyV/Z6H0lgRrhXtajTEp9FzDKLxDVeVUfP2Hqu3nk8QQCdGuGsrVYxzPv94aWNizoSwm1MVSkUEHU8M1FS7tfozVx4JUWjEkQzmJm82pvNndfQcxU0Y7RD3JrtiDyyD7gebZM4KJSBf0pS8+Gbl7BxgrWTQ1dwr/gs28jVXbQ7ZXFrT473MQcOb09CwCthQ5cCJ524o8HQBExdTgsxATqbb+7FuOtU0hCF4ws0C5XSjiO1bCCoCSnwmSMQ5YTERsyziHS4VY+zxQooqDnoNaZoeNTxDV+kLkLS5pJHRR0rqsU5UaGUZfz3dw+7JDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FGZTAt62h713PVt2MhMKZwhlZ+PgY0/kMnMVgbsPKryXP5gSL5ArA0WNFNLozsw2rD11LrLdZgoTfSmkJImFziytqiwps8iDF+8CZk9jYoNtyKkkhBqeXgdFM26Wd4cEEIQ41iV1qa5EQmPNC+vv0AML9anotJzT6tLeQWFWk0y9e+dPzDvx/FNf7wVgr7QzdRSntnB7l30zHr7m7wjgjc/nGDTUcPmrBYM0M6nyzwnZuFFdgQrosZeBvMIUdaU1sr2SJJcFAGNojhaK/3NZTcVfOdDM2DwvMHmKPOQaw78JzXt+0FiCpb8MO45zA7i9ixch0Sff36iUQK6FAZFtpZ6HPW55SNiEUm7yt61iLQqvSlMsiKHBHOplshX+ZyIqwgPXqEnFDuSaBiwMClrOgciloYa6A4zr1jSRILnyvfPQ2qOllFBJEwNzBwtxadZp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:11.9989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e57fbf-3f9c-48ba-bf20-08deffbb7503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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
index 0baa8c07077d5..765105aea09e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -746,6 +746,37 @@ UALINK_ENUM_SHOW(info, addr_mode, vpod.addr_mode);
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
@@ -776,6 +807,58 @@ static const struct attribute *ualink_info_attrs[] = {
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
@@ -1467,6 +1550,9 @@ static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
 	return r;
 }
 
+static void amdgpu_ualink_xcp_sysfs_init(struct amdgpu_device *adev);
+static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev);
+
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev->ualink.info;
@@ -1496,7 +1582,9 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_config;
 
+	amdgpu_ualink_xcp_sysfs_init(adev);
 	adev->ualink.sysfs_init = true;
+
 	return 0;
 
 err_config:
@@ -1515,6 +1603,7 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 	if (!adev->ualink.sysfs_init)
 		return;
 
+	amdgpu_ualink_xcp_sysfs_fini(adev);
 	kobject_del(&adev->ualink.stations->kobj);
 	kobject_del(&adev->ualink.config->kobj);
 	kobject_del(&adev->ualink.setup->kobj);
@@ -1522,6 +1611,82 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
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
index 2e579d0bbe9e6..63710b484c6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -27,6 +27,8 @@
 
 #include <linux/uuid.h>
 
+struct amdgpu_xcp;
+
 #define AMDGPU_UALINK_ACCEL_MAX 256
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
@@ -398,6 +400,7 @@ int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
 
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

