Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEFDC25B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 17:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8A310E0E2;
	Wed, 22 May 2024 17:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egYq0Kfl";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A9010E18B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 17:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ4zoGd0EfAbxBZ2SnkMHWExmY+5xJlL5gTyurPK4Br1kK09JmJFYUq1bgubrpKprARDkbnOBeMIq6i93kINwlthAbpaKgyJelj8gH33VJ/hyBCmEjSgia0R8I0NnPUuv4FrPIFI4//u186R78EN9+fLWqyrit0/yP7bgSeAntewFXJ25B0I4XwHc1uih40DKIbYVRKxFvZDc7j1B1oItMaCVukJRX3wFXybAYymXrw4M5zX5lXxkvb9bqGBubC8KVoGPUsbNP/KGoJXuPjioZ0N/AiK4z1YhRfQFfZE0bLj4oiFArjkDf07QequvwISs8npMfnu/siO7n6YB15J8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXU/S++Bfs1+bFKRRiv4aIC/gaXlwo2CyQvt3KzhEsg=;
 b=Viav9vQDn8U+tJNpx8QJ1TYJieJ1RcTHhSufE3yvn9cNX7pMhJupvJvByJtyoEIh0t4rdtSDID06W0o/LGHMUiq2kwr1UqFm5XVcZoeYyI+AE49/TUNBitC/K0xgJfCdjb9zT6if+JH28QARsvxoT2MA0qujoUpyUpS2qMXbIRT/JB5M/bwarB8/VGWXld7dhLkmXxJBqOVIOxVkowYxFs3UA2/jfPhRaaUIGQJzP7YfKXAcTBD1qgr4mZ/5zGK0B4TkUCZJssEZDEhKkaI2tsLDnCm0DqfpsypbqjwqK90ni1AAWW6B7EP4PfBUT313RUQ+CtPh8JbrpWp9R3COsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXU/S++Bfs1+bFKRRiv4aIC/gaXlwo2CyQvt3KzhEsg=;
 b=egYq0KflrBrECrld+OJ9/E2fvquu2Hn2V4fi/DyblzPpIhDW1j50bGZpddpWpClHgQOX36spEk//1VyKpsaUvsrOk2Jarou7pgf4+By6buq+HwiXdkNVYqLZ7fvqYsmpBckGV2qJi5ei6f3uQY8ICYBmdPyYi1uPRR/iIe92rQ0=
Received: from CH0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:b0::16)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 17:27:58 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::d2) by CH0PR03CA0011.outlook.office365.com
 (2603:10b6:610:b0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Wed, 22 May 2024 17:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 17:27:58 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 12:27:57 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: use helper in amdgpu_gart_unbind
Date: Wed, 22 May 2024 13:27:19 -0400
Message-ID: <20240522172721.14085-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522172721.14085-1-Yunxiang.Li@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f649ba8-0adc-4912-c294-08dc7a8485f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oWmIpRKNF4GYplpjgdBb7q20XKQ28QRJM0yl4liaHWY25wfElnvfyC0iCGWK?=
 =?us-ascii?Q?YsO2SGyzddQhkpGhucAQha/ZO8hiJdFOC8eLO6riphUAUcq61IRTzL3qbnWt?=
 =?us-ascii?Q?fosla9csvgvyPNs8CXSVtqBxFfeevcxJnbvUSS94qZXp7Sk8K8OqPIs77xTE?=
 =?us-ascii?Q?Xno6ZodK9uvBq8YYEJX5nWo/cORgwiIYwe3loPOKR1za0lUAZfCsv4f9Qylh?=
 =?us-ascii?Q?Bo+IVTDtdSaO3wSyXPlm5Jxf6VBSrzLjMXzDjkbenlv0sZGLKIHOl7tlDqAu?=
 =?us-ascii?Q?Tus49i/GxzJKLdxdxFSqIAbQa4tW4yrRjk6FnJ51KAp17+EjnqDMm3MG7LTH?=
 =?us-ascii?Q?X3hC4t/GS3v4oZ1MgyK+upjQjDcrk9huHviOHPQVsSUEDUfnpSIwNl88DeQ4?=
 =?us-ascii?Q?E6U1sDScyqpm0oxAKzlTBSyTILYetLr7aydgCBA+jFzDO7eWf4c4sExhgkDy?=
 =?us-ascii?Q?E1lLQzuQGIVi1OK46nnUABvKGhIM/Zs1qEipPtflnpboscOg+8omyFHgW/4T?=
 =?us-ascii?Q?DmOehXh3h6r5ghziCth3yruubbjOs+AoNIejKrhs1MpPtFs1d3exRrq57X3c?=
 =?us-ascii?Q?9yvslBgK7AkcFO7csppkmqNlxw6ZMIMskZx+yXqaERoJYrZQ6WTte7g9o2Gp?=
 =?us-ascii?Q?OtJrTgpCx/kRu9m+7VGCrFzwiBCKeC9jnIcG4Vc5oTsLqywNrk3pbDqGcIls?=
 =?us-ascii?Q?clI49aNVuVZvw1L3wxxmC9XsXo5oIl409rzouWgJFgq7Fh4EMCuq094G/YSa?=
 =?us-ascii?Q?6GpztIFKNx7HYpGgovGvFeQzbKVLsn3NdkkreTmYrfnLsuhcbnZf63hVXNvp?=
 =?us-ascii?Q?TLWWg3uBIsUxBY6opbPAWlrEPbr3EOG/E/LFdV2Q3/HygSMxTrfTckx9XA6D?=
 =?us-ascii?Q?NUZyjOw4pYqfkOruRJtpC/u948iaHu9S+kzoAb6tS2wfwNDfaySSDQv0EDLW?=
 =?us-ascii?Q?LhrTyp9Cb/JymQiXBNFdkcGoZCITm6cULr2Ks3vDFu795E0HpUbVnnqQXjQS?=
 =?us-ascii?Q?i9CYntnTkbDGm1zgW5qLr7eKpdD52I9ay9Yp+zn61o8JiaD6B+edbBk3BrZu?=
 =?us-ascii?Q?//eSqE9NIKjfrrnjToAb0fxXhn6E4dQP72Wnx58aneEOFT+eztvfW2oAgdlr?=
 =?us-ascii?Q?wR2osmvtcpQFFglj+kYeHSzHD0aC0KnCuZJo/mWzzUnNFWv+pzE/J+JGzo0e?=
 =?us-ascii?Q?pz6w0kQUl44zq6FZd7V0Bes/Glr27n5OBRetlLQY9CrOmGxrq1X2/8kzP5Q4?=
 =?us-ascii?Q?WiYblJJtSKwvxGYM9izJ+RjAg+VAvKW2Cr3VtFjGLnNAy8jnEOkA5KkcbHi2?=
 =?us-ascii?Q?JL9kGh774cokZR9/JgCX2O4iTrJa9q8NKyI6j6cALr3EDhnDjeOpBdTDIVNA?=
 =?us-ascii?Q?rcXzbGYZhfbAJ3+wI8TQ7bSaqsIJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:27:58.0628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f649ba8-0adc-4912-c294-08dc7a8485f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

When amdgpu_gart_invalidate_tlb helper is introduced this part was left
out of the conversion. Avoid the code duplication here.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c623e23049d1..eb172388d99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -325,10 +325,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
-	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	amdgpu_gart_invalidate_tlb(adev);
 
 	drm_dev_exit(idx);
 }
-- 
2.34.1

