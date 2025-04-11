Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B25CC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C8410EB2C;
	Fri, 11 Apr 2025 08:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AaGMdJKp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529F010EB2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSQas62ebrfDa5gNHqIDf+idnjU+6GhuZGIzAHeKckVYtaiF/+JldZO+1PIpyBMberoOY9xKLtD3/23g9ye8EPOkX6gU5Qgqyug7X3QLe3yFcF3h3xoeyw0Th1FINiaSRduhwDIVoy0MDCwLJbrsKQ/7Br911St94IgARs4JMkydPAYyEM2li+m3XlUCTT1Fygs7406nzMkHTgqHKLl7A8oYhfYLo8sY2X15EUcDIB185petg44cU55An4MFjEkcnEU8mMy3aTQkwFykUZ3bl8x33mpEFHlktNCGfWh5KitWrdv/znCTqIrYnA/Cg+9/RYnHtE58lxyNQH2YnPzvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc1zoo9/idrxrOIXbCpN+Bv4LMS4/hvxlci5Ehv09sM=;
 b=FKvzj/cgTXRwGWQ17C9DnpD5+sDDQkT381xP1tC4+TZSaRFa60NTM2EeFzaaCAGxF32Fa2yKMQLJd6P0DJIItOq9TJIzWhf29MmWf9PFt26CN3gUjeo2MFSOPHtmkS5ZGyJLRiUaW2xlOZBb+wmAXvVkuP1VknGnVK2hxvRSp5KjxzrSaRC5I9bb2T2rkxWZRzhWymw5kWwepNNpH1TPkVfUSF1Wpb9VMnsczgYOCQbbN0h+sGZoIbWNiv9l0qdMmVgBKwk+F3GOy8JhVIX4pXhRWtrU8/I+rFK2Uy6O3uCaZuzfz8xdMyY+CvES9ArAK6zTGSiOg2908YU+HAjzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc1zoo9/idrxrOIXbCpN+Bv4LMS4/hvxlci5Ehv09sM=;
 b=AaGMdJKpm/n8aDuzxaZTmbUhAJwSizbAhvr8IqO9bQp8l8ipGUN4I4WZoOstKznWOJjQxI1eIhIianiNCV/VIhZ+2VjR86VVi3EkONxonl8MLf3YZxDu2h584+yPa67BmLvxctC+UAc5sOw32NfK7C4hFYOrCJD3z6tNwr+lF9s=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 08:29:35 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::85) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 08:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 08:29:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:29:33 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:29:21 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [v5 1/6] drm/amdgpu: Add the new sdma function pointers for
 amdgpu_sdma.h
