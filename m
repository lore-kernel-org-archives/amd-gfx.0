Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6928BC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 09:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E492810E9FF;
	Fri, 16 May 2025 09:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0SkOrKk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3446010E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 09:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqCY7lzRjqwIWdesK+eGPyRHSu5aI0X46lZHnz39GZexNqjPFLsjIJR2Rzcp2UHGfLwNMb8FfAin64iBUuVmiIFs9U/yW910GnugFLL5PYwMStGdlJXdLuBFMrzfgUap+OuDFoDcx50CS6Qc8HsGEcAO4KpueKH0jPGWDsYQDDDWkA0ILMlSVJN2joA2GAYXC85w+SW1kst+kyRqZTTvWSa1jNUw8hJYUPUhwOaLWbmV9nMvuprk/W9ehmkF9DjBEq3BoOXAycpd0Ue/6OIZPkhhfpioGmZeDejUs04iJD0qHzhPP8g/zNeRRp/LBE/s3wjrSRA0A0QhcEejWp8tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVMACGQ7scZKjGc9G09VuMK+hvqhz6PXjHBsuR68wow=;
 b=gtm7BgbvwPaEgDPqAxyGI3y7QkAyxu+u+G8bnV8P+DE4XQCwy6XMLt42WNv6kAl/ICEh5562WX3ddlr2oZvUYKoblVtUaivypfSCXZ1BxafMIQbUxR8bjaMSDzMOPh0/QaK0055MBbh6dVgQgeeHr8oKaf+C+IjzxBsvJgYeKpHLszz+jIf4gp9nvVRzTYTa/6BVckoXzWxCOcdxCmTIHlB925eYQS+OEzQiNxO8KUL9C+SYV/53/Li/sO//PR0Dz6wrUuP+st1spGmCtitswljt7+6CH0qpWxuYoMDuDLcObuiuV1HOyWo7BIMCm88cU5QjOLfpmDYCgBZsgPG+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVMACGQ7scZKjGc9G09VuMK+hvqhz6PXjHBsuR68wow=;
 b=Y0SkOrKkJT3IZ2E6WsnDXE7+NLO4ZiXhJQO5uXoEH7UBJpVo0XRPH/qOa4vsD8FB5aJU19YEPG/86PHM8OFdupeh2c+F0VKY87c9gMDReyIafpi/oO8EXusdp0nixaW4OeyCBN98TKaz72huUTuNpIwf9uHTDPrUfoPcMuzOFfI=
