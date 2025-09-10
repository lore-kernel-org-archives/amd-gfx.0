Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721ECCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1569710E857;
	Wed, 10 Sep 2025 05:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2smW71c";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DB210E857
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZwspraJOL8d8koRGk6aLp+05vF+tOUPRAguMUUrtE8/WaVHgz7aZcW4nYkV7Z7K4DkxDnLX0jl+YrDzOVNNc7JDdMDp6Nq0JroP9IFXAq0hiO2wW+xJ8g4UDnl1brnw2AWj3i5Xp1a+SgXkMmtYroctjeTi66Iho274i6ky6zRr6f/AyUA8xky5IgxOQpQE43R/otU9knYFrJKYqALmXDRy9y5s144QVw4iZax1PPIIw63VJZZ1GNke7oyzmbmVkAZOYY+OjDGGK0QpJkCJHV/OkswGGw61OiL1XEaB++zcrkGPDfJEI71fhi5nRfVXYYQARbGJqphy0nGIN2dcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0JYulrIfElXnKjWH974+gil3VEEoTamxog/Qrbb7jg=;
 b=g+jejUQfRJhvP+j4uR+IQ5Q6n6sdCQD9gOkYiUZ16AMByH6Pu+RCThR2T0pY7BWGeG0roUAtGVeoiwbHYN5yw6Op+g1oumgFF+ocqIppk8hOoX+OncFjzZK4OXbgp9vAw5lEpkx4Rsws0UTeHA0yT+bOiA8hDW9/idCISiGjMbRP7PFM0TjJI7HFwZwvY/2ME0JTHJH50eZ76+ETf7Ob8zdJB+nhWSh7VMFJ1V00SRf0toL2Nsi6aNDKiriNpD4KCLyIFi5NvLOxsPYQmLPnGdhmCqjzDVcchqtZd3smFdWXzzmSkfzVrjmpnenysNi48GQdUsTAVtQpUGoSZMF7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0JYulrIfElXnKjWH974+gil3VEEoTamxog/Qrbb7jg=;
 b=u2smW71c3V97Ybf7ZpFc+zztF6TPiI7lo+nY9F8tEGNWuhBEDlfclH1g5EQUsFnOOpIuyjxFwnLLFXX416i6U2tFsafqZIIX8VoQa3E9cYNKrV9bX1a3v9qtri1liXjVs71r0xi/f+1LbhdR7SEfHMoDusRb1gchcozVvzoq0Zw=
