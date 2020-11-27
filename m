Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9BBC63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB68206B5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S4Siy1Nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB68206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655986EDE6;
	Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2116EDE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxzTN3UOPqnjNd38OhY48WTmQ40arkfJJQIiueBTp/IrhNfF1+gbkJs73beuMEbW+nfvlTwqUoTB/0F5YSReCZn4tkQU7ewB3NbewJIOYRkFfu9SjedW8UqwsvLrcTmxsLw2aQk64k0Qr2unOsH/YSnltESNeym+Y1VaiOTMAhaAq3M4e7O0ueliiKFTsXxXaOFvhlYaJ6GGvESBtl3S9PWomzmRqUTtOajMZYcIbMgY/9R1LeGDwXPXCf8mMMK3KqaErhTiy+YPnX2dmXzzzrKsSgZIDiJUOmjnFInTCXY61S1LkGduy6Jxy7pMA7kOx1RpuE7hnvmxOCuOkGOUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/QcDfK8x1QC1OVH94jzktw57D998kojHgPZDmKFVVU=;
 b=AMZnRKe3uwsOp5hPFkeKZLAofmjcXdlFSKnNy25XycWZ7PAhwIlfB+rvPpo5MqSaUeV6ePndWKLXVKSXRQvwHvaF6Gd4zK172rqtHpg98ArFmOP9OuRW6mVAVDjwx0BI7Uo/pdo+WbrWzDvUB4qOXLsJEg9/NRtfxS/SjvFZadRv1HGs8bUUR0L5eRvdhtel7hMFqZZdnCEFzgANUTCUGaKGvUbRQmSSRf6Omk+ycpcOQFH3JkYLrUooPS7rSckmhvnEGI4FhVIpjsSuprm5d057kEXgZAx9e6rM0UiYyZXnB3Dh/oE5v/L+3zH0hRw7Dp6kL05SqdBhiXfg8lZR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/QcDfK8x1QC1OVH94jzktw57D998kojHgPZDmKFVVU=;
 b=S4Siy1NlHzWDLb9wyP2e5ZZPMed4xyoWcscj/JNpWCfve8Y4URR/9p6xlqBUTHPOyJUytWWOds966dAlQKJBmRLW8LqeVroKqSJieZ88b2Ci2xiV2qCc57uZaV2Be5mO0OD1LD5v2JjcdzVtipLH1YdHVGeZGid63H29Eciv2mQ=
Received: from MWHPR21CA0063.namprd21.prod.outlook.com (2603:10b6:300:db::25)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 14:11:19 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::ea) by MWHPR21CA0063.outlook.office365.com
 (2603:10b6:300:db::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:15 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:15 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:14 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: Add HDR3DLUT and SHAPER memory
 shutdown support
Date: Fri, 27 Nov 2020 09:10:59 -0500
Message-ID: <20201127141107.7731-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77733767-dd47-40a7-9eb7-08d892de4f7c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26705CE7DAEC5EDBE06D717B8BF80@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jCaLxfCejhneG+8x3EAjdxryVR0l8/QYRcx4v79rbG34dn56MlnpVOIm4vD5Ik0Ph3G4YHGwIb0GbYBkYPHBmUHekhdqon4FHB+lukCrwgN8PcMabl8pgoI9Xzauu/7HYSm6QNVF9RCCUCdV6H/co0oT+R2wOi0QHmtUA9Ln/T+sFbD5lEbnA73xbliUIPV6L3uLoXs92IFmy124dU0tQcwG9ZUQBtUHmbpMisAgLTEX/Mv76zqLU/u6zdQBMBRxGubLA7L4O5XPfg0NloM/KYHqLbYhb+HcQgMQBoFDZT73Zxi30D9aBRMYuq3kWuWO1drQiNqUxO0KlU3zCxuH3h9SQU42/9kxcBilp1taXj9j395lGy2gDgh4W0HAsdvFqiH8g8D3//ySnfw3UZt2/XxpfhmJJit+1UmjFdjff8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966005)(4326008)(6666004)(44832011)(26005)(82740400003)(2906002)(1076003)(336012)(356005)(86362001)(478600001)(6916009)(8676002)(426003)(47076004)(54906003)(2616005)(81166007)(83380400001)(186003)(8936002)(5660300002)(7696005)(70206006)(70586007)(36756003)(82310400003)(316002)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:18.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77733767-dd47-40a7-9eb7-08d892de4f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The HDR3DLUT and SHAPER memory blocks should be powered down when
they're not in use. This will reduce power consumption.

[How]
1. Write to HDR3DLUT_MEM_PWR_FORCE to put memory to shutdown
   when HDR3DLUT is not used.
2. Write to SHAPER_MEM_PWR_FORCE to put memory to shutdown
   when SHAPER is not used.

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 38 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  | 14 ++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 052bab3e5e8e..6e864b1a95c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -510,6 +510,32 @@ static void dpp3_power_on_blnd_lut(
 	}
 }
 
