Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA9CCCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484B12A88B;
	Thu, 30 Jun 2022 19:14:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8602810EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCiwp/isemE3UrMtKmfoGH+BbND56hdnHf1vwmXVqDUQHrT05USQmiauHu/FL2CxN2GFHpx2lbuSJqCFKsdbaXW7CD6RolxDj5b5ySdv1Uo/1rLPgMya2HU8eTIYfHAuyMZHtkXQef/rCz9T7hwApdyaPTvIB18uicpWKM8dMFQ+3OOYbFAFAodd84GAqNbO4OmRDLJp0iVfs3E9sBe69wirX62MjQZpEhQPPiQRblYB8t//0HfwMOzpvoRT5XFdFrzL7BZZIqaIavBvl2dkXsBK4sUB1XUyaYoxEfHQNiG9vXRv7mB9K3GGxEe2zWSGVnhGh8qvnoERoAwmJu4NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFP3o64KIPvPSXe0VF6djVRlPVnXAGKuMpAhOvwpj+8=;
 b=DXdjhUU1l4FENumlVGLhyqZGL8bJoUwntEak42prPk+Ld2J1WkSRJ18N5YklRQCm0km5nDHJQHRuQb88KVL0OczlDg7YQO0woPl7ahVX38hPkGcLtkMA7BjQmB5uDVOAllfozbs/rNTGLLs9khQML9tMbOVcNvCoSF487Jz86w6Z5xUZ1048OsDz2pi3EJRzdDLX+K0ad522LmUK0thpvnGAePNT0Os1FoHprGtdE55BRWxw98Il7lM2f2h503/HhAE5avy8vlywDj5Oy4Tp5AJPlcsBIj0frj8BK0niMb07xBvoZgzaOFGwcrZUCiUNalnwa13aFrbTWWN3EGtc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFP3o64KIPvPSXe0VF6djVRlPVnXAGKuMpAhOvwpj+8=;
 b=OrJMmLKTbrjxDMzDDGF+2YWBht1Qi8EPn88i6oz2rh8Mp+83BZUp/9nMfxMQnqTKZsHdSqzQKNSOU9cGBrEmxzKVcX/JJk/GpcThEPxfq14nI3b+9ngb/tflVM9RUIfYvcdVzQ5nw8WNj8wllW/pgGopAMMQRFAWjniywncQIWU=
Received: from BN6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:404:10a::33)
 by BN7PR12MB2705.namprd12.prod.outlook.com (2603:10b6:408:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 30 Jun
 2022 19:14:24 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::c1) by BN6PR13CA0023.outlook.office365.com
 (2603:10b6:404:10a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:23 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/40] drm/amd/display: Fix uninitialized variable.
