Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731CC88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 06:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9EF10E010;
	Mon, 26 Jan 2026 06:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4GaWOBZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540B310E010
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 06:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGGXyfVI+BMAA08v00HdSKU6m0QbyYPPRvD62SCSw8cRZFbI30IGdKRxHwGZbrxNaihQklEdRP1EmVZ4cGyjsX2X66N/nN31k6ExpRGQd7hY3Pf3fSCe5qwXXXqHWbPqfN+OgS2gxWHb62Y3Xy2SOCntn85EAN1EgFTtqw8nnVgFyAUsglHIDO0I+SPncUnW8bbG97psO7s9jZlRRvVvBS290Xrl7gcf/eHUdYaF+wd87OT6BUmYxcsBUEXmBEWvRoTLMDdbYMRg3F2dc56edXEmhs2nFyFIQVYYMgMZHc2sHUyJhWXDCu4+syAlA8boul5ZZ5aL5ZFuk+rZ8AqE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=240bHENaGxESmXPLPjJ0O9sb4vFpacbdlXGjyav6WdE=;
 b=ABHZMLoDCq3yLp64QE/JvuqVRKyJPxZ7I7uHHD6FA7Fu4tH8gO54/s9KsPgU+9fzC3tlFnFpgyXX5S2DyrABaDz8GdmSwpUM7tIQF2Ry460QTrNv1xUHscM/5mcNE903y/RBOcKFEZayo3Y3MRBd/ILZt++uEaqBkGShddFjjB+Z2sZ9Rpq4aJnlISy6XeCSzZw9Sr0/89YhVzLudl43mNbKL7KfHOzDZL9a+hT/3NqhqBEIeUEfLiNB3V9Fk4he+3pXyEcx24uqap322VYHklNhyOecddvDWRwe9OJ/2a75FBzoL4bkK/8Xl6sJd7CGjM750DMAnAJYVp3/jwW7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=240bHENaGxESmXPLPjJ0O9sb4vFpacbdlXGjyav6WdE=;
 b=L4GaWOBZfAvOtzJQ2ba/hs5pDlyw/RvDrUzz5dK/GflcQYSqKozqiAJKCt9NOgB3I6Xj613coKolSQAQidgnnmZOxBmpOMhNMVh6skHzME3Y1a1EmQD2rXKG3T2JDeO5L0j7o/GbUZNZFUN9G/I2g9dS+f+X4H6KtKD6KCQiwSw=
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 06:19:38 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::b) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 06:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 06:19:37 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 00:19:35 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <perry.yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfxoff in amdgpu_irq_disable_all
Date: Mon, 26 Jan 2026 14:19:21 +0800
Message-ID: <20260126061921.1886410-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: aad0286a-0d9f-4afa-94aa-08de5ca2e1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B/NxjllwPU86ajG8OgaQf8scZPTkE6+O6ZfprFwXwwc26/p6r9xbeCOH7+JR?=
 =?us-ascii?Q?O1HSwKJFTwtBQQ7r9bf+XDkzKb8bb13Gge+HbUx/fgQNs8G24iFWY5aBuM9G?=
 =?us-ascii?Q?ZCijoDh+ZGT4VAZQ/1T9WJbNjeWuXxe4ZydfFls033ui6EkYq1fygDYSXJnI?=
 =?us-ascii?Q?Zw6AYgaBKsq7HIZlG5h/oNIVSLwZx4Q+DD9aHaDjgfyvdwrRqQr9eV2KycMB?=
 =?us-ascii?Q?PSftNJgoeCCHNCT3xQAuYytVnauKQ7BauKHFyYutTIPPuIJE9eTtJql/PPao?=
 =?us-ascii?Q?l2klJ1MD243QRwbddQq7uLtJhLCp4HDCOPdjZxUVufmrFthJdDmYZWoA2qOU?=
 =?us-ascii?Q?EPdkq7HKvtI2tQCNZyeBz5VdkXWYtf+uBU7i+1URWELflYp+v9lceewEqDjt?=
 =?us-ascii?Q?z/5jbTrhVxaOaWVv9gqdLSGcxGcIyrkKdYer1jPtg1I/x5FHdq1PmDumlBcp?=
 =?us-ascii?Q?mgLd3g1xhFRvm9w0JRw2XhpE/exTweBZtGRsnqcyS1MfluNOBFw/EROQpcxh?=
 =?us-ascii?Q?uSDVpOugu2+Ilj84ECrnD5t6yvfKFrW/TRpGGzG1iY0WWBFfRPEW41Zy2qam?=
 =?us-ascii?Q?II453bNNRnKuiuPDs5K4fRY1rFRDX7Igpk9pNuJ18qhvOzmfUs37CQDO6D8V?=
 =?us-ascii?Q?V3WQIEodxhkcfIpTKWJGSMwhMIZwl9QW5+EYp1gY7203cEHeULpAXGRQf0E6?=
 =?us-ascii?Q?W+kQCavRYKojcpJ3jyeZnN1mtQpwZB6/ZVEsxlmd6VpSKRGoca1Db6bwZS3l?=
 =?us-ascii?Q?YDDNMsRWCANFaSjosnvx+94/N7YlPGTzJlwlolHRGLvxKrAQ0lr6vnLAqw1Z?=
 =?us-ascii?Q?KDmF3e/qVw8x2GsK+LQjtQ3y+k8rHjJ9GxdUeCgkz4q4Q6of5le6Hxt8tC6N?=
 =?us-ascii?Q?wYmUQ96FhaaYUntweI8oalv/y60K14U/3rV3S+MOjzG1SFJ+YPrxU6HGxbVp?=
 =?us-ascii?Q?oIHAsWY6kiiqi6/3SRHgw2Z6b8tPUkm4aPxfxWgjnqQQv07dZDXcMJXDK5Qd?=
 =?us-ascii?Q?cXRe+8iHCFV9KHUGtUKfHYIbPWDsse7U3yxF9jdaelS8PVPNiFxKn/B3+PiP?=
 =?us-ascii?Q?p/S+dgifvLnjt9HNLFnS1GH6wl/8VWRbtwFWs64FKoJC8wziosG5TdkVBwhv?=
 =?us-ascii?Q?jgJMVIU3h9ewfPQR67arkzlsvEHL4LGBx2l7tLaoPP6/HfFpc1oPOJMNHpvH?=
 =?us-ascii?Q?V1k0gyJ63YWJH6Fft368v9/G+yqD4aUma9RyRMTGFTGdo3iMkN7xips5EHc2?=
 =?us-ascii?Q?qTrGv96+zsXIzx/GfZSqnEX2MDoWQWTDAdSSlSyD9yE18tUTEVhd1On1akfM?=
 =?us-ascii?Q?wGyT5gnaa1p6XbKUisnwTvXJSXyMhGIgdAcfhaiK81EZmnu/DbfoWo63fTNT?=
 =?us-ascii?Q?5fKWAc89Xnnq8OSfSanLtRKUbYUPQQRtkDNZ/aTOEITyZpml4XPOn/t8tpSE?=
 =?us-ascii?Q?f3A3ChBlqo1DX6N0ulau9ez7K6OoC3P6ladApQPnEzFw9bgmsN4OhWP9QEoe?=
 =?us-ascii?Q?rorara5o9/u925oJFjDxSbkwGWMLn7LAQTSKB/wL0RmF+94fmAq7wlr8iEuD?=
 =?us-ascii?Q?EOugCOtdAfJrROZwZ/PlkIQSvsFPyqEatGCkhWAdgUuKtER/Bp3Ft1enSr09?=
 =?us-ascii?Q?8r/7EvYKv95V/cc7QUd0TDpzN1r7n4mUyPuJr+FIa+NgjJgJHEi4uS3vkRkL?=
 =?us-ascii?Q?Ylgq3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 06:19:37.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad0286a-0d9f-4afa-94aa-08de5ca2e1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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

amdgpu_irq_disable_all touchs GC registers, keep GC awake inside
the amdgpu_irq_disable_all function. Otherwise IMU may be stuck due
to invalid GC regsters access.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 82bc6d657e5a..85e5399fccad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -162,6 +162,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 	unsigned int i, j, k;
 	int r;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	spin_lock_irqsave(&adev->irq.lock, irqflags);
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
@@ -184,6 +185,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 		}
 	}
 	spin_unlock_irqrestore(&adev->irq.lock, irqflags);
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 /**
-- 
2.43.0