+static void dpp3_power_on_hdr3dlut(
+	struct dpp *dpp_base,
+	bool power_on)
+{
+	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
+
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
+		REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, power_on ? 0 : 3);
+		if (power_on)
+			REG_WAIT(CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, 0, 1, 5);
+	}
+}
+
+static void dpp3_power_on_shaper(
+	struct dpp *dpp_base,
+	bool power_on)
+{
+	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
+
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
+		REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, power_on ? 0 : 3);
+		if (power_on)
+			REG_WAIT(CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, 0, 1, 5);
+	}
+}
+
 static void dpp3_configure_blnd_lut(
 		struct dpp *dpp_base,
 		bool is_ram_a)
@@ -1095,8 +1121,14 @@ bool dpp3_program_shaper(
 
 	if (params == NULL) {
 		REG_SET(CM_SHAPER_CONTROL, 0, CM_SHAPER_LUT_MODE, 0);
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			dpp3_power_on_shaper(dpp_base, false);
 		return false;
 	}
+
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+		dpp3_power_on_shaper(dpp_base, true);
+
 	current_mode = dpp3_get_shaper_current(dpp_base);
 
 	if (current_mode == LUT_BYPASS || current_mode == LUT_RAM_A)
@@ -1285,8 +1317,14 @@ bool dpp3_program_3dlut(
 
 	if (params == NULL) {
 		dpp3_set_3dlut_mode(dpp_base, LUT_BYPASS, false, false);
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			dpp3_power_on_hdr3dlut(dpp_base, false);
 		return false;
 	}
+
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+		dpp3_power_on_hdr3dlut(dpp_base, true);
+
 	mode = get3dlut_config(dpp_base, &is_17x17x17, &is_12bits_color_channel);
 
 	if (mode == LUT_BYPASS || mode == LUT_RAM_B)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 2ae5e1f93dd4..6415aaa01d24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -161,6 +161,8 @@
 	TF_REG_LIST_DCN20_COMMON(id), \
 	SRI(CM_BLNDGAM_CONTROL, CM, id), \
 	SRI(CM_SHAPER_LUT_DATA, CM, id),\
+	SRI(CM_MEM_PWR_CTRL2, CM, id), \
+	SRI(CM_MEM_PWR_STATUS2, CM, id), \
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_B, CM, id),\
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_G, CM, id),\
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_R, CM, id),\
@@ -344,6 +346,10 @@
 
 #define DPP_REG_LIST_SH_MASK_DCN30_UPDATED(mask_sh)\
 	TF_SF(CM0_CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, mask_sh), \
+	TF_SF(CM0_CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(CM0_CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(CM0_CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, mask_sh),\
+	TF_SF(CM0_CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, mask_sh),\
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE, mask_sh), \
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, mask_sh), \
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, mask_sh), \
@@ -387,6 +393,8 @@
 	type CM_BIAS_CR_R;\
 	type GAMCOR_MEM_PWR_DIS; \
 	type GAMCOR_MEM_PWR_FORCE; \
+	type HDR3DLUT_MEM_PWR_FORCE; \
+	type SHAPER_MEM_PWR_FORCE; \
 	type PRE_DEGAM_MODE;\
 	type PRE_DEGAM_SELECT;\
 	type CNVC_ALPHA_PLANE_ENABLE; \
@@ -448,7 +456,9 @@
 	type CM_BLNDGAM_SELECT_CURRENT; \
 	type CM_BLNDGAM_SELECT; \
 	type GAMCOR_MEM_PWR_STATE; \
-	type BLNDGAM_MEM_PWR_STATE
+	type BLNDGAM_MEM_PWR_STATE; \
+	type HDR3DLUT_MEM_PWR_STATE; \
+	type SHAPER_MEM_PWR_STATE
 
 struct dcn3_dpp_shift {
 	DPP_REG_FIELD_LIST_DCN3(uint8_t);
@@ -461,6 +471,8 @@ struct dcn3_dpp_mask {
 #define DPP_DCN3_REG_VARIABLE_LIST_COMMON \
 	DPP_DCN2_REG_VARIABLE_LIST; \
 	uint32_t CM_MEM_PWR_STATUS;\
+	uint32_t CM_MEM_PWR_STATUS2;\
+	uint32_t CM_MEM_PWR_CTRL2;\
 	uint32_t CM_DEALPHA;\
 	uint32_t CM_BIAS_CR_R;\
 	uint32_t CM_BIAS_Y_G_CB_B;\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
