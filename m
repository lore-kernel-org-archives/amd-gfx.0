Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87007C1B0D9
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2ED010E2DF;
	Wed, 26 Feb 2025 17:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYpUo9/O";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E900D10E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfCP3lBAlU+c91gPrrrJskz4S1PdjM9o/6THR8GdNPOe7HxC+/PCf1w0g3+7fj1MwpVBk5eeXF7yhtULFOC2iRiPiOuX2NLWUuU6//Kk12FvJGDW5YXiLYqOlf4WGGHdRQ/2HHyjOLbVjRRGC5SJY1zjH4Q25WmXcIKnvlkpI/xaPU5mXPjWGQmG4Lw4H3BgOMecdgTFQbxOP/wFmdYsQ8/nM1S8sZCTxMxHgWSbXlqVzFYWRYFDsoj5S9b1rCtEktlwDA6wIahRxZie3EVTe1iGMNwebUhMYIfbVuyqMxNc9fJ+Eh7snSlZ/nF9YS6hEYf0d9LiCSag5iOeOjfmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BUdZapkUbDlltSP5EX1HC/SPH1k/V5MsZf4DSGIhlc=;
 b=sIugKFcPlhrDyDdf9zP0AUeqRaxHMZBNv/v8u24PrbOgSxlwD1NMDaEfsLSoHi5H63JJFe+Mivr/UrAUIV4abYfGr2WRcDkxGCLtH00kIu11thDgwaF36j/5vQuOZbGZusyKWbnF42y4Jl3J5yAErjRTpM57hQYcYKUEocQ6xVsxOVl4DHSKloKggblQ6nRwKLUTmnnPHxL1Cs3N7DA2aq3uWDW2i+RSonlAxPP6s63O1k/84KWAl3nRFUIVY+rktjkisYoXmhGGEbUabqyVvJ16JRrsKNn1GcPlQrbft6MJkg0FnOBXqwQk5AUNJ2S/+r1kNUdZ8HAqAXgrVjYJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BUdZapkUbDlltSP5EX1HC/SPH1k/V5MsZf4DSGIhlc=;
 b=rYpUo9/OgGnsQO96m9owXk4hP6MRvD6QKt+XHnSgSW6uG/PcgQY5R7MKaLIZdwD+1ki1Gqd/cy49V/6mNnFVu88jB9xzCo9jOa4Oqp9Zl5BYl1bIV6WDGm7qFx1U6NoINZ6v4K14OaOC3yyWnGwsTJzBXuvL6sHLmAwyy/tAeYs=
Received: from PH7PR17CA0072.namprd17.prod.outlook.com (2603:10b6:510:325::20)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:15:18 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325::4) by PH7PR17CA0072.outlook.office365.com
 (2603:10b6:510:325::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 17:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 2/5] drm/amdkfd: KFD release_work possible circular locking
