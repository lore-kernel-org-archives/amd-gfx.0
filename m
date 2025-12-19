Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F9CD7879F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 18:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF08810EDC4;
	Fri, 19 Dec 2025 18:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubOshtL+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C0410EDC4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 18:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STNtAPb/wZLWNy/aianKdpR3RjWRmZc2Xy6sqs64/DL+dbhI9zYp2mbjVnqLw4k2bo1kV+qJVQsAsOsvddyqyNy3dLCjO8tMyHkAPhBfoEpPeA1GxUzGDFtlDWuUOL4G8xhJxjdQ3nWKB1829xvwTgeeOejTWGB+RH+Io3Zg41S7+XyO4xeTp230saGGvCZumUTagnwrhZpIvImLzGxb5oluUoPD9NhfQiwF75mhbNGSMGrGGv7JLFPqWiaqsfurKxnm063T/s0Y8aWjLBqUvT8Q9wK8bTNwUXnlSE0xCYdt5cZHXuVwmjqTGKKyMjEWU5/XBatQmQPU029+ijg8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pK1LAQt/m+vueSVAkgVoT22rQR8yN82z+Ht7Iu/XKc=;
 b=euW9e+cZ3Q2nZiPclaLordY6OVXCeiDqHwlXb0WDlQKsU4ijwkyZY20B4l5yRnA43Ps6EQeKATfkCYvBHnTpacWPf6bimJfst/tiPoR6YmIgTu1tz4Xxpfn65DBaSiPYkUCceBXsIDQ/S9A3drBHYwbQj5iMcZTqRqpT23y42gI9xCqgN3HB1IQBf3oJLJb11oncJR38Uf+3vhbnOjxWqzZPvjTS0Vo/ppFMtveTWBBIdAaPNTaaqw80DrSmStMXA6e+kInFc5soUqhEQmcVsOg6MXuN43swqxG0k7SyYpqSRMvmeyaLk1iRDp5wkjgTZdJ7Po3uiK1ZdakQOrCE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pK1LAQt/m+vueSVAkgVoT22rQR8yN82z+Ht7Iu/XKc=;
 b=ubOshtL+XX7aHT/EeI5JDXJmJVkBcjZTDseSuqt0P4d3mrFrJKCWHt1peBIYxWMB5rfOAghNOxbyvRYzVslFeFyCStelrg0FHNBjNwI4SZiotWcfASQ4/Lk62iQe+YAF94ysKfCKa/nkYzfZdCMJKQQP/lGFGVjSGJfON/fFQt8=
