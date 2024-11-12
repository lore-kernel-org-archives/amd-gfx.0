Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E75AD42BA2
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 16:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522CB10E032;
	Tue, 12 Nov 2024 16:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TDU+LujV";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B66310E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 16:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNy5ECwwR1/5/mZl+48/yAWlX/Ln7SdH5tGv2UPUut68quJ5u68QsJRovfa7xrxSJkADAB1WOjtd1mvHbajWLdck8tseAgLT5UIBncpweGEJb64W8cJZmDxRymYNiJkm53yVOGLODJM0nweVzswZJrLMig0YXYYgg8XtnKY1A9dG0UXw/aUajj0F+hNLtRa3eZ4JhmOUiB6Ow/UmgY3esTC42i5fKvV8JWh+55wL5BdLuDzyaPf+MGOSqGsfnnJ1BFGgK6AysU26IoMn6HxnEOqStksJif0MIO8Y5L3CEg8nFgKFpgU3HKT2dhXk/4pzkajp6MbK/garN+SciA4X2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1446b/DBfr7++Ht/2vdVsfIKnHkdtUMn0nLDR4lrD6Y=;
 b=bfKrBbgJQUzf3d98XnYqqk+JLsWkiSF1Vh3xvGP4PDDw/9UHYaL75kFMioq09e5t1K79ShNxQSqNGYnRw/orN4v3fWqAZR7KBUADojCThUarrGn+RowLCNP/B1/qm599d8ARHiVDjIzkjeTMTNyEC8OhOflMBPwsEn5TfDy6Jx2dMUy9PNDZ3W6/jm33LWm09nsqEVHDeVifdbLuNvpToDrYkDG4HbNK37FZ1eDJ3baCbckY5WgVII9rGSWr71TM2NAV30TOU/zwWpUdMN0ouSKfrYu9gsFQ6BRHxBmaaVG5MzE+X6UZjeK8lQtJ3shP7+GRriIC4lz0xdFXcWgIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1446b/DBfr7++Ht/2vdVsfIKnHkdtUMn0nLDR4lrD6Y=;
 b=TDU+LujV2kLRv4i91oE0nfEyN6j09YRZFonf/ECOqetfj8F3PUkwnaG+5BDQ2kvpAYBWeHx4rAM34ld+uCeSdEwc2MERaJZU/ho+nnaSemPWkjfsiRN6dYhgtmkcpFL5ij7spEzsE3u/Fd7tUyfzxOdcDkCBmYWogA1pEZlP6D0=
Received: from MN2PR20CA0055.namprd20.prod.outlook.com (2603:10b6:208:235::24)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 16:13:01 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::2) by MN2PR20CA0055.outlook.office365.com
 (2603:10b6:208:235::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 16:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 16:13:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 10:13:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fix initialization mistake for NBIO 7.7.0
Date: Tue, 12 Nov 2024 10:11:42 -0600
Message-ID: <20241112161142.28974-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3600ab9d-8661-4231-0a75-08dd0334e1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NKtGHoR10zSYKFG9JDVQc/clo2egXrOr3rToEdqIvD/aGB3ODFetYcopvhsp?=
 =?us-ascii?Q?NSs2/xbfl7KjFZego173DKSIthJmG8ESs3kOQqFQ1QzYyZ2KF0lrD506cwva?=
 =?us-ascii?Q?ojc6EpjmFTU0KdR59tY8SdmC8TnBgZbRJ9dBEvhGbIxGX5DS10H0jgkQET9K?=
 =?us-ascii?Q?42nkRsQq+0+EmwnS4obbU3s6tqVG8CZbyeGzpJshCrPzEksd2LLsq2K3yPMf?=
 =?us-ascii?Q?c++lFkK5vDjWDwn689arEzibaKArjUVZhkgLCrEBVVp8RRfbRs0m11AO3yHC?=
 =?us-ascii?Q?ok+KjmnGX8ei2BHoPVKW9krmXVAi4HhgyKz5wHKjzjIYKWDfujNHkFXiV8e+?=
 =?us-ascii?Q?yjgMlF4mhOBmtI9ZrToiAFDGHZnjWyPwulD3I5D764/x3Q/lUiWrZOYnQe+i?=
 =?us-ascii?Q?kWfKCg8g60BdpEZww7gfTxn6RYt3y2OkfIR7p+I8NN896YYjpjMkIcBAv0qO?=
 =?us-ascii?Q?wYGcmE4DfdaVPopAmV5eXbRjVCC2xhkkeXeZ8FsopL6nJD05D5duagsotcka?=
 =?us-ascii?Q?1SWxVElvMywx8341fRAqCJHO+akmM4QF3dZCFfIGBrkCVeo3azNCMzx2WS13?=
 =?us-ascii?Q?8/gR7rnSNaJ8FORHYNg7OENNIoDt9+2VHNGUUbcIREqO8rGxaBhSLOi9hNeO?=
 =?us-ascii?Q?v6A4qw58/uLCGiUCgJXjdyt0ZrpZHhoDyEmNQWrD1p863DHRXfSWUbEdr0Se?=
 =?us-ascii?Q?BYq1ar3QJtsNQw1Tvz1Gir81Xkh2V4ecWNrD0tigyruhRx6VKOXLgdz1m/6f?=
 =?us-ascii?Q?qnDU8yYU/Gtl0Iw2vZHnAkk+E1rCWuuX2lYxTOj74Jac5m1B4pR2tOmSBVkU?=
 =?us-ascii?Q?zgMudowBxbbgOKdoWwstXLExlSIvMqRxf+FyFfXpl7fXRnbQ18f01EUX+o4x?=
 =?us-ascii?Q?I0VDXQXUAwbG9ua7axtKkCG3/YlENOpKA1O/aKwIQeN7Bj8r+bnIn4OA5gJG?=
 =?us-ascii?Q?kEotEjx6HwJ0MqIDD5cYo7xu5aadee50hBOaSqTaWJ9qkvXb52dBkmyy2WEq?=
 =?us-ascii?Q?CfkLdwo/gqjejXcu1c1gfvYmVZUQF3IQdaVQYgLy46a8KRfIsuevg6FQb8CU?=
 =?us-ascii?Q?JgB1CLPPZw3IsUrp+hoL4LsiGTqS3jwHHdJdo2wsW7hbdoCQtJiwoY5oyNbN?=
 =?us-ascii?Q?qv+DKDMxC8PcbNPnY6ascGS1QFSqFGY8+knEVKMh8dDO0W0S4zg/uQ4VpOs7?=
 =?us-ascii?Q?UODu33DvDdG5YaA2n4W/YKdNoWaUsjiG0dnImP0mkZyhW+kLmExjNRxds1+A?=
 =?us-ascii?Q?0IXOSsdxQDFIla6zqvrOcALe3r69d0KZLngaSTtPrqxFSwRga8wPPbbaC75k?=
 =?us-ascii?Q?AoyLPG1HqZtCm4SIS2KFABOdxkRz4h70QD3lr4Al7k7zn1wOXCz8B1OmnTon?=
 =?us-ascii?Q?cZ+ya737YQVdcGFy5WBobVWDGB7yeX5uSeSmqKctT5WkI/Jg2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:13:01.5814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3600ab9d-8661-4231-0a75-08dd0334e1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

There is a strapping issue on NBIO 7.7.0 that can lead to spurious PME
events while in the D0 state.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index fb37e354a9d5..1ac730328516 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,6 +247,12 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
 
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 7, 0):
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~BIT(23);
+		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
+		break;
+	}
 }
 
 static void nbio_v7_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.34.1

