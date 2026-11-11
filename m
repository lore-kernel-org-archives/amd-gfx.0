Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02079606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5fAv4uPH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7F910F8C6;
	Wed, 11 Nov 2026 01:41:58 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1221010F8C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld/WWSZ2fjoJumenFjcfVv0n3h8kmRZDNx9S+NuAAEIXtRtSh0ZvxRzAznsEiuRy1H7RY9t1qsBFPrv4Zqtytb/8t5aR9X8qt42cOetuwZabzB9hT8jn/KXwBpc9LPAzDUd6jeUva9Bk0wKrd3rNr973Kh0Lfsu8r+LMAwQCembGYg1H5P7S7kjTGqq4wqGKvbnQs0J3oMqBMXNhLTFmSLQGt65Sk3Znfryrm5NpKXIFFLmRGOanxyE+8dWp+UWXfEcwHoR3ZFwqo5QaMDEC4huhERSQqOKi11591+jEO7RrAdI33oLgeFxgLSQoReuWyJb0PwK0KYzzE3at9oHE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFQzLghXs3Mpragp9paiXbobfamxb+f07m3FxxrZoAM=;
 b=ZqB2BBpBAVhYmyhTeo/j3QC9A/okjW9GvxyfbXo4Tgw+3xSbxGJr6qJjSOB4owu+V8Wp1dk95MEdAJcVkciFfEGYZfcTxbQ/xfncptr5Vjd8+HDU7DUXfEsltN/PCM1Kp94KQf80ldMdtWdTNixt1Pu0jmlvce9rr/qHeOGPDcKJD0MpCdSSaokIOinT+r25zXo5BTNcvQk08os4H2TpwflEqzorfwI381CMoh9HCXYsf5wcd/94l6f+owblUigW9HfNGmIS1863d+BHavhZ5VGTTtx6nIoQB8L1CF46WmS6D+pJ2Te34wwY5d3aBIz0bL38BU2Veag/JpJ97nRfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFQzLghXs3Mpragp9paiXbobfamxb+f07m3FxxrZoAM=;
 b=5fAv4uPH9tU2G6t5WjCVAzGt1q2fQpq5Ys53H/C2pslZLncIArgcwyISlBt89pd9v9FCebyG6ZNKU8pIdzfPxpGONyqIlN/Qx+GGkxnRl6vDlzTGvAIvDFe+5VsBCzYEVOsOjhrCRhd+CegZF8ZYtV/FdNDYZHr2qysicC1Rrz0=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:41:48 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::21) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:46 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:43 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 22/74] drm/amd/display: Update DP HPO to use correct APG
 instance
Date: Wed, 11 Nov 2026 09:28:28 +0800
Message-ID: <20261111014100.3596072-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 034a9625-5c5c-4d09-e9ca-08df3f94f3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261102123227099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ESgjnHglXv/Y5FCAUv+sLf6qRx252KgbTyTnEXp+Na7YpBYTaOw5xA1i8rUJe/hYvrKtjKvaCF0qPqU3y6phsSL4NmbRNnFrqrT6KEkDsDBoicf+oSH+6NKLzgTWk2/zhozabtlIMWDY3JhbUPerZmykX8ExK6FO30e2m/owEHlaXiXmXPoEX/Dha7eOo0XjH9/UwyriOYGxR13LYxYImKyLLbeGGkohZtnwfppAYrPczHeqJB4//fdsqEhKdDSg+7noQ4zOGWiOxD0vzg9qd7w/ODZLRCwP+tjRc3d3/o0q18UbzlIceltMgYwIF2pCxJeFqlNWtzYXVGpwpqJ/8C2D/rn/SV9Cak2KZKcwpli9ahdhMg3ctEtRnMqk1D8u9X95o8VLJ9gszuLThdr8CwzWVCecXJshrlqSVo0HQIS9iWkwQh6wIaQA8xkfB6H7ahBX8wDe+rzkAlMNQ8WBqW5aKiyGpRzzOSNf8pFZN/BwmIDMcvIF6qgGZsSOMWOsrtbsTTOS8zoyVbaljw7KrSNRRpD/iLRvYPVo7ku5i6U8SCqXfFyv7bisQJSPUub1oiTbQMdhMd32ocl2CGWpMTJRZFpQw3tn9i7QgEht89sXOiBOZ335R6ltF5yhcRNoD/juEhLX25tpkvFFShql7SuO3Ztu/ZylniFFT/IVljilwvVYAosiV2Bw8s7tQaFd2n70E1A9qZsfBJXFdk5yBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261102123227099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ot0k1TJDelLiZEm9pYhvEPqd/BLqOiY1kyeVlmq/r0KFmwCuw66gx6xF/0wB96v8TWtd5mClGyOxGzgSGfVMvX5DsDzVPNptDN4BD+MqJ+hHixnwYwxuY62j8Ra1pESB4RMEqi7Z0jIzsFSmw0PYNL5mQSlhM25ffEM5Jc6fAgbokuueDNv3s4qYwgQUsFg8FEwDNDhByyT6NAPc7Wx/WDE/bLjiU0M9e7ipnGsVun+Jqu/Z+ZmhImb6S0RzBjR4JKT6rg1egYxPI+4NOeoDiqar+cK+aXYky3S7Bef8ukFLpB/UgxDDnjAlUUpFf5+yuyX/CIZYa1FZswQn4/8ieMDJ5K4ztypOUpF+TtxoZgv27blfg3XlOCsWeJxa9d0ARce4ymHuPcSB/fbUPYdmmW/nwPOh6sxRBYJrZymzcuoWReor35qseK+dTsLYf7Ed
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:48.5329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034a9625-5c5c-4d09-e9ca-08df3f94f3ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
DP HPO uses APG instance 5 - 8. In total their are 9 APG instances
for DCN6.

