Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F2606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mjfTMWXf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07CE10F89D;
	Tue, 27 Oct 2026 23:24:04 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2306910E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmqR8FWX4x3trhpdS3HUOUXaR3NeRc8cEinu92bAKuSrM9lrOrfpBYtqKCCtNiPRzMtu8xRoeZ2y6V688pUJD7p16kWOQXqYpi1tkX/Ek9oF0flTZwcFnEVsqQHOXNQdvAtsFCSlKXgtlSZ+fAfMEo95z4ZSTn7sf44PN3QmhvTIiSezypjiiakhOGk0ZM5WbwsMZrIIxKHU/V0XPl6G1lRY8XDOrvDvJuTrDLX2P9N3dvLWRWSQKuTaH34yNxthwGp2j94qP/HBkjdpG/QT/S7F7rVKy8gi/RJU92zBfpgcNsNxvc+mlX2s7nbQVHjfezDELpYlS6sH09e6xHCzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt4rBIhXc/7lEnF7Fb1rWqd57T3cWCpXya2E+ji7xY8=;
 b=soS39dbhS37nT2YrlSj+j9Pklx+BV51gek2rBnAVAsY7ENrY5TsLmIMYIhn4OsaBLZI3x9HYmvTwDrwHT1bMqdq23CBI/DXy5g6q4hIma/x7OC8qMVL4I2LLAmf74EgEb9SMbjliOSUBxR0uiS+tw+Yc+99o/yTETT96I5Nyj52eKasjETf6TTk1rVsTbVVmk4xwyn9SKikafPa7qbdiDvjKXnZ8BQRXHv9kgFAzlZn4A60mg9ek+/VMLLk6ZXHq6zjyc28NyyiWLvEOI3w8tIRgvL41G5oRVlMjpv5HpVj5vHbDgBh7BJUbUQZuQpuiwXkvmqsw6wDnO2Cnmhj9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt4rBIhXc/7lEnF7Fb1rWqd57T3cWCpXya2E+ji7xY8=;
 b=mjfTMWXfv56bYrV1a6gSO/Q1lyCCqqpaomDhT10rUlIO9sGi2Nsm71eeedUPpCIVDAcU8J5z+EaVIYvguugB6oXvskrR1VbJoSopTfOwJYXM/dwEEU+fgXb6BbiWyePKiNv4Jy5YgI0qjwaWOmQeVZh4xfDNqj/XpZuR88O0OLs=
Received: from CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:22:52 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::76) by CH2PR08CA0013.outlook.office365.com
 (2603:10b6:610:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:22:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:22:51 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:22:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 11/28] drm/amd/display: Update Rounding For VM stage groups
Date: Tue, 27 Oct 2026 17:17:07 -0600
Message-ID: <20261027232005.2879750-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d178400-085f-4b68-694b-08df348138bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|22082099003|261026121527099003|18002099003|10067099003|11063799006|261021121427099003|56012099006|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: E0tuic94T0Hlv77BXXbN0HfBfxv9Vt1L7PPWtcydcI+Ae30kd366T08FqJLCTwprUNXea7B6Ira9pfzG82TzsvGyP+iCqGOARN5Fh0LawB+zrFSrbW6YB3G2d9v9sETPs6R/tgr4WRVe+GXx61nsJYWM/BXUhP0yASagJm0jC5r/BtXvg7X3AjQkfTqYVrdrvgfs2QnZ2FrH4kHWS+9GgZJ5KY6BeLE7F9ylL17OxP6CHTjM8YJ8xYOTEB77Yxn+1alxucvNqsDq7x2MAvCi7nbWrYLUuLABIrgUTZLs0NiaA/nknAO9YXI3ykgRYTbh42XQ5o1W+TZv2+Rkmb8LlawPPTp67iBLvdcvZ40uq7PyCDDhCFfFX7MEzp6qsUjRaPl9uiTPKPMoZsDMxfOz7smQGHruYgg8onzhaBNgp3dYYptVytPLQ4VW6//kJJvDeKBBik+Y01VH+FDj8ZXFmKnxo3yGVpG2gT6S94orW9FOnOYMDVb3FCW8e8Lfva1N4Uby1B9UdKMMLU/jshd2gdxJUfHvYi4t/KMhNUnsNUL4u3IeSds+Lro3/cYlBo9M95crTMs/mMR4lvcNlhRih8Wo+BM08cD/RHDiKFnLq411riOVN74xUzYPlzGdn4iodPqKymK7Bd3eWD8uPkzCdLDBMX2O/yFwQAOaTrJ5r0G3atEY+umccO+jl74aNWHYKYirpRLkhF05Ge8hQVY6nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(22082099003)(261026121527099003)(18002099003)(10067099003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BCTXbJi9OkkOs6qH2yXKahbnxYKONMUIh6JLY70k8JViAnYE5Z/uZGAmkXZRBp3vorPMuN0kjfgSm2n00TtxjqWZyFiLkbPFYn7m2ciOgz25ptZv+W3xYGrPtNfcZ6Ca5KOzFKlTdFHzaaSHOYWkrGDQggJF9V0gyD5nDp9pQPWihowhHQf68/wQM36xG/eOrJtiPULtVsFqgmRnWGqV8xM01ekcrncMzCQGrXsFYErvhEDR30Ei3F55OJBJHJCrK04SwPLwLTbz7ecAwzFVZR546sgrYpYI3inEjJWjehlr5M68tWHCIBWOLnGE+vnrQuExTdiBJr97JOTqNW3m39l7dSRxygwPUcCEtrfVDmxxxeplakJsXnZQONgd4xFlO1eZbH1BLt4ID/s/6YIy2Hmvx9nbS5nJNbAJXXwr57efnk2ElRbSfRh/UAq+7bJn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:22:51.6720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d178400-085f-4b68-694b-08df348138bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY & HOW]
Value to be ceiled should be casted to properly ceil the calculated value.
Otherwise a value < 1 will get truncated to 0 and won't get ceiled.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 262b8e098343..09cfb5046c81 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -4893,7 +4893,7 @@ void dcn5_calculate_vm_group_and_request_times(
 			num_group_per_lower_vm_stage_pref = num_group_per_lower_vm_stage;
 
 			if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut && display_cfg->gpuvm_enable) {
-				num_group_per_lower_vm_stage_pref += (unsigned int) math_ceil2(tdlut_pte_bytes_per_frame[k] / vm_group_bytes[k], 1);
+				num_group_per_lower_vm_stage_pref += (unsigned int) math_ceil2((double) tdlut_pte_bytes_per_frame[k] / (double) vm_group_bytes[k], 1);
 				if (display_cfg->gpuvm_max_page_table_levels >= 2)
 					num_group_per_lower_vm_stage_pref += 1; // tdpe0 group
 			}
-- 
2.53.0

