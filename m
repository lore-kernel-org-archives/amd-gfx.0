Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E23C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFDA10F71B;
	Thu, 24 Sep 2026 18:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fbImGk6d";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D4510F71B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVEGQfMzS3z3hp0zkvNz8YUemS7mh50ADubto/xLqdad6C4acA+BSzhzhS3lLB67RDGaeZCFkGCfnHOfgOkMPaqfaquCzbihUP6YljKmoSasToBVjeNZcVSYidfBCVyjsjOajNVExzRNXKQ3k9gmXdmymLqwfm1EZ1X6EmOp1dlbp3CF9x1f9+0gyv90EUUdg/cENfn0VtLQDkyeQ9VK/5NQciFcB1Ykxju34KwvyzqHfYtKjIWGvEl4AVmZt9lFsPaE6KjLonrezOvlBSGYzSlejEuLUBSClaloIxmTS2cDwd6i6iTxYG9uMUglIxPNReS9RrrmVfKg8YxoRe1geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oaE71HQwPhREcqTPxCV+MbWvsxJNa59JWKInZXNB1k=;
 b=ocFG53XfSG2GXQhs+zhiWibZohbgRJdDjAj6UjjTmQBmV78rMvz+M7lWMtTOV6++1HXpDRs6UMn2lbQ0AQ3k3ZWjaeX69auh8WGKvOf3aJsAprfmjoB5r055hfm3Jl9jgyi2erBhg6AxicPk7ciTjBg15/TG0jK/X+hjNFN8oyl7/Pdta1pDAGeebLGd9XJYhUoAzpXEw5AYuvk9U70gzLOqUFGLc9s47dKDmnnHjo75VLne3SDHlu7tmYk3ekv8qNKg3zLz0tTRflQFGbRSy6n/WcWEJeQKoDSu4VQ4nU/+6y8Ystt/FwFx4Ut6n9UHeHmFnqqe3PwIwG8frBpOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oaE71HQwPhREcqTPxCV+MbWvsxJNa59JWKInZXNB1k=;
 b=fbImGk6dtbENvMbv6CnYPjcBKFO13tlEPkgsyTMjX6cvr8CqMrtBgo73YeF1zjUM2xL9s5I6X9w3K+6XK87o77ZRqHDq07O45r0CZ6mnOKF9/Q5eRJ7s3usP5JN87kHcyxtR8+wvoTPWd/IfXTn0NqsaBfrYtA2QMi6ro4Qdpd0=
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:05 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::52) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:05 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:00 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 01/34] drm/amd/display: Move struct dtbclk_dto_params to
 dc_hw_types.h
Date: Thu, 24 Sep 2026 14:45:14 -0400
Message-ID: <20260924184824.596894-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffac632-1f32-4e78-2223-08df1a6c1706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7Qf2oqpFH1YMvqc7AFqZRqGM1yJIzVetZOCXiLO6whREK+ztTNkdv3Bo4dPagpskkJB9qaZbPGuBubuv6n8NxB5SaPbmWODI8a9EWqpZLZccbSP8hSIGXu3/rqujeewyqpG1rrXqbczc7wvJ2xUKCizBs6ML/0M1vYMcGp46IUzSF6LR1t2lHG5b8MRbqoldm/n9GdeTAtPOTJpUc3trnUaGKBBG4YTg+jmjE0YLtXNiv4eslR7eWYjJhh2IsxvoKQLIUvqq8U7JsmkLAfq92voAus3FNQF7p8LOEXMemc3sJZQrSLNTFozUNeU1+pXwaV46TK5kzMuJH3kP/rEu8sdpUQJt8vSQO4JllWXOMk9RUXB2VjBKqZiTdCxt49aAMHKuvvLFz55J5qblHN+e3lvKImibRtWeVelK9GYiyhn2yyjjD16obf9qNoh3u+NhCgbnIlphewClaY1OVdjKE73Gh4sa4qT+uqwVOgYLkhhb9MJ/p6zMfx96bMbPJD29zGncgV4z+fNRxUtU31b4YKYVEQhITxKgPyrGWwcm0Vey8cwiyuLpqW8XrM167cG2VgEAEDxOhqzYhGQk7RwljyHZM3fIOqbT6fwtZi9glRFtTUi9UauTcpY6lgZUbDhKsDpQAg0U+0fQsrxiD91aoSKaH2W1qqwu5yhmRqA3ntAdqemjL8STqZrOHmMISBI3d6JbfJw3CIR+fuwgGe2fDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0sZyz4NO6NGNwPtoPFkgaIkukHx+qQKRBPtb4sZ7W6ASCIdTOFRKUSEawlY7M+FPI0898K+IHect5c5X6iwwpTqUTTkG2u+nWD6+bjVvYgF3usB7Z9rc4kqkb0rx2XdwHybSmkiwyqj+G8d991GK1NF14g7NfB9b6tOtHprArS5Qo2ASy8pZAY8XzGoFozEtbAN4tqtEL/9rU6nuPpLbP2tF2G3kRJTzWEfUVH6tv9aI8zyyXY97sbGM4GByLkwfDL7uW8fJyd8zS2BHTbbsvx2j4JsAh+DQURRPmzD2NXdWSq/8sZuIpgysS4xgkVV2JUzwZI2XPHaP4HOzGRReQ1qj75T8w30EnRf50ZUJUsTbiCHSwc3SMUgKB6NB/b//NxvbrR4/c7CqhuhzwialV1QgxWSzrUzYcIUqyWz14ORpKRNfGMF+MqRIXrXoJ3g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:05.3678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffac632-1f32-4e78-2223-08df1a6c1706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

From: Tony Cheng <tony.cheng@amd.com>

This can simplify includes

Assisted-by: Cursor:composer-2.5
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 40cd4e5d1340..baf6091bb52d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -1086,6 +1086,15 @@ struct dc_crtc_timing_adjust {
 	uint8_t timing_adjust_pending;
 };
 
+struct dtbclk_dto_params {
+	const struct dc_crtc_timing *timing;
+	int otg_inst;
+	int pixclk_khz;
+	int req_audio_dtbclk_khz;
+	int num_odm_segments;
+	int ref_dtbclk_khz;
+	bool is_hdmi;
+};
 
 /* Passed on init */
 enum vram_type {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 4b7c55eeb0c6..1fe703e866fc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -201,15 +201,6 @@ struct dccg {
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
 	//int ref_dtbclk_khz;/* TODO needs to be removed */
 };
-struct dtbclk_dto_params {
-	const struct dc_crtc_timing *timing;
-	int otg_inst;
-	int pixclk_khz;
-	int req_audio_dtbclk_khz;
-	int num_odm_segments;
-	int ref_dtbclk_khz;
-	bool is_hdmi;
-};
 
 struct dccg_funcs {
 	void (*update_dpp_dto)(struct dccg *dccg,
-- 
2.53.0

