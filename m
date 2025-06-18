Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0E0C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA97410E8BD;
	Wed, 18 Jun 2025 15:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YTn+B6oj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0544710E8C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JI6TYNLDenFy/WzbGfoJaBhlpd6D0NybPuPPOVMq5YAcYU7nnWpd7fv0fjSTHyyBh2hHLOsz+YtCxx2TZ++UbO7DIGWyfc4rrNAjXhKkAGtEjw3yLVwQDMC0h9feWDBhX6mw+OKjWeaTGEqV/JTJ+4q4Jtp5Zyb97xoQ27CCJJvyql4ld366g5Q7y1th08cUkhYV6KxbCcTEnEJYbRhVIWgSE4q9LWcE3ZDaKAlrQdo7VUk1IyrGHo+CUEcPO3eSK6iFKC/jp4rYxIEVIxxHm63uHNJeojA6KAGb1YRhjC4CqSu+zo2cTd9dWdSc31qAYXXEOecDiHSCY9Ci5Otl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2LA/yKjpN+y2NHzRT5wg3/YQVyDFPjWtBqV3BPPyxY=;
 b=PKSomQTDAxKIDnfY/ct0UxDsQtT+KvT6YbB7LAjMLrz90PG+caaimxKd34fYWTIRQ9IjN8GlMoaUck06uFO52/HCl9SI0VdTfwEBuQF7ETmjqRIoQFooiw4kkR+m3HmOa7LOo+kU/vZQc7WPEiAjgMb3eH3FlH8EeK4n/cRhNZYMlW7K4Hvttx/Vxi5xCuf1cYmrY+ctRTMkfYWLtRRwbpYU70fKtucLHfZzUumb1ezXO21eSTsdLD3aI4tkG4eK9sNXfsITiLZJRTQSB1E3lddCc2ggreJyF2Y8lJCtOHFSc08s9nJM3jD0QBNmtz7a6eFCkVLPLykNxX9sgvMcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2LA/yKjpN+y2NHzRT5wg3/YQVyDFPjWtBqV3BPPyxY=;
 b=YTn+B6oj1FEPl78JSEi3rw77pb88wRvKVrWmPh/XXE1Xx186RQIeHslAAPvPdKXJwBTnO051Kxe5ryfWwFI+FYcP3yL++PEnnYdWTlIiUtMpT8gro0XXsTlcuOi5/YsCtNZOz0aYs2IQRmjX29/IpR5Zxse9ykRtl8INyatx5+M=
