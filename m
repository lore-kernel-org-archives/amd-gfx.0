Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111FAC4450F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E69710F6F5;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2QYy4Edb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F9110F6EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwwFS9KAHQ3gE+1H8Sv1/Pzv9teGK0lQmhZHmah5cHKEyWYzNNDkKPtl/dNyXPZa7/yrzwoPH8hApu38tW9lfeB3lmypwC2cQvRLEfwZryj+YEW0NFwuIHHJkDk5oX5xMPMfz634e2H+cPlNyKTUC7m7wZtmPL5NKJF04KnfJ1R3BQImwl579QkGePV1mv97o5mUM+xv+u3FbVqIhT5JpqQV1T0jiMyVSew9QwZRhWBFjiwDbjY7FHdzHhW7f7llp2SAi2Xoecxh3NSuDlB1zTIMZCnYYZH92vwFyplRdBkmX6XhlMQJqPmXrcOuu47WmJiuUlUkUrafdNdMRCBYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0/MTe1A+L7H6WVRwB9oV0dRdpl6fiAjBIlCHyBbOGE=;
 b=IT6UzvRlYT+SAk7DZ26foQ8EkhZaDrBYo6ALHrXrzXPRDjA65l9e6EdJoRvOgSS0KZflsF0jsioFWmdI1puGCxWOKR62KGl14iX4oSWvfLP+G1uPT3oVeAXyCBntqi50J0miZzPh19IT1RjjYAYyTxzqV2V+3e01TOymaH/iMEPESIzn5wIRBpLY0nE2LMORJm7u0YohYqJ7BlvD5m+uN16bpM+nFcnuWg7lQ5fnt/nfEldp84t2Pnzy5Xo4/+F0kwUZkPMB4vxw2+Cj3BFoUF0MptqLbuYpgyNMmOU69ELqRg2QPHW49G3HpK4EOhm12gjgDD+vNy7aoVzrsViwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0/MTe1A+L7H6WVRwB9oV0dRdpl6fiAjBIlCHyBbOGE=;
 b=2QYy4Edb5/KhZjgIz8Z2/yRixJ744MOmh6zGi+6lzZOJTO/BWBYQtU9HPGO36EZmnxMLY5fBrVL6lSZIIXj3Po0JR4nF7MaycYgX2S7pg7KUHDAThf2hrCBqUgOCkgEbGmC4gYcl1U4Yft5E1MOyMtWA2z5sVmYW6AscqeKetMo=
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:34 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::6f) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:20 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Mohit Bawa
 <mohit.bawa@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 58/80] drm/amd/display: limit reuse dsc capable bootup timing
Date: Thu, 9 Jul 2026 16:48:26 -0400
Message-ID: <20260709205936.5719-59-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e25cc3-5cc9-4c26-beb2-08deddfd6646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GEJm/XCW2v6824whYElG/lsJLy9LbgvAh0XYA4Z/nMQytz6+RcIjl/kY8yA0BhKF4Qq7OSmGlOjnNVYSA7ixCdfUgHJQ7CfdC4SYAqtySoEzLQxZkdmThIPNxYN5XaTzwVuTRd1DlMCDuybGiUxGELyoGskfiJ9ZZyh+5cbegYo4N4+rYIqhZkUdtHaxXxsMs/wERYxhz8HZ+au2AGe5zxiq30Lvl31L4CVeCqAlv+1HtT59ufl6lB4WccMR/HnRAhmfN3vDO5TVJ9fCSkICM2xC5hK3XvG5OisTbN1Hd60oEA5onFvuYS6A2QSDwoonmG6eyiiqfyfPs1s12qFVZWXT3cIt/WlCl+Ye0iSHADJTbNAaqC+q7yWpbkwMPmGBPu30Ncfh/nuTmlzG0+YyXIDtRxrdtET9nNnWXPCVWv9BpfuMb8c5t/UMkODKx8Z6UeYTDwI7Mp7t++baVMWB3JdHZLk8n4VCAKgSx7jd7/6zu7kUgkXacM7VLSA670aUn2M2Q/lgZnuEicmnGW7esvN2wiCZWUqq6FH9XLuq1qBsKKzc4j97ZuUD0JARpLGyeGy5XTXZ7wrmU3JPjw9AL4LYiUAmdSfOJTQCtNvmB8eV8rl7SYdq1SFbo9LTZzogppUQIZ3nW3KrJbpAVJ+7SRtHXlNjSQ5fJTHxCE/QiFeN5HO1RKiSOnCALjxY0mk9kWC2PdbBwWrroMPc6yduXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N7g9VNGEyPsel54TVFY22ckZg1aw4oiwAV465GzmDUd2CAHsLFJszw9HIeUbD8MMZ90razw3S3yD6OhcE2Ak/bNfNntnt6MCgNB5wVUqeh4lMxmWJhsN0emMHaewmnJorHDA5QdSvnOnZlnn3OfwCqxF0AAHTVrtc0DGbpVLoCJQlow9j97WfVjJQTqlGnxoZ1erDdzZTBq+Mb6SwqSdgbJCnPNPcDLOndltc81O9HQwjwrxvrzM76DDqLmmd+dqIO4U3yanN83VEig/uszHNvWHHx7HsBEFdKJ7DK7l9ibQcbbSxdJfDq5+j0jGTwwFCsdMqZkDTTg5U1fYrGAX6bWPKLIBi+LvvMBw77SC5gFQH2Yrmv30lK6yD0BV8Q+3V0Rg04jTWTbwW8BsigWLR5Lbcy8F1wLf9lKLEPxeg+hl/Mm8YVhtdG6byBfpmaE3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:34.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e25cc3-5cc9-4c26-beb2-08deddfd6646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Previous dcn315 BIOS has known dsc issue, not good for reuse their dsc settings.
this pre-OS dsc issue is fixed in dcn42 bios.
since there is no production bios update for older asic, limit our new code instead.

Reviewed-by: Mohit Bawa <mohit.bawa@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4a1d63e157af..cea39eb70285 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1945,6 +1945,13 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		struct display_stream_compressor *dsc = NULL;
 		struct dcn_dsc_state dsc_state = {0};
 
+		if (dc->ctx->dce_version < DCN_VERSION_4_2) {
+			/*vbios enabled eDP dsc for one of DCN315  only but it has known issue,
+			since there is no production bios update, block it there*/
+			DC_LOG_DEBUG("boot timing validation failed due to unsupported DSC on this ASIC\n");
+			return false;
+		}
+
 		/* Find DSC associated with this timing generator */
 		if (tg_inst < (unsigned int)dc->res_pool->res_cap->num_dsc) {
 			dsc = dc->res_pool->dscs[tg_inst];
-- 
2.55.0

