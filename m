Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35301CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B08110E962;
	Thu,  6 Nov 2025 16:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjncX3gR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DF910E95E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWbEykG+Y3ox2JG9kXUKJANft7uZ4yPCHPd+K6Yj9nAolNhsCyQxEPj6e+AzEyo3UgNdZUvRsoTObMtPvxVdkYUe+CwPZz8YzSFOKOG9i8YAoAJZ6Zbzgic5ulRk37xk4M8y6Mrai2BA9zfapn+zTUqYA+jEwcZu9afXR57lvsXeKhX80l7fbpY8Y6sHsVEbSqtaJDtplzhIwWeLcWm8xlwO6M9IsIJg9v9BcKkjC57mSpZvvSk4f9H1b61dF1Ei5hlH/A85Hgu6Rn42nIsa9QhJqBqkyPpbU0ZHwwwyZAzL4/NuqlFLxRo81DaRMe69igtcJGlHNkutbXoqx9wPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uSYqpGpuS9aV340xqmHd2bA+vZqAJXre0gD9jfZ16s=;
 b=qO+8oy+tfdqaqyeZphNOHCPu0TlV7GqPVEi70MeYBjPasqnoDig4O3VSMR3Bi7oY1dicr1gW09zFeUAUwqjmS0UY2/ZMREDndNTMyOWtbxbbLX7Yk8VQoRJMuiJ6S3Ft3ebV3ca1wKlq0JaOdf5W3HBGXy0riVKPI8DEUpd39JihFHr1VxtHq5VbeD6qx2O3p3UoJMmQH7ZrJGa9WDW0V6rP7j22SXJMyA0eVypk9THiXR7yBjzGbf9xNaU10M/Gm8hCKwctBUg4Hm8ja0OXUsnXCLPjNRkz3htap8/V8e2secyFyL3LR6zGZy3N62RHixy1xrxF64E4FCPUGeRREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uSYqpGpuS9aV340xqmHd2bA+vZqAJXre0gD9jfZ16s=;
 b=mjncX3gROz1NNSQBcTH0yxul0ma0JRDrT8Bd24RtwRvPCKQnXCTTwGv8jsf2Gpp4W657TrTACohOFKc+/rfPaSMSjnjMLm3hntJR3UNnJPwhDd+dWElPUI/79KEWsdY6oRyQMiQN/PUb747WFb1V6IKImQX1nIXFdYq55e6RamE=
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:55:29 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::cf) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 16:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:55:29 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:55:26 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v4 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
Date: Fri, 7 Nov 2025 00:55:07 +0800
Message-ID: <20251106165508.3785924-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106165508.3785924-1-asad.kamal@amd.com>
References: <20251106165508.3785924-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: dc819cbc-1a3d-41cc-a6fc-08de1d554a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XboC10c54zm15478ILPC1SXz9n4W0cssH2vbW8xDTrfngRIbxMxKk36ioxRH?=
 =?us-ascii?Q?lghIk+J7ai/CfmLMd1DKivXuWH4nqGZo0AFzEdfP+neswfmw0EqpQ4A7EOUu?=
 =?us-ascii?Q?4JwMiGsQKEtFE99N7nkTDBgrvp4mVxIYD/g4eCjTWqDvl6LPsJyNlhGlBksH?=
 =?us-ascii?Q?F82p+fVbKMHGjXaAP+vBLspHv+PnoQmEIpP9G5kT6Z/dKbgbXtHNvRkTGOBC?=
 =?us-ascii?Q?fG0CixXVIo9kXl/MKay0FcuBt1Qe+HBIvaAXA/XgCIcF42N33pWFqGviLL7f?=
 =?us-ascii?Q?BQuxQAdg1niDtMJh4ncWC9qChkXGFW1tmOCQrpJAOe+LmqISSrZ02jiwIQtz?=
 =?us-ascii?Q?/T7XoGFUP7KbBQqYYGkfmzr/WA6rBEPAKJgpFNt125ZeTY7sudJqFV3XBsu4?=
 =?us-ascii?Q?92aruKnaSR09FaWsmcpnLWznFu9TWkOyHIH8adiANWb+XIKBMwkEW+F2x/Rc?=
 =?us-ascii?Q?sPWZRp3HPMVlFjaS04GB3OFktbTx5Vjq3loZZuDB2DmIWLCpFYpYOzpP4qM2?=
 =?us-ascii?Q?WzejrNhCnVjCn+eA7g9M6ftRaVVHzc7KQ0f9WSeoQDaLNNZqQi1rZanwzw2w?=
 =?us-ascii?Q?PfGeIe4B3une3uii2K7O5Dh5G5XRzR2MYwpqU+KUU8uEEaqGpXvJ4gbK28Yj?=
 =?us-ascii?Q?PcLWICweUugicPJaWoDqaI64vItIgFUNaODOesuzmKH6z7P6akpnrnOGcFd6?=
 =?us-ascii?Q?azOZ0MImhsl17t3mmKcUCa5EGLMPVp2H33phxADw0kJ58XmXNB/VqXAk3pmg?=
 =?us-ascii?Q?m8HPGincx0i5k6hEPg/vL/93WIgJrSJd77mYSiSedJjuHYafHj/b5KGR33Hf?=
 =?us-ascii?Q?NMDiiGx7fpV9CUX4CFia/EgYdPgeS9gj3uCxNnrBEeBKPafWn5Jt9nS09xOl?=
 =?us-ascii?Q?b+XLux373ViarAFLnnisgmyWFrbmGyv4VbcUdtGHEj7LzBmQlqwC45fXtOUM?=
 =?us-ascii?Q?LDJY869x04gNGMq0XqyYXk35fgL0O68RhThDfTtFHheaLFHV/cbRP+a3bO2x?=
 =?us-ascii?Q?71KKz3hehHza4HjA/xPNlBlYS91FYjVConZvOSEVkrDW2PYAd+mUBB+b+7UD?=
 =?us-ascii?Q?khvBZkscI4NFBVUwsVaBPsyzXg9TYJIf2b2gJ7hOeoJ2JzzivRuxwM+KWoT+?=
 =?us-ascii?Q?sjTVYQcSLqumhakn3PUJvvR65FnRZNnpyWkO9jyhz1HSDavgEB6DlNb3yU91?=
 =?us-ascii?Q?iYvADj+wMyvFO4RTS2dKqaewlwKrLQAClIiKdLPqAXPpfiOpt2WkvNmJNmFY?=
 =?us-ascii?Q?TCNhKEbX/yt8PTAY1JEC+1zIm6MlSltoMgWY1sLuJ9qukabZxLmzKsMYw6d3?=
 =?us-ascii?Q?++mjr5BSIl5CpO7qzP4YMHalyhbUKGSw7ja9f4GzxyJjvfT+c7NsGwlya83f?=
 =?us-ascii?Q?VeWYRILte0+QG3CEvFVO41+aebpoJIOVN7q/u6nu79GXWhWC/IOriNJgOjJu?=
 =?us-ascii?Q?Sgdi/dJieXpAhLBB4GZm5TvOaQ0uM8c2fXxUZt+wVcR+XuqHMG4V+GbBFT3O?=
 =?us-ascii?Q?DpW+oy2MzlviaJMthHD9+Y+krHiFsVBaNiCAyUP6Q1teqywHj9D7IbW2LL4/?=
 =?us-ascii?Q?D/v1VNjEXv23A4NvBBA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:55:29.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc819cbc-1a3d-41cc-a6fc-08de1d554a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

Expose power2_cap hwmon node for retrieving and configuring ppt1
limit on supported boards for gc_v9_5_0

v2: Remove version check (Lijo)

v3: Remove power2_average (Lijo)

v4: Put back power2_average, will be removed separately (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 ++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 69aa8e22f103..fe7a2f09e021 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3373,7 +3373,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
 				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
 				  "fastPPT" : "slowPPT");
 	else
-		return sysfs_emit(buf, "PPT\n");
+		return sysfs_emit(buf, "%s\n",
+				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
+				  "PPT1" : "PPT");
 }
 
 static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
@@ -3826,13 +3828,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* only Vangogh has fast PPT limit and power labels */
-	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
-	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
+	if ((attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_power2_label.dev_attr.attr) &&
+	     (amdgpu_dpm_get_power_limit(adev, &tmp,
+					 PP_PWR_LIMIT_MAX,
+					 PP_PWR_TYPE_FAST) == -EOPNOTSUPP))
 		return 0;
 
 	return effective_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c0e7c45ac0e6..8b49fb86c77b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2938,6 +2938,8 @@ int smu_get_power_limit(void *handle,
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
+		else
+			return -EOPNOTSUPP;
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
-- 
2.46.0

