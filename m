Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCBEE20AF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066E010E087;
	Fri,  6 Feb 2026 15:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnFnNW90";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C7610E087
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfosoRDz59YmCrkzzE/7PciYavpLl3Am/w9aYRmTCzrGOwsX7OLzjx+UdsTuEvRaIFvRwEJ6KLI6yF6ZeXoGMWFDflp/LId2/Sm0l7CnfTcOOubzljf3vgjq6RJSWKHpkDb6Q9hGouoKZCNfAnsrVvQdAVRYo2N0JAVV1rFuppwBQHj5pBi2ppYmyCKKj1aQ/ogwnIHYpOUhERpYnwybNNZ6GhMHxt7QzlAcSTc5DfMP7wSfI4JEfq+i2sxoFJF/758peSXSmE+i5VcxX+MdUdnypnBdilI4kma+CdZDHL+DOTWjoqRolAXdL8Pd75FZA0ie2Flzx5/EKJRSPhqQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyP61HZl3tKInyI503iyiMoxP0mFR2fe7HJi0m5lEIc=;
 b=VV4Xy98f6d7mdsz+da6OkjCJzDIABNyRol9vqcQVUNXnPLFNai7t1wOSSCT1rLXNGcS6ZjynAeyC4TF99yAuWSARgHxWXQAtaqyIpyi/VRPbOPzc8OmZpDmvY8swS1mVNZwewp1e7xHyk6PZx/5seCPstYle2mZidF6LgXpzPd2vsjYewwnz+BgIkSZhSynCqR6P/0vYJClXe95ZDdb94mCnE/VFKy1kh+XtMmo0AI1H84ozgrrXB+sf2e/QLTuNSwr4jWERShGnPt/MHADjNVvFaMDB+FszRumWL28b4DgQMdBnko4l9AE0MsqliwQQnp69nCg3+A+JFKHMX4P4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyP61HZl3tKInyI503iyiMoxP0mFR2fe7HJi0m5lEIc=;
 b=UnFnNW90/S18pk0GBLPdzvKwpQYBEYtgbNFVGhjec60M3Pt0GrUC0Gc96cPcZDItenOYFCvsY56mljw5Lt7Oj5VFOK6clpSYReSAPAXCgkcPD0rybOBEHF9+QBrqsK3P0otnoH0uUTX5LfBxZuHHWP4nMS3H6LysT4fbCV2kCFs=
Received: from SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 15:19:40 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::6f) by SA0PR12CA0030.outlook.office365.com
 (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 15:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:19:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 09:19:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>, Mario Limonciello
 <superm1@kernel.org>, ChiaHsuan Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH] drm/amd/display: Fix out-of-bounds stream encoder index
