Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F583E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 14:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119010E012;
	Wed, 18 Dec 2024 14:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ew9tjPA1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C8B10E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 14:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvwYcGt8+puZLHy5tkGlvVLICAzcBurn/y0I3E+d2HtkINKj8P6b3kQkwGpuBtmj1cs06KGUnNX5RQhFEFNlEXx4Gm3XeiI9AfbLCN7gGvSNfi+Rol1vTHtKma/iFFMAGMIBOSLf9KHmhik/Xgj9lgeI6vFehuQsCS9w4ymafULioL0OJl/y/MloEW81ScXy1YYT6gXeb8pCG3S2Ifn6vbYmv6sBT+Nw1uSxlj/4WWFfFygLdu0uQRpi4MrvFMdaHZhjO/JFMwtGqZfO+Ht6MpPww0LhzeQKXreuQRWhg+02K+gfrgHlHzeugqWi0Wq9tlKUV9xqiNxqWlYEP8+MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKaFU7CcXOHsLiCtoa6HzT4/RI+jU9+UgEnELNjE0bk=;
 b=gKgTFrgZjokxmgjfVYj1mIh671290n82LFsLiI/ZD3L+U0MDuynXBuWJQp1AxY2DClA4vXVv+X8pyEOK4trpF8Wnb4Cww38BgoP07AE/1ospLWwtXhsew8y1w73+61FitPLSIEoaWmuLRavqR8BmEJPppyu6GRKC95WAp4nzLFeXBPMqhRuM7rHQhaR1DTAmXmfJe3XoBs4ren3ZCmkNGJ6WJC/6g6y8XRFuYGhh906AJeqZGKD+lLbbc+kCIZI3VkL0FjH1Ut2qzEMKEP5y4AHEwD6mBX5CI5hFzlHRJuVIXiHsKbh4XIqWlWOpfuW6G4GuIvWxr2sYn8bsVCnInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKaFU7CcXOHsLiCtoa6HzT4/RI+jU9+UgEnELNjE0bk=;
 b=ew9tjPA1Xki5UIL1acCjZ9afkY5gy2vKEk4HaYGRCPtYsAOUK1XJWmzosCMiw0+kMu0ZWOd1aMHnBJSxkXDQrRTeOP9zVZac+pBJZYN9ynf9auD6DcyvEEe0mJN8DwkYjFXJy/bhijoF0w5CCIgn/t4HJAGBb+rysNWfRX5zjUE=
Received: from PH7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:510:339::9)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 14:23:38 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::95) by PH7PR03CA0007.outlook.office365.com
 (2603:10b6:510:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 14:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 14:23:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 08:23:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] Partially revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Wed, 18 Dec 2024 09:23:23 -0500
