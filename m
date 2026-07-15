Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B72C4450E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B4910F0A9;
	Wed, 15 Jul 2026 13:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7hg94r/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E207810F0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGNbAuNfxOkUEn2/NYTe9/uAXHILcIKp/qrKqqGcrM8ri3/q26eSFbMa8uMcIIrhwo8FZ4PU6spUqj02WPPh2MG/dfYVzqbWgH8+1ZrYR0i1IuVisl+jRSCn28F9SlGV9k/U4ecLnoBVag2hJcLqnV/g2USnseSHnKiYhJtea0GZV1YIPascbtnJVLdkv/tuxu1jPXYIquYU2UMnG/dQjVY57410zlbZ5zAjqice+PsgaQWorQxEa7wKctqw3OcbMikFw1u3SMaPfNd9+ZRaNXy4C83t732ftnglImBcIlyAHujDRgVdKCtHF1Vcv2kW3OjA+fLHGISHkzNn1nnouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R61bI64L9neOaLfQ8Zj8wm3KsNYkLQUtj5VSzQtsl0=;
 b=Waevvc6gkV8UKbYX3h8EYn7Y3xL8afi0cqAcQ/nzkOiVL65LWZhuxRnmy8d2Pdfd21q+IsoZEWFT9Wu8zW2NAwBXW71YpC7I0djsMi4qWHXObx+ZuSIn4Pg2WPWkTifbSOTtAIljwv84JGvVeYSov0LBu6Kc+T3qcMm5umy5bulf82R8bT+/G93oR4n3x8ZST1c6ry1Etli9WllZH8YJJ6eDfU6zq2XTh5kJ302b/DRdIASBxkXDbjAGR6fLVGKWZzfH9sSy8XBYKsJfy2TkpSQ+8RdbIv96on4YZTCLNzxYeopeHGacXRCvJnKN/nltGf57CtlZN/ETD6j+mLXX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R61bI64L9neOaLfQ8Zj8wm3KsNYkLQUtj5VSzQtsl0=;
 b=E7hg94r/XOHGP2VBwCV+GWQRlY1hpiiUcGTCEGVhOBUZzx+STRVc/llX7T1yTVGtNt1HQR7HE2w6cDzxPyN3xHFVk0MER4xywezpJmwjlPz5g1OV5qADg/0tMMmaUhjdZfgjT3cTxtAjEiAZkhZXGPmManylqyDuHJCvgz4f6pA=
Received: from DS7P220CA0074.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::9) by
 PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:48:37 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::19) by DS7P220CA0074.outlook.office365.com
 (2603:10b6:8:259::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gleb Markov <markov.gi@npc-ksb.ru>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 58/70] drm/amd/display: Remove unused-but-set variable hubp
 from
Date: Wed, 15 Jul 2026 21:38:08 +0800
Message-ID: <20260715134432.1975118-59-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b86726f-59e2-46f3-52b1-08dee277c547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Th7tQMxnRYMxm/+sw7OLDWZfzARcoe/pUo7idCsQ7YyMHl4RQbpF+ekUWJrdQTDmwot54DZ+swpvuu0o5QtiZpcY+Jv9npLlCn+yR4neXOBS5GZKfdO/DmJg9rqMjIvaBI3zGNnQ7wwQ2AsGmXeWIQab/nz/s9VTf6Da+8cyUlaxWfH3jhKQ1hOLmWzktm5P9mAQRVa8YIwfjAiuv+BMs5OtQjrsMMCmPHs6MZ5Y3GJ4SJd7mTbqTG9bbnBVd9cb7q7qv8veQw8+OMy+DozmPYDPrwrPBAjZ3i+Jd27BuZJw2VqFplKDYwxYAHUqicf0z0veMZfKOTwvM5b2+aUWXNk6kXjKA+w5PmiX9+VBD/qv0pTtrOIfYagb49FT9x3ZNvCRv4ri+m8v0WUVmHEmF9pb/PkK9HL2hvHPe4a5eQtGUpYFG/iS6t2kfa0H1qMb4EcDQNm4hlns2zGp19tIoWzupua41uvlDkEEPfxgS+2Us1joY356x1uImTNM+XLlXcJDRbURbVGXjYWwdHWUFjT2o2KEDHTel2YV8yhrr8KSQKHTS4eSQWevGQMUeMFbIPxfHKNssdjsbffShOiU+wL/odbkIo3EyTZ2yDbd6bVCdrP7Mu6e8dzCs4upMk2aKsvnL2WtCXn5TysRARaJSfIyT/wMIYFV+yl2rrdQPdohna3ERDX2vmCgaXWhME0SwYAutQ86sqBbSOQjL4y0zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bJNTMyDeYx+AHa+EvAvEqfRPvyh/ugienHpD+JhPTXLqtpBq9y4r17IuCUXVP2eZCpfM27uLIWN4o3AcyUG5zZxFSvd3DECJB5jk12frZWd9FCoDxVQjbZZltRgoTFNgppwPcGPZK6VySSHgbkZov8krf8GX+/iyht58IVZtNVGyORh3pqttDpDzmco0guqHlQXR/hIBK4dFKW9UXi1P6q+MbygXvyFEuCp8dyrVCm1bqppvho9cN1ICFnuEr8rEnroNbq7F9cLC0GmPj3R+0kH3CIUgSb+8jb/DNVQ5lsuk5vOyiafX/9ICAYYVOGFNJ0qBy3llGTyXETaOJoWY0S5C4smri7u7gP+FVS3OlJsxpHfJ8YKHgt1HzBXF/EnG4UcjxOomCNfcWLW19iMFpW2IEodugNeYheGgEySxBcquc63NO7qaEXbi8csAKYfY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:37.1088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b86726f-59e2-46f3-52b1-08dee277c547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

From: Gleb Markov <markov.gi@npc-ksb.ru>

The final check of hubp for NULL covers all remaining lines of code, since
the value of hubp does not change until the end of the method.

This check is redundant because hubp1 is already dereferenced within the
macro.
If it were NULL, the program would have already failed to proceed.

Remove the left part of the expression with the logical "&&".

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: be1fb44389ca ("drm/amd/display: Check null pointers before used").
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 7c97a774141f..d8eb5996b577 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -772,8 +772,7 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
 	if (flip_pending)
 		return true;
 
-	if (hubp &&
-	    earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
+	if (earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
 		return true;
 
 	return false;
-- 
2.43.0

