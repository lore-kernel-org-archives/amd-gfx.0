Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08597C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72BB61447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72BB61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646F26EDFE;
	Fri, 14 May 2021 04:51:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF91D6EDFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq/MeNJL2B9M/mS/aGZos6/KL6RpTw7TaUQ2+d3YPSA4qFmuwCenuvtTHPOCgV20SoI1dYk/zbMae51v4nskDAYFf91ujSbdlv2Emo9LySRxQbQ8s+qQ06hNir8nCaBt4CjuG1WnPDSrxyVgJlbkxP8LcMJu4zoLgErXb5Njgq8NHIY70BqD/8LQ9R+FkLroRrN9Q3fBLsLkBVnm9+6Pr1wuqNjbeNnuc0kUu6JEw939FqwcaaxED9SA4IT7EDcrQm1fRTdrSU0MgxIYqJei9m2Gh0zyxa1ofe/NxO9ITjzc60VTF4FmfcWrlcXi4J8X4wufp0THOUMirre4yvpT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESY0VcB2On/s5pdL0kFhQnNAyBOvtoQKceu/azPgzUQ=;
 b=hrvi0i3N4oepdV/WPM4RRTcQ1TZ8BL1gR2HPLmmcvMRs/uv8u16YKGF54/JzoAQMLiBe370ZCUdy6+Iaif+jVVjrAtBqLu5hwYHg+TD5SQwWd1TZaitTEu8lXmGU08ijATxKpv8Y1hYP6AhR94lxIArY0TuSHwp1Ddcc1kiy/KEzcA8F8b2aT0y+zfceYS6/hZXRQmJOq5xfVO9tfdUsYmtpbG4QMeD1om/HawJQteiznoYrlOYd2iGbKVtz0C1HQtr05WjPWEI8KG7weIkGyYCtPHXoiShOTOljrx1O7uuDwJzE4qZtOLbfIdkmeYQC93tAXH8Ri1UztBZf3Nr/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESY0VcB2On/s5pdL0kFhQnNAyBOvtoQKceu/azPgzUQ=;
 b=coIFQJJId+NRPC/ltAxxF7QR/gDIiNQ4q2ZyxDc3NNzNyKXVOpErzlhQzu+G/4jDzRaxPpxf6gjduYRwgxvB35OkAs2HjVAahdPQvf7o2/ii19l2kAVMRLqpP8Mz4asS79PDxCDhlCnMKxNb+kLfNjmdbD/wDzmR7T6lf36qPJs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:10 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:10 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/20] drm/amd/display: consider channel coding in configure
 lttpr mode