Message-ID: <20241218142323.937038-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: b9586ead-7e78-46ca-b7b1-08dd1f6f9035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ov4m4lZLemayLEq9dITqEYPY1QNl4gyXDdGAoeMITEFOmNwUZKJiWeNg4165?=
 =?us-ascii?Q?CxFURMO8dvHdpFsZWf8xOsJHbDtVqeFzN+OSvqi93ug3DBDtFtK2YW1/5cko?=
 =?us-ascii?Q?aKCF2Iin3uwz8wP0R0fQGdZr32j0bLOh4XdQx4K6gHhxhUkSBq/hXdMikIa1?=
 =?us-ascii?Q?7r2aH0V1McFQqu9ee21KbFHpx5sRMsqYh3G95ui7zj0Mz2umroBfxjsooeka?=
 =?us-ascii?Q?uOwR3Zc3E9a1pjAdZazTNI5viMVcyZjOELCFICPY3LpMf+Zak8WCQskTwFJo?=
 =?us-ascii?Q?EJJjCCiDMTgeTibm7p/YYZKeu1uEKupVhvTUGc4aBPB4o29VIr3oT4EGo0sf?=
 =?us-ascii?Q?5wBeETpFQgAD2Nu7HPNoQNBh683DGh26xr6ICRm0cKf7BO7hFAHfFsbxaKCy?=
 =?us-ascii?Q?/ywODTmJk3vnyG8BFWC4FNd2sKklwAvLHhv0XIh+ISu3WIfKeWLxHUroGhVq?=
 =?us-ascii?Q?dgK8RpBe3FgO4YFCDvR1JRcuXPZdYGTOdISDI6u4DzrJfqXJWdrOCwmy93Fh?=
 =?us-ascii?Q?xkaCiJ28e//xGpL2iXscrxe/L5izpyhTq+QJp3EWimmNFiAiBvYTczkAtNrm?=
 =?us-ascii?Q?SWmPpfmlryVeU3bLnGIn+nNrPXLs+YC3Opmp3SkY/u01yJGrbIaLki+fQ75N?=
 =?us-ascii?Q?pjB1wpCcH94+SirVcOLhqIhsLznh3+zz3cHdR7MaW2Vlo/NPx1mN+E3LYSX+?=
 =?us-ascii?Q?XwK46PZaqATSizLEw9wC8mZMiF/I+LhN9JCZi+Rsev8HHSyU2fWYObJ8Vzdf?=
 =?us-ascii?Q?hlXwmrxt+MIP2pHkIeFYs+A+vbSausj5yiySAIBqYt+Qi6s77pKshTBxpmpC?=
 =?us-ascii?Q?RZYki2wxW7iNuefEkmxQIupgGtJlLXENfODw9j3rvNCTRBffnhgukGKMw2ec?=
 =?us-ascii?Q?G+4++HYaTZY7gdDLAHYqct4ecvOtOR/jl7EqxGrxQxeEBuFOvgcBx82ljKif?=
 =?us-ascii?Q?7iFi5Ib0umTW0FAalDmXOi3UxIqZlOlRO61s7+JnZSMm0EWXqEbEQvPcBqPI?=
 =?us-ascii?Q?EjzcqmsLbIo+FirqaIiMlfeXYvJuYTTRRO/JUgaKo62s1IJuTWDGxTx9vHjZ?=
 =?us-ascii?Q?nCTAwNgUifBDVc0+UwsvGinKxk8PXTCpydiPd8aaCxB6WxVYSQFfgS5e0Pcm?=
 =?us-ascii?Q?uioJ0rolM2qk2+UqaBUZdlc42w4Ekq0k4PAUm+s02nsuGPbEdW6Da3izd3Kx?=
 =?us-ascii?Q?nFSFlDX+vlM6uwwg4Zx3BQgCahUa0W9oLaBGLJG1+jJ0bj9wZ+/Ia0iAbqoo?=
 =?us-ascii?Q?w5dWfUZtL3V96j5HYgobbUfYuGLLHxql1S7KCVssTWx/cEfcjY13cz2qAi2y?=
 =?us-ascii?Q?R3EM3B1wCGDX6wGehoKFZG6w3GyzFp2603ciyDb8ay7N1cCDdLaVay6lpZXQ?=
 =?us-ascii?Q?xls1i4jQcPlPJJA9SwgnAD6HVk5j9FsDwdiFPoHjSkLcg25THOIB+59X/mjk?=
 =?us-ascii?Q?0LEZkT0uWH0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:23:37.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9586ead-7e78-46ca-b7b1-08dd1f6f9035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

This partially reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.

A user reported stuttering under heavy gfx load with this commit.
I suspect it's due to the fact that the gfx contexts are shared
between the pipes so if there is alot of load on one pipe, we could
end up stalling waiting for a context.

That said, having both pipes is useful in some contexts and
this patch was actually enabled mainly to support some SR-IOV
use cases, so leave it enabled for SR-IOV.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9484f3b5a9b7b..727cb753e58f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4722,7 +4722,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		if (amdgpu_sriov_vf(adev))
+			adev->gfx.me.num_pipe_per_me = 2;
+		else
+			adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.47.1

