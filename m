Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F93C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 02:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC06810E1CD;
	Wed, 25 Jun 2025 02:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z2bL56qj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7290F10E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 02:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D50rLh4idg3BH/rQ5ZIDfedf8qebcuaUpkl61K8wW9HlJnCggR+pFod9sGP4yCB6KdDoB3pbgK1rDVFxDWMu9ecxD4CZrU+E5jdgaS7c96iZo7YKdGVA1X4CU8FcMMe74W4tp4PX08Jp2pHbegoufsHD01bRSVCAi8gEUys5s4ajgEWZ4rb8NbkLrb/Cb8lRhHse8cnK5+4/qGlNuXTgUWE7dDX4meB5Xfm+QMrFFyYNbwF7vzigqQLQItBVZXdknd+M3j75R72xK6sXb4Gy6XOXL2O4O2t7BDiOk67xeF08eT6ijQVq/HbvIPFuIh2S1cuGmI3OKsUdVK/4J87NMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhsOGMvob1ThHLE1EOR2gsYy+/NTYqSqdbTxr1QcnFo=;
 b=ynJjLqYLigaOWj9ZSvqvoT04n/w2T4093X7y1ruR50Yy1aeIuPJ+Ac7Nh0uqGqnJSPZw45zZSDj0tOnhze7PPD5D2IuU/yPTqZArj5szJZoS+diSEU8/RUN2ZAbfz2r75KgMfmjLupJK8qvRh7qqUvOeaPZGwnP53R7PFB44/h3CzCZAEPfwLQiOD32WYjfwozzOnmVW7EPv/iWzmUeZTAby/zZdf7P8LWZIAfTco+mY5mtS+fmZsNI4Ip1iHHIgNWt/AwZc5PYkaV9DjVUqvNJtaqvWVv8Kg7p66mOmibg1S3IxoObvqY4m+sHPSLiYRat0fsp6s/pjyR3m9Y4jVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhsOGMvob1ThHLE1EOR2gsYy+/NTYqSqdbTxr1QcnFo=;
 b=z2bL56qjyEjoS4SQ7Jpj1ixPJFjZg5tTrLbZB+GyOx0I03wTL9st13U11um1Tx8ujE/+hU72J2cOa+QNziQlZ9sb6VGWOs+0ukyrclnZy5K+37PqDPkFYF3y3iXFya/Tc3HROGzgg/O45roph/QlBCrRI5ErCY9EX3wAD29eoi4=
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 02:32:35 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::30) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 02:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 02:32:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 21:32:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2] drm/amdgpu: make compute timeouts consistent
Date: Tue, 24 Jun 2025 22:32:20 -0400
Message-ID: <20250625023220.8417-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fc3fab-4051-4a42-f1a5-08ddb3908b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sDVOFf2ZDP0XU0eY2Aui4V05NiVchPJ2yhKQzJ6HxDKM/5cx/wCxaUzg5Naz?=
 =?us-ascii?Q?uqBjFTgXCJJd5svP17iC1vcE4vrj/omyJLJLh4Th6JDj4TIrZ5X412x9j+nF?=
 =?us-ascii?Q?qFA9LVR5ojCk7WHcFCbw0GxbBfUP9yBHt6pS9qOchjK+pJZbaHobOmVZLteu?=
 =?us-ascii?Q?B//Htbyrzv/5ZS9xPUATZuZ5L8gNxqKlfK2Mqv3ErQC8TpcukW5gt5H7Q7Qm?=
 =?us-ascii?Q?GMU8WujjZJKpjuokqVf/WevTxLq0MVXLPErXuP/74707IbdWFqpsgDYTu3GA?=
 =?us-ascii?Q?wi8Vm/4nRiYaH5j1GGZ2NymqOevQl+lXQTiBQeaOiWMC5c8ELAWMsApshb5W?=
 =?us-ascii?Q?4Xq0WCkOh8U7IciYCyOFG1ZyOIuG+zhUiExW1O+DVycn8nsBILZ7OSsvaSJ1?=
 =?us-ascii?Q?aB7PYw3A57xiHskPmsFLgtO26B+ZjFzDevuzgIt2Wzm86czCzAfUWFmwnxvw?=
 =?us-ascii?Q?6ftm9Def3MCptZMdyc0hmeDYidy35YXC7mcxMs7EdWsvStwzSGA8jVbH6ynZ?=
 =?us-ascii?Q?rVTU9ujglpKVSzDQsIrZVMxjpjV9pAp2C2VQcho8yCUEOg0mt5VpnxMJ6ZWn?=
 =?us-ascii?Q?4qXYwOBCthd2KkUt/ckmDAQbDGFGi9i7LPOMuT7ZrPqPkB289J00c0XKuJqc?=
 =?us-ascii?Q?yLr2ugTY4LhWucfyh+rA8Ipl5zmylEBn5EAg0bhRzME9km30c7vypTBjxawc?=
 =?us-ascii?Q?VlA4fosfiJ3i4igt9GQI/qX/rLTl5PyfGWwzhI2ZPsjakT/b1pr0ieTJez4c?=
 =?us-ascii?Q?oc/avOcTDC/r8PXJ60QKnqeAebExv1qKe37IbsAEykbQbGTF/1KKWvV/4P8U?=
 =?us-ascii?Q?Jrqp8yq8ZN6zhaGgZVmgqymDxwZzHfxrxPTnrqFJcfAh2A/+bQdspZuoRqBs?=
 =?us-ascii?Q?oRSFyYe5N9SMhjYjmIaM6IwTTFGJsHgmv5JZ4oYfMD2gZyVt4Agdnt3Md1xG?=
 =?us-ascii?Q?o38iGDDeLst57LGDdBU62HnydF24Hmphwx10m+ckOomdwJLFjZtLyXBk5fHM?=
 =?us-ascii?Q?7RC9VlOns4lpJFyfg+AYXj510BJ3AQPZIDJ1hSZI6/X5MUy4JBTXIK/e8DCM?=
 =?us-ascii?Q?5P+acxdID+gZv0yOt2xmqxtWQmVFjfr8eg2PdTSYKIW+2/QsQF9fr6Cs//LQ?=
 =?us-ascii?Q?1ibV1Oa+KKl6fNGgCcrkyqo3M0aw8Rw5qUozqjUr1SyqFV9euP03qnbMrPek?=
 =?us-ascii?Q?p5pD50rTXpQpI2nqI2gKU8kDC6EUjJHHNdW5SAUzPk2qzw/dUr5gc56pKhix?=
 =?us-ascii?Q?HKupE7+SDUAxakVJZc4JUsK6pfQuATAgOojh30JLly8PCEF5DbrNTz4onrf6?=
 =?us-ascii?Q?Wbhc8Jem1Y3Xt+qr/5ny6928El1IMZAlNx+6GHXwbFVWsQcCRVp1Lc9V9+nt?=
 =?us-ascii?Q?0+6VfMApIRyBlN5etJ2f+JgBtbNP4262uKaI9ZuTMj8TWiuxWuQMka0DIOfP?=
 =?us-ascii?Q?S9+DwF9MfMaL+PbOk4s3mtNp5gElrXN2BniUw1lXTVuGRedPFWrWy6BY8u6F?=
 =?us-ascii?Q?JYTor2Tbgtu4hduRe5gty3cx79xrCBgDFf1p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 02:32:35.0098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fc3fab-4051-4a42-f1a5-08ddb3908b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