Received: from CH0PR03CA0313.namprd03.prod.outlook.com (2603:10b6:610:118::34)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 09:19:13 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::89) by CH0PR03CA0313.outlook.office365.com
 (2603:10b6:610:118::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Fri,
 16 May 2025 09:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 09:19:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 04:19:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add sysfs nodes for partition
Date: Fri, 16 May 2025 14:48:50 +0530
Message-ID: <20250516091852.447786-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516091852.447786-1-lijo.lazar@amd.com>
References: <20250516091852.447786-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: a6063a7d-b81a-48b2-98c3-08dd945ab93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eyc7DSDQKzTUCCacGvuGYwVTKNC+zRWu+clahc9LCfQtxUMubcjNL9LOuOj3?=
 =?us-ascii?Q?aCPZG7LlBv009eGettmX2bZaVPnkwRQQhwcKUf3e9YRKtbJAOkBqE91iZCOK?=
 =?us-ascii?Q?XyC44Ek0BWaqA6dGUjFj44EVa6awVnquadbLQGoFdABDPym63NOzS8MuyHQu?=
 =?us-ascii?Q?FnqaHIBWuIS6VAzdKjwO6WR+rJrXam1CDG3JO3tydheasB1YSp16H/+cKOC2?=
 =?us-ascii?Q?foCEARo+RCOssgNGAf5+pfLYeHTNH9vzwUoiRXuja35ARqKgQKic0QxO/buS?=
 =?us-ascii?Q?50xsbLiqdgXN3p6or0UH5gM0ylbnTVHXS7mIW+Fq3GESeEEStJHlyW/vwEev?=
 =?us-ascii?Q?TfTTc3tdWuGIUNoDbmx7cZRjIeXvOPBY9I8tGesVEhAKx5/4tUvB2orNnI7g?=
 =?us-ascii?Q?OfcNCzMvYobLC/CVnudXiqeGOIhEb24IuG+vbQvFFt0VHlVfFU6eXCLHpDsC?=
 =?us-ascii?Q?f/qOlwlLI6XSr+vpM5uFpkMvnCRx23E0Xi7HkdsevH1rDGAnb9KFvstxYx2q?=
 =?us-ascii?Q?Wmy3QLawusMLnycIQvcrd92b9HtSEB1srpRE1/650FwIhV5yjB3mQOktg/BR?=
 =?us-ascii?Q?vN+O0Kgy6MOFZBNwj5+ExSXpnMqDeuYAtSspjesoOn+1EbP5FfGCWrwoAqin?=
 =?us-ascii?Q?4a5MzLRP9hRbJCsJAg6Fa0ifkIRW3mpR1m7F/xLbIvodck1yy5AIXdZaEbvq?=
 =?us-ascii?Q?gA3xpgDozld7Xb96zQiX4wbFKSlp/IYdLTKVq23DNKm8is8GjrFc3WNLJK/m?=
 =?us-ascii?Q?Yh1XTdbkxd8AU3MM42F6+0oasXAJjEqvaYes92C9m5VL7Uba0TpYRBoecXIz?=
 =?us-ascii?Q?Oc8ZQlGRqXbPMwxcXq1jnQFjsPf246xpPYzKUYExTAALHrFjOG/UfrH0z02Z?=
 =?us-ascii?Q?x76whLy88DWBOdZSwZ6LHkR0xHnGHUdVp+jl+beKIY/IIDmGa30IldN3e8L7?=
 =?us-ascii?Q?Wn1IWI/sSIgrg8BUPEgFmuij5dmMlCIua5zXtlDFe+jXYVKrShN+6c8w7YI1?=
 =?us-ascii?Q?+Y2G/hr74NxhSTC/j773X2RPMRevkNsMwgtLJuWcOXHkc7BNzNSu7Z9eDhoL?=
 =?us-ascii?Q?ZVx/IyqOTwIdDfhMO1FNy7bAqUgfXIEjgw+rlTFkfIy4BUmJB8we6aKeZJiN?=
 =?us-ascii?Q?bF/mSzJakkz3QaTU3ReJduKTqdLzrFeFC14HHXYBnPo6hMdWKZy3VOweqAsl?=
 =?us-ascii?Q?y5WTFIc1PYdbXyIVjdGkcLK2G8bH2YKqEFhvFjUzvq4ZRhZSkLLqJBjGQt/f?=
 =?us-ascii?Q?COwcxzWFwjgkfycFU2kYMYgrGUbOnxupyIXyOJa5tYQbBwWlrQEM56Lxflkg?=
 =?us-ascii?Q?3M0El1hmhRsw8S7YuYPSUmZBb2gyRn8fcjj7imr1XWm7s5bAXfYY6kmG9RB1?=
 =?us-ascii?Q?vIcESlgot2rDs9Ze9FeACzLshFunmflVzKXbpqEpNRWbSsDTwBpC6+GzRhaE?=
 =?us-ascii?Q?3Foh1f9mCXkrPqJy0R5PhMhHZQVFxOC2eOBVnS++FrrpR2X4g/xako9VWyhj?=
 =?us-ascii?Q?xbOSmt8BHCg4RTOlmPrmhG8uZZWeFt4w8e6E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:19:13.1527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6063a7d-b81a-48b2-98c3-08dd945ab93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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

Add sysfs nodes to provide compute paritition specific data.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 144 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |   6 +-
 3 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d47c36c8280..0565229ea4d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4728,7 +4728,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_fru_sysfs_init(adev);
 	amdgpu_reg_state_sysfs_init(adev);
-	amdgpu_xcp_cfg_sysfs_init(adev);
+	amdgpu_xcp_sysfs_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
@@ -4858,7 +4858,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	amdgpu_fru_sysfs_fini(adev);
 
 	amdgpu_reg_state_sysfs_fini(adev);
-	amdgpu_xcp_cfg_sysfs_fini(adev);
+	amdgpu_xcp_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index b03c3895897b..6f52373358f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -27,6 +27,9 @@
 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
+static void amdgpu_xcp_sysfs_entries_init(struct amdgpu_xcp_mgr *xcp_mgr);
+static void amdgpu_xcp_sysfs_entries_update(struct amdgpu_xcp_mgr *xcp_mgr);
+
 static int __amdgpu_xcp_run(struct amdgpu_xcp_mgr *xcp_mgr,
 			    struct amdgpu_xcp_ip *xcp_ip, int xcp_state)
 {
@@ -189,7 +192,7 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 		goto out;
 	}
-
+	amdgpu_xcp_sysfs_entries_update(xcp_mgr);
 out:
 	mutex_unlock(&xcp_mgr->xcp_lock);
 
@@ -263,9 +266,10 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 		if (ret == -ENOSPC) {
 			dev_warn(adev->dev,
 			"Skip xcp node #%d when out of drm node resource.", i);
-			return 0;
+			ret = 0;
+			goto out;
 		} else if (ret) {
-			return ret;
+			goto out;
 		}
 
 		/* Redirect all IOCTLs to the primary device */
@@ -278,9 +282,14 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
 		p_ddev->driver = &amdgpu_partition_driver;
 		adev->xcp_mgr->xcp[i].ddev = p_ddev;
+
+		dev_set_drvdata(p_ddev->dev, &adev->xcp_mgr->xcp[i]);
 	}
+	ret = 0;
+out:
+	amdgpu_xcp_sysfs_entries_init(adev->xcp_mgr);
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
@@ -288,6 +297,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr;
+	int i;
 
 	if (!xcp_funcs || !xcp_funcs->get_ip_details)
 		return -EINVAL;
@@ -306,6 +316,8 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 		amdgpu_xcp_init(xcp_mgr, init_num_xcps, init_mode);
 
 	adev->xcp_mgr = xcp_mgr;