Date: Wed, 26 Feb 2025 12:14:18 -0500
Message-ID: <20250226171421.14436-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
References: <20250226171421.14436-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e9d5c1-bbd5-49a1-005f-08dd56892459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zCoZCXcwVr8nkBOyMjGx0oLp4DvhBIYJ0VmIwQIB8O6sWD1GjSRBypkyvvo9?=
 =?us-ascii?Q?PwILz90O0dJYig5GFIFf5iUiEdSH4nPlcWtjdKJUNyPxzCZfxSkH0PkWtbxs?=
 =?us-ascii?Q?K921ych6RJ+jG3hG8NgDwY75QrpNPZ+gcY4JDE8ymsF1mU0jPgvkKPzF0410?=
 =?us-ascii?Q?6I/PYtsLrrxvc/zQZL/kj8f3MgcnWD7hxpA70ZgqePh6lMGSwKm8qJza4C8p?=
 =?us-ascii?Q?q0NVrsR9NfveK8ej1tedtf2gtAUtycj8DwCQIAXh0KfBa3HYfOYFLJ9ox9Uw?=
 =?us-ascii?Q?j9oj0RCr2nf4GT/3tFQ2uarI20LRgUj2wgyM+/w0eLM7NFI9X8fC+jpDrI0h?=
 =?us-ascii?Q?HgpX1mSWVW50Av7wTdRL3ZZlaijIN0ggyoxKbnaUpGB22Lj6sA8lj6KgcR2n?=
 =?us-ascii?Q?hGvWeiBLPhd8pYBE6e7+TktNAG/CRf5kmIzcsUcUuQJ8mUDQUdJMh5fzxhs7?=
 =?us-ascii?Q?CbiJCOxA3IVSDgDEbBrR8KMkbO7+4EmQvUHGoiUudNuBeNG8GLQL4n3IBfA6?=
 =?us-ascii?Q?jkO8N20ejvBLKiefgLJQsJB94ALVB7XGRWBXrgqC+0pdgTrGOZL4gakNUNf+?=
 =?us-ascii?Q?RWWZb7HNZeDgoYDXOW2cOQlklb0nxeCuBvvKqzlPs4cDBR5L15IqmJBPLUzr?=
 =?us-ascii?Q?mc2smjhM+t8zx8seWGOKaA99Z0NTlLRl5j33syiu5a1tA4twOjrp3KJJ0Bvw?=
 =?us-ascii?Q?8uRYg7bL3zJR/150lb3bFQNAg0mSBij3LXMoF4U+4Liz6VT6RVBzAmEqcorT?=
 =?us-ascii?Q?Umpjv3uJ2yj3xFxgT153N7Ze9HsEtIPiyPzp4ioesPOH6UeLuH0fwnjGSxWC?=
 =?us-ascii?Q?rTxtxpreA48cVL1DdJyqXnBzmX043WTsCsz8kCZczyMzl1fJv/LkzWOoBR7i?=
 =?us-ascii?Q?gaDEUSSPjucafyBvaM9BCSYKIzeGUEqe2Mww96G/jp79/Wt74AGzbi9z9kfw?=
 =?us-ascii?Q?UvABQBDR4oRBzLd0C2r+LSwEP+1iw20bLDOovCaKMbGg6AfiFGfBTyKELycj?=
 =?us-ascii?Q?og8R+nyDuYVGfyDPfpNnnSRJ+TkRm/5hxOpZSAVXLFWEHx+Y7bRGzvxFDngj?=
 =?us-ascii?Q?nPAyRH1QF/m1aKNY2epjhyvoKiApqigJ4/PwKTBk+W8PmP82VVpBkdREvHrc?=
 =?us-ascii?Q?HwrBSka4GH3LNYhRDDh6TA7Uxq658fepaNydlchSgWwPQJ6fE/6YvuVCoU7j?=
 =?us-ascii?Q?ycp0+Zp1p+eRZI+hp0exvG1ikRT4vt+68FMn6ZcwaNwlAKpsJ1caCO2kIF9y?=
 =?us-ascii?Q?1sUoyX1PdBDWoB/my2dgXlU8V6xWi9J5PU08KzCzx65K+S108vulHRpuoECH?=
 =?us-ascii?Q?4s/2O1dzG5tghmAIrSQqp/t1aeLc0VgtkrzkJ8QuD662Z/xgyAJkea6ov96d?=
 =?us-ascii?Q?h3YyNsidfFwQrXo1MkqmEhTcgNLhnF9z+s1FEUwhhGE6L5pBwPcSPPQz3J1I?=
 =?us-ascii?Q?FTJM3ht1E/UKvpmADfYBhiRna23QVc5W12jAwQ5XOgzrGKau1sQunl67RwYJ?=
 =?us-ascii?Q?3/9VA+eQPHvXjwc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:17.5236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e9d5c1-bbd5-49a1-005f-08dd56892459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

If waiting for gpu reset done in KFD release_work, thers is WARNING:
possible circular locking dependency detected

  #2  kfd_create_process
        kfd_process_mutex
          flush kfd release work

  #1  kfd release work
        wait for amdgpu reset work

  #0  amdgpu_device_gpu_reset
        kgd2kfd_pre_reset
          kfd_process_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&p->release_work));
                  lock((wq_completion)kfd_process_wq);
                  lock((work_completion)(&p->release_work));
   lock((wq_completion)amdgpu-reset-dev);

To fix this, KFD create process move flush release work outside
kfd_process_mutex.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1067afdb456e..2715ca53e9da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -838,6 +838,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -858,14 +866,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
-- 
2.47.1

