Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC266CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9387310EAFA;
	Fri, 24 Oct 2025 16:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpK7/6Yu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6734710EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUUFskNF92wZmCyS9urGuRc3U+XKJTTQ/SApD8QX0JYoSQcNS68Kaq0dnje8nebjVMv6DChsgj7KNwjeczyW2T4MBWVR4c1XricjalelgMcpzisaDMO6F0E9sARwFcBvYnkHdM2DJdUB4lzvgrKOmkVtMCCxVsPfQDq9Cpgos2AJRmFjblqOv9wBe64ljxwWBV7hLYGT8H9aH3i2Ae3kbZUbjBBq9kynKCBP5Nx13JxQJILB5VhIlDXORiUY+DTborI/rzPjEIJBgk9RRpDyii8Rk3I06hwrXqJGaKA2CWunNsGK3qTTXqfRuJlkt8MUrtdEn1qQWzQvIeiAFg7d3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeVfMh1+X8qAUz0gnx7AAKJ+Bp9sWvmFv67IN2ZoS94=;
 b=IAm9+yPylfCk8c2aTybsoefGFvn+xw8tTM86pKL/TR8rwIMVhHvzgVQu09+dSmM6MznoZeTKnoLPjPlSo6X/uCA4oEIUQgH/v0pmV5UbgfrpnkMCG+1GDbpt+cuLJb/p+IhuWjX0lRjsL8eN307Bsi6y5PLi/MnABa1YencYMbYDhGNAP7RmWTudCwRIBWaDgTv7j3CrmviMMh/ypH38dU82uW6ty1hNg5UE81olZBTsiIaceU6ZIO+Dc/Ryq5/ZwKoBPqLLhMpUFJVXUMWzTwLEm17gqPz7RQElUbinUVRk0eSuERsPwq07f04l8yPtCvQsmhBkoWJOalFYpOVWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeVfMh1+X8qAUz0gnx7AAKJ+Bp9sWvmFv67IN2ZoS94=;
 b=bpK7/6YunDTa8oDnig+AMV2DyapJKM/Ktp+pbfh3DhEyqI7rZtR+fRPlS6jWNoS4TCv4bDg3D8Ekp+tG6JfPUuCNlldnKsXbJe2NYi9LhHjWVDiV5+lZ2lS31c4xLyfPTeIzF6zRf9XewZj8bHjlNkIG7MZ1PicToXvqEJ5ojVg=
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:12:40 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::de) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Fri,
 24 Oct 2025 16:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 16:12:39 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Oct 2025 09:12:35 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Robert Beckett
 <bob.beckett@collabora.com>, Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 2/2] drm/amd: only send the SMU RLC notification on S3
