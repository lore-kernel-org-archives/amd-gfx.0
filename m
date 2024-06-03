Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C427AC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C62D10E334;
	Mon,  3 Jun 2024 08:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVIqogE5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F98110E334
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUWyte72YCn9bja0yYkjczksuXs0aK0Lf4nAbVs0P+hLN1VgTPtYftHYfY0IDOo5Meua6hWLAU7skfJTNFOSrIUWAfoIEHAnraJd17duveZE3xb1TZAIlGHuth9K0CllEcVDc30WZEvTGNQqKstw3UM3zFsosVxRCEgcwrHOx6MWcOJ0ki2oBJpQFhgRUVep3sqKP8J5E6Fsz2dAYAlcGSsAvDX3SdBWJms4lvt15XPVSukav1fBXmFoKB0X7qPipqg9KpeGSA48ifiX2VQWl/v7tB1jHwnQvGr4fIZqmM5o1o4C0Lyy5OWvGRmqxWQKyUOZBkJQPcCBJkAzmHIYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOC1OUFPuYtEX3yOozR8WzQZlMGlIQ6ego6h6f487WU=;
 b=JzWB/43TYs5TcWjsYWpF5/NzoUN/qIqn1oRiGTTDjTbftE1knVFFRdhSdMCffbF+taDEzKnWRsuboMk2L2PnIY5wysT132aKehsOenOq8FR1cQJM1SqhhVqozbm3klGQjFeKZJCmjbR8r6q54s+X4uTrjHi0/TwMwg+yox6pGI15yyzchaecohNyfclRkB6ewldg9+hmZYJFLTsy0+OmjfemO1rpGLKHb+RWygfMIWOeFAYKkhwqIbQFTIAPG6Z14+s540xYfC/cfRqb4jnThWTZgtYs0VUIMXqv4U2TSfh6BFbDOfFmXPGf8c9mWMzCNdymu691wYXlBUKEUuFk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOC1OUFPuYtEX3yOozR8WzQZlMGlIQ6ego6h6f487WU=;
 b=sVIqogE5giWtVvwwnONGqUwC+wpqtKw5JK88UM7gpkyrAZa6BjKje4jB3cjZcn/26VLDCnNXhaZ/uAGLQGZHG/gEg9Z5CY9w9MpwxhIWZEXyQMoehpIAEeMK3Z3+rSThhfj+LNjVZFbOtijMkfIjPCS1lD8wzgJKSMhoykOTWjE=
Received: from BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::24)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 08:50:14 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::93) by BL1P222CA0019.outlook.office365.com
 (2603:10b6:208:2c7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 08:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:50:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:50:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:50:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:50:06 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: remove dead code in si_program_aspm
Date: Mon, 3 Jun 2024 16:50:05 +0800
Message-ID: <20240603085005.2570360-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 511dd7be-790c-46ab-f6b3-08dc83aa2f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJStr7Rvyn6dNAYUI0hX900pDdJ6/pKs1YRkjuSGFWtJN1kab8MtMNY7r0Q2?=
 =?us-ascii?Q?A54eY5pFE6xR4r33w6oPq3Pj4tBZiJSu4v/mFK9A1oXWV9FQ+XxyJcP3YcQk?=
 =?us-ascii?Q?uk3ix62KUH5OQG21cOv1wvm541twHpA7y3+Kvvc4mnL69uDpJ35b8RMFutSH?=
 =?us-ascii?Q?+QOGGp51XU/fhx3eyPJPZTQUgMxDyUb3saqBdRCojVSC1ma+zY8kPGLxI5J9?=
 =?us-ascii?Q?03aQJchInf57YAf2qqUW6/nXTREA4jZ8A797pN1ETmhcN+qIEXDBBqAU3FDe?=
 =?us-ascii?Q?o0rXoEek5mpoLGSdJAvWK4KwFESHPEUphdPyB9Ya/X7eYMQAzlRZrVIRHSrF?=
 =?us-ascii?Q?C3mmqoxmKGMCDolWTzw//vh4PszET0UZriTjA9kdCkq2HIPMT190nlW0y6hp?=
 =?us-ascii?Q?9syrkrjjNZGQobTewVSER8tTdFulXBqc8H2FUKWvbBan7ciI8HvL50BoWcpo?=
 =?us-ascii?Q?J8ipZ4xNJtRcV2QVMMt9C/6twVbsr6RHA1kt5iFqGrCkCnlcKjtBSiTd32LI?=
 =?us-ascii?Q?nwqDSdR2m6V1n98fpzJwmQE49hyZH3ffNC6n6BZTh+fSDMI/9Tq4FdngERCy?=
 =?us-ascii?Q?sOfdcXyNRUca6Qo0O2bvMmEKsblRbFoXMjPnbRGUT+3bRrgIQ/1PtkFctWnT?=
 =?us-ascii?Q?XujjtRB4XR1aeL5DCNUnMDEFF7MDRx3wD1wOW/kPlWAI7pA3P1uJPVnBb+ro?=
 =?us-ascii?Q?ryALMW0/naKkvX+5vy8/PwWveOaoDgW/eNXzuZgRs2VofDqam/ZRcKmdfAK8?=
 =?us-ascii?Q?tkBD32C1jq0kzFd9vf76hQ9Rz2WCIn3sWbKiM+hb8IGina6+z3yuv6toXJzO?=
 =?us-ascii?Q?LGgf/9nMGe4KgsapYeUmNrbJVGwqSpczSkG+70HMQgSVjJICwwKS0feWGcg7?=
 =?us-ascii?Q?nuI3Ym1QS/OeaygIUCkWVb9GhPJmkqD2JMuHZTkHdzguk0ksHYXgoYT1Nw0o?=
 =?us-ascii?Q?5+DsTR7vlHXKiSJlijXmSuCtXLRzUuWa4vpNcOa0tBFBZePK59lu7nXkPpEl?=
 =?us-ascii?Q?V0G3QXADdQCzN9wv75M64Sx1Hm0Rk57GnmbEL1kQZVf+3DO+CV3vKu+mGhct?=
 =?us-ascii?Q?bhn1C3MuLN/bnEfHGHG5YH8HVdYJG/PtnervIJKKbGtGPBc8Aw/bL4BTl2Uc?=
 =?us-ascii?Q?O8RAUrbf226TYkF13TLnZtvlKE2EB+6D68Boq55yxNfmHomhqjyV92MGNkQE?=
 =?us-ascii?Q?rdTYQHhRPJOEpdnjLQfF5fJJQdxOj/zp3mGsubeIi0QNT7jaoebk1Z0mMLwc?=
 =?us-ascii?Q?y7wMu5YGbF8cpsOBAMRaGImhfpaus0IxLjg10ScYuX/GE6BRnYkuwRo08mWC?=
 =?us-ascii?Q?huD5JVefZCwrxkubToL0tTBFAOvDvmzXGjB0KmMxSvZjC9gf38Qx6++8qlu6?=
 =?us-ascii?Q?BaoVEtz/jzMaDM36pewZksKvzBY1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:50:13.6618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511dd7be-790c-46ab-f6b3-08dc83aa2f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

The variable disable_l1 is false and execution cannot reach the else branch.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 85235470e872..d80eec275090 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2598,9 +2598,6 @@ static void si_program_aspm(struct amdgpu_device *adev)
 					WREG32(SPLL_CNTL_MODE, data);
 			}
 		}
-	} else {
-		if (orig != data)
-			WREG32_PCIE_PORT(PCIE_LC_CNTL, data);
 	}
 
 	orig = data = RREG32_PCIE(PCIE_CNTL2);
-- 
2.25.1

