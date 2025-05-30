Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB49C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 15:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8574310E0CA;
	Fri, 30 May 2025 15:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eueCCCSW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF28D10E0CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 15:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrTYBSjeHUO7/nOneCYoif+P+H5RQ/ex69wG6WdPZ5ft3CsFHc0932UWHfZJiezTBsQR6JtGSyJOQstIdhlJ8CjeFvgZmM98AEIPYEEDB4MODeooccbIPUSoTBZ+OHbmpCAxGaXuSyqY4yilueHTtXUB7487eWipYwoyv8nMdx2IvyuKLMB4E9zKwMrRO9yLliylNR8qZv/JZrUoBb4H7nuhNlvnp5WXySEHCShatTZEOkIDwS3g7+pbtskgjicfuNklcViWcyAsJwqX2ojT7clGDwrPMOgSuKnw1FptHa5HgmX2v1i+wq9Tc8jrWsiaLuHp000qykSYXXJeLbWCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/k0RnBgqZjOQVtj3JnrqzMI25WLGHKdfq/etYzC8KQ=;
 b=MNUhUwcRXHz4RDrSzWZw9AaQyo6KcoLqkwmDzzZc7RqrEOxE49cFoTW5vPMcUVt7PWwrHIZC0bwS+HgF2iSBg2aeZng9+01VddV/hUvKnMsSDB+s+LuAl0AKvFGn0CXs8vsOnLFlYFkJ9wz4bGaujhdE0vTMX5BrVAzaKniBXNK8EKkcD7mOHZ7brERBfFQJTecwSUTCCfjND78rh3hCTIjQY5X2BwGEBxMjvzc/8ggmFCE166tNoMzX3A0Z+0lsoZS/R6DcmTeqgAGwYTW5lLZT7eq7ifS6dVj/Mwr/V5SjhfnP6jM9EqxGMrYXiAlfZhPaK9hgPX8cvSB4TEcjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/k0RnBgqZjOQVtj3JnrqzMI25WLGHKdfq/etYzC8KQ=;
 b=eueCCCSWRilJblR1aKKTy2SBe7BKIn/Fb+qI6AGrwkAgegTs3gdRI09t/yHFZQBPdcKq2juMF4kQmZx6+vAqF2oBJ7DKCkOCsYs96ITqKY98cskpJYIjfp1H0bwHNRUFo4zOdkfG5IH7Yj9+cwJrI7VMTcBnsYz1Jtzwqj6AY6g=
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 15:17:07 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::16) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 15:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 15:17:05 +0000
Received: from sclement-U2202a.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 10:17:04 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexandru.Tudor@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Allow device error to be logged
Date: Fri, 30 May 2025 11:16:54 -0400
Message-ID: <20250530151654.2503769-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d170e8-f025-463e-e7f1-08dd9f8d09ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aS17XywLbCZoQItgVsWVyabf4gr9fhKXRjQ//HtXDE8BYgz6ky3lmUJR8D/I?=
 =?us-ascii?Q?1Jx5bstQtUeczILg0ixnI/oi8o9SfMc1WrrNTGxBt1Xj9XZgdT+ILL1YwKPA?=
 =?us-ascii?Q?PvRQyWKByC4YyBMg82SKvJxjdzkscLeBGIET284lmDCM5aC+pubh3b5ewWrK?=
 =?us-ascii?Q?5eBJT65RMYyaH8b3HwenHyyYBgoHZbcvVqtZA0ch6vw6W8KOzaXF/0NUMvdZ?=
 =?us-ascii?Q?nEd1ylJQFRI0rd6mC2BWqN0Gm9VDavTMkSR8WV3UALWmpB6Sc+7wIK6tmWRq?=
 =?us-ascii?Q?g34H8b+UuwwQ6TUWmRjZsUIBg+eZYVsPB5fy3h9fMHEQI7cDMHg7IrHEMvIS?=
 =?us-ascii?Q?atOCfS66qTDqlrCCGcpNUIkGJmv2UYa7jf59WpihkYIglhmotluU7M3E62uq?=
 =?us-ascii?Q?9pDgEUo0UIiZd0GaLxw6x84zw5hT7wtt1t/XLVHi6LYo57euPVUu98EHFxR0?=
 =?us-ascii?Q?piEnVCLggej4AgUBH/I+nR+pDL5HR1oWQAgD5UHUJRsMO8lcWxbt3lCAo0jF?=
 =?us-ascii?Q?L13iyFMSuRZsHqjc5YIi2BoWaHnAdAi0LaaCrY/Qo6cSXph/58zr3+RjE3u2?=
 =?us-ascii?Q?qtD8M4QRHpdj6ngIp5eWPEMDYCEDHdeNAwkG10oKrSjwL2aXceodn1l73rKq?=
 =?us-ascii?Q?sUCU7eLoTHga41JrNMol7DgEpEmJDqwX8B3WasPAYmuWjH22Ybllo3SgJZVW?=
 =?us-ascii?Q?ueTQrapmcxc5ea6JPKncqvdAt1yj6kKLg2Mx/DR7A9FkLggSQMNviqlmNebb?=
 =?us-ascii?Q?VdNYRPLhKIAn0ZlYtu1Q24wRn0XYIoyGKa/p2dglY8IBwL0Lx+zzx6aQqgvP?=
 =?us-ascii?Q?FfMJG4pc7fI7J8aT/vkfdeqJxY+yEQesv/Xg1L8MARmJYN1ZzeFdzdT44aVV?=
 =?us-ascii?Q?Aq5vh81IL+Kcn+JbvCB7ycZgm4Xyr6/Dl+E4meK1kP8PLaXAy86VJHT9sP1z?=
 =?us-ascii?Q?7UfEFmEf5Q79DOEAXqVzoOdJRcGbYFwflXiMF38YB5XXslxxrOAl9i0KtEXG?=
 =?us-ascii?Q?M/hyxviEp5a/mI0dlp56myiNpF6MNquM844FWSk1WSZ3/nZwDjfKVobsXhE+?=
 =?us-ascii?Q?3azI0nYSvns1JZW9CeauyIZyVIsh+eVT81p2bciPwLG1E1dWrDC6hfHtSBAE?=
 =?us-ascii?Q?32DOBdC4iRGjXHABaXHk+1aKX19MzwrYUBxo0sLBlgRJ0cFd+8rlCulwbXVq?=
 =?us-ascii?Q?M80Ncvj0HiLGoSR91W7IwC2vqJtrSbGNkbJOhXak8VNMdaRmasV4/zOQkndE?=
 =?us-ascii?Q?YbLe6IL4MjbgyuAzwdbDVeKi4RANJf8aJ+Re/qQHyJ3TB6gD/4SH2Q4/Y75x?=
 =?us-ascii?Q?XCTYoRWwmdFzd4nFPMu/Pqiu3BdYSOXyAuFXTwLWjN+LCzYMvcUl9iDJw1N/?=
 =?us-ascii?Q?CmID98wzXQKo03bqc1DgBi6fV9FdWD8drJyjb7NFBdjDi3Wnh3fAudVgNSV/?=
 =?us-ascii?Q?cCSygjtfBaXH1r0aKSPzLD8XALD3yTa3ceMoqBwoeYBb9MiD92pzDqkUiTzK?=
 =?us-ascii?Q?PxF7oJ6aa4pFjlsGoRZjtsFVW5MXM3RLBvHv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 15:17:05.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d170e8-f025-463e-e7f1-08dd9f8d09ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

The addition of a WARN_ON() check in order to return early in the
kq_initialize function retroactively causes the default case in the
following switch statement to never be executed, preventing dev_err
from logging device errors in the kernel. Both logs are now checked
in the default case.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..fb3129883a4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,11 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
-		return false;
-
-	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
-			queue_size);
+	pr_debug("Initializing queue type %d size %d\n", type, queue_size);
 
 	memset(&prop, 0, sizeof(prop));
 	memset(&nop, 0, sizeof(nop));
@@ -69,6 +65,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 		break;
 	default:
+		WARN(1, "Invalid queue type %d\n", type);
 		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
 		return false;
 	}
-- 
2.43.0