Date: Fri, 24 Oct 2025 11:12:16 -0500
Message-ID: <20251024161216.345691-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024161216.345691-1-mario.limonciello@amd.com>
References: <20251024161216.345691-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: acddce92-9d6b-494d-f6aa-08de131827b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?knaH+paGmFyQjghTa1xXGZr9IddDGrlFLW5g1kk1LGmH1DiNkdlfqyYWtFSh?=
 =?us-ascii?Q?eRFzYmgVYNDsliSLUa6bhT1sxPzF9TILjkmjn+V6ItRxcOSYrBGnulekFWyJ?=
 =?us-ascii?Q?RjiMwKdkY02BYwjqjE2pMaW34fSpl2WafqDHOoU2Xh2Fes6u6UZjyXkeOxHq?=
 =?us-ascii?Q?e2PzH813rmPtMneP6gmzceivpJW25N8vWyWtpYHCZBAOu/wJr9E23aU5n5E3?=
 =?us-ascii?Q?Gdx37BFaogeSdGvWvzOLyqW5ja3kF6o8RD4ZV801onwYtBUnN52oGEl0nRV0?=
 =?us-ascii?Q?TIUfhNfku9g9mQHFdpZ53YJEcXx+zOqKJhxS5buZ8kw2AxlO3f+RvJzT0UZx?=
 =?us-ascii?Q?TJ4joNZGeOJZtL/RX9B/fUfgTTumRPTHb8+7PDB55WwbIcJkwqp6A/VwI8LV?=
 =?us-ascii?Q?Q3kSwTab6rrN+nnhFUofhxAxJ51TJmQZDLWefvxHvtVBQDoryrD4cFB9R6oj?=
 =?us-ascii?Q?SS51xr3N3bXG5hhyjE7uuxZf60Ag97dsZmHh2BXmcCDtp5GDIvnxHb3S1XAL?=
 =?us-ascii?Q?FpM0TaeDWaByp7A9YhFNqGsuQHTIqiMsF9RkSNpE75CnADEt1AlVbOiV7twX?=
 =?us-ascii?Q?JpLe/qATak4Mffvfy0rGJMOXaG8hdih+dsyOeMDdf3eEZbEzQ8RgOkbNfbAn?=
 =?us-ascii?Q?oNO4s0gwuWUQbf241mX8miKxSjQ5DJCqtmQBqsu4mSVHtx2Go5BEUBujayyF?=
 =?us-ascii?Q?pWpuErQnwHsuQlzldba6j2Xg/sQl+ex+ZPrQ5NXYZMqqiZUv+3LWRSu0RcNY?=
 =?us-ascii?Q?9nOcolS6XmuW4unOHQ0pqQS6JGo86imUrCYs6xrtqBVeED9qDkXcuX8Kb3ok?=
 =?us-ascii?Q?h0QO0et5aq/NN4nGFZgTf3EVTeXpWctisK3GJawSLee4n/okJsYNplrgZyB/?=
 =?us-ascii?Q?cEWlxU/cMsc+aCzzuJLaCHMTHdrqG1vn8fQDEChzKucmXFVkJOEnAh1GwWfl?=
 =?us-ascii?Q?JNAIoMi3q+ClqBGlKfRD/D/L1MoT95NU5t7PZKkPy4WfkGFzh9YsBAJsUSMb?=
 =?us-ascii?Q?LyEffyJ1XWMb9SlpX+m8DXshBy6w91VkJ46nramamWU1X3E2xzxuSMI+e69M?=
 =?us-ascii?Q?T9dJAIdIu8f5vN9BYMLemyAB+q5SgJamNZy8sjb4qhkL7zcZIbGtO8wIFJl9?=
 =?us-ascii?Q?XhmgmAku7j6qxoKyuFr1TaLVjr4JltS7hu4Vsds2g7ahl9iL7+0xDrmzHU48?=
 =?us-ascii?Q?URuBlDQhnu6C1DRcyFpO5/eyKoVaf36pzOvvqXcTDSGmi0iqbyVwV8iTEgtM?=
 =?us-ascii?Q?qLqrVzKsaH5UE8FDwqBBHzKCaMISN5RLY4BDCN/HPlZqS3MKD4Zvme/5Sb2F?=
 =?us-ascii?Q?veknItm267DXPEJMVOvaVJCvT6nmUyleb0Gupj+3p75zthakFmGOYxQEzBdl?=
 =?us-ascii?Q?yNKFooBnj+Y+TA4Q+tnz2oM0EDZWDTTwojDfZupdLct+7AhBWreolTxjIm8m?=
 =?us-ascii?Q?ffdjCmqfL3VrghtykwT3nzpBPa3v4yY8bmK7ACgDAbhAkSukP9Jc3H6YsFMm?=
 =?us-ascii?Q?civ7LnJRvD23e4oCzBBPFJeC3CKqc++OpOWS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:12:39.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acddce92-9d6b-494d-f6aa-08de131827b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D
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

From: Alex Deucher <alexander.deucher@amd.com>

For S0ix, the RLC is not powered down. Rework the Van Gogh logic to
skip powering it down and skip part of post-init.

Cc: Robert Beckett <bob.beckett@collabora.com>
Fixes: 8c4e9105b2a8 ("drm/amdgpu: optimize RLC powerdown notification on Vangogh")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 10d42267085b..5bee02f0ba86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 	    smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
 		return 0;
 
+	/* vangogh s0ix */
+	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+	     amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
+	    adev->in_s0ix)
+		return 0;
+
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
 	 * BACO feature has to be kept enabled.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3dc1919b8c64..e67fd972fc28 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2201,6 +2201,9 @@ static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (adev->in_s0ix)
+		return 0;
+
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
 						      RLC_STATUS_OFF, NULL);
@@ -2236,6 +2239,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 	uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
+	if (adev->in_s0ix)
+		return 0;
+
 	/* allow message will be sent after enable message on Vangogh*/
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-- 
2.49.0

