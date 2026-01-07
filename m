Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F848CFD65A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2380E10E645;
	Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9JPCJGj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7459410E638
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP6mxUDKxlGgM1VvBBwDRsyVTb0Gv3dEFVyofZdCE0tqXILmANQfo1oTYOU4QbNwtlSEn6awDiDqUy6X29fKfzc0T5seefZZZZQALnmvWDlBj12hz5wbka4wit8CzZb8TcpRlfqldfbu1/gs0wzJjC5ehM/l8Dp7S7m4Z25i+AexyMJ77KZpjPyA+mL0heoo+w18Rs7wazCcohrHLFtcpiU39QYL/+fCICg3O9K4qdTDpezC3n4pQ3f8+wls+Zi2pABoRV9ikYzySdYKX3t3KBJT5v81YQ0gP5JTLEksE66CTVR6WL7qFklQwWF/9kbWgssioe9oxLqsxLAnMcVdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ET1c6Fyl+fTh0GzBIGAAUFtP6ewzMaATmX4G6QWO3A=;
 b=iatjdUuXypU/NBGmkDwMl9CZx7MfgpZ3uOmi704fpS/hL6gANtLLGXu8oWamJvwZX5HbXk8K8/RGuDHc4k2NNz+MTIYzZkOzDknnGYkvZkv5ivDYRDkE1I1QZ3Xgmhrlq9VkUS3zDcoKwp8Nmxl7QLw20Y9YvVpEkDBCgpTh/Ibw/9AeU2CXkugash/VUFgKJdwUoGfyDdKvSHy17++gGv1V0wknLuYTEPzc/r+7CVOjBkkLIOT6kUZxzzYPblu/Si81l9wTa7SvaJw0UFIR5pduNwtOEuNPiFqh74QfiHMGpxLN2y2E78gkYugMTR4areMeG3Q2Q8PK/o89vpLJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ET1c6Fyl+fTh0GzBIGAAUFtP6ewzMaATmX4G6QWO3A=;
 b=C9JPCJGjpQrq0VsThmAF+tTxdqxtqD4IUJIwNHiwcF6+uB2ZKdeUJIItEj/ckhM8vDtAe6VR1p8jRHp7mcTVx7qSIeCcOpI8PMRBfxE//eLVrgRL164COMOxYhg5j+EJ2LNubA7jrSpPexWllvimgxuNVgJeMN9HGZBi2NaTkD8=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:17 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::93) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 15:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 07:58:11 -0800
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:11 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 21/21] drm/amd/display: Promote DC to 3.2.365
Date: Wed, 7 Jan 2026 10:48:13 -0500
Message-ID: <20260107155421.1999951-22-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5935c0-8b6a-4a93-2fcb-08de4e059288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zJrCbS9s4vxPFdq9bmMXoor53pWmkx84Gb3rCO4jNndkRyvmL1t1gwOEDHX9?=
 =?us-ascii?Q?Lfq/gRLd4ek/7bN5bEtz/U4fP4vwnqJvMQrCd2A3diL8sHj4c4rXmyRQd3Ux?=
 =?us-ascii?Q?pWkm/wdcqe7a1or1rmaBvaEHWkVostw49DbI/ib/bje8hj6iMPEq0t+XBIn6?=
 =?us-ascii?Q?HhoGkG7N0nOJ6zFGXYdVjIY8Lyo//Pwma+Cukg7hcYjuWUL8ZNZqcSTpjxWb?=
 =?us-ascii?Q?Eg6aKnrJkbPY8nTv4r2tg+T4DCPlw2g/REBLMfkWJi5ANksM5Cs1/cbVW7B3?=
 =?us-ascii?Q?QYAFlIa2lrnofcjbUleOEWoEDu9hW1hmkRvW5Sy9PWPTB34Xhg1kPynH2R9m?=
 =?us-ascii?Q?nvrHXUC/7QEpzQQXgFDASw04kv7QotQjP8ZVHwvg+6N6uouQGyV3i52bDcHZ?=
 =?us-ascii?Q?IWXrKuABQMFuKX6iR9GltSpL8H4oS5U+b32nHb25P8JXUl/0/89qCxaivyMr?=
 =?us-ascii?Q?nVv7ax3SAjiy6/TifIXMSFoF3NdbXL7aesJ/76SILA1PqmUf9TMGjRbu64tR?=
 =?us-ascii?Q?gc7dlsbi40XNdh4FUVOfuAjCMqc7XI3zC+JyCK7xuekFp7glEYk+w7dZANWK?=
 =?us-ascii?Q?4a12hfUEOCzFXiI8gApX6JTrg1nmzaB3UY3eZS8CrE4orZs0ETG1diU2hJQy?=
 =?us-ascii?Q?WObouqljch8xs9FkbdBpvKk+wIFBN39Q3UCRRxfbjMks8hJh9OKuKbF3ejyc?=
 =?us-ascii?Q?a5dHhqvSjnapTCm7sl+oO0Cw0pFQSZZFWoO/l8pKB53ofdsrdzyqUD55uw4H?=
 =?us-ascii?Q?MlYxOia1l0ZWc6ewl91jEfQY6bsfOgNyEVNmMHJnlLgLozs4Uk/E8KiZ2396?=
 =?us-ascii?Q?HMMOQUWZoKCH+v8Di7ZQHqYJz7JRnSTkREnf6Tz/bHVrlR9H44UA7lv4V19L?=
 =?us-ascii?Q?VQGYAI7k6dc9LXyDM/zdO3K9qz1IJMy4hYUJa2ARDbnuG82f331lJWfZ3KFW?=
 =?us-ascii?Q?s90R0soJjDZ0Aqbzz1cY8hTzjxrLEgEUnGEDP1EP+b/W7YCwk69+52m1ZE7T?=
 =?us-ascii?Q?iNxOwSdRjC7I8RuCtbOEHITVVWbavgBsMgPio+Cd+uazs81CU9mQ0WiJHNWm?=
 =?us-ascii?Q?XyG5pfqO9i/QjVdtmwf82zWbY9BvXjchNuhMRhlAPg9KDlLyRLSxVq2+TsrZ?=
 =?us-ascii?Q?vYG5YMia1IKB6B9dRMkcQpgcZ4696LVv2DPtFz5PHZCSOEkCbq8jytPAQXjb?=
 =?us-ascii?Q?FUrN15P5wTFppc30UuQaR6C/6r2rPyVhHtSbFkuUeJZ5wdhZvob8CsWmm/P2?=
 =?us-ascii?Q?jGPDt7Zm9FnGgj+glRumnjU4NdeeLF/A/QxUfk30Ju5QOndwIKndXLeNraH7?=
 =?us-ascii?Q?0njTuJMfSkmluz8NjYEjpMnMkx+qIte6mFHOTSCKKj9fOfY2nxuem322Bua6?=
 =?us-ascii?Q?rjWU3m8GvJ3hCV0MG2Q/6rQuQ/3GPpXzykxseI6MyZLxyccX3bUsSgZhGJPo?=
 =?us-ascii?Q?N0Klu88c6L1+heTOVg/R10Chd943+C1BL8cW+hZpzineVWqMpaic6Y0WcqAx?=
 =?us-ascii?Q?Kp0/C50jBDeYfY4U2ZEEouaNCoRD4U0q/MZRjLVUU9RP5ifjHwpIClwCz4s9?=
 =?us-ascii?Q?+Q6q7WoqvhSAG4csYek=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:17.2944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5935c0-8b6a-4a93-2fcb-08de4e059288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

- Cleanup, refactoring of panel replay code to prepare for non-eDP
  replay
- Switch to drm_dbg_macros instead of DRM_DEBUG variants
- Add pwait status to DMCUB debug logging
- Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35
- Always update divider settings for DP tunnel
- correct clip x assignment in cursor programming
- Bump the HDMI clock to 340MHz

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0724d92a2353..4068d5baef21 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.364"
+#define DC_VER "3.2.365"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.52.0

