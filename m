Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13BDC282D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD1E10ED19;
	Fri, 28 Feb 2025 18:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nmBsOCl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FFC10E337
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFWae0QXA0GVlB5N4gipyVU5KhSvzy2rUNI5UOMBBBY5HDAWRHULkK5SZI/VBnxypdK5esooOVDlF5FFD+RbbOZSEuH+Ah5bI5rb4fLxbJcqv+PO7QVmEpX/GzagfVooq6joag1DlXs7rcXoqIiTf9gO5eH88xsqHyMDVcpatdh3Qeb3AFbgDwz556x2uf7wTybja31GK3OkxMOy6ZgU5GlQz84Na+Pt27dMyTQAOtXoxK4Zgqb45OM6pej4PZs6iGEZ8NyC0PSKpBiWnePE32cWcikaYfbSLEdRgncAIeWMrd44g8CgiSxesHwVjw+iPNnusvNojCZ600XGK0rvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNfN16eIrp8BMt57KqjUeuDEWb38tbx/Ub+pRitIFHY=;
 b=FRfpSn53vK8gveaVdLwTVDuqJ0F0STV64UX8AzdnSSaekhO3aRlJ+iA0A5Bl58R02jq/wGWLkrIqG3lEyet7qFNtpMMhpeVFn1ThaGoj2AxOt4yFf34mEHb2AcvpTyA0+8quDrdWehHCUxAj//HAJ8r9v4ODqequrtwS7WIynYhqmVo1IGal7tYTpapxM+tMwMvoXKmBw/ooli3+1YVWJ+aFPoXWHXOf6NBglaV6ywscAdjqBV0UKfQqqfN5FF07WvgDy7z9rdi2HswyMqKHU+7hQpGocG2jSgwufPBjIqYNVI6EHymKF/wg2d8MkITWtIiWbcPrCVE0TDf4GpmlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNfN16eIrp8BMt57KqjUeuDEWb38tbx/Ub+pRitIFHY=;
 b=5nmBsOClmhcraI/O3eAO9NiXxJ3jUzPJ8ufq0vhIRTJZvSgnx2Ai74LFEhRbtzD7WCK+Ykr5ApUWxc82lMUeuTs7yc3eDvNk2c+ga/gUrDS1Mv6KcPCJnphSmzaR0ZyvuQXo4+zYyr3GvMVyfBkF2dEctVhQjCb16YckhniORqA=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Fri, 28 Feb
 2025 18:52:02 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::dc) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Fri,
 28 Feb 2025 18:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:01 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/5] drm/amd: Pass luminance data to
 amdgpu_dm_backlight_caps
Date: Fri, 28 Feb 2025 12:51:42 -0600
Message-ID: <20250228185145.186319-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228185145.186319-1-mario.limonciello@amd.com>
References: <20250228185145.186319-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: ab12a9ca-08d1-40c7-b7af-08dd5828fccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BVZGdIN2K9vQ6QBCuAD5d9yzQfuBNZTDn8JLJUYm5oSLLyWnBrG1Z3+KVt1p?=
 =?us-ascii?Q?rtXY09YVPFM9lpTosUVyqryNb+P0GPDV/32lT1vBBxFTelqTOK1y5ZA3bgcR?=
 =?us-ascii?Q?P+Mh7WuLN207IDrfJwma0pjMK5D2aGZ28/MfsUIggkpEIzyZ4cOMwoV+YsFJ?=
 =?us-ascii?Q?kct0HdT7rZE+RGeA6vA7jVSupcs6dJhvdm4nLQaxk83ZH13/wHEvpeln9Ro4?=
 =?us-ascii?Q?biO+CJPYIBHE37Nn6Mj9MEC12f6UBn7OQ5CJw5TGomHawE6/GSrOjk6AXAck?=
 =?us-ascii?Q?izIJXETKWemgIkSBQacyYf+0j/ahE+YIhwzJ8d9AXden+ZXnyAz+kl0FFfzR?=
 =?us-ascii?Q?awx4KRMxjaxl24aVJNSip7FjaD13noreuRpA1FgEYTjV70UmbHZOxy7pQTin?=
 =?us-ascii?Q?Ht4pPvMGTt8vBa2MGg/9pxf5N+YCndQKjdSiZn5sKVRrAL+9kWd54ugWGSdR?=
 =?us-ascii?Q?x7z9VkFcolilWxaJUq1eBdsF/oqebDRGhdl+R42xoo2/8QpBthVY8gtKM30E?=
 =?us-ascii?Q?p0NqYfUEAkf6dQyB68BiA6koT/vQaJNJQ8zH1OCvFhlFDO5z3VgSr1oGNiOj?=
 =?us-ascii?Q?eVNv+zZXxcBYxby4IjRFWSzCfov/W1GbE2dp7X3XS6e/usI0oizEHggZB0cV?=
 =?us-ascii?Q?0Lwp9eGwsguhpqY/23CWfU2Ex4zUo2ToZUq0hEZ7f5am7eNI+hu4hlcXOadr?=
 =?us-ascii?Q?WBkzEwuY5nJgnNw8QRS9qXhU8IQ8K4YYeKg9WvAjuh/7hervoTeFyksKzqRw?=
 =?us-ascii?Q?gqI9ICf3OkEElr7e2p3tcU5Y//5iCscYMTyjCBCrZkfugd7N2CMfO+fESflv?=
 =?us-ascii?Q?xEFXCo5v2mVs7cheX0lqR3bloMz3DW90/IB5PXd0BHl8HZbeaLmF+t4HIdym?=
 =?us-ascii?Q?5uV/mFle9pzmrF7UXsBn5v8cIuXOkxSWw6HoifWduUpLAE27ZsksiYadvjCo?=
 =?us-ascii?Q?icRaMaKrFpJ5K0fqZmAPpWfDVlWp92uTSKJr+uRCiaGtzK7AGzOtRsfq8g/9?=
 =?us-ascii?Q?1dpYW7JuFegxPp1UAHWVJ5bVY/P/hwDBsgMj/14b1mtUxO2Jm6svkN285Hz9?=
 =?us-ascii?Q?bYe2dIl+e2AKcR0wBsy+0W9Kmb4RT+4m5L0GyAl6d9A3FS1nQO/Bo77+D1VG?=
 =?us-ascii?Q?9RLGW+NtO63WaLtt9Lk7lEYOmQsrLGCVed31S6oS1pNz5+DeaK7GBlV28bXQ?=
 =?us-ascii?Q?ky4rfpuQp9u1LHjIWyviVrQ3p5JvDpOf2JYSB1t2iKfO4I2mdVODCYmXpmDs?=
 =?us-ascii?Q?t07viOLro9d0C4pmOX8e1Dg2f5VAixXz17kwAjnlXLxmo9OGn/HlwxS6GzkS?=
 =?us-ascii?Q?Vm4+kfWydlAw+cTfxO3QSK3a4DyhpvEEF8cRMMjnKa80FtdDHDZcOGCoQaNI?=
 =?us-ascii?Q?AMoGqI12owAG1jJjD5gmtl1k4yXtBhrrgFyQ0AvkVDuTAHVl+TiYPYzQaYrO?=
 =?us-ascii?Q?AUcPAznMez8oDuKK3nNIabeVDBWdq5MjWc192jzyWGVqHUZjB6a/gEGbadfJ?=
 =?us-ascii?Q?rOuRFP8KF1RkO/I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:01.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab12a9ca-08d1-40c7-b7af-08dd5828fccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

