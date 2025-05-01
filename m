Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63828C3ABAA
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B15910E0ED;
	Thu,  1 May 2025 18:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="acsdK+6h";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393F910E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0tXS+A4TcApvjg07uqDc35nObQCwnkl+VxClHhC81VpUoRgO5e3GueJkF2ccbGRmp3cccuhpT8Db6t9UCZ5JRxN9ET4TG2D3TAn33+/JMchQhcosvIw7KPGHAzskoNUEBsMgeRG1jlLpOTK+6+6QpGm7r+B10x1l3bX3ieR1V9kxuiKaOH8LFlC+IfiXzUYecKXIi/GOH1IkU+/FyhMzJRTM+fOAgi4dTxEeRh+RZyXMmSg8l+GXvpdPG3Pn76t1rZ0C9SPZEUF+vC/+OftPJFo+/2k28O3fz8Vg1qkmcEDezUiWshFv+I6nwEb85Ba3fPRuVe1gLnGdZMagixR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wza9tsy/JpMGB8Wkm4c33WdK+wUR3k6GXy2qpTZATdo=;
 b=MilLVo+O2x+WzPfeMv+ZaG1bC7csgGXTUsLhPJiljTaQpGMRt4ZEukHMefApxSl8pp/4vASVvvUVDyyuj39uD+KsU1y0OVmU1z/sKSX05JIMLkCmD3pfikjXyn94Pw7HeOLzgpFbYRSbqCJUujM3wsMOleG8EgqXpLcMdBimtXIKXSFBem1m0RIEkU8yF1Ng9Z4bg5hIWkkGKriQrllQDZjbKSiHdynJ+vZmKS4x1R0pj9yDgHAn85/gHhsXatgsTVkA4lvJ+T9njOw9mRq8YCFwh/P78jmwYLlSgrAagCZULWbkbJqWzaKMxokYpxVMfsaF19Mq9bByUvmnBYyQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wza9tsy/JpMGB8Wkm4c33WdK+wUR3k6GXy2qpTZATdo=;
 b=acsdK+6h569Yv/uVIgWCnSJUnpgfnmV15nolEf43DIxwsYvwnnY3pRlTR3AUMB3Sxv1gNZ+niYwpUJqmbh6XFuebRp8wCFI6WGFFXHSO+8/GeZK7o6R+veHBVaqjhfMgUMz0CjHh/iLQe8R9YSvbd2o/eLQy7ph3jxNhKNxWB3Q=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 1 May
 2025 18:13:44 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:100:cafe::63) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 1 May 2025 18:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Thu, 1 May 2025 18:13:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:13:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: stop evicting resources on APUs on suspend
