Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2022CC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDE32067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BwGejbOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDE32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931416F4B4;
	Fri, 21 Feb 2020 16:04:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206236F4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VELtpTf2/F4jjDySceXJOAAyMGhXzu2KmIaGpeGBTmXjiiKSi7ZhBy2dti9G/AEPf6kaFW5c1i+YJqSNoCAZZFF8ZwDdjDcjyVXlDUhlHGl3omFZ6nha/zmIOMjlV1nrXLCKKk8JCCm3KofmfiMxISGgg/wywbkDLjnnPjqb/C7wPhv2vflwfkkdpl/Y1ozqXR91NP2a1cuf9XLDDWpEY/yr1Kf1V6k77nIY6bKAqaMW/zCH5Fh40ncGceeSn5JK4c9tsnGJW3kshsXoDpYhyuBA+oaiDG8qgtOTSdL/wH0evQFYh9cucpH+PctKbYhxKhtlYYJccxrgNDDq3KmMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKgyIQNVmRbhzkKI06QmVNgtolaycPoOf6oPnucN7ak=;
 b=YTDhUQozyJVAKDxbxZgD+dS3YLBbUJq3pD7/NkCLcI1RjRLpU1y8VvGXPrva/FaaMxiYQXQGoOvLlVOU7UngJm5S0xEhFYcD8UtMPe7+LkXihkva9OSw/uglciTjT0g7ePCFD2jWrppWITSbAi9jO0swiHYZJw7wtRp+Mb5gNgK9Dkhogo0IIl0AEHwgcwL2Bn8d2VaG4EfheUG92SRcvpp5Kj1AP6XOelUP9uJ0ivDE/7sC7/CtVbUS3x5u1Ly6bX/dbeqBwgGJgfP3Y3BU2RYrJFcGU02qleyv5Kfj5X1nrURhUpKPvHEGKtPV3u6QQZE98P6Nqoh/uEXZQfXzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKgyIQNVmRbhzkKI06QmVNgtolaycPoOf6oPnucN7ak=;
 b=BwGejbOkIJlNCnvwJ5Yz6FLwTUdeuhwiP0Pu3Y4u5gE8+e3iSFvEI11NoNe3QvjAD9m9Pz4nb3NvQJkVDr+JnR+jwpyP4t5Qy8Zk3a+3rsXo0z9RomRfd2CD7q3wCy7c9u+cbGpL9Lt/v79VJzVI8gR0NzQcRUt9fgqvYHb9ExE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/35] drm/amd/display: Fix RV2 Variant Detection
Date: Fri, 21 Feb 2020 11:03:17 -0500
Message-Id: <20200221160324.2969975-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:10 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 616b67ef-36e3-4d94-2442-08d7b6e7b057
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409AD729841378C32CF274A98120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84y5LykzY6wQG7qm24rop39X4hGOWYuAa/E9o3bDTZIdzlgCcP1+Ycp4gDXakA+oOlej3Q8HVvoAz5uyWqq3v/LqCyqYVhqeIdIyWU4azNkvPFpkv/wVfJPYkzrDIusfQ/THSDYqHMK2EP8DtmagltR1MTD17KVkFLuXzfWECGZsuzUtqFYoHMc+1GIMn8tApyLwyaaOigBwvVWNX4p6kzI2oYfnb9EiXxqETSqFRfjau/UIolGWywMFt5MXtQDDTs8BP59v6PgVHfRXFQku8fVWscVYWQQOEy5JgMW4grI1Zm6E8DLN+Amtm1xHaOd+wi/s+l591lkw2JPNeyRPeUlOnyc7KpqdV3ldy8wDq4D65B9M0JhzVQbpeYO3qTUex+Q8OZN/7dKIng56qrMw2TOoybA0RMuqoAzWCDOha0CWaAarLlUPHkOLFfMlQ/RX
X-MS-Exchange-AntiSpam-MessageData: y23AiNMzR/e/vuzNxtn/bp/AADPJbXS8WtIcmv2MfCA/kLQqTnbRJYdBNyzEifq1BYYi16AKaFqBUWuyS92+ZLnQciK4drQEaYR1cpmdya1zBH4jNF1H5lumJ8W/p5lL1kd57mc3/n4+GK29qpbLOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616b67ef-36e3-4d94-2442-08d7b6e7b057
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:11.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtYndjh4Ao72CDgZPQtsYINHmKpdjihfkMWBHwUKLMoNv+Sl28upP34eSiH3JpZeNb7sJd28feMRC/M+nMhFvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry Wentland <harry.wentland@amd.com>,
 Michael Strauss <Michael.Strauss@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