Date: Fri, 11 Apr 2025 16:29:16 +0800
Message-ID: <20250411082921.3228498-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8b89e4-7902-46b3-39dc-08dd78d2fd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hyZgJ7xUuk/Moqjat2Sg1X9j1umyYcvioUX3VCfMNnDAZQWolZnfWZWSPMYf?=
 =?us-ascii?Q?Rbh4ttfwjKGNI669i5qwO+E5lfTl24Nuq2/dgxhHDvN7Qvv6AB1iSpqLHTVx?=
 =?us-ascii?Q?sPH/9X6Pkn45ETD+kWdQTJIzT5ZzonJsjLE4A/LCUzMO/2C5qq+MGDDJdqSf?=
 =?us-ascii?Q?3RZZy0zyV8PEJYEa/Wn4wmSq+e2OJSuudIoIP6BvEfxQm0gkVUFRAJfJMzGi?=
 =?us-ascii?Q?HpEkjYZm7uFIyqHFaSmzuMbjnepmxSzTzE2AOTurvbJpgoVhoEsgf38+Xrj/?=
 =?us-ascii?Q?63kfTZQE4Rlv4YqpUFkbp8hvj8iqUZRd8XIhh+B5U4f/g9r2HAy/8n1lG7iO?=
 =?us-ascii?Q?RFFDtvC3t6FptzyzB6WXlBW9abxmaB1cTRsy8A0jCo8pHG2VAYqTd+DBe1GA?=
 =?us-ascii?Q?kW+Y911XLFv63h4kzOoK0Pp+YQiujI0Ie9R7X/3Cman/V2itnb2LFln/bqUv?=
 =?us-ascii?Q?MllyDZiB4DMZYq0H2yTTeKsx4pAzoS0mwe4PlZS/CkFPQlhBwtco//yJKSDt?=
 =?us-ascii?Q?DU9/1XHTqBq/yNBfM2r4jFWQtfn1I2I+h4Wu8Ls/ikI4k55H0c8YfdQifzzR?=
 =?us-ascii?Q?aGGu4CjoskITG2yZNMNzNlV1th3BpcvmIMACxkL67md3teceU0FtCRvuMnzH?=
 =?us-ascii?Q?b2971b33ZvR+5htcKIkBjNvrecw2kzPTaqJrtFbsNfmFi9CDEhPTL//k4iKO?=
 =?us-ascii?Q?F+cSpIOlSumPZYwbRtQPFNM0l7+PxUwr3Wy1aoNHWRYWpk1eYlNd7hds5HGj?=
 =?us-ascii?Q?Fbq5yS5OUnl50yih8cOIZTHyH52c2EPYOy6PTYkNPZPWAZDJMBp0KEsCENMI?=
 =?us-ascii?Q?KmqY/uyBJZkhVvESijSJQ0varbcWr/+4iYj+b5+Y4AQvApur8gxgsbbmxH6X?=
 =?us-ascii?Q?iBIGT16+A0scRoTysOdnBWHGa0ziDEZBmy5yy8IZuIdVcLq8bnJzb5oxB49W?=
 =?us-ascii?Q?kDChakfoMYouvCBqdrgNdVftqiUAhOQg+DyHjeYvZU8jp998z5vOn/VW/9P4?=
 =?us-ascii?Q?z5BeH24l3r7ZKM7U+1Tt78ShznVjDi6okT7QrS/MVijDfhdEEphOU2Nsfkqm?=
 =?us-ascii?Q?k/lTHjk8eeRew19ST5d3PSdp04uO7DeMttdPkHQEzNtt4sPp3BA6XSsCV39b?=
 =?us-ascii?Q?RRd0dk6q9efWA/DzdAJH3FeH2gP/OcHJH4yKIcWViM67JRkRrVbAinQs97I9?=
 =?us-ascii?Q?rx4rmLhtL5nWjSjXnTsqrJ4D8Pjgvm68qnl9yVKi5kDK+xkPc5q5yB93B/+d?=
 =?us-ascii?Q?gPZIfGCweGvwHGWpVf3LyxY3H5scg/n4cm2F0CHp2R6k3VkY9/xJbZ5BkbBE?=
 =?us-ascii?Q?bg1R/WWZWkqpXxGgM48YyXaVQAqhRJM9BqbA4P7UEV+GyD2qIbkhmHs0Wxex?=
 =?us-ascii?Q?+rHeG0AMBg7ryi6s0UiMBfZoGmfwhcy2ySVJ330ZOvSU9DpULj27TEPrWMZB?=
 =?us-ascii?Q?dZEoG45/YLffNOKdQcSR74dEBfoA/CPblmTM/sMt980AaRQEbKT+MTAM8AVQ?=
 =?us-ascii?Q?wQl8u1hlzLnBX42Gblv6HLo7DO0QtVUCFoiz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:29:34.7589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8b89e4-7902-46b3-39dc-08dd78d2fd99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces new function pointers in the amdgpu_sdma structure
to handle queue stop, start and soft reset operations. These will replace
the older callback mechanism.

The new functions are:
- stop_kernel_queue: Stops a specific SDMA queue
- start_kernel_queue: Starts/Restores a specific SDMA queue
- soft_reset_kernel_queue: Performs soft reset on a specific SDMA queue

v2: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Chritian)
v3: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename them. (Alex)
v4: rework the ordering a bit (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 0b1fbcf0b4d0..a6c8f07a0da4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,12 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_funcs {
+	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
+	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+};
+
 struct amdgpu_sdma_instance {
 	/* SDMA firmware */
 	const struct firmware	*fw;
@@ -68,7 +74,7 @@ struct amdgpu_sdma_instance {
 	/* track guilty state of GFX and PAGE queues */
 	bool			gfx_guilty;
 	bool			page_guilty;
-
+	const struct amdgpu_sdma_funcs   *funcs;
 };
 
 enum amdgpu_sdma_ras_memory_id {
-- 
2.25.1