+	for (i = 0; i < MAX_XCP; ++i)
+		xcp_mgr->xcp[i].xcp_mgr = xcp_mgr;
 
 	return amdgpu_xcp_dev_alloc(adev);
 }
@@ -433,6 +445,7 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 	}
 }
 
+/*====================== xcp sysfs - configuration ======================*/
 #define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
 	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
 		struct amdgpu_xcp_res_details *xcp_res, char *buf) \
@@ -635,7 +648,7 @@ static const struct attribute *xcp_attrs[] = {
 	NULL,
 };
 
-void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
+static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_res_details *xcp_res;
 	struct amdgpu_xcp_cfg *xcp_cfg;
@@ -703,7 +716,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 	kobject_put(&xcp_cfg->kobj);
 }
 
-void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
+static void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_res_details *xcp_res;
 	struct amdgpu_xcp_cfg *xcp_cfg;
@@ -722,3 +735,122 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 	kobject_put(&xcp_cfg->kobj);
 }
+
+/*====================== xcp sysfs - data entries ======================*/
+
+#define to_xcp(x) container_of(x, struct amdgpu_xcp, kobj)
+
+static ssize_t xcp_metrics_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct amdgpu_xcp *xcp = to_xcp(kobj);
+	struct amdgpu_xcp_mgr *xcp_mgr;
+	ssize_t size;
+
+	xcp_mgr = xcp->xcp_mgr;
+	size = amdgpu_dpm_get_xcp_metrics(xcp_mgr->adev, xcp->id, NULL);
+	if (size <= 0)
+		return size;
+
+	if (size > PAGE_SIZE)
+		return -ENOSPC;
+
+	return amdgpu_dpm_get_xcp_metrics(xcp_mgr->adev, xcp->id, buf);
+}
+
+static umode_t amdgpu_xcp_attrs_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int n)
+{
+	struct amdgpu_xcp *xcp = to_xcp(kobj);
+
+	if (!xcp || !xcp->valid)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct kobj_attribute xcp_sysfs_metrics = __ATTR_RO(xcp_metrics);
+
+static struct attribute *amdgpu_xcp_attrs[] = {
+	&xcp_sysfs_metrics.attr,
+	NULL,
+};
+
+static const struct attribute_group amdgpu_xcp_attrs_group = {
+	.attrs = amdgpu_xcp_attrs,
+	.is_visible = amdgpu_xcp_attrs_is_visible
+};
+
+static const struct kobj_type xcp_sysfs_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static void amdgpu_xcp_sysfs_entries_fini(struct amdgpu_xcp_mgr *xcp_mgr, int n)
+{
+	struct amdgpu_xcp *xcp;
+
+	for (n--; n >= 0; n--) {
+		xcp = &xcp_mgr->xcp[n];
+		if (!xcp->ddev || !xcp->valid)
+			continue;
+		sysfs_remove_group(&xcp->kobj, &amdgpu_xcp_attrs_group);
+		kobject_put(&xcp->kobj);
+	}
+}
+
+static void amdgpu_xcp_sysfs_entries_init(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_xcp *xcp;
+	int i, r;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		/* Redirect all IOCTLs to the primary device */
+		xcp = &xcp_mgr->xcp[i];
+		if (!xcp->ddev)
+			break;
+		r = kobject_init_and_add(&xcp->kobj, &xcp_sysfs_ktype,
+					 &xcp->ddev->dev->kobj, "xcp");
+		if (r)
+			goto out;
+
+		r = sysfs_create_group(&xcp->kobj, &amdgpu_xcp_attrs_group);
+		if (r)
+			goto out;
+	}
+
+	return;
+out:
+	kobject_put(&xcp->kobj);
+}
+
+static void amdgpu_xcp_sysfs_entries_update(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_xcp *xcp;
+	int i;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		/* Redirect all IOCTLs to the primary device */
+		xcp = &xcp_mgr->xcp[i];
+		if (!xcp->ddev)
+			continue;
+		sysfs_update_group(&xcp->kobj, &amdgpu_xcp_attrs_group);
+	}
+
+	return;
+}
+
+void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!adev->xcp_mgr)
+		return;
+
+	amdgpu_xcp_cfg_sysfs_init(adev);
+
+	return;
+}
+
+void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev)
+{
+	amdgpu_xcp_sysfs_entries_fini(adev->xcp_mgr, MAX_XCP);
+	amdgpu_xcp_cfg_sysfs_fini(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index b63f53242c57..454b33f889fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -108,6 +108,8 @@ struct amdgpu_xcp {
 	struct drm_driver *driver;
 	struct drm_vma_offset_manager *vma_offset_manager;
 	struct amdgpu_sched	gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
+	struct amdgpu_xcp_mgr *xcp_mgr;
+	struct kobject kobj;
 };
 
 struct amdgpu_xcp_mgr {
@@ -175,8 +177,8 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 			      struct amdgpu_ctx_entity *entity);
 
-void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev);
-void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev);
+void amdgpu_xcp_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_xcp_sysfs_fini(struct amdgpu_device *adev);
 
 #define amdgpu_xcp_select_scheds(adev, e, c, d, x, y) \
 	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
-- 
2.25.1

