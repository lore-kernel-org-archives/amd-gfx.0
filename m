Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CAAC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508CB2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xBnXfQAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508CB2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7956EDE1;
	Wed, 21 Oct 2020 14:23:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4856EDDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPA3p7nquIRN9QUZ4UdmXZstowUx4SLarlhVM9PVsw73gtmFXOucxuCg1Etf9/IlOEqKkZC7mHKSiDtrbc7xXyIUC+wqcCqDnBTya2Wc2qJb4k6/watsW8mcnr5ZuFf122wRnrMhMxbnzkwvkZmKtDJgtSCKhuuFJVCVyQglNtxkdG3xfSSMXap8XvxdyMML1Xn0B4JO0bXwEMSIr+utsReXVDFme9qWbjMab0jCaMwsKZQAekxIUUvXUep0/QeEvfQCg3mRe6dScTodm7LaKS3hANONTetrasfUf7iQP+/f7gihjXmq0YiB+6Z3QC7G8hnZ438S0btCmB+kGWGY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUIz87qADCCKFeFpPJgu2OI/2FXDrntwEKCU9+rS0yE=;
 b=n1XMqXHcd5o5prqcfXXD94sFg9EPaaR6jCzniM1uotpdWeUtihzzlsWICWZtPCqaqk6hkH64Ucb41MB3Eq3McbKZvEqGBCLf+NatfJaZ0Lkesw8XMRwLlyrNBhw4Q3FcO6CORi/4vRYr8mEfWD/AJzXj1WWTp6bZRWzp78Jp7GYbSsWOuNCYydXHCPzVLVph4uikoEdTNR6pyMsQU1UkT5HqkpUa7LsnaBIzyZDsDZZgDNHjAW1OVhhMxrw1LZ95tNmlEotL4+BFALTRT3XaslhvvtDxxbFWhNli83unYMRlSdejUz9/i9n6wef40OscX9r0S0KEkw8qeMTNeECO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUIz87qADCCKFeFpPJgu2OI/2FXDrntwEKCU9+rS0yE=;
 b=xBnXfQArQVOuFIkBYkPinih/IN5F6HPMN7USpbI3GFJU4yYym+m8QXQdajTkyOIBFjzOAbBHfkmPiwt7YT3p6dRko6uOBYZdo6m6U1B6TbcLTEhUGjFl8xKekK9/brb+9uO4k5VvMzExnn+Qp4gyzmk1Xuc7wv3rM30Bx4FyOE8=
Received: from DM5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:4:15::21) by
 BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 21 Oct 2020 14:23:33 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::49) by DM5PR16CA0035.outlook.office365.com
 (2603:10b6:4:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:31 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:30 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: combined user regamma and OS
 GAMMA_CS_TFM_1D
Date: Wed, 21 Oct 2020 10:22:57 -0400
Message-ID: <20201021142257.190969-34-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9772f89-a86d-4ea0-b9c8-08d875cce3ec
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802C0BD7FFF3484BEAEF6648B1C0@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPbt0fNDB+z6NfDQLwn+G3/HM9Oi0oY+I4qO3YWR1brX5qJpO8WovQphAFbQi3FMyLX69c00ySLKFkZhSunhhQoWtuRJQjXqHfsC781TzByhEgNPimCZi4KBkZZdV7Y6VkOdwwvqUaUIsERbDbgTdBRJsPLRvj4zLTDgb6Jp6sOtwTb/hzTPT+rVtdwFXYXLuGKolAXKiA57hGGJ4SQ3D69uC5ogIneF/nXs5nW+ehunUK0ZZEU2yCm/CCSGAbgQtdihA8xh0U6ADFpl3s1zM19s7GRIPaJQzBl8Prd8lnbMRzr3zQvJ3bz9auTTzo7JSYvkYVeWyvs6l+jRtIMkySPWwGxIZAr3/ve6Vj5ZycqVzqrRdNMGWv22VmKMvIEPR7wBEq+kd8cQFtkXJDXt7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(5660300002)(82740400003)(70586007)(70206006)(86362001)(316002)(8676002)(47076004)(81166007)(54906003)(2906002)(36756003)(44832011)(7696005)(82310400003)(4326008)(8936002)(2616005)(478600001)(83380400001)(356005)(336012)(426003)(1076003)(6916009)(186003)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:32.9656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9772f89-a86d-4ea0-b9c8-08d875cce3ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why]
For user regamma we're missing this function call
to combine user regamma + OS for GAMMA_CS_TFM_1D type.

[How]
Applied 1D LUT in the mod_color_build_user_regamma.
And Set the regamma dirty as updateGamma.

Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/modules/color/color_gamma.c  | 12 ++++++++++--
 .../gpu/drm/amd/display/modules/color/color_gamma.h  |  6 ++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index e866da639637..bbd025bcfe0d 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1737,7 +1737,8 @@ static bool map_regamma_hw_to_x_user(
 
 bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma,
-		struct calculate_buffer *cal_buffer)
+		struct calculate_buffer *cal_buffer,
+		const struct dc_gamma *ramp)
 {
 	struct gamma_coefficients coeff;
 	const struct hw_x_point *coord_x = coordinates_x;
@@ -1778,6 +1779,9 @@ bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 		++i;
 	}
 
+	if (ramp && ramp->type == GAMMA_CS_TFM_1D)
+		apply_lut_1d(ramp, MAX_HW_POINTS, &output_tf->tf_pts);
+
 	// this function just clamps output to 0-1
 	build_new_custom_resulted_curve(MAX_HW_POINTS, &output_tf->tf_pts);
 	output_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
@@ -1787,7 +1791,8 @@ bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 
 bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma,
-		struct calculate_buffer *cal_buffer)
+		struct calculate_buffer *cal_buffer,
+		const struct dc_gamma *ramp)
 {
 	struct dc_transfer_func_distributed_points *tf_pts = &output_tf->tf_pts;
 	struct dividers dividers;
@@ -1834,6 +1839,9 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 	tf_pts->x_point_at_y1_green = 1;
 	tf_pts->x_point_at_y1_blue = 1;
 
+	if (ramp && ramp->type == GAMMA_CS_TFM_1D)
+		apply_lut_1d(ramp, MAX_HW_POINTS, &output_tf->tf_pts);
+
 	// this function just clamps output to 0-1
 	build_new_custom_resulted_curve(MAX_HW_POINTS, tf_pts);
 
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 37ffbef6602b..7563457e2ff4 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -120,11 +120,13 @@ bool mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
 
 bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma,
-		struct calculate_buffer *cal_buffer);
+		struct calculate_buffer *cal_buffer,
+		const struct dc_gamma *ramp);
 
 bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma,
-		struct calculate_buffer *cal_buffer);
+		struct calculate_buffer *cal_buffer,
+		const struct dc_gamma *ramp);
 
 
 #endif /* COLOR_MOD_COLOR_GAMMA_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
