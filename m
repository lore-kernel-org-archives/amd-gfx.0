Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A03C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C6511A8D9;
	Fri, 26 Apr 2024 18:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3JPwskY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E05811A7E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPEhKHh120iS9XjQxjsBckl7cV1olleJt4UQzy6kUYKv/CgTu0oV9o9r0iHh2tNRccOv1ZrIlssb9VeYSW865Lh3qF0EceA+IG3XCOW6QRWVnSAk0E4DYomzlneZ1aSn+Ws3xCvq62AJhP2UB8PW3VZ3nN8xjLQv56eOnNoaH/gpx0JoyUSRZad8tEA5n9h6AQY3XKcUScKogBd6xN3SycNf6ZQ8Ctu4ZePDG+cvqN5flgJrbslET89OzU41DS0ej8rItw5NG4SnbOktkOet3IcYRct+giiF6FGE3Lwa3CM1djORw3md0YHorl42r2GuzxOPHwmSkL3yFoXWqihwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07Rp4EUQTX80Pjaj7ZWvdRev3hfhg8CyWCwgwL49a7o=;
 b=OCivQv8MKwer/Q/2sye5b9SCp+0xPwGj+Qp3vGPADuzoyByH2B1CrlMBECC9OG22edhwSFTMUsAtxntMdb9lZAOsiSfu66h6Ojl/7Dc6UrJ0ym/WDylHHfO58NjXEeNY/2XDjItqUN2bYLGoa1ANH+oVqzalfO3aGcK2C4C30rTJgqIFq9lnrY9xcDiaR3SEjbc+OHKUty3uwUo5FChxJVkLRX4AsbjWj0h1YVLjOrKPheCm0vgivjEINFfucC77ZsxGzf0mPeD2r9OcFjmI1h8wcjSKk+Epbqf/dV3PDA11qU9YjFTSfybkDR2DTZeWDf51xwJPe5JVr/W9dWbzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07Rp4EUQTX80Pjaj7ZWvdRev3hfhg8CyWCwgwL49a7o=;
 b=q3JPwskY5ip7yeySSTkVvvC7013gHulrjmfn0DlhaFJL0q0HmGGkbrdBORfjldaJHVu+061xOci/le2fe9h0+SBLvzQnlVcI5qF/h7TU4nTotyRYPqnDBQcioZ29NaK44xI+aKtfA/EitKi8CyRIcxpMJcSEuIoqndfVKLEBbek=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 18:50:39 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::8) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/discovery: add sdma v7_0 ip block
Date: Fri, 26 Apr 2024 14:50:17 -0400
Message-ID: <20240426185017.660146-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426185017.660146-1-alexander.deucher@amd.com>
References: <20240426185017.660146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: a17b4217-380d-4056-7d9b-08dc6621c458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hvk4I5GiQ77idLNLvS0DZ7D8ZjxJsmcsys4DQkw9EfXxtUWG5bagQjPbuC8w?=
 =?us-ascii?Q?O/LshrfUuVbk5NAIS4SmB21TA/umF0ZGbXg89ihSaiOVq3IgsFYx1gYSIrEq?=
 =?us-ascii?Q?eTeFthIZvOPU/IFes/b5mNYxZqHp/xx1CZRBuhEs5B2lsUbsnHfvKwX4TQPK?=
 =?us-ascii?Q?g1f9TN8nrMNmZ/DH2L55JKDa+/GbXkIySZ/VSAX5pa38v7Dg4aLExc5lgtT2?=
 =?us-ascii?Q?XlQM4p0fFG/s4bptOYfa2CymOJaV3uVPkdyM8L/F927Q6Sd1VGEg7WceCAQA?=
 =?us-ascii?Q?2ltpPLst2T2F0b0tqXNVhx2bbLVT5Erai40DPf6WUkhKIIgZFJkNaDEreL72?=
 =?us-ascii?Q?1n07bFbDLF3IWunZXOnFAfqfwmafGPwgTti8OOGoOUPhUfIUQCBtOLoHsX90?=
 =?us-ascii?Q?AlHwKuNgfbr184hVYhdI9vpnVfR9VTbiirONtLrYR6Nerc05TWQXeMXDSKvj?=
 =?us-ascii?Q?P1aNL1SR9vVe1m4jM6pLGakAHwXnmxd020fZBHEY9LaN21JNEDvsDCyrLTDZ?=
 =?us-ascii?Q?FRHmZ8KD6TwCSn05GC6hOS1qtHlGT5GmqISeSMRTgVOjHrsgdsD0Z0PeVzsn?=
 =?us-ascii?Q?4xhi48Y3KmjZznfaNLhTCHd0Ad4NFRfl7O35l5Wm1e1FXg/HHg+yJJ71R3IH?=
 =?us-ascii?Q?kTIUAwTGR+5fjkwQtO8NDvICzbcpIqlBIk0Eng0DlSmMRb68kwdW/hAQZOqC?=
 =?us-ascii?Q?tAwdka1GiQsN/VZC6D/eH9XBwHR+lx5BYYtCVC60jLeVwBfHB8Ci4nHvTDEL?=
 =?us-ascii?Q?yBCzsfbM0VoFHdLB9ceauUp49JQlY02+mdEbiE68ZnNM3zbhFfH6PYItwKVE?=
 =?us-ascii?Q?NCOtN17Gx0C5vGSfZTHLQk3SwynrIyS101NlL/q0ztmRMEoEW9FgLTMiwxcW?=
 =?us-ascii?Q?khz7tUmv++fl2KX5lKiM+YlvlVqph0lNpJd05xF/4uj9cfdoTcRXeQWOfBK9?=
 =?us-ascii?Q?+xt7iB1C7klDdsVQUuOY5uJ9H/RYaeUvuw15gTVr7ectrjdSzQrISDVqjmoX?=
 =?us-ascii?Q?Gg9MO8Eaz4rCkX4RH3xSCMWCqcqqNs1zGUpDss9noY7NuJLtqKeuy1q45F1B?=
 =?us-ascii?Q?QOBAuqAHIJNGBxrdE6tVfli77UtkVpN2kR++nBlV5+lMt3ytUUySYK+f8n75?=
 =?us-ascii?Q?yg3OSPJerLTEnxvaHytkFR2fUxVpbNeo24nzW1DoJ4Ob8EorFEud6M5gGLJs?=
 =?us-ascii?Q?UsrgPPDU5v9qVZTWMwPjQ3v3Ngj0fkaXI75kVa/4BkHMD3ME4cz7qvfsJok8?=
 =?us-ascii?Q?AkaXObolimVUXU2ZyoitCmhIYDJqT6+vVeW0RXKiYePrs7+VsrDxzcMaRkLK?=
 =?us-ascii?Q?VlU6d1w5SIEn756uUKBgDYrJHXNpUE/AC4G7ffiyvWBL/vM1jGptMG9O8xeE?=
 =?us-ascii?Q?3oiPatw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:39.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17b4217-380d-4056-7d9b-08dc6621c458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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

From: Likun Gao <Likun.Gao@amd.com>

Add sdma v7_0 ip block.

v2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 98d6915e955e..2aad1ba0ab9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -79,6 +79,7 @@
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
+#include "sdma_v7_0.h"
 #include "lsdma_v6_0.h"
 #include "lsdma_v7_0.h"
 #include "vcn_v2_0.h"
@@ -2084,6 +2085,10 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 1):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+		amdgpu_device_ip_block_add(adev, &sdma_v7_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
-- 
2.44.0