Date: Fri, 14 May 2021 12:49:55 +0800
Message-Id: <20210514045003.3069681-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcb02586-0606-4acd-2e09-08d91693e484
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129EC9E2FB7799276CA75C1FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbOeEgYjgsUadfW6Hh5z36HEGhlMbQ8IQjBvtFXpQCLL+mE3LR4PsgaT5lExDPR89gFKXgaQdL/HYFq0Uawu1Tgz2JT2Azv2ZWHtZssGBEN5aYSZYjLdzPaAaundUPlFTlJq8ZXH9HxwCrdO2KWiArgmU/Yi3KeTV+XSW4KUvm63eBtSGwuk5VHfIOAV/AihCjarBB6DZ4NGXwKrrfYVZjOzadN9kUGw20o+HWeejXPPFBP3YO/4LfYcRwAb7ELGvLvJrtDZKZ3jbt2iRRMk/EGMfJK7O3tIp9f36HbCrGEbAEvd9Tq5t8tCP6mT2rx106xgI9qf+bbarFC5Oq8VviYSJpBfiBDrRFqD8VruDdf11+i5iqpmbXOobtcUAuxCVc9JL718pN1suf+hqQc20Hc4M9DfBXWcBBHFYf9CDonN5S1J2phx0BauHSHPKPRavqXtBJpF5EU+p2QyzBdRgtIpZn3pjUIpGyOeBps108yTS7X545KTWo+5v6PAcFLTT4pb70OU8ukDPyg2B6YYEFhd1bMlI391ANbLvzpeX7iAJztT4wLxpwmaYTzZRwvDdUSSHRW6yUqll9cgQmYcWsojczu0OPlMee4lclIHnflQVUcOSDeM/Bs4NjsEVxqG2SisPKCaPjsLmmJlcV7+7L77Mxc45QuHO2gtJbte3Rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(498600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7sWmSwODm5cG+7TPpTPj1WG1UA+So3n/RQ0OdsIkHIKnxEZn4FOpqsp161mr?=
 =?us-ascii?Q?oW5raKRgBoNUQuYbCDNJ1oTGNgdzVPbHRMgPEvzLbXU7nT6BrMm+rr8XfxEf?=
 =?us-ascii?Q?I98nAx+M4pgSd7oV9OtXYxoZFmb8W/5UIRBkioK0BErB5QdSM6C0X+VIidIy?=
 =?us-ascii?Q?C3ms61x/8kUXvs8ZBjPqr6PEJcbMHOQtLwi4p1tB5vmEHdhrukwy79MWr7Ec?=
 =?us-ascii?Q?wUhJBZynE6bCue+wkoj/xF/PQwVY1me4IXv1wqJVv7CKGpCJlixO4TUgdSP+?=
 =?us-ascii?Q?2N0eMljHA7swT0ltXHUEoaGAqKWoCpah9DKzQMIekfV7R9brFpqn3bIxBEbT?=
 =?us-ascii?Q?GSjbnE57pMhTJYnGkPjnxFfo0WrNwb71pSf2yRA5Tz8hS7/KRI8wyEMhpMF9?=
 =?us-ascii?Q?QJZozjpPOtj4POQrRTrgzCL+8Z8haBqDluQL3L9Fk3Ac0CgHpCPbZ0urcdj2?=
 =?us-ascii?Q?XMWAtZo51Bfpkh563k8Qy6tQC+SsIptaVFUV4haYngToGjTFrXrYjBChoHpM?=
 =?us-ascii?Q?806JC5Ps7KvOdeg7zii40guP+eWTLhCtkt0mYyxNZKm0lLMA3Ma+f776E0JQ?=
 =?us-ascii?Q?cx6puPBQBE7/xEkK1frfsqQtut9F030OtWAFMKmlLwd5HxYEwFrG/rMvuQB9?=
 =?us-ascii?Q?sKd2r8Rm3uQI7jg3XAFCbLP+hK9dtUA2hRu4EZ+BOmRPEggfakgIeprljhJ4?=
 =?us-ascii?Q?aGI/SgJlhO+BxKNDLuYX6jEwv/6n7MXW4ZLFHrzunJHy2c6eZzG4htOECw0X?=
 =?us-ascii?Q?rG7yxAG1DOA/H51VfB7T5SVm6MGzSiuFlLvLNChzU4kLxUf22WFFZjgU72L7?=
 =?us-ascii?Q?uzlnJelOAIbXUNWrv39m3qkICNd4D+/iq6r3d1KieVE56s9nxg0Dw1GUeep9?=
 =?us-ascii?Q?VDaiNkTfIwXjncYkaUvoipFnKQ50hyAXVOxPbr6gzx36MZp9EabmJW1wE99c?=
 =?us-ascii?Q?JlGHGUjWoCN8SJmOpdwJopwnUCa+j3HjR3zrNoTAjXxlCCkKKAFo208p5/Pl?=
 =?us-ascii?Q?IUoaW82sCIB+MgojMxcAu/fxfmAurzjlqjZD2jbWEBvtUoP+1jNYhTQX1c86?=
 =?us-ascii?Q?+DLGgUyzU6i6knvFZybuCoTH0HsDklJhz3HnwxwD4N6iS8bfikae1VmQ5d7S?=
 =?us-ascii?Q?YTSt/OCCDA/SDVDtfroyfSbn5rAI0cgqh89nWJPpxAj+G+Oza19Ur16H1Dss?=
 =?us-ascii?Q?IM7GzliECH7MNW4+SpimR9LEJ02RBWrLnOFTIjo4OFrqlKbOdeimfD96eNew?=
 =?us-ascii?Q?RAnOSAwz5F6QRc6GNAK5tAE3mugOb+UcmFqjKBrpUKwprP5KLyw+ib/KEo+j?=
 =?us-ascii?Q?eWBPcnnDGXTRSCsxTHQt8I5fOrtJOeSw9qw2qByGMotUKA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb02586-0606-4acd-2e09-08d91693e484
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:10.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaREmbVndSmGb9p9DfBdCvqzfpHQ6KyR6YA00h3IOMVqCg7tOWGNS1KR2TozVraCI20yibaKaMueszxJSfQq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 George Shen <George.Shen@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Some lttpr configuration steps are exclusive to 8b/10b channel
coding mode. We need to take channel conding into account.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Acked-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 47 ++++++++++++-------
 .../amd/display/include/link_service_types.h  |  1 +
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4b3467a5d2a5..e860d7cd4fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1275,6 +1275,8 @@ static inline void decide_8b_10b_training_settings(
 	else
 		lt_settings->link_settings.link_spread = LINK_SPREAD_05_DOWNSPREAD_30KHZ;
 
+	lt_settings->lttpr_mode = link->lttpr_mode;
+
 	/* Initialize lane settings overrides */
 	if (overrides->voltage_swing != NULL)
 		lt_settings->voltage_swing = overrides->voltage_swing;
@@ -1367,13 +1369,16 @@ static void configure_lttpr_mode_transparent(struct dc_link *link)
 {
 	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
 
+	DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Transparent Mode\n", __func__);
 	core_link_write_dpcd(link,
 			DP_PHY_REPEATER_MODE,
 			(uint8_t *)&repeater_mode,
 			sizeof(repeater_mode));
 }
 
-static void configure_lttpr_mode_non_transparent(struct dc_link *link)
+static void configure_lttpr_mode_non_transparent(
+		struct dc_link *link,
+		const struct link_training_settings *lt_settings)
 {
 	/* aux timeout is already set to extended */
 	/* RESET/SET lttpr mode to enable non transparent mode */
@@ -1383,11 +1388,16 @@ static void configure_lttpr_mode_non_transparent(struct dc_link *link)
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
 
-	DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Transparent Mode\n", __func__);
-	result = core_link_write_dpcd(link,
-			DP_PHY_REPEATER_MODE,
-			(uint8_t *)&repeater_mode,
-			sizeof(repeater_mode));
+	enum dp_link_encoding encoding = dp_get_link_encoding_format(&lt_settings->link_settings);
+
+	if (encoding == DP_8b_10b_ENCODING) {
+		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Transparent Mode\n", __func__);
+		result = core_link_write_dpcd(link,
+				DP_PHY_REPEATER_MODE,
+				(uint8_t *)&repeater_mode,
+				sizeof(repeater_mode));
+
+	}
 
 	if (result == DC_OK) {
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
@@ -1407,17 +1417,18 @@ static void configure_lttpr_mode_non_transparent(struct dc_link *link)
 			link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 		}
 
-		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
-
-		for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
-			aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
-						((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
-			core_link_read_dpcd(
-				link,
-				aux_interval_address,
-				(uint8_t *)&link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1],
-				sizeof(link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1]));
-			link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1] &= 0x7F;
+		if (encoding == DP_8b_10b_ENCODING) {
+			repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
+				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
+							((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
+				core_link_read_dpcd(
+					link,
+					aux_interval_address,
+					(uint8_t *)&link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1],
+					sizeof(link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1]));
+				link->dpcd_caps.lttpr_caps.aux_rd_interval[repeater_id - 1] &= 0x7F;
+			}
 		}
 	}
 }
@@ -1611,7 +1622,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 
 	/* Configure lttpr mode */
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
-		configure_lttpr_mode_non_transparent(link);
+		configure_lttpr_mode_non_transparent(link, &lt_settings);
 	else if (link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
 		configure_lttpr_mode_transparent(link);
 
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 73ada16658aa..7a30ca01e7d4 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -93,6 +93,7 @@ struct link_training_settings {
 
 	bool enhanced_framing;
 	bool allow_invalid_msa_timing_param;
+	enum lttpr_mode lttpr_mode;
 };
 
 /*TODO: Move this enum test harness*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
