Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66CCC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D1E10E6EA;
	Wed,  5 Mar 2025 05:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzQQH8SI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1D410E6EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHA4EUCSM7YgolRWUdeOO8whP87A2jXNoFaNEYpY3Yvz6+UPt7/6LfP+hXibq0b99WcOuEPvdolTi2lnn03rCkGSjG+dtSVBofwTXpse4jLJC6k23zRs7drIqbBdC7zOhMwsytvNkTMwA0AbCRQBZmG/otJYTaLlRFfA729+JlDsEgH+V3g3nZO7CHON2KM3zVNlvjap8uVEEgiQO7Okuo9+qkm/JE//IIzMxalW2IPTqFAsioiVtMMylA8XCDIDWoEwHc4kNCjE3ZZbgjrEU3yjmGy95qg91x7VYLsfZhfsupmfQaXq9qwG9VO+/5JAxPKxaQWcGjs8oemq/NB8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1PimBjDPWK+nzfmFd+rcOPwjEu5tJpd1QUWTeTJcXc=;
 b=jSqttQN8chw2yYA0uG1UP21DcT8HNhhNa97t5oE4iHTg+oGOSMSuTyXcfBbQjFi0/gR6NzGhEz6SIBfgt1FEHrgZAOAj0hahd9P0grcetzhVrzlSxUBtQ/GK+wzuEiTVbfNygqjqorxMqMI/fiv/bfMt52hWIX7W1B8kre1F3+kZQfVty1Svvvc3vuichFHeowXQKna5HWqVIxS1+eed5mg9ibyFrt8sq9NZuqmsuLRLkkj0o3fd2eqVjShEPUfY8c6lOwsXOpphpXgtiXfKdeVJJulqcT8J/cVKqW2XugCsuKcw+cTgUgm84JOjaB8KQ/cApIeh0kpZvdUi66sw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1PimBjDPWK+nzfmFd+rcOPwjEu5tJpd1QUWTeTJcXc=;
 b=NzQQH8SIwcjQH4Jb35Ek1kmSAbQi55+JAiNMJWweHJhJpMb59C5OEeh7dgIID2NlI4+st2mpsj+CMQLq2yUEUIdEVF+yRXGMygyNk3Vq5XRYq0CgIwhjh7IvtLC0AlqD07JKlnQFXu9NGJv4rlS9j0U8hBRMqruhnT8TrstYsPE=
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:44 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::9c) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:06 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:16:24 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ryan Seto <ryanseto@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Prevent VStartup Overflow
Date: Wed, 5 Mar 2025 13:13:57 +0800
Message-ID: <20250305051402.1550046-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6767dd-7c82-46f0-eb1d-08dd5ba50f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TS3kkI8ALs+YmsO2abeTxZmIEtf9hObP32Ly2cOY5//zG4k92rySnvSYKbUB?=
 =?us-ascii?Q?hVmgYMcihaP61Jujaibc7siCmzlgCD513VWbr6IMmHzAITYJ4X+Zost6LMcr?=
 =?us-ascii?Q?rlCzRM8AjLrCj1cD3grkuOHelQctI9nlvUH47/Pp6KriIJpgviyydv0HYgr/?=
 =?us-ascii?Q?m12t6uYtDOQiuvDOlL/bLySB/3pPUi1U5bM0SB5clB02sQi9qzLeZ5h6Oir9?=
 =?us-ascii?Q?RUei/fzqBgeuxdE0qAEARpLk7mxq/l1cqNED1xFTuUA8ry+2uY7FgtTGk7n9?=
 =?us-ascii?Q?HjU7VD4gAiCFxxHYqagzbmaozIbQlwzmjLz4xONEYglSehl+9wpqnUsEWPfT?=
 =?us-ascii?Q?b+4Er4Hecl79UsAgNCaOxTq0mfYqDv82p7Kk1o5k7od8h+8+7jE5Hqt60joe?=
 =?us-ascii?Q?ReGFD2WBamCUrz6+WnrlsnjnGh9pXsxnyPNjkgIEq/jbucc6dkGe6quLKHPt?=
 =?us-ascii?Q?/xciECHbX0RYQHV1obCPGmKVgLyq4a/o5bIk5Wn1cDCcaTWGuPdZUE+6iAY9?=
 =?us-ascii?Q?WmwRKSc99ojUhlUiOU1Jy/DA5B52voGHpO79JTnT/ygbHK6f/fBE4bsDdj1o?=
 =?us-ascii?Q?Nd9HrHylA3Dp0YXuUPmztJ2XMZwLok0BXmfp4LvVuPu2bHtBNyY15OuPcnuw?=
 =?us-ascii?Q?oNKZzMVQlaGTbMOPTdolj5Rwn2ppN8hfpNAMk13D7Cg1rtRWW3+Wzk3pG2EC?=
 =?us-ascii?Q?B6JBc3WrPwDrGfFDbos4b/PkayF01fjYs1SwKosMIwyDLH87Eehgn9rebVBx?=
 =?us-ascii?Q?5U3fKPwcqAM3Oib3jGCtM7jjewX1W8zSYYOEJp0NnEvmNIN4QYlLouV7znHF?=
 =?us-ascii?Q?oh5FY1/6IYJLMpqZ5gyHJucL56HfLyCSLuKrl8d/i8Sk0n6XIekFOkA8x5uV?=
 =?us-ascii?Q?gIbgvFlwlIbtSCYQeU9Cy4lC1CwuDyUbucqm+002HeEdIpCBsDFQQa9TCSXY?=
 =?us-ascii?Q?hTLGTx454thRgmwQ+TOiMhG/dSzBek3ZAKyXj4uoG3DXe+fVuK/gmt+j3UjZ?=
 =?us-ascii?Q?J30dRCejPvNgzng6h9FfXH6luBpZ8k8W+owAcNnFIF4bgUEEfOVIf+leo9Qd?=
 =?us-ascii?Q?XrKIz4jys6nDUxwsXW83LNGgyrimj2/yqoRXACBaYtoYSc2rn7mIfcL0oYGG?=
 =?us-ascii?Q?qFwUlMP4B0qOADlv+nXlh+558qXXZryNOXO+L7gIjHw9TPTyqI6Y01KApuia?=
 =?us-ascii?Q?cHVrX2hQhSOe6d8s13RtiJiiy1b0e6eph/665fLGVqSOud5KjULiThXv9FEI?=
 =?us-ascii?Q?dI8Cx5rFEXKAi5A3u3XSzS8jCOFl97J1P7KAtV3tuTfcxR0WciE9v+VK7uSu?=
 =?us-ascii?Q?1G0rijxoLI6JWcLYISH+ULUGuTaOmlMKZjQOcI4ooyZ8dW86rpuBp4ro5ldN?=
 =?us-ascii?Q?MUebWsDW7DQaluEilae3wC8It6NvACn5wynbaGPiHQaD8GuqDMcNXQslFkfD?=
 =?us-ascii?Q?Zhc6+swMGpn5+f4tlcRah2PZC6acoveur4wepdg389Szvs3gC3c2aChffGuQ?=
 =?us-ascii?Q?HV6DsjF/gxRgY9s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:43.5918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6767dd-7c82-46f0-eb1d-08dd5ba50f07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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

From: Ryan Seto <ryanseto@amd.com>

[Why]
For some VR headsets with large blanks, it's possible
to overflow the OTG_VSTARTUP_PARAM:VSTARTUP_START
register. This can lead to incorrect DML calculations
and underflow downstream.

[How]
Min the calcualted max_vstartup_lines with the max
value of the register.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 4c33d99ca7e8..4c504cb0e1c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -15,6 +15,7 @@
 //#define DML_MODE_SUPPORT_USE_DPM_DRAM_BW
 //#define DML_GLOBAL_PREFETCH_CHECK
 #define ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
+#define DML_MAX_VSTARTUP_START 1023
 
 const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
 {
@@ -3737,6 +3738,7 @@ static unsigned int CalculateMaxVStartup(
 	dml2_printf("DML::%s: vblank_avail = %u\n", __func__, vblank_avail);
 	dml2_printf("DML::%s: max_vstartup_lines = %u\n", __func__, max_vstartup_lines);
 #endif
+	max_vstartup_lines = (unsigned int)math_min2(max_vstartup_lines, DML_MAX_VSTARTUP_START);
 	return max_vstartup_lines;
 }
 
-- 
2.34.1