Received: from PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::12)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:22:26 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::29) by PH8P221CA0057.outlook.office365.com
 (2603:10b6:510:349::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 18:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:22:25 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 12:22:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: use dma_fence_get_status() for adapter reset
Date: Fri, 19 Dec 2025 13:21:56 -0500
Message-ID: <20251219182201.5722-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb4d432-8966-4346-2b41-08de3f2b8fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8tcwUo9ZBIvHINMLlLkf/S051Tz0MKNWiMiP8rGE9QAqZF0UNHIZv2Hm/sT?=
 =?us-ascii?Q?yOrALyCkn2OoUvm8JEow+eBx+cMjQJ+SCsOb0R/hZvVrpwZ6bBo+FFZcc8lu?=
 =?us-ascii?Q?ydNjRPxP2PMKkGiUjWWLB3ahNc6r01Ln7SRwknCh0NQSIUk07AqaFT25w3Ht?=
 =?us-ascii?Q?8KFuSqYTgR38up187H0Klytuhn0dDCcx4P0uE9L7fXOyVKKyNUQnFdpVqSsl?=
 =?us-ascii?Q?SJXhZRUJ/i3lRdSRxFsO3QmDuO3SIcHVSOdhV01S0HHZm40ouaREJLIbEvsj?=
 =?us-ascii?Q?iKUpkuxe0sanbzWxXdSG3RKJpyB3Lq0IEmemKjzMrjM/84WrU6x/qLxt9Gmr?=
 =?us-ascii?Q?MTHDTLmTUO9P59V2XgN4Uf+uRuf50p7v2jWCIEg4q4sdFQR0nRZG2ZRsgNyc?=
 =?us-ascii?Q?e2ZhTes5Boj4kOSkF+X2J0l67TlwGRqqxBATiet4zK8SqPzdqBCEWrQMdHvE?=
 =?us-ascii?Q?hP4VeHYD0rM77E9JhqL4pmTmgdWHYM9gVTF2cgSiFP8Tg2A3+PjAUwNT6nHY?=
 =?us-ascii?Q?cC0qwwQH0EJBw07gFiob8IlSIza1BX+sqrImUmGyrrlr0MKlNRzu+J0R2FD/?=
 =?us-ascii?Q?4agaQ4NntYSVO05dcVP8TLJQ2mtd4lZc8XFsEb+ANzBKQXDevGnN1udEShPE?=
 =?us-ascii?Q?YlQ/+SQU008eCrMZ/2b8WzevZI95B8ztkZLfJlbLxzO720Ld8CXwfXHLvZmY?=
 =?us-ascii?Q?93vLR9PXiJUM2ZZw6QrN3QLN4KCwph3HpLegyKwajSbWQTu5Jsvs+8H8Y/8D?=
 =?us-ascii?Q?ynmKdtyerrCesmhz4WXHQZKhhmmGgT9gsS4jz2r2rSHlPp5MeS56ncIO6VtG?=
 =?us-ascii?Q?Ei2BIyFSNEpnamKGxLd+tmJ0DLTlQdaJUGO7Nc/weOVs1Kdg2ylH2NQfXanv?=
 =?us-ascii?Q?fvjN26tB3ugoU7T27zJz6sPjMZCSiaSS0MImzgOui9poK9vvjtzUFzrfYKoY?=
 =?us-ascii?Q?nimTN31Yfy1Mu2Inn93yP89nF1C3y56mCcOCtNvs23OaxtA5Sa6ylbbcyDwj?=
 =?us-ascii?Q?dnETCGcIsV5z60xDoer2W7ZdhbBeJMWkKqPGf+cEJ7U+Qpo9QBTVmSxRt0je?=
 =?us-ascii?Q?Mdx95twR3TExkJbW/nyV4OhkfnjA/rZx7vKOxG4Z3l/zgMV0WFbkWI5CePhB?=
 =?us-ascii?Q?cnrslb+yxyqaJ4kSO38SHNmoKbKqpsOEV2lC39aobZk7vScc23HFQoGXCFpt?=
 =?us-ascii?Q?6rTzFKDYNGHtHaSZaFQHVko2iIIijIsdgEUTWdAefO96nl8nRViktaeo1UYj?=
 =?us-ascii?Q?SHYIG31e4RyyA/ZR3VX1gZNl+v+Y9Tl3f68bFIINXAQC63jM7XX3JlD58e9I?=
 =?us-ascii?Q?dSAKlhVwS+RQfR+6uK3brmKjA3oXKnZ90UFMri+e3VjUr6FOTve1iHATnkLI?=
 =?us-ascii?Q?5AWhnA8e+APo2lV3IkwYNSw58WE0wh9l/ddUVs9IZtTze8BV01qg5loY8gzR?=
 =?us-ascii?Q?ICejwuYYMPbcThGy0QOZUK/wlUObC+KprAf5nyU3wUlB1HxOx4cds975a5sP?=
 =?us-ascii?Q?6DABKDeZkzRJkHtRwlUA/EF+smx/uCGTGgEanvPKx5pXLo3V7+7UITzPnaRt?=
 =?us-ascii?Q?3udN1B35vj8HPuWFUL8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:22:25.8347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4d432-8966-4346-2b41-08de3f2b8fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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

We need to check if the fence was signaled without an
error as the per queue resets may have signalled the fence
while attempting to reset the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 52a23fcaf617c..5d4fb20f719c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6539,7 +6539,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
+	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
-- 
2.52.0

