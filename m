Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E08C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5354361A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5354361A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27F46F4B4;
	Fri, 26 Mar 2021 22:06:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741B66F4B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfBKnPH3ZbO8W8RV3I5OEJKMfRUKkjsJSB8N3k0s9NuYOY+64E5Gzwd+/3uS4s8mtKDd5VGdnwyI7zUOA2yUToMN6gCmj2bNklzlh1xmsCQYcHzs81zKHXc0HFZpGGw7tB26YBefQ7AHyGwVFpNXZ57qF9cwu46hXBBVLllv9w7IBNmQKEgUlOFBUvJup91Z8GLrKO3Pv54gqOitGCoLdB3T8F4mPc2u82CMDJMUxTgjdWwaVWRgaFX1L4W1pWKwy8A2s6ZWt34p37ofMFM/y/P1pMM3EE2HAcnx20w0m9IaN91B5A4oDAm9jwjqQkpbsajYnAIi9x/i7HW5GhAkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SkIVyeDOjrUweAvey23QBp8bP+D40pE4Kwgp3h8MeU=;
 b=M55wcaUc8l6KbUPb6F8SKjpQT2z1uc5OilY7pzbcfg3a4HzQRkMTxGYi6N4WaSGBj5X0Z38d2Rguxt12CWKc391z+Y6V7hmTaTcqa6ElTV6zJSaqBbBEi9kWvkzPMS8/pXWHKQUdvxKEvN1aQUGe+6sfBx7yfbRJiMk4NK2OYeT4qR+G11niPfevqTbxSIMDTRAzhlv67OQtXOb4zkehqDjw05r/P03ech8ifH14s42UP7W5tidVlzYr3n8W9eGIWXnZOkiDN7EguYODjSogCquyKto5Wb/bgG8iDi1d0eI0a45iJTul2KuTAwOJhDLb9lWauO8SLHnjjz4KRojsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SkIVyeDOjrUweAvey23QBp8bP+D40pE4Kwgp3h8MeU=;
 b=os1K7E0Z6j0SCjB9+mr4EY0yj8ejCe2cZ8wZ95iJ0BSxLWUZTF7SiC8ejnTYLtkSRaFw0Cjcdxr7iBPJBEDrUVYa2BCnFGJm/SScKbKz+wVlalDuuPM5CuESFKWjtKif937mqUEDwEx0cOZJiv8Qb3dt8fLdysbkT7/1iE2xR1U=
Received: from DM5PR07CA0153.namprd07.prod.outlook.com (2603:10b6:3:ee::19) by
 BN6PR12MB1505.namprd12.prod.outlook.com (2603:10b6:405:5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Fri, 26 Mar 2021 22:06:02 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::a) by DM5PR07CA0153.outlook.office365.com
 (2603:10b6:3:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:01 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:00 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: Rename fs_params to hdr_tm_params
Date: Fri, 26 Mar 2021 18:05:22 -0400
Message-ID: <20210326220534.918023-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1bc156c-f4ec-4940-1084-08d8f0a35827
X-MS-TrafficTypeDiagnostic: BN6PR12MB1505:
X-Microsoft-Antispam-PRVS: <BN6PR12MB150566FDC20C9EBA0AE7C12BEB619@BN6PR12MB1505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMHGux9qB3uNfnp52HhkQQ2kviLub74D3ZzC+LbClhHBISPP+edhnlodwTgu0OT9EOYAucjpeW1DOhac0FOBvJ30wnHJYQVFOxjYOuxHIeIwi0QzMh/CtoV4m5PQBET3c6c59DNkdDVC8Q/+vGsEpwxc4EA2YDzD23ePiN7Tf34p2U5+R9o38TBFZf5iTEr4Ut2QG4YYjSjJoMRjAkxRSz/NdsNhTERiRy84Muz6cDwexul31BCPF4qXZ3GGyxXj4AZ/i8kVR7vGGOmCXJ/3wuaKDzEUHOCDmJbnv3bZgyisJ5UdwNNMfSIQVCzP/3K/5mvZxiN80aYVO5myUZY76Rc1ijbAj92nicEhWNe1q4imbNklGFI5ouxI9zSQ20tqZtZoGFxR40u2kSTJm5irbYqLBesIQ3Cm8/OsAy38AKlJybB8nrZmK7WBq58Ao0qyiFdVeldh4hgPir7ucjasNWXsEBefiaxgBXm/rMp6DtkhPF3AixYk1eatSYxeIP1I3iCF43Y3PQtdwmMbUCkVBxeSHZ+//CdaDQTINOTNACkilRU+CK9tOox/Y1LL5CeitLUSvzFzn3SDzHy00JqNsABcBJqaOyRrmYyrfu+f8DUYhByES0bKG1a159II+OiryXLg/MSvHmksm+QYFn0y+XPh7gg5ZI2iYVA5MqC0to5ohgtb2J8WkSisqWypzgCZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(356005)(81166007)(8936002)(426003)(478600001)(83380400001)(36756003)(26005)(2616005)(6666004)(8676002)(336012)(36860700001)(47076005)(82310400003)(82740400003)(186003)(86362001)(5660300002)(316002)(2906002)(7696005)(6916009)(1076003)(70206006)(4326008)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:02.1276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc156c-f4ec-4940-1084-08d8f0a35827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1505
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[Why&How]
Renaming structure to better indicate its meaning.

Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 6 +++---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 5c67e12b2e55..ef742d95ef05 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -942,7 +942,7 @@ static void hermite_spline_eetf(struct fixed31_32 input_x,
 static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 		uint32_t hw_points_num,
 		const struct hw_x_point *coordinate_x,
-		const struct freesync_hdr_tf_params *fs_params,
+		const struct hdr_tm_params *fs_params,
 		struct calculate_buffer *cal_buffer)
 {
 	uint32_t i;
@@ -2027,7 +2027,7 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 static bool calculate_curve(enum dc_transfer_func_predefined trans,
 				struct dc_transfer_func_distributed_points *points,
 				struct pwl_float_data_ex *rgb_regamma,
-				const struct freesync_hdr_tf_params *fs_params,
+				const struct hdr_tm_params *fs_params,
 				uint32_t sdr_ref_white_level,
 				struct calculate_buffer *cal_buffer)
 {
@@ -2106,7 +2106,7 @@ static bool calculate_curve(enum dc_transfer_func_predefined trans,
 
 bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
-		const struct freesync_hdr_tf_params *fs_params,
+		const struct hdr_tm_params *fs_params,
 		struct calculate_buffer *cal_buffer)
 {
 	struct dc_transfer_func_distributed_points *tf_pts = &output_tf->tf_pts;
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 7563457e2ff4..2893abf48208 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -76,7 +76,7 @@ struct regamma_lut {
 	};
 };
 
-struct freesync_hdr_tf_params {
+struct hdr_tm_params {
 	unsigned int sdr_white_level;
 	unsigned int min_content; // luminance in 1/10000 nits
 	unsigned int max_content; // luminance in nits
@@ -108,7 +108,7 @@ void precompute_de_pq(void);
 
 bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
-		const struct freesync_hdr_tf_params *fs_params,
+		const struct hdr_tm_params *fs_params,
 		struct calculate_buffer *cal_buffer);
 
 bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