Date: Thu, 1 May 2025 14:13:28 -0400
Message-ID: <20250501181328.4107034-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501181328.4107034-1-alexander.deucher@amd.com>
References: <20250501181328.4107034-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0d7020-745f-4926-2d1c-08dd88dbe8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QveFG96C7r4DiPhG55eyDL6BLIMrIxkickLv1w5ft/vzzcyCs1W+NxhedWKA?=
 =?us-ascii?Q?J2y3U7DW+Lqb+OQzPRJbpnNjuEvUez4v308J5TMX16Nf3WvuqES5MgnDi9WB?=
 =?us-ascii?Q?xSwbJpuTXr3bfrNJF2qGmlnn9w0nH8c/HVkRisBX638HuWLklNs9IX+lQA1K?=
 =?us-ascii?Q?PWBqML9eicPpv2INQ6j0tq5DrVRE5J0bKb9MfX/p9I6fwwHau4yhpeE6g5SN?=
 =?us-ascii?Q?rQRWLotjV7ZaJfnL96Tg4GsF5j71EIqttesW6IG/O25xWQHQfEsqMnFXHXuK?=
 =?us-ascii?Q?x9O5Z79XukoN1P5jGfQ7eDjzV+c+Y4HeSS5+MYHoGTUFEOfXIGoOzXRX06jE?=
 =?us-ascii?Q?VaQ/MWDdeCuUAj2rkjuRXzNUemTVmfGxKtPDll0Y7kwbd6ld6OvJDFifkR2Q?=
 =?us-ascii?Q?MQMhi5P2ZY9kv1pgptPTMKAdyl5x7YwYmVFlImeLc/bODpRjbB+BfJklWQ3U?=
 =?us-ascii?Q?E2FDOpw9UvsyrZL062LamMF6Xve6GXbZELW1y5cdVglyig7aUnYKM1Dp9b3T?=
 =?us-ascii?Q?qRjM/q8OnYJ7enVFXTsU7EYu1lMrReRSGr6OjECKFiRnF/hLMDv7XYTAoh9c?=
 =?us-ascii?Q?dZi5SPg/VssY3vaQOgp9c0WsDy1S2sChoFl3P1u5tiiU1iu94KqvMK9r+PEL?=
 =?us-ascii?Q?tLt9seKwKcVxy1pVBwjveJGKJsJ9/jl+4ZVpaH9X4wmHnNCRASgoCQJr/+p5?=
 =?us-ascii?Q?aILxklupHAMdh/JMVgl/qzTeLlpXlH+M001dWaYRe15hdp4rBxIkUUsXqsw4?=
 =?us-ascii?Q?V7uA8UWEmtynZC/8LihwnE64s2hwtq3g0VmE6JWsPcxw2NEHji6i7Rd7EHfb?=
 =?us-ascii?Q?PJQvbmBbLpKZGXXa7wZJJUjv44JzZGYXh8Ab4fkznjK/Aa6b8FIrYeZsFQo/?=
 =?us-ascii?Q?CQObmTmcN8Ifuf2jlZC/ih3K5Ev67dbVtvyvxR0jXQAuP/RWA16Jkh530ux4?=
 =?us-ascii?Q?JSdbfWO7ilN+eK7U4ku8BSRZ5e8yGw9xQg9BRA2zQ4HBdj16fushuZI5qa3x?=
 =?us-ascii?Q?7w4KLmXJGqpBA5ODBaHErktND03rAJOlB5+3WfgXvj4DNu3e/OVC5qqHZU2N?=
 =?us-ascii?Q?0CF9jUi5q8nXT/uIbBJNNLtoHqWlC0XZ3Zh33V+DnbJRnRgt7c6MyvnSwoOf?=
 =?us-ascii?Q?NwH3AQlKE47uUb9LWqWuP4vu2jJ3ieJO7vFzvlnoVnVqyQuUyn2yt6aM/7wG?=
 =?us-ascii?Q?k2yLbMZCSa5VlLFjIeTYM6S4Bwt50Y2gJwe+56GjNROivIeXKHuPyAQkSwpP?=
 =?us-ascii?Q?ayYLNZmf9bYwbxeOCYesrIPRQxuoIT4BAk1vsrZpyor5npBiRh4olzijz1kD?=
 =?us-ascii?Q?F8HAuWxgVXMdq0pYat2/+XRCb9ZNgjw1WYs++kg34JesQegMG9HyCGHuPnnQ?=
 =?us-ascii?Q?Frs2Q9n3OiBLdAWvyWHnfwXLmXuWylV8euv2EKuql7Ji55qz6ZJu7OvmI24G?=
 =?us-ascii?Q?b5s/XiZ9JQSxbjTbXNIpBIH30cso1sIs69D3PAosdwVdlTs7jbDuHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:13:43.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0d7020-745f-4926-2d1c-08dd88dbe8a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

Set the s3/s0ix and s4 in the pm notifier so that we can skip
the resource evictions in the pm notifier and pm prepare
functions, then reset them in pm prepare so that they
can be set properly in the suspend and freeze callbacks.

v2: always reset flags in pm prepare

Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 14 +++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ac7bd5942d01..a3e9f289e37c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4919,8 +4919,20 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 		adev->in_s4 = true;
-		fallthrough;
+		r = amdgpu_device_evict_resources(adev);
+		/*
+		 * This is considered non-fatal at this time because
+		 * amdgpu_device_prepare() will also fatally evict resources.
+		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
+		 */
+		if (r)
+			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
+		break;
 	case PM_SUSPEND_PREPARE:
+		if (amdgpu_acpi_is_s0ix_active(adev))
+			adev->in_s0ix = true;
+		else if (amdgpu_acpi_is_s3_active(adev))
+			adev->in_s3 = true;
 		r = amdgpu_device_evict_resources(adev);
 		/*
 		 * This is considered non-fatal at this time because
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 24ee4710f807f..60c032f124149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2516,22 +2516,29 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev) &&
-	    pm_runtime_suspended(dev))
+	    pm_runtime_suspended(dev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
 	 */
 	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
+	    !amdgpu_acpi_is_s3_active(adev)) {
+		adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
 		return 1;
+	}
 
-	return amdgpu_device_prepare(drm_dev);
+	r = amdgpu_device_prepare(drm_dev);
+	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
@@ -2603,6 +2610,7 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	if (r)
 		return r;
-- 
2.49.0

