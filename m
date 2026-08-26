Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05EDC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6893210EE42;
	Wed, 26 Aug 2026 23:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znarv2L7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17ADE10EE42
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3Bf9NE6kX5OMK6slNfWiZH+55TYsbiqYSmuiC9oLlJjA+prhQ9qjx/9ZFYur+mYfp/mcnBK1Ldd5fpby+gufVh+IZPMIO+yQyXE9k9dKopQPTd7MTvspl3RvLs/abNr5x4iSHQtAbQQFr4w03e4703A45wK5Fg7EFef4nl3CIzGU4XiIFmLzPuA2mpwEuPeSpvkVt0BXaVk/vfDj525ziXeA7mNo1zF3Wy4ZWLMs2SYdshEf+6e96OA8DODFzghnaAkxNkbILbwtwLdIUucbIXXF2XWltO/foxnK4HAFbRcOKhrgZzfVsAzHQEHtvy1QA2ZVtnm6bCc4Tyi7alx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbPLc3UQZ7U1TVW3C5iM9jo7CNRlXRcZyeYPBPabo9s=;
 b=NNjGGsGwS6522ImkySFv5dgN6D68KlVmICq0zVn79vNnV7fsMmN3sjdRcmuaODzljKrITKJIf6TnvB+o2Uuk0bvV3E+mswwRpT5keztvfcRxWWsipJpNhe/Sc1/4LW0if0xGzxy9dEFBnce8d9YKfrBmotOI2bMSj5W5EHaVkgSO67ZjjAK/1jg59dXN7zILXg+LrYo680j0FIlMQPqNtzXE9DoRNmOC1Az3GoHZWIQjJ0pPShevDqIQjKruQYrzGF62UM0IN8rMfov3sdV0zgLI6t/T5B02t3BvSJtRSbjyOc8Dem8B6FCw4k65QRS8jU6z2HXh2GqqQi+3kt8fLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbPLc3UQZ7U1TVW3C5iM9jo7CNRlXRcZyeYPBPabo9s=;
 b=znarv2L7tA3avq/azg/yPEGpVGkWtAVP3E965nr0pn7Fa+Rh4xtZBcPZNAWZ3w80vUw61wOuOKgHSO3dMF/VJZzWTs5xSNcwapbecdQj/ond/ObP3FEkcvjIBYDR5GPGlARdrePZtwGmnWj+NEnBnySNfyJFxVKPi5FXJcNTcy0=
Received: from PH7P220CA0153.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::15)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:22:12 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::46) by PH7P220CA0153.outlook.office365.com
 (2603:10b6:510:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:22:11 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:22:06 -0500
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
Subject: [PATCH 19/59] drm/amd/display: Fix Order Of Operation In Calculate
 Flip Schedule
Date: Wed, 26 Aug 2026 17:04:50 -0600
Message-ID: <20260826231519.881949-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fb7f07-ff28-4cb0-0e42-08df03c8db64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kt5Ot1T+zmz8HEjW73gXvyvFKsz7oyzeo+hI1cQnzW689woioiGGmKG6po0Fv0diDVdr+3OZAZI1H2fykiPtiSr6enU0V3+SffA5uULcXpFahWB0Sy4IFjvYuYijvLxQJc4qcyWBYVW7lJQVJjUXnixDLun8Q91uEFxEugQ4yK1MrzvKm3FZJz8gDmXmhqUhyOwvtZH8ZN2UYOSPfKJFCvDdLaCq8qwFWzp2Zdnzhk5dvDy9irMfbe1AIUZt/0HdiPUU/ZcbzRthcVx9D0ki/zNhYoyX1ct4TOhoPb2w+Er53osw3oVUryiAUxqF6qrBRZxmtBYo1Csx+/0z0A0lAa5w7Hf8ELHROb42P+zTV1xLwNp6UhKZa2CxYCybHjrF09oBa2VvZqoCXN+lRyMKiPtmq+sH3OtyGvX2mQC5FbxGsryHGiC03PZ4ma3II9ZUmfHDgXcSqVN3dY70wzHH+TXNr9Wxc4aFT5eM18Ydgaa+DgzHLEhbPPF0sWlZQvkicypA4Raxa199wxt68+lv4GfTshN7goRcbPvw4J/j3FQVLk/IrovQw2ZCctmHwhNmpUbMfvk55pHtxMz8HUOeW8AU8p1knwZF/P20/boSk8CIZaZwLa/ERdkeJaJs/ujTmGuvLs3vAWuO/Knd/zkKiu/BnTv+5OZnqoKqOhMe2NcjM012+qsfQUZH/PlHagiKLEkJJIFo+Wm+LxurR7wXuA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vwxWeGIu+jCQU1uSOMT7Fh928px9OvDa3MuuRCCtneRgWD8x/t3OuLlJ0g8ALjC7ssvAnpvk9x4uA+Pr/XpD3ZBm6ev9jVTwI8bu+u9TxcsQ5dMNry0UAwyRJp4i1AA8oKEnVLO5qocbfDGR60wIQMIVDyiatMXGUNC9nVduGB9J8zdC0pMtvihsPRFKbLComExQBU4WOQ/4VwqRZlIbaNt7kTFqqlVA2NQe8N+raAgCNVnUCZm4EFFU2kyiQgymuC++J1rzoc2ebBvnSADI62Wotp8mQPhsKx4+lm/MxUIalUCgi98lnyXidrA7BMvpWCIqjQPd0R1ImKegq+g2oAIfSkI8A7u6rsNC2jtmP5/p7a8Ei2//GOdxU9TNnf3glMzU9K1EmbEM7G9AvHYOHgDHiYD93NuuOwEj1u4CB1Lxr1FJxrg/qN48dE3SLhec
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:22:11.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fb7f07-ff28-4cb0-0e42-08df03c8db64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY/HOW]
Tno_bw_flip is a time so it should be a part of the denominator in
the bandwidth calculation.
Fix order of operation so Tno_bw_flip is properly accounted for
when calculating the lower bandwidth bound.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c   | 4 ++--
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index ab778fac34b2..09047661a411 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -4102,10 +4102,10 @@ void dcn5_calculate_flip_schedule(
 					DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
 				}
 				l->lb_flip_bw = math_max3(l->lb_flip_bw,
-						l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip,
+						l->hvm_scaled_vm_bytes / ((31 * LineTime) - Tno_bw_flip),
 						(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
 
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip);
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / ((31 * LineTime) - Tno_bw_flip));
 				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row reg limit = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index bbc1121fd85a..ba0082e216d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -631,10 +631,10 @@ void dcn6_calculate_flip_schedule(
 				DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
 			}
 			l->lb_flip_bw = math_max3(l->lb_flip_bw,
-				l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip,
+				l->hvm_scaled_vm_bytes / ((31 * LineTime) - Tno_bw_flip),
 				l->dpte_row_bytes * HostVMInefficiencyFactor / (15 * LineTime));
 
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip);
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / ((31 * LineTime) - Tno_bw_flip));
 		}
 
 		*final_flip_bw = l->lb_flip_bw;
-- 
2.43.0

