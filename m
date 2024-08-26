Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB60C5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 03:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866CF10E0CD;
	Mon, 26 Aug 2024 03:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y9hNOaT6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6147210E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 03:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwMNV9fK7Dgw1LgtiJEd3YM5SqFqP/Zp+O5sPvix3ZAUp5150LPka++GHN5stnJVbT9UgLHnNQhRS988p6WrIVi7Uh1l7MhgvRob8z6SSGd3TEwZHOt63QEAJm+YP986WxeSZ3Q2Ndgv8Mtpm+evRZUgq9VinsficWHiO6B99MVRfDj8wI9UsScLmCKUMEl5dUcHWt0FaxP2IjGkWmu24MdHX53hLh/p7dyNOWRQgFaWfWVhgB4LRgtjiAA4Vb9IF9oaRW5c3CDwv/4zCpwrV68d0HtsoEFJFhPnJC0SN6HGrEYkMfFWDqOrf4QaYV0xB/NwLpPWpFDc88iCKenOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XLWHNUQCMe2M9+Mrj/iGTAXjCedVJT3Dd5yGFb3ZSk=;
 b=gKpe99AxC45fWZxgM8AH8qv3aiVVAURD3+nYoX6e8nHJrx6+E+uWyYzjsjfHXpkuP5aMojsFBFQbFpwj80URmLMZgAElgtqA5d0g3gk3huXVX7FvSEUowAmzu2+AU0I1euA3+By4GKV9cW1h8DeUGa7rDAtXxyrX0bGDImFQX0MJpzZnPU4pL5Vy8I75YXfb8aZkhr9z3wnVQiD1yHE0d9m9NcAH6nWHhLhFIVtIFCUrka7J22KyOh6Mj6CLqvTkJeWCgHxUQBR5qZPBck15LHOE0BOAtpsmziVEhI7PX9xtzdgLCjE4XbWvdGp/lMs0OMqoyIcHCy1v4AY8aB3gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XLWHNUQCMe2M9+Mrj/iGTAXjCedVJT3Dd5yGFb3ZSk=;
 b=y9hNOaT6iF2Dq1+jOKo17HLlT3AZksrPT+MR5wb8zK/Q0xaO3ObxhMGZO8sgoVeyEBBAE+nn/nOgSNdG1XYLfltkyOfDklC+zKnuLiSDZPxtrpi2KSDhn9JuF6A3EUgonbO3hcXc+UK02/dFil57oUApFHGu+F2H9feuRd4gM7Y=