RV2 and variants are indistinguishable by hw internal rev alone, need to
be distinguishable in order to correctly set max vlevel.  Previous
detection change incorrectly checked for hw internal rev.

[HOW]
Use pci revision to check if RV2 or low power variant Correct a few
overlapping ASICREV range checks

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 20 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  7 -------
 .../gpu/drm/amd/display/include/dal_asic_id.h | 12 +++++------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 1a37550731de..f0f07b160152 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -703,11 +703,19 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 }
 
 
-unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev)
+unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev, uint32_t pci_revision_id)
 {
-	/* for dali & pollock, the highest voltage level we want is 0 */
-	if (ASICREV_IS_POLLOCK(hw_internal_rev) || ASICREV_IS_DALI(hw_internal_rev))
-		return 0;
+	/* for low power RV2 variants, the highest voltage level we want is 0 */
+	if (ASICREV_IS_RAVEN2(hw_internal_rev))
+		switch (pci_revision_id) {
+		case PRID_DALI_DE:
+		case PRID_DALI_DF:
+		case PRID_DALI_E3:
+		case PRID_DALI_E4:
+			return 0;
+		default:
+			break;
+		}
 
 	/* we are ok with all levels */
 	return 4;
@@ -1277,7 +1285,9 @@ bool dcn_validate_bandwidth(
 	PERFORMANCE_TRACE_END();
 	BW_VAL_TRACE_FINISH();
 
-	if (bw_limit_pass && v->voltage_level <= get_highest_allowed_voltage_level(dc->ctx->asic_id.hw_internal_rev))
+	if (bw_limit_pass && v->voltage_level <= get_highest_allowed_voltage_level(
+							dc->ctx->asic_id.hw_internal_rev,
+							dc->ctx->asic_id.pci_revision_id))
 		return true;
 	else
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 2f43f1618db8..8ec2dfe45d40 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -153,13 +153,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case FAMILY_RV:
-		if (ASICREV_IS_DALI(asic_id.hw_internal_rev) ||
-				ASICREV_IS_POLLOCK(asic_id.hw_internal_rev)) {
-			/* TEMP: this check has to come before ASICREV_IS_RENOIR */
-			/* which also incorrectly returns true for Dali/Pollock*/
-			rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
-			break;
-		}
 		if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev)) {
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			break;
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index a2903985b9e8..ea7015f869c9 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -136,8 +136,6 @@
 #define RAVEN2_A0 0x81
 #define RAVEN2_15D8_REV_94 0x94
 #define RAVEN2_15D8_REV_95 0x95
-#define RAVEN2_15D8_REV_E3 0xE3
-#define RAVEN2_15D8_REV_E4 0xE4
 #define RAVEN2_15D8_REV_E9 0xE9
 #define RAVEN2_15D8_REV_EA 0xEA
 #define RAVEN2_15D8_REV_EB 0xEB
@@ -146,14 +144,16 @@
 #ifndef ASICREV_IS_RAVEN
 #define ASICREV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)
 #endif
+#define PRID_DALI_DE 0xDE
+#define PRID_DALI_DF 0xDF
+#define PRID_DALI_E3 0xE3
+#define PRID_DALI_E4 0xE4
 
 #define ASICREV_IS_PICASSO(eChipRev) ((eChipRev >= PICASSO_A0) && (eChipRev < RAVEN2_A0))
 #ifndef ASICREV_IS_RAVEN2
-#define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RAVEN1_F0))
+#define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RENOIR_A0))
 #endif
 #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
-#define ASICREV_IS_DALI(eChipRev) ((eChipRev == RAVEN2_15D8_REV_E3) \
-		|| (eChipRev == RAVEN2_15D8_REV_E4))
 #define ASICREV_IS_POLLOCK(eChipRev) (eChipRev == RAVEN2_15D8_REV_94 \
 		|| eChipRev == RAVEN2_15D8_REV_95 \
 			|| eChipRev == RAVEN2_15D8_REV_E9 \
@@ -177,7 +177,7 @@ enum {
 #define ASICREV_IS_NAVI14_M(eChipRev)        ((eChipRev >= NV_NAVI14_M_A0) && (eChipRev < NV_UNKNOWN))
 #define RENOIR_A0 0x91
 #define DEVICE_ID_RENOIR_1636 0x1636   // Renoir
-#define ASICREV_IS_RENOIR(eChipRev) ((eChipRev >= RENOIR_A0) && (eChipRev < 0xFF))
+#define ASICREV_IS_RENOIR(eChipRev) ((eChipRev >= RENOIR_A0) && (eChipRev < RAVEN1_F0))
 
 /*
  * ASIC chip ID
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