Date: Thu, 30 Jun 2022 15:13:16 -0400
Message-ID: <20220630191322.909650-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76345dcb-508d-4844-f95f-08da5accbe5f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2705:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTAB2fg6dyBwqgRQIWgJmpw03i6EOnjoUNIF41jZypXnSwPpdPwXLz1WCKHgOXT/+xXnJJbQ4VzEKa3idMO3VoLWLntHe7h4Iqr3FMtEPK+a41yvm9FOM0+fCBz2giCH7n8kPnPoj4hgbv0q5ePn9BpZMEKRqG+aVQ5W3lKn4GeIphArZyNxS69x75uWvaXa9FP0N4Ed/QbvVJKIjHIxFcjm5fCe/fu75n6ZHsqWaczd5zrpEur91i7vcngVK7A2NykimSUT0DFRS3KiruMPdYrqIjt2VFnp4/PbdKXtPGKpvHQCqNtvQ+ZkRA0hCa56Y7OH0JlSYf/snUXKY7g3lKjJICPoXlIDexRwOWgi86kJN0z5DPamYvw6axbpcsDDYmilyfpWQLBaPNoZX69VXdJvhrwcSTYV/wBTalwANaUPpPJWIPaXR9mE6SUMTeDaZaKX8FPBMK4E9vK+nKPh4rTnoohCR9cqKD2oNEiADSluFZHNROywz9Qm9cPlWwhjLHLXwFL/afVgoBPiJFl64++5HaDct0AkLvVssHZRVwdRasrcWuoE0JnSSjjHLH/jUBS3aInEzco6lEcSwi6macrkM/NxyQGLlLSW9Jej6RpN9jdMYuGNpQ5isbFISTx5pKu6lO9TuDArNy/ulQenthUAuRualq/DKDUAY/yU67v/H0qFBG/mHtxQ1IhwnahAImQ5qJs9YV7Gf5+aJ0rAvsG2qraD3FU63geJ1OE/liYpDXx6b0W9QGVDuFNaILRsziJQSMe7Z5sCu355CvY+UXYoaeHC2Pa3O6f4i9Mk+wO5aCakvOZ3soxHiVINcc2O3HQT+cvxLfauwCCITdjYcRZ60nAmnvOF7tXGYAJCJtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(40470700004)(8936002)(36860700001)(41300700001)(6666004)(81166007)(86362001)(70586007)(5660300002)(2906002)(356005)(7696005)(8676002)(70206006)(4326008)(26005)(82740400003)(16526019)(83380400001)(40480700001)(54906003)(316002)(426003)(1076003)(82310400005)(36756003)(2616005)(47076005)(478600001)(186003)(6916009)(40460700003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:23.9198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76345dcb-508d-4844-f95f-08da5accbe5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2705
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Meenakshikumar
 Somasundaram <Meenakshikumar.Somasundaram@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Uninitialized variable causes diag compilation build failure.

[How]
- Ensure that variable in question is always initialized before being
used.
- The variable in question is the USB4 DP training pattern. In case an
unsupported training pattern has been requested, update status
accordingly and abort current link training attempt.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 49 +++++++++++--------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index c8610a5dedfa..3b8acda50701 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -202,30 +202,34 @@ static uint8_t dpia_build_set_config_data(enum dpia_set_config_type type,
 }
 
 /* Convert DC training pattern to DPIA training stage. */
-static enum dpia_set_config_ts convert_trng_ptn_to_trng_stg(enum dc_dp_training_pattern tps)
+static enum dc_status convert_trng_ptn_to_trng_stg(enum dc_dp_training_pattern tps, enum dpia_set_config_ts *ts)
 {
-	enum dpia_set_config_ts ts;
+	enum dc_status status = DC_OK;
 
 	switch (tps) {
 	case DP_TRAINING_PATTERN_SEQUENCE_1:
-		ts = DPIA_TS_TPS1;
+		*ts = DPIA_TS_TPS1;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_2:
-		ts = DPIA_TS_TPS2;
+		*ts = DPIA_TS_TPS2;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_3:
-		ts = DPIA_TS_TPS3;
+		*ts = DPIA_TS_TPS3;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
-		ts = DPIA_TS_TPS4;
+		*ts = DPIA_TS_TPS4;
 		break;
-	default:
-		ts = DPIA_TS_DPRX_DONE;
-		ASSERT(false); /* TPS not supported by helper function. */
+	case DP_TRAINING_PATTERN_VIDEOIDLE:
+		*ts = DPIA_TS_DPRX_DONE;
+		break;
+	default: /* TPS not supported by helper function. */
+		ASSERT(false);
+		*ts = DPIA_TS_DPRX_DONE;
+		status = DC_UNSUPPORTED_VALUE;
 		break;
 	}
 
-	return ts;
+	return status;
 }
 
 /* Write training pattern to DPCD. */
@@ -336,10 +340,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
 		/* DPOA-to-x */
 		/* Instruct DPOA to transmit TPS1 then update DPCD. */
 		if (retry_count == 0) {
-			ts = convert_trng_ptn_to_trng_stg(lt_settings->pattern_for_cr);
-			status = core_link_send_set_config(link,
-					DPIA_SET_CFG_SET_TRAINING,
-					ts);
+			status = convert_trng_ptn_to_trng_stg(lt_settings->pattern_for_cr, &ts);
 			if (status != DC_OK) {
 				result = LINK_TRAINING_ABORT;
 				break;
@@ -421,13 +422,14 @@ static enum link_training_result dpia_training_cr_non_transparent(
 	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
-	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n"
-		" -hop(%d)\n - result(%d)\n - retries(%d)\n",
+	DC_LOG_HW_LINK_TRAINING(
+		"%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
 		__func__,
 		link->link_id.enum_id - ENUM_ID_1,
 		hop,
 		result,
-		retry_count);
+		retry_count,
+		status);
 
 	return result;
 }
@@ -631,7 +633,11 @@ static enum link_training_result dpia_training_eq_non_transparent(
 
 		/* Instruct DPOA to transmit TPSn then update DPCD. */
 		if (retries_eq == 0) {
-			ts = convert_trng_ptn_to_trng_stg(tr_pattern);
+			status = convert_trng_ptn_to_trng_stg(tr_pattern, &ts);
+			if (status != DC_OK) {
+				result = LINK_TRAINING_ABORT;
+				break;
+			}
 			status = core_link_send_set_config(link,
 					DPIA_SET_CFG_SET_TRAINING,
 					ts);
@@ -712,13 +718,14 @@ static enum link_training_result dpia_training_eq_non_transparent(
 	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
-	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n"
-		" - hop(%d)\n - result(%d)\n - retries(%d)\n",
+	DC_LOG_HW_LINK_TRAINING(
+		"%s\n DPIA(%d) equalization\n - hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
 		__func__,
 		link->link_id.enum_id - ENUM_ID_1,
 		hop,
 		result,
-		retries_eq);
+		retries_eq,
+		status);
 
 	return result;
 }
-- 
2.25.1