Received: from BN8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:60::33)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 03:52:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::f9) by BN8PR12CA0020.outlook.office365.com
 (2603:10b6:408:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 03:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 03:52:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 Aug
 2024 22:52:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 Aug
 2024 22:52:38 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 25 Aug 2024 22:52:38 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: move drain_workqueue before shutdown is set
Date: Mon, 26 Aug 2024 11:52:25 +0800
Message-ID: <20240826035225.3382900-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: fb066738-9d9b-4fdc-5080-08dcc58287e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/VApRUlgar0GaoKpir0cUBVD7gYiu4HELMOK8VGi+iL6ciXBtwmq2zNCpw7g?=
 =?us-ascii?Q?JMfGrW/mONeJ/dSMC1y1vb8Q3R9MUNThTLyyq4xjVXwUgifhnxAzWtjA/Ivb?=
 =?us-ascii?Q?bjO1vAQSIxnOcihRadxCeTLRhWV0xZA0QtzpvuBzCMbkHyJOWfQstZ08RjfQ?=
 =?us-ascii?Q?vDUaMApy9bCHydLtwNrM5WXSnlvFzLSDONMzrkrIU54KQSQbbqHj7sdb9L7k?=
 =?us-ascii?Q?Cxtflcc55g5GzZrwRAU90InHTIf+mSqZNXaxnevLTktLgx/larhpG05KjhO4?=
 =?us-ascii?Q?bqWKJbiXzD5k39Nb2mZFtWTv/0Aa3kJ6VuWVcjOvF+tpr0AFbdIlFayWrGb6?=
 =?us-ascii?Q?sn4lbjz8Ph6NUEkxhQMCj/Z0mISOTrwSox7/LP165jw0y0eHZg52sBgNPzub?=
 =?us-ascii?Q?OvjpWoIFvcmny+4mPy5biRLjKtgVSxobBAZ0mjrYElHPZNYqB2oAlGoKLwXO?=
 =?us-ascii?Q?HVEfdAx/+uHTQ5F1Mc6fchYBPMv+grax7Lgc3itWWEtuoJtk8kcA5gKV+UQB?=
 =?us-ascii?Q?2MW6q8Du/I8TT8ijmP5BHufxMBLThx0Q4nz601ZeX6jN9SPBPiTd5BH7Gay8?=
 =?us-ascii?Q?wNVwduWN0A1TrIyGbpMPm2+mivDfLVCjHHWMHwFB/I7KNI3KUNaQcPG13BC+?=
 =?us-ascii?Q?QbZkMOD0HcQQ6y6IJFwsaX3WzTJGWPDBpNwZziHkbMkVp5Bdga1g2GIJNJA3?=
 =?us-ascii?Q?sIwHiCo8YFyf57t+mp0ptZDAWaXHADVykn4Pb6SK5WzFfRyvsQfSuWiGBjzm?=
 =?us-ascii?Q?ItgM//7kWz9NrZh3D0ymhekrUFhYsQ9tWVbkBuNHTuR84EZzchi7X2ag7wvQ?=
 =?us-ascii?Q?oumCwvVR2whMOkB+0Ryt6n1idhvhch7Qtn++lDzP3RZNVq5mdKmB+qPCci6V?=
 =?us-ascii?Q?sACaIVZtZ18trvHo8HndOOZlhfGkdAWNXm9TWRdyzgM1+aBg0dy4fotrFxiA?=
 =?us-ascii?Q?8Rkfc6d85+5AomHfmjVOWK6AH418TudLMQ2slfiREZ63BFZcdtMzskCBV69f?=
 =?us-ascii?Q?bHxsNOZOTFd47FWefbyubu74AevQwp3c7vOBwyD8czXpK48e/0r+1zY2df+h?=
 =?us-ascii?Q?SdsrK5wBEOLt3Ce/ne0HNJTPwXgyohJ19Iy8cibH/MJMkyeO4SuE/s5RcpAG?=
 =?us-ascii?Q?W9dRJZtPB3dhF+qmqBq5ULL04MEAqkqRalOjvvA+EnlZBtSVrvqQAHCXijem?=
 =?us-ascii?Q?xPCwq2Q3huUKO7r09Ue3NrHmk41IezWe0r3letl9LLP3o9YWY25HsMDbeAn8?=
 =?us-ascii?Q?2tG1eeLhL8beuY3h9b5EtC1mGePtYMrpPuvHF/iRJ+AbDSB7JlkQvQEKeLrD?=
 =?us-ascii?Q?tBVWmepJ0NA927m0vngtKqo87sTVfrcPjZJ6ZirZ/sR95M6qkyMc+BM7WP0R?=
 =?us-ascii?Q?o2MCqBoelD1PzokzgGvxNRHoKvLn2Jf0vhkNcvXfjn3hQr99btgkPek+tC4N?=
 =?us-ascii?Q?ZWymRNc/zjRV8lC8VImFPI2wATF34wOn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 03:52:39.5450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb066738-9d9b-4fdc-5080-08dcc58287e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
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

[background] when unloading amdgpu driver right after running a
workload, drain_workqueue is causing "Fence fallback timer
expired on ring sdma0.0". Under sriov, this issue will cause sriov
full access timeout and a reset happening.

move drain_workqueue before shutdown is set to allow ih process and
before enter full access under sriov to avoid full access time cost.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da06705f0026..f06e1f408f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4531,6 +4531,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
+
+	if (adev->mman.initialized)
+		drain_workqueue(adev->mman.bdev.wq);
 	adev->shutdown = true;
 
 	/* make sure IB test finished before entering exclusive mode
@@ -4551,9 +4554,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	amdgpu_fence_driver_hw_fini(adev);
 
-	if (adev->mman.initialized)
-		drain_workqueue(adev->mman.bdev.wq);
-
 	if (adev->pm.sysfs_initialized)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
-- 
2.34.1