The ATIF method on some systems will provide a backlight curve. Pass
this curve into amdgpu_dm add it to the structures.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Keep ACPI and DM structures separate
 * Add static asserts to ensure structures remain in sync
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  4 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_acpi.h        |  4 +++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 515c6f32448d..b7f8f2ff143d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -394,6 +394,10 @@ static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 			characteristics.max_input_signal;
 	atif->backlight_caps.ac_level = characteristics.ac_level;
 	atif->backlight_caps.dc_level = characteristics.dc_level;
+	atif->backlight_caps.data_points = characteristics.number_of_points;
+	memcpy(atif->backlight_caps.luminance_data,
+	       characteristics.data_points,
+	       sizeof(atif->backlight_caps.luminance_data));
 out:
 	kfree(info);
 	return err;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f3bc00e587ad..85b64c457ed6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -151,6 +151,18 @@ struct idle_workqueue {
 	bool running;
 };
 
+#define MAX_LUMINANCE_DATA_POINTS 99
+
+/**
+ * struct amdgpu_dm_luminance_data - Custom luminance data
+ * @luminance: Luminance in percent
+ * @input_signal: Input signal in range 0-255
+ */
+struct amdgpu_dm_luminance_data {
+	u8 luminance;
+	u8 input_signal;
+} __packed;
+
 /**
  * struct amdgpu_dm_backlight_caps - Information about backlight
  *
@@ -195,6 +207,14 @@ struct amdgpu_dm_backlight_caps {
 	 * @dc_level: the default brightness if booted on DC
 	 */
 	u8 dc_level;
+	/**
+	 * @data_points: the number of custom luminance data points
+	 */
+	u8 data_points;
+	/**
+	 * @luminance_data: custom luminance data
+	 */
+	struct amdgpu_dm_luminance_data luminance_data[MAX_LUMINANCE_DATA_POINTS];
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd/include/amd_acpi.h
index 2d089d30518f..06badbf0c5b9 100644
--- a/drivers/gpu/drm/amd/include/amd_acpi.h
+++ b/drivers/gpu/drm/amd/include/amd_acpi.h
@@ -61,7 +61,7 @@ struct atif_qbtc_arguments {
 
 struct atif_qbtc_data_point {
 	u8 luminance;		/* luminance in percent */
-	u8 ipnut_signal;	/* input signal in range 0-255 */
+	u8 input_signal;	/* input signal in range 0-255 */
 } __packed;
 
 struct atif_qbtc_output {
@@ -75,6 +75,8 @@ struct atif_qbtc_output {
 	u8 number_of_points;	/* number of data points */
 	struct atif_qbtc_data_point data_points[ATIF_QBTC_MAX_DATA_POINTS];
 } __packed;
+static_assert(ATIF_QBTC_MAX_DATA_POINTS == MAX_LUMINANCE_DATA_POINTS);
+static_assert(sizeof(struct atif_qbtc_data_point) == sizeof(struct amdgpu_dm_luminance_data));
 
 #define ATIF_NOTIFY_MASK	0x3
 #define ATIF_NOTIFY_NONE	0
-- 
2.48.1

