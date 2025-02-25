Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D12C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4672410E55F;
	Tue, 25 Feb 2025 06:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRTCSLl0";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78E310E55F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOhG4Vg0KeK8JKvKW3ZEhJl3Ii5NZlq71ifALJltfHAVQMketCNHmQPnS/8oTlut8umS5zJs1CeDfYwxttYiChYYoSxHrghK7KtYBNXHHVZcidqpacI7J4VcFloPjIv5Ce/tdiNUr0S89lEFvq0/VBAG6zFzVkefEuCfPj5gt5H5ORlx7BGrcxSn3Cy9Kty4vyhUQR4hR0TPERC+LtU5b2Pke4NzNVhuvouPFTT/lG8w+2dfPM4HLoHQLLazTu+SiPxHOLzz4NoGz1wKoNAKUNIBp8ttC/kxVlZh3PThbRJrf2ljyOJFRxtc7nFoxjanEA5ifJbXi1Fwj6Hb1q0fuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beFzRcv8Wc4N6OFUnXmefsXrHxpPZJLQpvlMyxztAr4=;
 b=dlAhkewCoSb+LwVUaNiu74MKNjNzROpXu/af/shT6NcShIpvQ+fn3BPFnpVSZFY83agnWp436ft9eiZTTjWGxdPzts/fOP7CHS/IVa+bQxivu+xzlrGDgn1sm6KxfKftNVlnSlaoLOsmkhKGuafjxEScF2vsUdapJrpnIcj8YxPRKxfQUOgwsC3hcgP9wX+xnsC2vP61O3NuU0k3mTIG1S2IgVz10xLQXrXICFgDypAD+/hsoM0PfgzBXZ7uFQBiozGsGs2N8XCOXPMh/23BZvga6f4z50+EAURyn7cQVwE/4Fj892XxI5u4KKpMzCPjdjG9+Peg51AJIWh5Jygy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beFzRcv8Wc4N6OFUnXmefsXrHxpPZJLQpvlMyxztAr4=;
 b=PRTCSLl0lNf3J+QYF3ZhVYLWs34gpCRUs+cZ0NdpdBr5UkzVnAx++6LgsyDEzNnPLhGFYU37WtsDCK+rY3uMWOVmBAyqaR97xY4TexmvXgH8o20+q8IXB6ewncbcwy9RPwzHAlBQkROMCYM1+rvTzJDpuAE7Rx0g6ZonxNy+PK4=
Received: from BN0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:e7::11)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:37:22 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::45) by BN0PR03CA0036.outlook.office365.com
 (2603:10b6:408:e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:20 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:16 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 10/27] drm/amd/display: Ensure DMCUB idle before reset on
 DCN31/DCN35
