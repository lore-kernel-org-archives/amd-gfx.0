Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB3C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B51C10E273;
	Tue,  2 Jul 2024 14:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgLtUGHV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1470610E273
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 14:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgfjBtr7gUYWHUoU4Yj8QII0KpLy0FW9AWEcA4jqvQDRDjNvQrxE0jO50svW32EHmIhtOTIX5N9JiCmiGqQkUdInRCwVNuz0i+NnI5IA/zdmxOr1M64OnQLqEMQPo0JRsdLlk9i9CxGE1fz3/BGGtS9v25WabUU7pKXDVsh/e0BXOgwzqDs+0odreMJcieOJ1Q5bU1yJkmAN1S04sX3/wW98pF+MhkvzQBgwMBECZgOsFLVdM9w/apvGBXhllUurpqAUb7moFbL2zXTmf8sepATUe/kQPFMJ9NXl4DrYFKXmuNhYvCT0rVNid06OKmZn4TitD9EPAWWRtYrItc0ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSGfJCjzKAv3SRSJQKkHgRYPSdv0boyopGratPMHf8g=;
 b=l2WIxLxvGqKIz+i0rUluQ9It/l+UwYmQkwT2aj1hVYehKkj+qW55qCCQWGth9Wmd17DjycM3zNfd6rsfKnVA5XKpjZEg47QZw9EThv2RrYyYHp4yQ4fhE97MiwnqUlFSm/TaJMF6Z+KFFf23Rs9vVF9YIrRgYLrM87q3WSX15aZX55Aocc0HDnLqsi4aoXpBFUWFGwli49l/PlPjZCEYKd3bX8VZklLf4AMROK4otoMXgIOLPiQe1kFeaYre0d8oSq3PMTQSx0GUtpNiOJtAldjNi3gEfdfwVu9uNkyL6Y1DlWBQCtu42TRviwLXBNf9qUQ8GIuk+Rdr+J5jTbiniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGfJCjzKAv3SRSJQKkHgRYPSdv0boyopGratPMHf8g=;
 b=fgLtUGHV4u3RTcpiR8eEohzptSCQHKG7FJu7Zl823/bSaLjj019K0ClSL++zcSoBw3b5p1Y/e+ExBN2SYJGYc6ejUZJ7XWQOh+15jEr+OjAWQhBztMI7OtFn3DFlL8BRI0p/OK28kZ0IW+f7B94+V3XHlbpwU8I6MPSU/+WOda8=
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 14:28:48 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::be) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 14:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 14:28:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 09:28:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] Reapply "drm/amdgpu/gfx11: enable gfx pipe1 hardware
 support"
