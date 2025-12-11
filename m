Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D313D3E793
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3B10E0B4;
	Thu, 11 Dec 2025 05:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+uwUb0E";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B6D10E0B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0faM7dNYDzGunZABzDZ0nUK0jcoeAQe9qkYMq+zFEYxpgFvQu3ZiZ78FRQASHDXBNqS8ZW+nSAc2TNlHx16StR/wwuHyN5ZhBNaSwHj31txqDVnjUCLMdsPJQqJYLONj97EZpPxjCA+4tkPOoDAnrZLSIDPoWIteVT859NGS6G55vxrhx6bDY5l9X6ODOc/auGflEq4UZa8SVKGpt5U/h3c4S1ZBlmIWOYeTD9NrVGARFJ2sBQfweNHuGDK3Ojqja5VaRc8FpMo1LVnX9rkBJN0tkbdOQr2Luha4weO52FQYhjwNFhEX7TOw3KL/VeMnPWob7K52Ns8qaNJst29NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBHC5GY+xt3cdNoVOuF0zl1iWNTq61IP45xgEQSI7/U=;
 b=GNd4l5bk91hdUxn173Ra4FE8olYKl9oqlSL2I28g6rLHpksFflJHwA1MiNlY2zLJiCF6R23zlD2GF988E9XMA5WKEdbdzAgliiEf1l547A/EIZqUCD0Sy+5kip2RgpvowB93RqnhJu9LC5B/sGgZ/jVc180zUzeCd8Mjc9z+6bS0OQ3LPZ0Vny3Uko/ch4Eguh54L1jlbVvW0iic/H85Kue7fJtQyLPbtosWGDuNMGPSVtmr/tvzsZ9ekAjobGWi+6YZU6osowv6Ud0z5nVEh6myEBVVdPmmWIgNQGMaNdTQhI0r0PAGL9jfNLR3vQiv2fFkun7qNIjfWARZP2R/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBHC5GY+xt3cdNoVOuF0zl1iWNTq61IP45xgEQSI7/U=;
 b=h+uwUb0Ei6TB8SbrnKREU0P40PH1wHeTg7n+PAaxHq+g1q5xPvNqwRvV7Lye7G0OALP7RyEN30kAEWUHebmhLcBxKJqBbrsndpzOxlPR4b19F9FR79jJm+ZI9L8HbbGe+3bUjQNEaztgGA9lRf7UwhomjxxWovQPhJI8bi8TtpA=