Cc: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/resource/dcn60/dcn60_resource.c        | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index f192c95952ab..d068d5682619 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -291,7 +291,7 @@ static const struct dcn31_vpg_mask vpg_mask = {
 #define apg_regs_init(id)\
 	APG_DCN31_REG_LIST_RI(id)
 
-static struct dcn31_apg_registers apg_regs[5];
+static struct dcn31_apg_registers apg_regs[9];
 
 static const struct dcn31_apg_shift apg_shift = {
 	DCN31_APG_MASK_SH_LIST(__SHIFT)
@@ -1394,7 +1394,11 @@ static struct apg *dcn60_apg_create(
 	apg_regs_init(1),
 	apg_regs_init(2),
 	apg_regs_init(3),
-	apg_regs_init(4);
+	apg_regs_init(4),
+	apg_regs_init(5),
+	apg_regs_init(6),
+	apg_regs_init(7),
+	apg_regs_init(8);
 
 	apg31_construct(apg60, ctx, inst,
 			&apg_regs[inst],
@@ -1525,20 +1529,20 @@ static struct hpo_dp_stream_encoder *dcn60_hpo_dp_stream_encoder_create(
 	hpo_dp_inst = eng_id - ENGINE_ID_HPO_DP_0;
 
 	/* Mapping of VPG register blocks to HPO DP block instance:
-	 * VPG[6] -> HPO_DP[0]
-	 * VPG[7] -> HPO_DP[1]
-	 * VPG[8] -> HPO_DP[2]
-	 * VPG[9] -> HPO_DP[3]
+	 * VPG[5] -> HPO_DP[0]
+	 * VPG[6] -> HPO_DP[1]
+	 * VPG[7] -> HPO_DP[2]
+	 * VPG[8] -> HPO_DP[3]
 	 */
 	vpg_inst = hpo_dp_inst + 5;
 
 	/* Mapping of APG register blocks to HPO DP block instance:
-	 * APG[0] -> HPO_DP[0]
-	 * APG[1] -> HPO_DP[1]
-	 * APG[2] -> HPO_DP[2]
-	 * APG[3] -> HPO_DP[3]
+	 * APG[5] -> HPO_DP[0]
+	 * APG[6] -> HPO_DP[1]
+	 * APG[7] -> HPO_DP[2]
+	 * APG[8] -> HPO_DP[3]
 	 */
-	apg_inst = hpo_dp_inst;
+	apg_inst = hpo_dp_inst + 5;
 
 	/* allocate HPO stream encoder and create VPG sub-block */
 	hpo_dp_enc60 = kzalloc(sizeof(struct dcn31_hpo_dp_stream_encoder), GFP_KERNEL);
-- 
2.43.0

