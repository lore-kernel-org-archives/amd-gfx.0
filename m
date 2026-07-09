Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60E0C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9F110F700;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IjBuOw7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9F110F6F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AshnvbTThWTVx7eAuExs2NJtLdShgfuNr7VO59el7M/kC6WgN/4zvrIlor7A75FH+o7Lu4MfD6YkBe1QD3+rYG8YFkQWWm9Y3TL43daJyj/hMRf741q+YPoiYUY5i+dytwHGG/njyOkoI8os+ZKtorQv2pWVLZgEY4YJYkws5lTn2DagPGb65pZA1L1DOLypp/xgMPA3GDmRJQob04LPtfwKX8VOpMUo8tw2iO/lFkeppQ8YjJkp2yiF5JeqEb3t6hG/mrlmEa+sMW5OEFT82KDxu9mQR2JlUWsus6KMDim1CwC0ihWKm0IpRWCWrAVJ653ovsADyHRbk3//9A6qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpqC0aTg9LHvYJ8M3jKz/q9uauNDjOpUGboUCz3ZgkU=;
 b=UT/HzATM8otLhDZfl1quNjctCwhv7gZpThUEoBzvvv5cpOUofDXFnO3q77nrhrTk6zJHq22Xyi97O0f6WJuFIpNP2suxEQBKWaySMaMdtnwWUZq2QjXK3IzCjpJEBEQ6unQzZdFyGQ01XruRVllbKbieJZ1CLCVSbdVhOFCW1/6L3yA0PnavwcBpRSGmHWeMv3bnTsEF06t20P322XTW/1w29pfIqhGH1PY2qJOoENZbaJ/r6ccHjl3ztJcQiG74bEYgyD3LOjRHwf3Jy6z0H//uBHmvM0xVcsH0yn3xQAUSE+pWGDhwuc7KG/HledTd/KClbaLro/y7l/tEBhOojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpqC0aTg9LHvYJ8M3jKz/q9uauNDjOpUGboUCz3ZgkU=;
 b=5IjBuOw7tP3QUP84X/Xa0NVkN1nyb8QLXShCivVmBlMsd4Q8xlwyS22/a09EMG6YYiyoFNJ1C0bC6saQJJ7dApWCHcHOGMsvpAhwrhU5k/B8v9kT3HBPj0yfPf3OcynPdwDJBvw8F39LuPabbES6eI+p+6eBy58cutOVogyHsj8=
Received: from MN2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:208:1a0::38)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:39 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::17) by MN2PR07CA0028.outlook.office365.com
 (2603:10b6:208:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:33 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 75/80] drm/amd/display: Enable HUBP/DPP Driver PG for DCN42
Date: Thu, 9 Jul 2026 16:48:43 -0400
Message-ID: <20260709205936.5719-76-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 28da6358-7437-44e8-6ed0-08deddfd6915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gg2oKBpEvuuX+yAqgG9edwhBIdYDdmfeiEazfCN5H37Hbcl25u2NpidByl7enu4CkMnHq28A9JNqsVvSh96dWxmNZyRt1F/C6D1JIoahxGSm81EMD9nFO+tX3XzIkouzrn/OftD0lCzAymkPMux286LfYY2OBp/qYxhn4kh21wDvHoavx1hvTa1ZK/SWkMhv6sdHB7g/btn3AavEl89WfcX4eh4na+yPVCQ+fltg37Vkd6iTQU8RBQckqY6cQ6l1CfFMaXHzoNxRqkvjNT5lOBS4iv5cWO21H/uEUPi82tbVCtErpQTC+a2HB1L3gUEUvJuNU074FDn7+7ZkzBn0xs/pfK7Ep3bwHDS2/Hmp5snRq5GuTEII04TkSqsWC2miu6RaB/ElIknKdTJ1ao5AemLwPyBMbRiyuoZecVdprBDOmVoQPn68s+qmgiYYE+GFZMi/o3fVUmRAy7GLr/lWUuTODNiPg8vaISEowT0SjsnUbHllKKhcQ3wuIRQUSS8pdN9AFGBxQH+Qde9Su0E7npzP2jCNeQ8wGQpRclkOqA9in1NZHFnzl+RKhfX9ung6BnOzM3Q0HT2u4Zls/AIbnMpwb9BNO5t3ufsXLibTmMgq7eMfzVMnpcaCPzcJFyifeYOa3qaOXD9nxazVUTCsDNm7gFOjj90ZAmh8ziVnIppXpbBdUpAwEyiEekcxoMQvlBy73XchwH2IvESZ5zIGOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJXcuelW1G2QEkFdL9VMX0R+rTo1UzTDaAKdoaN8r7Ja2cBF6MlId0DZH6gdNirtyQRM8394OEjm1yWNAYwxKeTGk0tB9t/3l3FJ9TG1gep23rW6jm/jrozrsf9WGg6olbssOBXwkRpf+H81akyCaSHrbC1Dr3GZes9OB5N3S2BFoahgYQ2u4zhqlFu8H0wAQPTFEkUTfB3JQEseacJODm3DYoQ25fEQsY38uoNvo9sITRmn0pN2AXBflnyBL+cctd8pyJpmjmnGVfSJaLKy68GUtrgpB05+stwkBOLiyrjTzdn5uzxVO6L/NzemFRyff++sVPO0pcEEdE2kmkCMRTSB9VP6l8LcFZHrM27+0cRoINKX3uYDw+3/ZaL+gF6mWA4bQ6BUf0g4cTG+MrmknEYKviWpwKDXuuE7bngE2LjKiV5hK9as506m8JWNkg79
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:39.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28da6358-7437-44e8-6ed0-08deddfd6915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
The related corruption issue is now resolved, HUBP/DPP driver PG can be enabled for DCN42.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index e40e246bcc82..547a0b816539 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -729,8 +729,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
 	.ignore_pg = false,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
 	.disable_optc_power_gate = true,
 	.disable_dsc_power_gate = false,
 	.disable_dio_power_gate = true,
-- 
2.55.0

