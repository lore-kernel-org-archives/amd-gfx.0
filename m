Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237F0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF4E208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B/PTJDZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF4E208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCE689483;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF6B6E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQEhKj90btgoqVbjgpzvNHhxJKEfiF6/uy+fo/Z8kWo9AHI9AcvvhjFWxqlZRpWwAkK6m0U0SWMQDErpKOg40EuvoU0nEH3RGadLcIf6ODR82JlD0F0Ntc2ZYsbZVvlGv8GG6qpzBuClHg+/2lXgLDMjVNyrKgPBMfPwPG0uo6Z/QkJlMFZzvi2EmrjyKLSHYLxxm2u+t7Ry9GqsvV9MpTB0r1X2IXHzOcjOCaByq7s+3ngm6mCXdJxo8+wbTieeSsopihiho9t/6Pa7e9a2BdJT9KvmaY2SObhg3CZui5qRgXgL3rWtck25IkGIDamxqqjzK4tqmTR52YiQlZlMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28hf1HwqVGMBT5zrTtbJB6qisTehILqPDM2XWkcak7k=;
 b=ljpb3y39j4xNoILHJLT2Uh0DjtZAMLpacNq6pZPS65xgnnE+jQBuaaG7H97ptCs0/4Sbb4S8w0zXR50It4wkbPsfYoSRsMLHHnNL1oWcI+lTd95YxCT24LyncABh4cD40GatC0dy2GcPXJTaczIbC4RJoxa3uwpW2vZqG/CUxsdt9JPkZTxzilS38ZJKQ3nKV4hLHs5Se/XzeyyRTBxImnL5YxKrgxRXaNUeZaKRf/L9CR9vd1T28Ix3Svvn3oUJXRLIrQeUDCmnOoebNZusL9KSGqSsqw0u0U8J80rc6Ca/mAIxUtI0T7RPOKPurEVmSLu1omNli+t1ZEPocW1Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28hf1HwqVGMBT5zrTtbJB6qisTehILqPDM2XWkcak7k=;
 b=B/PTJDZoOZ8C0xw24X9yoUvFyE1MMcFHTRBo6JfWramZOTvBQBjEgJ78GhdtQCVc9wrv68e20Ej4FT21X7VIL3IowY6cpye82r8kfPV2TXqADN3sgwC1ggcKh6nxPvMLG8TEtO8kNMuxV8h6zB8VKkvu701KONG7+tCjQl1hqO0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:58 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/30] drm/amd/display: use dispclk AVFS for dppclk
Date: Fri, 19 Jun 2020 16:12:08 -0400
Message-Id: <20200619201222.2916504-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:58 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41db741f-4c70-4fa1-56cb-08d8148d28fd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087C9C19AF0FC8EBF60141C98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOvYRrGvcHfre2PgJTBf/UwUTtSLLGS76g05lxixRwela3gpNxxm0flntG3j9Y2XrzVQ4sUSJsIO9PsSCbpVa96G4DO0e1x+zTVXxvbI1uoIB2hBRJ7CBmU/dnokxBoZPENaqTiJ1oobecgjzBnofwvdylnlcrBj3GeaoP3ydSzzudMvCYjjoK1lqTzPuhfQ7XOhPEuBBGLWpK1MTdSiDGAgwtD5BdjdVk9FUdPpKGuZG+EPnhWIIQf56heWfun4QRPQQXSr80H4EDRy8FY7JHlEXOf1A+FbD+BqMp6r9OStzqNYVICN3mJMhTe9ncJpSq7poqpV4lPhHndhOIUIcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: v4UicFEYciGjGh3ucgmo+eJeUenOEpFFaz6wBdbo3J3BVvWalfOBO6vMEkKDAYNA3nmrUK8gBVtu4D0+a0sFiJA2rEHQyvwnSSa5f7mV011OPu3au4OiuunVF7JEsuhbVhSTZcQOYCrEcLlCb3HmJbEsvKmJDt3HSdJ7rqcJuXddzXXO/gLh6zFxoE5til+ePZ4MYZPDjMAklicYuShFVV2VzI+UvsVTqT5R1oA/3o3bVKO0AgBF3mvDqK6BHNykP4UW95DO7VYAC0twyPHT5XXiY2VOoSm4LgcTgoZ7EV264r9E4B9Rwl8K44U+A3Dw8SUQkY7w7v+ydQHGBFpS3g1MzsTvrjsTZDyHyBMTf/ylMfmRS2xjy1Rq0yn2tnleCpeSr/NR2BSCQ4brep+d9mO5HOxAyfSbyvFcvuSmcWK8TqMlDFrmfS84v92gxT72C7O0prcGcchUTQxI2LGMAm4x6/fbPaJBMVdDVSMfVPwoQUoqBoztouO7RiAvL8cZeRpSvvklyg/IdHr3U9V1zw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41db741f-4c70-4fa1-56cb-08d8148d28fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:58.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBlRqXGaaPxFfHlKrmyBDlZhYXQ3znk/SjD9/O1vmw/bw1EGwiM8wMRTaBgWTacpAeN2M9kc2fDiyz/+Xipgag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Brandon Syu <Brandon.Syu@amd.com>,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Why]
There is using pixelclk AVFS for dppclk, that would cause issue.

