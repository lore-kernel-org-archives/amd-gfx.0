Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97ACCCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4160310E6DC;
	Wed, 22 Oct 2025 07:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dgplkTa";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2605E10E6DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPx5b4S9KFi4ODB9+63aeoiYpwvYWW2YXelbUyClZS7ObSU6olPVn1KRMOwtPC52u1G5rsWF30sJHkRn5ImCbPIz02ZQhzkNA4DrVdEgOKAbxMu7jQAd6dIgCw5aZPve1+KmEwLOwchSZTpVoEI4VPPTvTUOWvRuOH6Jyr7aEJSy0z/uL9c9k8LEtdkEt8eML7V+C92m/sbXUlXb2ovLcteZwVivnm0ROH0dtNfjD1Y/C35+foifegfhaRaiv1LB8RtSla5br3GYTf3gW2MW520zSifv5kcO+sXby4W6D/fVkHKey6a14a16vvC1iTu4D+mSmuhH5LoA6L1UHDcMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=lOpYawOPdmS9IM5tUc6KJ9qnZCUeMZo2u/06jfo/H2rQR3rcUFcMg24uGSKZSfMpD7qBieR0tcxQcUE9YGgDWQCa2EjEsKBL2qPgx8XoN8HAs5ObVli1Tb+cbtd2xSIpyC5jDQSWTATTpSL2yXO+hFN+kUQVte1qZH+D+lH45rLM4VhzweAC5qZFgw0CKXbyMxR3202ir8OfoGc+M22das0MG0rEhqCvIIpqCLBKirFQKJOL96ZOVln1DVulR0yiuMoNr8bfyzuUul4eM0fr99Csk/jYu1OnrI66NLyAxDkEOGc7FoY2+pVl5XQ7iyucLg6ZvrsdavHQZoMhIrGwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=1dgplkTa4rr09hQklFlL3hDqdiGk4guY/SXAO2lGtmC/lnob0apQtJCCvIgKA6tLVmALyAi1k97LOHUn2W0CBvTFC1mS3dU12pYstiC82ZuahEI0H69QNetYl706n5aoiDY4cC77Y2MsnsxzbRS0vJioSzUkldW3gETDbfYVEXI=
Received: from BY5PR17CA0010.namprd17.prod.outlook.com (2603:10b6:a03:1b8::23)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 07:31:25 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::22) by BY5PR17CA0010.outlook.office365.com
 (2603:10b6:a03:1b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:24 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:22 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 09/18] amdkfd: find kfd_process by filep->private_data in
 kfd_mmap