Date: Tue, 2 Jul 2024 10:28:29 -0400
Message-ID: <20240702142829.705019-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142829.705019-1-alexander.deucher@amd.com>
References: <20240702142829.705019-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfe212c-988e-4cfb-040b-08dc9aa34988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3yLfJ4plI0035fKtLo1nTqXryMqjr/njhRr9g9Boun4GjZZkd0uThNpd/JP?=
 =?us-ascii?Q?xPOa9bDXhBWkYJMRy/NmtKrq9Gvk3wndsp/fy2n8v9mpnAA/++1JrKPZ+nS/?=
 =?us-ascii?Q?Wl3a5zr+NxJB5HKg2LQsevq7w2yISOXkgSTEiLVDG+byx9E248Jk6tfFz7jb?=
 =?us-ascii?Q?Hg1aOFbITaLbvPCEungiDoAaDJTGIxRN/DWADjZgWFTH+Q+cvkvkqcRPqzi/?=
 =?us-ascii?Q?Xuh+tV9tLc3Y3JQ2/9qH/lj4cVWmtDsCzUfm1qe953TCjBQUMFuYPQh3fU6R?=
 =?us-ascii?Q?BSn9UzTk7IrY3hNL1uf64C0uGk+3ct7VDDOqsH8GAfJN6uLmI9UGJlOqr8hE?=
 =?us-ascii?Q?sM5kXNQPugsgJk4AcooY+6alaFDSbKdLJ/WDvNkD8412Mg1iMzoRuyP+X28c?=
 =?us-ascii?Q?HgYZDhKxICRTzn/ZV7uHbcAUoPTJ8AN/38xy4C5FbUXFbQTE4q71wm5WaXEM?=
 =?us-ascii?Q?fkR0oc3Pz4HnKw414k3ii80wrH6AFs7eE+CWnUMR0CFQ/925xXjvg6W/IJUt?=
 =?us-ascii?Q?QPZ1c5Y3TuqdjmXwf+7nQwgqsDwZ9tVw+w1XSlZQ6od/ykdn/ml4OqD+UlWs?=
 =?us-ascii?Q?YlogePy27oeMRiogJaPcycsQcNB7IkrrZQdWKfHUcqTrAGzv5Tv7A7AqDjG8?=
 =?us-ascii?Q?bIz36WU1TMPA0P07l654V413s3sPW7qOQGRBaYwUpcZzNxHoycELpib2GZdF?=
 =?us-ascii?Q?G/czSrN+dDSbshp4fvRe71mrCk2SAVVamP4qn3r/v/DyZsd1Yd4O0FmDPqOq?=
 =?us-ascii?Q?OljMzBAZAJBTD62LpVdfqAb4u2+HvUIk2ZkXP85TAKkWBrSEoh1UkH8RAg2n?=
 =?us-ascii?Q?mN/hV8VKzaKVDJu/rKPmXHOJmcAisCzma0Qxpb2qL6uyBhnJlDnxWPJd/By0?=
 =?us-ascii?Q?VHp+mB+U1QhaEILpCkqdQ0uoeKG8CYI3ER1Q/dpJtc8Xpgts1xgjSVa2frDl?=
 =?us-ascii?Q?Ec9g/X2ZFpz/3L3lXqsakA31xOUJzLXK/LUbtlN5fEpSwN5u3Tpe4as7vj/x?=
 =?us-ascii?Q?mMHhHBF/IRV2jzBCsphAOtAFuwjXl+WtN6G7Dnf+t/6zpsR1t547dcngLHOR?=
 =?us-ascii?Q?Wiy54W+O7LnlEbVoczMpBs6Gqah49UhFRJvn5juEWPOWuaIWJTYR3k/3orC4?=
 =?us-ascii?Q?BPUvGvDm4Q325Lgfw+MZvvREowoKodOScXJZBcWFU/Rl2a4OCKcNFQei0IqH?=
 =?us-ascii?Q?y5/+RKdlknJTRda6C7Eqg4sT8jX2qXrN1XbTrVEsMuBydkCFJnPr9fG6JPO5?=
 =?us-ascii?Q?uAk7Z94QxmEzWJrgAknvPJv8JyDtnqbfSBunUtSm3QAAw+HXsHmsudYGw6Bj?=
 =?us-ascii?Q?WhtiyFfAWMPJGRZV1EuT86N069/+jxVBwydGXkyOAHQGWMr1/5kKr3BVr/be?=
 =?us-ascii?Q?BEV93Z3iT5/crEl7oZoRDX1gM5rxAMeJeJb6CWzDLRpPQ3qINag7qcipOhwZ?=
 =?us-ascii?Q?mv38SFUXiWi64Z9FkkNevyAhF5xiKYVz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:28:48.2046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfe212c-988e-4cfb-040b-08dc9aa34988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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

This reverts commit 28ebbdd7677d84d6d25ccff40ea6e9f01c2c8c7d.

Let's see if this works with the gfx pipe1 interrupts fixed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b686a37a9fee..7d9b9dbdaf20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,7 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
-#define GFX11_NUM_GFX_RINGS		1
+#define GFX11_NUM_GFX_RINGS		2
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1524,7 +1524,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -1535,7 +1535,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.45.2