Date: Fri, 6 Feb 2026 20:49:23 +0530
Message-ID: <20260206151923.1479783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b86eb9-938e-4fe8-45dd-08de65932513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dbIa2l3Y5oimrD79XfoUQuT5kiITeUAm4K2TQaPtxBtcdPufgSfjagzk8uS4?=
 =?us-ascii?Q?cDCoigr47XKYmabhvyK4/ZgqSoXhECCsxo5EkVQuyje1ggm2kw//zrZN33Tu?=
 =?us-ascii?Q?SQIj6lXnSw+UBapdiPYW0euGT6wXkn5nRu0e41n2bXuEJwaTzfGeS5eV9Pmd?=
 =?us-ascii?Q?f9Asgv8194TkMpUhni/YDG2Ms4bKgtDsd2N5R/JVXXXxvSKBA0bDQD8WCKT8?=
 =?us-ascii?Q?iuFvgd0w4e0jU1Uj/Y2hIyMI3+R5DKlKYJce8b29ONO01Fpj0y9PGHpYAQM0?=
 =?us-ascii?Q?4+cYjxodwoQzEcgLgbv3D2s5g4ItorFIc9GeoD3x4cdsK6lJRGCO5uk6+c6e?=
 =?us-ascii?Q?3i9PlOb3YJ4NQmmQCGRn0QP2/OgUsL2nN/9LFzxzlu/JPk9R9wlyqSfh0wNR?=
 =?us-ascii?Q?6Q2kRxoMnk0J7fVxON/EBbiE6M1fU5PjEMYL8UGVlOXNvDH7GOgttMNIyT5V?=
 =?us-ascii?Q?eD9nNpTzzB8fVqGRpq8tKO0dBRYrqJE8AQ/gH3heEobVaG8RbuwXgBy+T1Cu?=
 =?us-ascii?Q?SkoP4YZbH0CpmkWLiewVZgyHWg7GxIkmxeTCP7PvesJwYu4/5g4aThJKxz+m?=
 =?us-ascii?Q?1Mo3D7O3E21l5No/s6p0Dg00iAuWmqEtEGUojP22HiWHvoksJ0uwCwLFnTsT?=
 =?us-ascii?Q?DRxhj02WTVpzvgRQ4OF2QechaQeKgi5bRSF1LlgEawsnrNaBXq0Oh0ZaxeXe?=
 =?us-ascii?Q?hpbmB5b7UR8HSSYfGEnpZxFK7kJQwEkQoByEG6YdOFEA7pl4SIcgjN5OO7zt?=
 =?us-ascii?Q?QI3DUIA8SUaDrRMgE2gc6fdB4eHjNSB+8NdIjCNLh97LARibmNBNhEEWj9cE?=
 =?us-ascii?Q?pJIN2weJNaPTnc11I5jy2242d4kYY74nr9UPv2/lBcbDtEt9tOtICsDdy1DX?=
 =?us-ascii?Q?qNMG/9r+/wyhxhovl5XwbIRWBFDkifrJhkY67D/vH6932Z5kzIXi7cOM0wJU?=
 =?us-ascii?Q?WdZMxJLL8ZKIttmA45sERwU/FufQdeSjH8jVjkGm4oxXYKVzB1QlRDNdmcXQ?=
 =?us-ascii?Q?9BYEWyqSPeZ1H4KoCaAzUFE62Jqak2FWPI6GDx8vpSCwap8xltee++L/rwF9?=
 =?us-ascii?Q?kEEWjpaDhjdO0G0h1v1TtScFtZndI/YNu94SvnhLNroey5/ClYjyDjlYwWQr?=
 =?us-ascii?Q?x1X74aTiQk7NC/w5XTfjvN2m1UEVmjseQ0fi0KaKtyxiSuPFQ0BZ1VFQY97s?=
 =?us-ascii?Q?rnVem35SL1HAIUs697ZbYh1chReEL8grdliJbTuRTURStCII+qStG/MongJp?=
 =?us-ascii?Q?q03xx67I/CZqB1fJe+mPrXrqWyE72S7PtrnofhiWxSCyymW4SOTKqAch+2Z5?=
 =?us-ascii?Q?oWUKIpm+Y9F9N3WoE1OA4hJS1gxty3+5QPCLs3bAtoJ2zjKrUluRdo6ZVsyU?=
 =?us-ascii?Q?+wgXBCr+QY9wcjn+07ern4o6bYdE0KWRJlYeAOWKdXVYSeTOanEOLXHPdWW/?=
 =?us-ascii?Q?9/NObAD5/gxLfbIz6fzlo9AwpFEzyYpymPudd/I/ync84dEFM0QoaSWVsT/X?=
 =?us-ascii?Q?CWIaRoe8qTNrHxArJY1YPQYuWpMi9Ypg9zrTCsijTUOEpG+NaHLCkrrBFLZG?=
 =?us-ascii?Q?CfgjaK8WRKh26RojWUKJrdURQmZCzK5uoV5SdRsYUerGJIa1x4NMKd8/3ToG?=
 =?us-ascii?Q?3sqGMhXwlH6Jcs8W9RUborNvqCQ5cBUoQnHHODGxJaadbgwossIqt+mie3qv?=
 =?us-ascii?Q?qW1ogw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5yrYOBsnc9w/cWUzy7eFZl4yQe6k03kAuGAW2pagDFegNhaTEKNGY6N/ApLzcaffhDR9cJdspzX9GuNpii3z84YI3cWJ6pYnu+0ivXDNh1N43vNYEVOOIvDcsgz1O0/CrrWabHfYEKk8IjKKjtwNQTT9+fqrvqDrYOuBFNUYpD534qvL9U7rP/U1U85DtnPfib7pTePbZhloPRihcSkiQppnXZnvgElgP+1n5YPgSRWHdQK91NFFLWN1BEX+xecz4vIoOqa7Bi9B7ZmeMMclFkz351EI12+vkCPkLw2P27n2k5MQpW6UUPkJhtXBKOujmshNpFFkBjX/jbu4EPWjjQdtVtMDJWVUsrOMje9eYWHVNhrmTkmkEE1F/t4GujMJJjP8TMIJsTRiRsYqGioL0XRSAmy4IJ1F/Ik378uVo3bOzcKoW1bABEZF5w1rJ53
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:19:38.9157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b86eb9-938e-4fe8-45dd-08de65932513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

