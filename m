Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE9CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF76F10EED6;
	Wed, 13 May 2026 14:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iv/DB+/2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FC810EED2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUiZBsSDHiYg/SNuuXqy4IVHdSBllb7jqrqL+E1bHEB5+F73aT2yfjgaKzzg1vFir/8RDKE8OpvaVIIegiZkRlOkdJWlyP/qky12RoZF/VLyCHa2e0FBaS8M2drfAc448FQ3YKftv7B8UErIE0+dSla3zRQbaCZQNYfAMc2KB+JQ298+b/DQcnd11jeE74GfEQgq4lfX1PboyQQLKFYuwP+4tCTSBEWUBAqp4ourWH29hJktvJKOvKNOYfrbEeSmJWjES5oxhZXDfOjMV6HkcWgxGl9hT2hzQh5Do3KwKMEusu/J0GXdOxaTIMvZ6tyK7IABfySxv8XG+ZfXwIbQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXVCezYnDAX6KUK+oBM839ju95ZYFAFlBl+WP2FdkJw=;
 b=ATsV9lyBIGQOiDN291jk6aXtg+kMAqnMY8VOY7SPZrfCkareLAfuZQaf5vODfma1OzaN9RkuquodeHeBRLkKfWD2GJEiEkdNC0TFIC5qUZbnKAvW5KWKxwftVrSrtKXDrYZGJX7XteSssh8sHZLUKnUK9TPF5g8Wat6vEfGT2hTHbRUu92dlpgChIXIozkgCFwVhg+G3TYbON8JOzXrOZSC9TR81NSAqxyELXQ9bqKIGRb1VFPQ8bLLg3sDBK3RkyEl0w6/kJmdVZuncq+P42h3Dm31bD2uVF89c5zCGi0yMLiJsBXQ7qflc1M2WEfxkESdXdaa/Y9SHdDAIUNaYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXVCezYnDAX6KUK+oBM839ju95ZYFAFlBl+WP2FdkJw=;
 b=iv/DB+/2eSJVOsGCWQN/lvhI7woLHaGDPDznbcay0QCKUJHb2gZVFgAVhRp4guq1Ifq/E9EKyqirRqrEzvzXqWLNndVtiblmOZMQJKfKxAbkV/kXAs1B0d1Tpw61q2eGo6x0fShUBo8Wubm2xYnIs4gyOgnHi+M44m/W46fH77g=
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:28 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::db) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:17 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:16 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sung-huai Wang <Danny.Wang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 04/28] drm/amd/display: Fix eDP receiver ready status check in
 T7 sequence
Date: Wed, 13 May 2026 10:29:26 -0400
Message-ID: <20260513143213.1852892-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea9b934-2e69-4d2d-31ba-08deb0fc960a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: fjdBib4bd3BBC9yNCZbIhg37oHQho6NseNuVK3Lpc6HSXTsssjcOq9kiWUN0ZfGMIEnpH/Yg0WJT7rrZxFsCXQmOPzmyeE3q/E1dg7Jocxu/YH14QAej0FZjP/aR6Z1hi7UAMEHwIHLAPHXBylv2MdpNi3S1WhCAHySRtcG+vF5JbGPWlzs0Q/TRnLA0PFQ86hf6GA/TM54Ugev1whf3G8h9+9Nk7FOO01ashb6Y750gkEC42gNWIM3PhcT7hW9HAbSnVSzyTqG5MR/RTJNKuYOeLjCumxXyJnq0BcBtgxydecS4tcbH3flL3POLn0MBWUkYlrp1PF+y4iATUlnuf8lnFnNLweS3fxckQa91jA6lEpm2NgiWEwzSjR//o8eLOSv0tSMNc7ZDx/+u8z6rsXoeXtozEvD/uIAEOX6Oq8XyElwt4M9M5hq5Vb1gYDDm1VnKIcmocIH/UwAMUVST6jMPKHUGGnU6zg2IXfxeabY8nxqeea8riIiALSxyRr95lDUFOdaUGC1ZfDU4moT7NWwHg7vh44ShE8ZA1lHMXVkO96PQDL6vPZMHe1i5d34ilQgqr0FXBDJsnbipRKXZa5MQ92REraIbXrptjVwrHRzLW0YgMJ98gbLzRg9HI6gZa0CjtSy46U927V7vLK7YBlYwwD21AT+wJhMuozAAr9E3iIfMePbEkDuriJE/YsYqdeyv+5a6qKLmhzg6TVjPvQuQR+7/MWqLI0OEssumwiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ry1lHvCS49WQzTZMgP9GuDTCEYkxn+1KIYHxMi4IfwV7Lni9d2mMQ9Jg7oPA7XWdJi03SEOCnZNGVilJJJ+9BloKDOfGrdm9LCBE0SbZvFn3fa4fj40iV1mDI8NfkRywFu4RAs0oJDNIGJzg3qu4HLDtZNQhxxfNe/V3yj1cpYrOx/0tJg1R1mXh1n2k9S41tq745sLAJ4YGZDU9IJWhnkPYN/KirhOjKQJb/jnU1OvqyWRXEOOS+/knUKCcWeQRy0Ebs46owFbf/gDMfM/PO5DbLP8x9zzk9YI7cAYU9b8qVz85N5R0wZlMLcu8SDb85r8bmLlcDVj0DnsAkBKsdkYhKQdlUbsyoZYM2ggvmA+F8Fadx7FA9+tu58a0bng9Qoac3dTA70z/udEmRmKKqjbh/Mss7MXZbejstabZ8cx3a3UAZL3WJTNNvK2FxhWL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:22.7577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea9b934-2e69-4d2d-31ba-08deb0fc960a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

From: Sung-huai Wang <Danny.Wang@amd.com>

[Why]
Some eDP panels return sinkstatus as 0x5, causing the original sinkstatus == 1
check to never match and resulting in unnecessary polling delay. The
equality check is too restrictive and doesn't properly validate the
specific status bit that indicates receiver readiness.

[How]
Replace direct value comparison with proper bitmask check using
DP_RECEIVE_PORT_0_STATUS constant.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Sung-huai Wang <Danny.Wang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 72b5921227d2..e06a9ac65286 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -462,7 +462,7 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 		do {
 			sinkstatus = 1;
 			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-			if (sinkstatus == 0)
+			if (!(sinkstatus & DP_RECEIVE_PORT_0_STATUS))
 				break;
 			if (result != DC_OK)
 				break;
@@ -492,7 +492,7 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 		do {
 			sinkstatus = 0;
 			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-			if (sinkstatus == 1)
+			if (sinkstatus & DP_RECEIVE_PORT_0_STATUS)
 				break;
 			if (result != DC_OK)
 				break;
-- 
2.43.0