[How]
To use dispclk AVFS for both dispclk and dppclk.  There would choose
dppclk for request voltage when dispclk wouldn't be updated case.  If
dispclk need to be updated, then it'll choose the bigger one from dppclk
and dispclk for request voltage.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   | 18 +++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 55d09adbf0d9..c63ec960e116 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -234,20 +234,26 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 			dpp_clock_lowered = true;
 		clk_mgr->base.clks.dppclk_khz = new_clocks->dppclk_khz;
 
-		if (pp_smu && pp_smu->set_voltage_by_freq)
-			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_PIXELCLK, clk_mgr_base->clks.dppclk_khz / 1000);
-
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		if (pp_smu && pp_smu->set_voltage_by_freq)
-			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_DISPCLK, clk_mgr_base->clks.dispclk_khz / 1000);
 
 		update_dispclk = true;
 	}
 
+	if (update_dppclk || update_dispclk) {
+		new_clocks->disp_dpp_voltage_level_khz = new_clocks->dppclk_khz;
+
+		if (update_dispclk)
+			new_clocks->disp_dpp_voltage_level_khz = new_clocks->dispclk_khz > new_clocks->dppclk_khz ? new_clocks->dispclk_khz : new_clocks->dppclk_khz;
+
+		clk_mgr_base->clks.disp_dpp_voltage_level_khz = new_clocks->disp_dpp_voltage_level_khz;
+		if (pp_smu && pp_smu->set_voltage_by_freq)
+			pp_smu->set_voltage_by_freq(&pp_smu->pp_smu, PP_SMU_NV_DISPCLK, clk_mgr_base->clks.disp_dpp_voltage_level_khz / 1000);
+	}
+
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dpp_clock_lowered) {
 			// if clock is being lowered, increase DTO before lowering refclk
@@ -403,6 +409,8 @@ static bool dcn2_are_clock_states_equal(struct dc_clocks *a,
 		return false;
 	else if (a->dppclk_khz != b->dppclk_khz)
 		return false;
+	else if (a->disp_dpp_voltage_level_khz != b->disp_dpp_voltage_level_khz)
+		return false;
 	else if (a->dcfclk_khz != b->dcfclk_khz)
 		return false;
 	else if (a->socclk_khz != b->socclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f9eb8c37d7c3..83de4c2e045e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -337,6 +337,7 @@ enum dcn_pwr_state {
 struct dc_clocks {
 	int dispclk_khz;
 	int dppclk_khz;
+	int disp_dpp_voltage_level_khz;
 	int dcfclk_khz;
 	int socclk_khz;
 	int dcfclk_deep_sleep_khz;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