Date: Wed, 22 Oct 2025 15:30:34 +0800
Message-ID: <20251022073043.13009-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 8540e363-3dab-4dda-ec71-08de113d0183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OnZyaYfpsgpYa5OeL18EOKq/DKjK8GNUXLty+obriYyYdjs6MTSSeBWRCbLO?=
 =?us-ascii?Q?tW3PmtJBVqFDURnxjDIJ5GjCfylFNQDbXwRgIz48/l9UXVX2LTjBGfZstIKl?=
 =?us-ascii?Q?tcpolbbmfqZUkyY9zSO8tmC2U/aHeRD6xUkmgdRKNi5ZrQybGep2ivhx2eXJ?=
 =?us-ascii?Q?0SJ3XKCon83IrjUHCK6ItSw0bABPlZgdj/6/2foBzA4OztBf1h2E9hcJNRjy?=
 =?us-ascii?Q?Cg3ptqJQN3LE+V0ZtgViEdtigY07UJiDlOQLN4M1LQtAaQLW2bpA3c4mQnaF?=
 =?us-ascii?Q?BMefiNbkv8j8f5hai0JYHeJSE/SAbjrCQxeBvbqb4EZqy8E6/7sDuNRoNhYH?=
 =?us-ascii?Q?2+cCWn9RvBaIW7DIZ6rrJZ7oTBFF8AQh4107dxlHX8kg1CJQO+yAOFQiCdGX?=
 =?us-ascii?Q?u1vkSeYvFrQyMV0qjRVh1mWlsNflL2DvpljU8sEQNPuTZTzBU3ue7jGiYUL9?=
 =?us-ascii?Q?lKqPDNdimLarbhnZ1JnGmpRWq8PGRoQzGXOCtVyq4x/izrVRyFjthXFF40v6?=
 =?us-ascii?Q?/Pp302h/wwKQR6U7ZYaPHyZbkLRtpPl84xSF1uCMT7PD8ECR/7dAEhOd/hXc?=
 =?us-ascii?Q?GdJyYVF8XIWk/C2fM55vAe4K2Yl4zK0Ozv/QEmvDX80nOXKQyenRv4lFDYQ1?=
 =?us-ascii?Q?46pRsE7f1xjVqTWhRM1mtvjTkXhN1hNm+GyHMzQHqlNgvmcRJoWTre5z7G9P?=
 =?us-ascii?Q?YBV3O4VJ73F9AzfHdsIgbWeTGMNVy9/wAg+mQa2i4RzbfeDAfimESCoJnx4C?=
 =?us-ascii?Q?ujmXHOT/ZTn1tlJRtxCd+05Z5AFO08bMokSkExQNNjKGwFJCMycx4I6apizc?=
 =?us-ascii?Q?wgLWuetO28GqKsF/AaS0lgsiABT0mnZhK8rjglppkBsOhdZ381NssYddbqrX?=
 =?us-ascii?Q?ABSLq2GlkJWbN/B1iTKxkz8NyYrqd95ldA+IfbUL/R8xK4DMKtfmBIWP4LeJ?=
 =?us-ascii?Q?azeGVgopqaB8lsQyvrsmf+M7TatVBFdQkq6w8mbwTJLZsZ+ZIxJPstoWMNRX?=
 =?us-ascii?Q?NrcEQMziy8ktGYQP0Z97PoQ4bQPg2UxTMmmdECynTMz9EJMBkggVW4k73ErK?=
 =?us-ascii?Q?B4agHsvUgmfpsMF9CbPVbKvqf+6mmpckRBjVK7B1VMKQpfas4WBqtAQFozPm?=
 =?us-ascii?Q?7Kxmmf6AtcHj7Jpq1l+bzj78JiXzwjbuZoeL4yqrDrvPxhjWiBZrrMyolf+L?=
 =?us-ascii?Q?gBt/Dc7OigXnm8PZ2vtn1ogRfWYw1/v1rM8aaOJ5CGwXubx+mSSIFzWwtoiJ?=
 =?us-ascii?Q?ZudIvU55Kn/7QswBfEXiJkqhfy4OH2JEoUeFPjubqRqQ0kMBnuTb6EIsnTfB?=
 =?us-ascii?Q?Unv6tWgREJ99fR/Lop9/xSR+eDKmjbI+g5hic0NHBJXmejku8rhi90xdyNkD?=
 =?us-ascii?Q?hbboR+47G6YhzjWG1gzjCEnjaW0/FFvBQh1ipP04K4vv5cyeIbi610J+Y+Fe?=
 =?us-ascii?Q?SpWcMydbSPi3uzYDy+sbe8atTqpafHCm+vaWb/LAf2J7BuDJT9f1q57ZTFrR?=
 =?us-ascii?Q?6iFcRnUnapWsaHiCQzf7SLwy5bkEhpTP44qDmkvhNMuecyLrn0ulMZdOFjtJ?=
 =?us-ascii?Q?ZzKt7SApkQwfbhkfJRM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:24.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8540e363-3dab-4dda-ec71-08de113d0183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
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

This commit finds the proper kfd_process by
filep->private_data in kfd_mmap,
because the function kfd_get_process()
can not locate a specific kfd process among
multiple contexts.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d1cb22f48b00..73de2de8be0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3410,16 +3410,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 }
 
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
 
-	process = kfd_get_process(current);
-	if (IS_ERR(process))
-		return PTR_ERR(process);
+	process = filep->private_data;
+	if (!process)
+		return -ESRCH;
+
+	if (process->lead_thread != current->group_leader)
+		return -EBADF;
 
 	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
-- 
2.51.0

