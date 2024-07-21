Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28BC3DA61
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A142C10E1C2;
	Sun, 21 Jul 2024 06:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgnSI20C";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DB310E223
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK49woKVlc5JwWbtrEpn1lymwLgCKfC7vaO6CPj94jQgXMgJbBTFKIdX+2CpwvufdX7c83UF1CLvfkmo27gcVjvO5iWv23uvtsQdTtKyxmj3gHnElPImtLpMDhaxkZ9oamXXPBSIhbqUYbVkl01n1+JybnQYjjsXnyT79z8+Qld1UOhab2BCF90jeyE4WGQX8JZFshWpPAy+6udoyM+PQjaasbmE9R4/HS3Sk6CFdKGtwN4xIKGQr1uJF9icuxWwwgF6WV+mEhh/eKjwFnsBDtiA+DFvpLyLPKDd5Swj2ffUwgV85Fa3wjAVAgMzjfkShv1epgDuZKgcxdyirOEfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAigPvMbDPOx6aDZLu/DLgnMJxxg+/M14Rz1vxEu0Z4=;
 b=UZDzG2oE1LEiaZjBUuNJtSk7BjMD/RGB1EudTiva1jKr9sTlubisNivl89smu2FOFlps1h0hQ06zXBl8znQvQUM5ZRjWDx+NK3niPF6XSlwFDt0TY2WA6saGa4F84kF0PClUaBGUFhk4gWFdsrjNMNhMazjp3CaTHC3f7EysjAyeLYLtRtghuplNIwDB93gjTA3WBpdC2b9QnKvw3J5TWTnVNYwcBwHDhcdNloQb9EOMlPAaYGEPHHRFGxajgp5BVnPHX/dGetbeIBhCPuAWaB5RVJU2hpT7MqjAFSTHoG1BQXO0tKAwBBDrgDVnaM5Y9W+SPYDjoXr4w5qX5yBRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAigPvMbDPOx6aDZLu/DLgnMJxxg+/M14Rz1vxEu0Z4=;
 b=QgnSI20CdGW1QZ4VbZWuH4EgeEsW6p3ilwNhZWZ47oIoG92+Albb3TS1tVECHJDSTeme5qHvVUU/Abb+9ueX1nbwbdJx0TfnnCaZCL5OIBN3BfKFrtp0OHuZT+Efq6RYDPaEAqsIAXuHUTycvN0sg0HispDroqen/ssTnM32daQ=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sun, 21 Jul
 2024 06:22:52 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::1e) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix index out of bounds in degamma hardware
 format translation
Date: Sun, 21 Jul 2024 11:52:16 +0530
Message-ID: <20240721062216.3151119-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6eccd1-a75c-4a00-d2ac-08dca94d8d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ryF4MNzy3VHatO6GsQtmawUuhqPVL0P4qfAYlOWiwpC313VrmUfgsxGwzJ09?=
 =?us-ascii?Q?UjSNC0DuTELZDv7ciQLWZzdYZrBi8wTEeFq3FPwKYQ4NMJCZDNW8dvDAGn+i?=
 =?us-ascii?Q?/UGDcdHSFJmVj9D4dMVLKGUKFzArWrMYmSUcopM3BMgwK0Kig9FrV23vBqcv?=
 =?us-ascii?Q?ggDzotyuBWKmurMSWqiFZJcReV0nkXaaXx9KKUfmKtueb2zzmJCjzAV4q6k1?=
 =?us-ascii?Q?idE9VIS5gB21Hqyv0REVUJ65fWrSySbugLbRwjpe5hoI3ZymWSCBGESO3Dog?=
 =?us-ascii?Q?5TEzH4hyKRrZnoeYctfb/bnmg4zuGmTd2iz9EZNQnVKj14t0Z72HKtfmZTg+?=
 =?us-ascii?Q?wlONZZknf1THNwuy2rUrpqj5oLiq+wB6MYpCF/MelEhmN4EiwfEUmKHD6QvE?=
 =?us-ascii?Q?+Ol5KFXQgn8NMlerYUkoaqOoQ/obBVV3B8m1rkGVjH09DTWIsGuMXD++bxIn?=
 =?us-ascii?Q?PEGjhe/6S4LHzqWLF6HBLNcKwwzwwfWVOaDENvnXkgLdhqoCIaNVYoiHyqaA?=
 =?us-ascii?Q?kbw611rp3VGXc/V+zL0CEXCdCIuOBdXpwd/3rHijLO7w1R6l20xEPdni+zYW?=
 =?us-ascii?Q?sO0A8hiCRIuHZ7n/I9SjfbD8zCMvXARWxkXakVUWHuLmeksyLeAebZP4PuXs?=
 =?us-ascii?Q?P6q87+w2fnua/owdWM+RggCFQmewLM4xClFoVLFT4WVOut5tWgLCsxUtOaAW?=
 =?us-ascii?Q?llIhMci538Il6jW4c0jAv1HmfoV2a2oHGeoMpx421AyR+Opv5eNFkI//UaCi?=
 =?us-ascii?Q?whLxrAUE755TG20+jsWPr/5KSxLkZqdSyb25x+fNqNTUHBdJK/kHMgqSVraj?=
 =?us-ascii?Q?5bHMEGMEVG+mZrx5eid0cmfE6gqVGAHtbtePbPvrm++uT68TRlFOkNWmSz91?=
 =?us-ascii?Q?zVwvY1DWmPcK8i18qbDp4AKLed+Oxknr4PEr1sRSyAwPH66BFRgAbQktygyX?=
 =?us-ascii?Q?MXaALxfdBz5ayXaVKZg68j12+HTQ0NIMBAJd3Mz7F57tXVaUW+/9RDjPIBz6?=
 =?us-ascii?Q?ZsV4RdCbMK2EQoE+/VccJtp6hkOU9FMUbov+gviJzsv06yyUqpMNwa2pmLem?=
 =?us-ascii?Q?m3dkvN+Dqx13/Ae+U51e6iwh+E6PFx7fx+djPQIOkTkUlGMh07kIvG4U4tbG?=
 =?us-ascii?Q?Wp4u2a3hy2BpekBeotDqvmIFGhm7sv9w39MK1EeUiONR89H4RPPBbk7lu61T?=
 =?us-ascii?Q?TDSTRFQItkid5PLxFJT4OSLcY5hKWvV4d58zW/5b5rOUyeTHItTXCI4ZofxQ?=
 =?us-ascii?Q?CNbomUCGdlEAXDhOSKMd5pz4CxXAxXdkKjS3J83g5t/XA2Z1jX4pHFFo8Unq?=
 =?us-ascii?Q?miAad5gyruchN8z+15iKi/36TA9/Ogr0dYisfGgx1zMW8reOvVaNc83fYflK?=
 =?us-ascii?Q?Lk9QrjBd2UqTZRI8BmnOQn5xpIVOd/8fquam3FYWif6iTTgBUidf/onRupP2?=
 =?us-ascii?Q?d5Sp0qe/A3hMPRkccdhU5roleYJRqjhr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:52.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6eccd1-a75c-4a00-d2ac-08dca94d8d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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

Fixes index out of bounds issue in
`cm_helper_translate_curve_to_degamma_hw_format` function. The issue
could occur when the index 'i' exceeds the number of transfer function
points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds the function returns
false to indicate an error.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:594 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:595 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:596 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 0b49362f71b0..eaed5d1c398a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -591,6 +591,8 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.34.1