eng_id can be negative and that stream_enc_regs[]
can be indexed out of bounds.

eng_id is used directly as an index into stream_enc_regs[], which has
only 5 entries. When eng_id is 5 (ENGINE_ID_DIGF) or negative, this can
access memory past the end of the array.

Add a bounds check using ARRAY_SIZE() before using eng_id as an index.
The unsigned cast also rejects negative values.

This avoids out-of-bounds access.

Fixes the below smatch error:
dcn*_resource.c: stream_encoder_create() may index
stream_enc_regs[eng_id] out of bounds (size 5).

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.c
    1246 static struct stream_encoder *dcn35_stream_encoder_create(
    1247         enum engine_id eng_id,
    1248         struct dc_context *ctx)
    1249 {
	...

    1255
    1256         /* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
    1257         if (eng_id <= ENGINE_ID_DIGF) {

ENGINE_ID_DIGF is 5.  should <= be <?

Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
end_id is type signed long, but there are checks in the caller which prevent it from being negative.

    1258                 vpg_inst = eng_id;
    1259                 afmt_inst = eng_id;
    1260         } else
    1261                 return NULL;
    1262

	...

    1281
    1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
    1283                                         eng_id, vpg, afmt,
--> 1284                                         &stream_enc_regs[eng_id],
                                                  ^^^^^^^^^^^^^^^^^^^^^^^ This stream_enc_regs[] array has 5 elements so we are one element beyond the end of the array.

	...

    1287         return &enc1->base;
    1288 }

Fixes: 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++++----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++++----
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4e962f522f1b..d8c1f1911c37 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1230,12 +1230,12 @@ static struct stream_encoder *dcn315_stream_encoder_create(
 	/*PHYB is wired off in HW, allow front end to remapping, otherwise needs more changes*/
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 5a95dd54cb42..732f7bfb9103 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1223,12 +1223,12 @@ static struct stream_encoder *dcn316_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index b276fec3e479..9c4a31c0224b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1211,12 +1211,12 @@ static struct stream_encoder *dcn32_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn32_vpg_create(ctx, vpg_inst);
 	afmt = dcn32_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 3466ca34c93f..3e760a9a8812 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1192,12 +1192,12 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn321_vpg_create(ctx, vpg_inst);
 	afmt = dcn321_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 45454a097264..09ed0d5e50bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1274,12 +1274,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e3c587165807..39ec7d5e6803 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1254,12 +1254,12 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	int afmt_inst;
 
 	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
-	if (eng_id <= ENGINE_ID_DIGF) {
-		vpg_inst = eng_id;
-		afmt_inst = eng_id;
-	} else
+	if ((unsigned int)eng_id >= ARRAY_SIZE(stream_enc_regs))
 		return NULL;
 
+	vpg_inst = eng_id;
+	afmt_inst = eng_id;
+
 	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
-- 
2.34.1