Received: from BN9PR03CA0082.namprd03.prod.outlook.com (2603:10b6:408:fc::27)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Thu, 11 Dec 2025 05:16:47 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::ad) by BN9PR03CA0082.outlook.office365.com
 (2603:10b6:408:fc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 05:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:16:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:16:46 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
Date: Thu, 11 Dec 2025 13:16:35 +0800
Message-ID: <20251211051635.652412-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d16e86-1e8c-46ea-613e-08de38747ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?heTwK7Y9NK9q9jx9Zlua5PFRMtLEEn4oCxfvZF1XyPHOzU5YS4PljwbP0kAA?=
 =?us-ascii?Q?oKIG423K2VltIWHaeCwZABmiCSMFuUJfCubjzT3Ixa8TJzSjxLUvI7ChFkdo?=
 =?us-ascii?Q?2o1yP+nSaA7ncI+v61/BVhbraw44OPl/zUNwngmbyT/gAA/oOcHTzi17be/+?=
 =?us-ascii?Q?BpiZMaSwYcykLyVCvAQ5BdfiudxcRe75bPXtnNoTlgLJF7HTSjt68qRWDqdQ?=
 =?us-ascii?Q?MfCsXCZl3o67zdqp0KzkivFWQva2IvTM7yCYvg41BK82gW4xkbnG0R34/1Nz?=
 =?us-ascii?Q?+H8Ro66t3oadRpsnXpwHVG0nVlhAyRYgkxi6KqdkTzeaMTlgRDp0/umNbo7U?=
 =?us-ascii?Q?/s+TcnExiQx7sVwlSsInV8xh6GX1xaPGo+GZCeUaPBdBdY5+kUVZa9jrjnSz?=
 =?us-ascii?Q?enPemNzO+aeR/FBVTnJu3/Wn9nH8pKuJg/VsL1+LO9YsHipAV7Np8COtPxfo?=
 =?us-ascii?Q?9qVBny+xYMLn5U0RjSQCJze0NWxwHkC+ZSxqBwr0g95fjvJZpLdLK3dkvaRu?=
 =?us-ascii?Q?XeTyRn2FRfuBgXLgg1QBcAY/MiLVBSR3oA9cska1F6beaSwa/P7FYt5fZ54J?=
 =?us-ascii?Q?0yeafY+zwUEgAK8lPTw8eYThHqH/pG9OOlNePUTPMCobuctHsUPNvzH86hzq?=
 =?us-ascii?Q?wH8k/frrSYqEKGIdKIFf6k+HUZNBQGSyc7xR6933QIzHfaMjbvcns3ctWp46?=
 =?us-ascii?Q?GI/lm+URBk2oMcucmCj8KUl6qKguNB/X1cKqnFg/ZLwC5EPUUl1qg0fqJhvq?=
 =?us-ascii?Q?vWZjgzKKoSquVH720Z7wFHU1aTjRL5WA1UPCJaHzX2UWyLdQcfZQshWpd4uf?=
 =?us-ascii?Q?pCtHlxUOs7h76FVqSYxsIU4NnIaC3evfpIGVzmJBFllcXtx9RzBl0PCDChLf?=
 =?us-ascii?Q?ZeEPo34HIntlhRskW5SWgHNO3ZKFGbQ8vb40npNwJWnkHB3BFxhcfmjQJJzK?=
 =?us-ascii?Q?BNLbZ7jO6CAEhFh+mch61DEa/gvrfnr+vSdj2fu6/AJkBcPunyBBVWsAiiko?=
 =?us-ascii?Q?p7DJrQX7UX6UL+ZXtVJbatEMFXQXc6t0IUvwRhBVKmOOjE5PUHAmYPutRGVK?=
 =?us-ascii?Q?RmRLFI20f3vKeIBMrSqzYQ6m+sOpyfCpoJs1vJpB4WNyklX28nq3IToQMtWz?=
 =?us-ascii?Q?uHWbjH9hNTS6GVX+MhlxXd4LeAR7m6ZMy0Y6a3K3HqHqDAQ10x4iOV6eOWQg?=
 =?us-ascii?Q?q4d7Ol/3OOPsQr8Z8+z46CPVlqWVbXjP0MmCHP6R+n7J6NMWVn39AKy1wwvE?=
 =?us-ascii?Q?aTyxYPHZ9h99iwQMR2G2HS1nMw/n5rFHt+7I0upAQf0UVeQxqULJaOd1TvZA?=
 =?us-ascii?Q?G++sNP9Tph+L+1brxiWtNMplLEhsP7KWG79LmW7MDp6tz566MjeSkZ3uunfK?=
 =?us-ascii?Q?5GEbmwOl01zPR9lo0bni8yFNHBTOMkY1H1qcmNUKIOLmpO99ZbyHBlq1Rdbi?=
 =?us-ascii?Q?5NW6UOJTQcDM0cCdGzYssPqKOnDeE+NBu9ZkmeUreXYesudvSQS+YwXOVkMB?=
 =?us-ascii?Q?Nicu2I4VSSjPPSSgu3po60JxMj67KQtQ17lJkDhPZHztPquJy2qUVZ+IFtxx?=
 =?us-ascii?Q?kiLWxwXHD7jvYIaxnKI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:16:47.4794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d16e86-1e8c-46ea-613e-08de38747ba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

fix wrong pcie dpm parameter on navi10

Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 882830770b79..0c26fe6fb949 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 									pptable->PcieLaneCount[i] > pcie_width_cap ?
 									pcie_width_cap : pptable->PcieLaneCount[i];
 			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= pcie_gen_cap << 8;
-			smu_pcie_arg |= pcie_width_cap;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 							SMU_MSG_OverridePcieParameters,
 							smu_pcie_arg,
-- 
2.34.1

