Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7280ACAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1902C10E8CB;
	Wed,  8 Oct 2025 18:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFe+J0Wf";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3150310E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2ZtSi7LqYZW+dKIyqWLM5hL8LYE+RMUrQibFqWIgy01ONqc5GVxwSHWam7XArkMl3FLc8A+8/xu0FURywuFjVhuk6oYrOyhQQpscEahGid1s2BgLCEPTI3fSgY44sfvSFz/u8GuprUcSEnDMc08cuAK2+xHW/GwjJnjAVCFNCI81Ah3bdI8nZmmVBgkcMHStXcEWpy+iBnKibuvaKP8MsgJh9fqQ/GFbsGkd/TEVwMl4ouDruald22pS9/3LRvHj85Vn6dFkUTDE+22j2Zb53EilHUMr5cD133z7zf9oWHwmuGAA9DDQeEoGRTaWilFasatKzT5U5glyY5rvG0KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2m97q7ynzLa5q1BVX40agnjnGI/Qf+m1PFowD5qeAY=;
 b=Ji4fH5BkreNGn6huMykvBPLIXf2FUfdwXRWs4fHDH4KGxykPlj+EKaa96TSdopCQfCx/HyUThqM1D1L7hIpN4pVQ2+wZJkER+ekkkmcSaFftDpU+QHIaszKpG8fXRM8gPzZU9/RdEtG5fFm3Q7RXxyU2Drbh5D9ZNZZrLWZXwEysqCqDDCr0asQdodzDyyVY67LwBLgy59/ODv2lYrfIgVgV3GXB3luM6ojA2XgFZZPlWrSQ+zax+rr9kLPrbTgFTY/UKK0mOwz+q5d48+5kpCnYworyXZRCg1WSsqU5V0IRQxYNGMMOQDmvnlF1edymLPYh42wnlEoipELg1r+dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2m97q7ynzLa5q1BVX40agnjnGI/Qf+m1PFowD5qeAY=;
 b=TFe+J0WfyldLjgZ7jNUea4tpiiVU7p5N69zmtUTVDwk1kL/HQGmiZJjgEDi21hj7olfkrWsB0+OXlk3y1Dyy6lepPA6RTzlNfG5gBTTOquARPZRDAqzfhltji7pWu4XZuhQj4+OaqKDj+p/Y/E17ld93BdEBMv6L8MXrziAns9o=
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:39 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9f) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:54 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:54 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 21/22] drm/amd/display: [FW Promotion] Release 0.1.31.0
Date: Wed, 8 Oct 2025 14:47:15 -0400
Message-ID: <20251008184839.78916-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2e980c-4d8b-45fe-c6f9-08de069b6fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d6DGDeVilB4QJLKZp7p1+cRvjBSZcm3VZ0X527VvgDQZ3x40vdP9RFyxMbfA?=
 =?us-ascii?Q?I7HX5fzCJBAwc6jCK06KCHsxAnp06qlvTsaig+QZZpaubpAwHh2K5NKwSF5f?=
 =?us-ascii?Q?cSyMM9r71LCJRFV+3xEr6zzYLp6WxvKrRxmWdWJPVU/i57pjWiQMn+Y9CTm3?=
 =?us-ascii?Q?yf/9Ga3ToliaQjavVzNQ5zkmwpyx9v9dSZhp86OC271lbR6BONsAzrK09aml?=
 =?us-ascii?Q?RqhfOXFAeyWsXKEZgqWR8Idj+HyFRwCZFSvxp3Er/qOoKVeC0jZePUn2hNYk?=
 =?us-ascii?Q?g7rhrMMK1Z9SYMonEVpRrYJtwtjrPiF/iwnj9QcmVnBNMIVjjIYWcW+Ntb6C?=
 =?us-ascii?Q?hBxrSYQgT3tN4vpZvuVbiXa9/Qicw93vbSj/4lUwMAggxRR9ChzObFGLyu/V?=
 =?us-ascii?Q?mJOuOpjd9SQPgKX1wJjeyVL6tLLkLYYF2Uo06R7rMbJJlezgAOEQlbtxp9dq?=
 =?us-ascii?Q?rPOs47iOJbMxt3OPGTBVsdqrR16SDmvzj+4UpVvZnZ4XGwKfIfZ1kEIV3k0v?=
 =?us-ascii?Q?k5r3RNMdDOvVCsTF1x0mQTwDDg+qayfzEcWqkirdGmriVRGMNN7Sam+SA3yg?=
 =?us-ascii?Q?r5gyitXe6tpQGYUVuTj1fpQIvAPEPpHWinGVUDNslrTHIZsvrYhA5IRTxaV6?=
 =?us-ascii?Q?Xxwlgn8AbVkYKmvOoDuw2UlJSgji0bRAhAVaJbAALLYqPu/VDF/gMCBbsk5H?=
 =?us-ascii?Q?O7Q62zc2WmkJmOXubyJOMW91zaDtF3lUnyMdwwmiWR1PX5vbzf1KDBd6DYLT?=
 =?us-ascii?Q?UpFh66+LF8X/PeX8HBLWSBktf+C+kyjo57QWkj3ChM2vYZx1tOA6BdrJIdrS?=
 =?us-ascii?Q?seUmH5BwVIxJswvOSbIQ5N0g3OX82hXqKk+KMcxCFrmZWeGaz/LGt35cYsZ5?=
 =?us-ascii?Q?dlPK9M6VNwcErHv+Gr1uLrVn3G3ZEwGIH2YibadM28y7jKQ32qMr4hycifkl?=
 =?us-ascii?Q?yopfTU9ZMBlyd5oC+eU00jOAiZCu0JUZR+9uTK5p+fuDJbeY6RqVvnZoJXbc?=
 =?us-ascii?Q?pNc3k2Wqa0j+1kvg4Tk+RfwdeLFOca7m0XoFP+0ikuX4e85dxkVXzPHSPo2q?=
 =?us-ascii?Q?z0xK6uSDGv5OViwz+HvObIPjY9IvyNeb7du5AJFuWQCxRY04MbX1cqNYS2QU?=
 =?us-ascii?Q?CWpus+sqCjrcnbedlZ4Blnw3G6gPzsgNy/6DWsqoqMiYPlG1b4kcIyB2qEhK?=
 =?us-ascii?Q?h0s8Y9LNhOXDVW5D6pghzVrTID4j3G0j+pJePgFJQ0nobjGfACxrkw4aYdEH?=
 =?us-ascii?Q?WBM6bvP60X9tr9bpMIGGf5MjpoMw4vLHRKiHs6KyuoRYnJFhv2dj3M6gm+mN?=
 =?us-ascii?Q?VQY3kn/2znD7i45UeNBHJn5jiJPbgiyh8Jjg5fjvtN5vyIVKXs/RhPaQEyeG?=
 =?us-ascii?Q?XB7lEoTC8yZM5Gii6PTCY0tAvZFEZQBc9FT4PXgJ/zweoXy1G84mi7msv0wX?=
 =?us-ascii?Q?GzB9YKUui2B+4Hu8uvfwg4FlCdh+6+0VR6S96u0MujTnakUu8DnpuMuawirw?=
 =?us-ascii?Q?D/XkvkhY+fz9dFLX/KQYTSz975KgStJ490zYQdw5X6RmkMeGUkT+r/4w5fm4?=
 =?us-ascii?Q?QXXoEbSeJtFME/Uu4jw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:39.5575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e980c-4d8b-45fe-c6f9-08de069b6fb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

Release highlights:

DCN35/351/36:
	* fix video lag with replay
	* DPP DTO programming sequence fix
	* IPS exit programming sequence fix

DCN 3.1.5:
	* fix video lag with replay

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5df050a90634..c0a833ae606b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -973,7 +973,8 @@ union dmub_fw_boot_options {
 		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
 		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
 		uint32_t override_hbr3_pll_vco: 1; /**< 1 to override the hbr3 pll vco to 0 */
-		uint32_t reserved : 5; /**< reserved */
+		uint32_t disable_dpia_bw_allocation: 1; /**< 1 to disable the USB4 DPIA BW allocation */
+		uint32_t reserved : 4; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.51.0

