Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E881C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BF510E54D;
	Wed, 19 Mar 2025 16:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HODWPPAb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B104010E54C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya7Oe9xGzhme3EaKfmDvloTupdjNFbc8xUTXHFiVh8+SfPwZWGoD+y+HcBdDX6mwUF4ZbmFLCn0AeBmYDnTazF7FkiNDWDrZzk/fhVSDeCe8Wgt8WAxLZgzzlDlnEJAsD4m0eafWUMls8YZFqJj4j241vB71jZiWp2XxY7gllFTdY+Dg24aHDzfH5oNl/aX4OQ/dRK0T2EceRyPifZdLzunxZbVHZeSVdkczEOEE1zrP2Ca8LOu1F/MdOAM5hI+eJlqRFneMiA4rhfJXaGGkKYg9DFt8Zi6t5HW+YDB13zbs3JPoGx6UGmUyOi+tVojdCF6CSvY39kANI7yrGcgJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1NclXlyR+GvvdwN7ZOwE4l0BC49HxsrL9DykoqhCxI=;
 b=wgdLmu5X3PtakyN+fAafwBdlEXLadWXNtgakT7tRbR9cxGJtuPsPwsCuhkSqlLpcOORIElT64JVChxVweoq+jGkB0MzZdB0vtnzryGcN5UAQsSXYdYnT6HfikrXPdVJGiOV+klb9FzsyR/sALFqAx01/YTelbLLcOqTXcTuytbL0Akz7M6GbS1ia/F/U4FoIZrKspNMi3XiLJeqvKx11lJWjMQbH/imMNn0bqA8roaHxLzZ7am6hSQKhD1SUsXF9HjY/atHJGwI8tRdEiVEmwgNqbp2PW9me5WloAOw2Ei9eo+P8nCjsgl4PAUdsISmbFyBa9S49ymXRnT+iaEvXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1NclXlyR+GvvdwN7ZOwE4l0BC49HxsrL9DykoqhCxI=;
 b=HODWPPAbQw2i57CHPmfj3ZiMPz9I4WjnDxalhfQURwIxBfF9uwYnmcMvjKf3+2lf4Y6WaFaGvZAciCC3DO57Zzw6qZ4pcOJEHoCeoItQq/CZWPdLDx1Qz4SyRBgC37FNXFW3VP4/viZoHCqcqspdLzVX77tjzqbX2GfGa6sxO/w=
Received: from CH2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:610:54::17)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:22:45 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::72) by CH2PR11CA0007.outlook.office365.com
 (2603:10b6:610:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx10: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:24 -0400
Message-ID: <20250319162225.3775315-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2846b688-0269-44bc-d0b5-08dd67024817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tOflFZ27xF8Nog1kFL2IDUlwnnNuWJdLg939LNJoxDqpqKJHn6HEwo5+DUXB?=
 =?us-ascii?Q?+EzEALUr2+MjZ3WtDeSWOVi48zkyz53mCo4GKSdogpeEKP8OA1mWpqVaOzmL?=
 =?us-ascii?Q?eTCTDXEidt4zbWAcrsE5eJh/VavWhGx/KNDMiNjtJeA215izvSTGkwN2a73y?=
 =?us-ascii?Q?D+9LbD8VvRW1xHOIUrwhMumCxxqL0uprTL/9YX22+GWsiiimk70m24A3A42U?=
 =?us-ascii?Q?3aJf3bj6lxmkTXmo1qjrirFqc3yWFGywSOnfWtEEhecW0dGhbjIj9IR3Egnc?=
 =?us-ascii?Q?WfKnhpSy4LgMr93iejCSG8+xAXLwONLdSYcoHm2VRDj1FdBFM2yk4Hhqxn4D?=
 =?us-ascii?Q?K5T0wsGYh5GUOdH9ONWziKsnDVxZ6i0YZ7908+oD7jwe4GjZ9QRqWZbL5L/1?=
 =?us-ascii?Q?+kG8F7KhY+4Y69dtMueg2kMYOYd9J3vB+myyYFVu7TqrqyRjsQ2Pc/3l9ABH?=
 =?us-ascii?Q?510Gfe/ygzJ0qfqrLwI39EQuk5msNPTdHO19XOrHwQQdNRvndg7jIK5E3Pxq?=
 =?us-ascii?Q?qf1Zpa6dL9/3NtOumV9X0RZN76l/H+2J21QtymFH3dcoqTNQwPeUSiobdq+3?=
 =?us-ascii?Q?xb3//dfVO/WCQG+AebSuKFXjokKKLJGqFhahxWyh5RBWknWFxLPvIzJkxnE7?=
 =?us-ascii?Q?NMJ6RYZCS4VVk6nf/mOWf63W95EeZdswqNhJxfCOCtJIbGJ+Z+TZKIPDdUmP?=
 =?us-ascii?Q?wwfYIdgl4VcL9MtpxOpPn0F0oNZRUvSOjgsnPRQjv934JX3XTCzdiSDA98vG?=
 =?us-ascii?Q?sMXgOTODcUUeAGiwn2w3dEqUBt3uH+vxhZsnhRhoP2txrlalBu/3NCq14dK0?=
 =?us-ascii?Q?40UwRlPHK/RqSI783/kFP44TYFp6CUOXAyyvuCiFRxHKtZucgWk2XgXolJa0?=
 =?us-ascii?Q?CQvjq8TJKMfuR1NPmPGiD5ZjJK5Z07KKwwtPomgiWds56dg5qjx7gFRtsw1D?=
 =?us-ascii?Q?i3ukrhsrN9PBSIrkt3pcPt9jOzxGLPeEBu7DT3V2dC/MWrUYnE6TMq+ARUed?=
 =?us-ascii?Q?2szfb4XfZcBNOmqw8tKLshtmNrx1L3eIPZZzdMwClWF+IIhdGYkI9GDXlWC9?=
 =?us-ascii?Q?PsTYhh+0CBX3oXl7TKHlmjkYwogRzjxV3Htc5+mXvRJSL/PGSFyfe3bnXlqW?=
 =?us-ascii?Q?FNR4M0xG9sBF/rp/bvWmbKKsii50P8kSl3RLfTkg3JZm0F5WqcqZTT3A4IAm?=
 =?us-ascii?Q?u7+S6mH0MXao0177QB4wa2Fk0+5SY762UsELXGOVrApUwN/a2rjXAGMPyqGU?=
 =?us-ascii?Q?f3mGDKb//LjKK9HvIut193rKUhSE1xXu15ZJvv2rmwMRRDTia5Pr8GZgIhmj?=
 =?us-ascii?Q?6u7pop0PEYSBVPhdkLQfx7c9enp9+HqeOXthgOq/BwGJAQT/y+FXCpb87W03?=
 =?us-ascii?Q?d5ZnBkbksqzdLs/GvyXlmd/7sqYvOOqG7bbJ3FtpSCQDdgx0qZ+UGg5vs4J8?=
 =?us-ascii?Q?ul3Eo0ebt+n7BXMd41KiUnTiC0WyZCP5WPxxQpQNRuENuNMyTLWBo8RXwJIJ?=
 =?us-ascii?Q?gvrBPisMYt2hoVM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:45.2969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2846b688-0269-44bc-d0b5-08dd67024817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a63ce747863f1..a1e3bb43babcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4322,8 +4322,6 @@ static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