For kernel compute queues, align the timeout with
other kernel queues (10 sec).  This had previously
been set higher for OpenCL when it used kernel
queues, but now OpenCL uses KFD user queues which
don't have a timeout limitation. This also aligns
with SR-IOV which already used a shorter timeout.

Additionally the longer timeout negatively impacts
the user experience with kernel queues for interactive
applications.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

V2: fix documentation as well

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c8a6b3689deae..58a0ee99eb2f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4171,18 +4171,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/*
-	 * By default timeout for non compute jobs is 10000
-	 * and 60000 for compute jobs.
-	 * In SR-IOV or passthrough mode, timeout for compute
-	 * jobs are 60000 by default.
+	 * By default timeout for jobs is 10 sec
 	 */
-	adev->gfx_timeout = msecs_to_jiffies(10000);
+	adev->compute_timeout = adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-	if (amdgpu_sriov_vf(adev))
-		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
-					msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
-	else
-		adev->compute_timeout =  msecs_to_jiffies(60000);
 
 	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7e3fa76227033..7bc326d0b4000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -362,12 +362,12 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
  *   The second one is for Compute. The third and fourth ones are
  *   for SDMA and Video.
  *
- * By default(with no lockup_timeout settings), the timeout for all non-compute(GFX, SDMA and Video)
- * jobs is 10000. The timeout for compute is 60000.
+ * By default(with no lockup_timeout settings), the timeout for all jobs is 10000.
  */
-MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
-		"for passthrough or sriov, 10000 for all jobs. 0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
-		"for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
+MODULE_PARM_DESC(lockup_timeout,
+		 "GPU lockup timeout in ms (default: 10000 for all jobs. "
+		 "0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
+		 "for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
 module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
 
 /**
-- 
2.49.0