Received: from CH2PR07CA0033.namprd07.prod.outlook.com (2603:10b6:610:20::46)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 15:54:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::de) by CH2PR07CA0033.outlook.office365.com
 (2603:10b6:610:20::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 15:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:50 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:50 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Initialize mode_select to 0
Date: Wed, 18 Jun 2025 11:33:52 -0400
Message-ID: <20250618153936.6472-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 71484ea4-0be1-4db6-bfea-08ddae8075e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H3KCOlztB8E98yi3irMicFm2cXZE1SFG6DC+1Bj9LpRqS+v0otQI/+bAZf9f?=
 =?us-ascii?Q?/DJJ3fVLUxECR4zzQRnewWrdgKbkdDoFjPvPNhVp2ob6dcXR8uAj7zu+vBYq?=
 =?us-ascii?Q?G7J2AAEXzUs2IPC6+9qYEk5L3sAdLUj4nSUDhp52Go1YchGRXbVOn68gWH3p?=
 =?us-ascii?Q?BNYZrpl9rLfb0zyVnbXg5lUgE9ascYare8nHuflhWh87ncCcQVKTyXso9TVO?=
 =?us-ascii?Q?nnbpc1sBO4OqzCNJMBp6jf7/vTSzdARyx9BLM/gUzj2/6RRyR/ISHNBtiFOU?=
 =?us-ascii?Q?y4F6zRkR3EHaGIKC3XtKl3BSMQZDhButU3afuAbC2n1sJcTC1caD2ITh9L3A?=
 =?us-ascii?Q?EwidK8q7u+51CEQgSyqyCanOMNT7c8J9hJJvL8b0uiM8fwqCN25wR7c3XfsU?=
 =?us-ascii?Q?O84vwpPqIVfdhnVfhzndFfExn/yIPe6soXd5Skkoy1xKWk9l9s26wH4b4CoD?=
 =?us-ascii?Q?Msfq2agpNOUc7MtPjjM7RJIVcY36gZwt2PW99z/11M/OwVMsRhagmSgAE69M?=
 =?us-ascii?Q?o0XuDCtG2CyxsolNELbubUiJwJylcFhBN9N4OOnE8ykoDH4AJ5vIUW5hXkqA?=
 =?us-ascii?Q?WJfjFF94CpBDhoNMwNTtnuqllyVvnHYDpYHCHG/j+W4thZlNlnLhBMkscOWP?=
 =?us-ascii?Q?NEyf6Bmlu+iHzQNBXJOAPCsf51fMzHJLD0zzF4eHWCprxwp2Hou1IODbzTbW?=
 =?us-ascii?Q?vA5WAojQb4cscheRBERulawc63Dpl46BhJi2BqdngtuOgXIGlXzFNHlx6Omz?=
 =?us-ascii?Q?3/92UiV7KxM+anEq82pg017OyU+BetryanQXHdALvDnhmA8McxJ/wuxiqRDy?=
 =?us-ascii?Q?aDdsbT3XRrn71DSrYgccstC/pDXLG/oreA51hhPCBC6145Ey2Y5vDS8bKok/?=
 =?us-ascii?Q?NfC5Vslon1XDFnoTx1zuQBpI7+QfceNFYnvL+WCgV/iPgj+I0rZ7M6zh9qhb?=
 =?us-ascii?Q?LbOmbG3FKQCUyx3KJmmxm6m1g9PxDjT6j8RQJq1AOqAz0EMDQOhXWTdjENYi?=
 =?us-ascii?Q?6IkVFmHgn+rnmqtzuiG5O2ME8qE4aN2lHMJWvBcayjfAnsKl52Ua6ggVOYSW?=
 =?us-ascii?Q?a8XI+//B9vDC0paYfDKR0KcLyL0+4kx/ewKySYBD/GxC+fdNEbwicDgUlEYu?=
 =?us-ascii?Q?ZC65kl0uPpae2S3SgwabZHn8LR2rAMxuYHqhjiTL8aOqcixXOyrCMLwpUXRF?=
 =?us-ascii?Q?+Ys9/jd1J4qQIUmBoAioT3HQbcsHkRiU2I7HqLJSKz9eeby2rEp6+VtvoZM9?=
 =?us-ascii?Q?hCZ6t2DfedN3IZpM5abuFAwtn07wzpzcnq9vWQbF5ZFoNOAjYecl+tRg1zxN?=
 =?us-ascii?Q?3Mkkh1pPEZNkPvR4KMf34P41LCVoDYGqnfpwK3jx/tR8ZmHng3IKrP+W5aVJ?=
 =?us-ascii?Q?VN6tyJXtorjRvLuP0cU/9tud1aKX+Ow9eIwF6MxEyqkHoTEmcGTs4Ug8e53x?=
 =?us-ascii?Q?M91Hvw/XbSuhgLnpOW/aNs1s6noDiaTYmPLDAqBzaSRPzU6JqyQqEo9lgDcQ?=
 =?us-ascii?Q?EZSOZ2BgJ4P/msEftDbfzKjQtAnqyW6dgc+Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:51.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71484ea4-0be1-4db6-bfea-08ddae8075e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
mode_select was supposed to be initialized in mpc_read_gamut_remap but
is not set in default case. This can cause indeterminate
behaviors.

This is reported as an UNINIT error by Coverity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index 99c10a7acbf3..f3fb3fe13757 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -561,7 +561,7 @@ void mpc401_get_gamut_remap(struct mpc *mpc,
 	struct mpc_grph_gamut_adjustment *adjust)
 {
 	uint16_t arr_reg_val[12] = {0};
-	uint32_t mode_select;
+	uint32_t mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_0;
 
 	mpc_read_gamut_remap(mpc, mpcc_id, arr_reg_val, adjust->mpcc_gamut_remap_block_id, &mode_select);
 
-- 
2.43.0