Date: Tue, 25 Feb 2025 14:35:53 +0800
Message-ID: <20250225063610.631461-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcf295c-adfd-4740-d7a6-08dd5566db85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XUH4VKoXvOvV9TKX6tlRRPAUnZXoyG7mjjLjryz0dpaD39CltyxlCXe9Qzi7?=
 =?us-ascii?Q?YRUsh0tElFginFcOpNR9ZAioG55IXk5UNl6p1mhppQGUnp6a/DMIKKpa8Li7?=
 =?us-ascii?Q?f9o0GEdPzjUhDPwAB09zVDFFmqCxnI4Nd8TsSHmE9k4/kCNWqrEMKqtlWqh8?=
 =?us-ascii?Q?qqQfLXfXsVGHcbX2Mk7Bq/5RnKa2+5JCk+P+Lq/Z+G5f+sR9nYgAEJBvL40j?=
 =?us-ascii?Q?LM827Odci60XlWSbdtucx6+NCW9xU9k+5YFvSTpN7njLW4Kb8MjXirujgEdp?=
 =?us-ascii?Q?T93LY7CLxpq3fJMTnid3OoIE5v7O5n6dDylxslO+3MYJnIJEZrZ3dvED3uGY?=
 =?us-ascii?Q?hIMuj8WtQ+W2D71sq8umic6AsM8GB0L8QoTXtCTMSIiPnA2oOuPLAuXk/jQj?=
 =?us-ascii?Q?t/hu/rHaeRbtnYM91cb/hmHu1kmpNjYVFHdIPnEb2Z9H5ILAFzg8VjoanFoH?=
 =?us-ascii?Q?tKw61mQEZlYxI25El+t4ploWd0SRfoxAH7kYr551VGdu+4dV/9FxZTCvM49E?=
 =?us-ascii?Q?LG1HQCJRH0Wo+7di6RJ5MiAVyd+slFGiOasl59eEsaazFN0pNP+9O7WhV7tS?=
 =?us-ascii?Q?BIXXK4CVl9thIC8TNv2lq3wlaJycFfqkkoGwKcy0Oldvcqz+T0K5T6juAaji?=
 =?us-ascii?Q?/YfAoFb5KdIlkVdIUAMirH1uKtdarVXp3AiWKNoLhTqQCDOAyVBMJ+U4SjX+?=
 =?us-ascii?Q?L6gHdBeTd2Tmx05U3Nm6MIm/9IgwNkCsMRWURX1pYZ7QGQ5IImRQUwgQXNVZ?=
 =?us-ascii?Q?+ko1zDAaYOqgRO0qzP91aVlCiJ2gE0fhpekfbO3Tv1KeCgNWrgUw3GaBQQ50?=
 =?us-ascii?Q?+IZ5D2CyWVDhuAj5hxgBFLlQkJKEo8QV6+8UE+2gba5oBfYMKlgZ8Ms8GO9y?=
 =?us-ascii?Q?w/fr8zWl2X8uN9D1eQDZgdUBq3whb3V4KSuCaYNLf5oQyeELUbT7a82O7Whp?=
 =?us-ascii?Q?fr88wYYAqMTnzy+c1+GVOXVVgb6e7n/a7Va9WwiJeTfsgamrWbIA8CUxo9LJ?=
 =?us-ascii?Q?Srv0bnOWVx56n7sCrepH57nZ+gGKz9SclMpmpwZBYE2LiTJS6iU6vKMvfJUY?=
 =?us-ascii?Q?i11/bC969bBLuccF70wWAvUH3dTdb+wRznQ2ZaaklK1MS8J3HkpKNu5Aw7NK?=
 =?us-ascii?Q?euZP5hAxzL3ZQzRdhNFJG25PncRojxOwgiW3oVWAngUDg1xvzkK9rAVWHKdH?=
 =?us-ascii?Q?eXN8om+tIc2KlfruQGdiZj8UWAyBRrHvvp9PsR2oJ5dxxATmU8lhrkjN0tRw?=
 =?us-ascii?Q?TCLzny75/xqtOs4ONdzNM9Hls8CNYv4KfterFaQ4HeihO6R90HcBXW4pFES4?=
 =?us-ascii?Q?T8hJHJYkaMWPqwSVGu1BZNFnk160bQ12A6e5cR8txItJ4jeNw7PM6ATdzeoM?=
 =?us-ascii?Q?PHJ82NMJmJDGkWiz+rchzCZfnwZ3ZHTTFcFupHllbxnx329x7lcVhHSFbBk4?=
 =?us-ascii?Q?R9lktGRoISqaArgJLPkgvaKGAvyvqul6xNMCXtQrRCHWKAQ+i+TzVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:21.4016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcf295c-adfd-4740-d7a6-08dd5566db85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we soft reset before halt finishes and there are outstanding
memory transactions then the memory interface may produce unexpected
results, such as out of order transactions when the firmware next runs.

These can manifest as random or unexpected load/store violations.

[How]
Increase the timeout before soft reset to ensure the DMCUB has quiesced.
This is effectively 1s maximum based on experimentation.

Use the enable bit check on DCN31 like we're doing on DCN35 and reorder
the reset writes to follow the HW programming guide.

Ensure we're reading SCRATCH7 instead of SCRATCH8 for the HALT code.
No current versions of DMCUB firmware use the SCRATCH8 boot bit to
dynamically switch where the HALT code goes to maintain backwards
compatibility with PSP.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c   | 17 +++++++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c   |  4 ++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 3d0bba602b53..9796077885c9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -83,8 +83,8 @@ static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
-	uint32_t in_reset, scratch, i, pwait_mode;
+	const uint32_t timeout = 100000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -108,7 +108,7 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
@@ -125,9 +125,14 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index e5e77bd3c31e..01d013a12b94 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -88,7 +88,7 @@ static inline void dmub_dcn35_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn35_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 100;
+	const uint32_t timeout = 100000;
 	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
@@ -113,7 +113,7 @@ void dmub_dcn35_reset(struct dmub_srv *dmub)
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
 
-- 
2.37.3