Received: from BN9PR03CA0941.namprd03.prod.outlook.com (2603:10b6:408:108::16)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:20 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::57) by BN9PR03CA0941.outlook.office365.com
 (2603:10b6:408:108::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:14 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:14 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:11 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Ausef
 Yousof" <Ausef.Yousof@amd.com>, Leo Chen <leo.chen@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 08/15] drm/amd/display: fix dml ms order of operations
Date: Wed, 10 Sep 2025 13:30:31 +0800
Message-ID: <20250910053222.2884632-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5baae28f-91e3-46e6-53a1-08ddf02b8d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Keuj6jscbisVxu7EDq7v8vcRIUOmGd7FbkV7ifbtt8MxKbfHc/tzPz5ebo6j?=
 =?us-ascii?Q?H0EPh78HmhjavDtrl7LvlEbxe/51iI88CO613iJxmwOPrE3zHGdsRiIUbvpa?=
 =?us-ascii?Q?4dJKJx7IfN/5RQpNJCwfk1PsS5LH6t21z4GIfoxmEJ2UwnUSvDjdbQdlupO+?=
 =?us-ascii?Q?ZwHwf+gr/7MKgEevaqF49iE0Arb7uLJqO2aKgjvthiYH2/D6QXXLlkrpE1bf?=
 =?us-ascii?Q?qSZH8ifa/4L5Y3P4tESn2+jGyxm/FVQin+ARNdkStpQN0pHxedTS8dqJFOup?=
 =?us-ascii?Q?Mptsr89HM9gfilsxfk1ge43BNoavKelScc/VOO030V1S0pj/7rw4iXHmwT9a?=
 =?us-ascii?Q?kJ4tZvT5QYet99y3tK9gnclSM8AZ/kMHN81yHJAtNs2mFIpeYKAn4kBuEpU+?=
 =?us-ascii?Q?EH7G3NCQeLnrqQBMvCA6SZYm3rx1w8ou5ey6swoPoPdAlX+xh/NDMANAZcV2?=
 =?us-ascii?Q?iA/xx8cCmcPjUHi8y5p1tJT/26qD0ySSxS/G/jiqepoqFrXeb8V5wYSNFMmT?=
 =?us-ascii?Q?pot3ujzKYA8H1eqq8MHMuafM1iWlkq3qIlTxXOq9EzzZKTLDFjHNZMWH2dTo?=
 =?us-ascii?Q?4gwvsVmoyJVndtI8CaTr6iRYPNIssM7XRRIdJ1e8ZRQROuSwc/KmNAZ+V/6W?=
 =?us-ascii?Q?wUxZRcHdcfvj2kNgPtADYqAo9PJozN2K96qlPsOEHUKOSdM+5CNKwqakrj5w?=
 =?us-ascii?Q?Is13Iv0hRXuscddzH7StUQDcm7+e3R1dvPN1MxLfRcDER0vJyyz6gAF/iD8H?=
 =?us-ascii?Q?pphV6/2G/fzj0CtlM2HMFkC72CsK7fr/a9z2uf5rMZAKYPvc4/OuZWGySjTb?=
 =?us-ascii?Q?x2/NIqG/t5J70L63FqNG47Wv5+0Jla1jLVNZG4Iatl05eEmlkMK9DPi7xyAg?=
 =?us-ascii?Q?XjXOj4DRQqvanKfBPaTeb63STPRgvf3QSOLZENSgNnEX9/uRaW6L4/dfKOj4?=
 =?us-ascii?Q?aOM7InH41a9NkQHRvjr1KqJ1+F5EkBRhdmzMfOfVzZn5nkn345sRKdPk+osw?=
 =?us-ascii?Q?hLbTQvbWdVdHz0AXHftpyQ1PErJ+e048HwXDb1lh/mN7Vlr4iD7w+V+/YxG+?=
 =?us-ascii?Q?WuPiqbQ9r7mLR0pbkJC7F0E6ofFidQxb9yH5Qnk8e08OOgNbs2q/os7hh3fc?=
 =?us-ascii?Q?0DIrZ4uCh8DdVYEByvTOcsxG3z29zmpV10nkkictAcdXyi1Sd1wBiNFLHxiv?=
 =?us-ascii?Q?yUjAPhFKhVPq4wtIFnw8TgWpNye2X2VbzjIezFO9evkruzwZDFSEEmmHK8Ec?=
 =?us-ascii?Q?lDkAtFqvPSuzmIMNVkrsfOdS66NUSPWuPA8DBuZEL9tIPZZgFxFQIHI/r3lI?=
 =?us-ascii?Q?hDLkdp2eLZ8onCYuC8sBNlOjgoiAqwPgM6p/fJ+jdt92MOTFSuAadbaWXMZu?=
 =?us-ascii?Q?8cSE2d1YBoL5PBv5Ql2/xON6k7LQcDgwPz4pwAqZRtRPySuUs+ifitKJ6ugQ?=
 =?us-ascii?Q?3Ja7iovjG2c5if/L2NXfOC+a0LJQxy2UGhsD3hqOXwMR1DQJogPAhRU+8IxA?=
 =?us-ascii?Q?Lzl3SA11Axt+SMOzZm6Z5g9iH+2YwhQle2eF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:20.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baae28f-91e3-46e6-53a1-08ddf02b8d92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
small error in order of operations in immediateflipbytes
calculation on dml ms side that can result in dml ms
and mp mismatch immediateflip support for a given pipe
and thus an invalid hw state, correct the order to align
with mp.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 715f9019a33e..4b9b2e84d381 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6529,7 +6529,7 @@ static noinline_for_stack void dml_prefetch_check(struct display_mode_lib_st *mo
 				mode_lib->ms.TotImmediateFlipBytes = 0;
 				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
 					if (!(mode_lib->ms.policy.ImmediateFlipRequirement[k] == dml_immediate_flip_not_required)) {
-						mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] + mode_lib->ms.MetaRowBytes[j][k];
+						mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * (mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] + mode_lib->ms.MetaRowBytes[j][k]);
 						if (mode_lib->ms.use_one_row_for_frame_flip[j][k]) {
 							mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * (2 * mode_lib->ms.DPTEBytesPerRow[j][k]);
 						} else {
-- 
2.43.0

