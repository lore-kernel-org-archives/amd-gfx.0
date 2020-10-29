Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0982C4363A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 04:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1B120790
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 04:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bS5G0MvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1B120790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80C96E5C6;
	Thu, 29 Oct 2020 04:31:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C266E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 04:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5YxoR+EkO+bnHjVFr+Pj4hhpj6fRQ0XSx8w5XSqjAVhNFVjf94yGm+MDuMs1sRhIFXtyNh6h57NTujuKQ+WA5CGaQ2REX/aMoaBMsTsHhV/HFK10c4jhDr4HGqNN0UCjprKngOoGPwKDyT+PSgPL2Zrqq9ycnvuchfKTs2/TdyAMHaYTGUl4bm3/UT2hxEnqDkCymozymTkkGeiGWgCNRWsx+M1X0x6spEH0Z57cXVPOKkAX7PxIJmYpJV/0X9rX6y7yzOmWm2rLoSPeNqukV5XFfQx5oIwEjlpxR1FW8s2Y1vvhuGQ23rNBUoT7ZB8J8ow4fvYq46uSMf6K9Kn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I+R1O9jv0aOReKeZ6cirNb743uKmPINJbYBmcQy9dI=;
 b=XfU/axtWB3V5YoGEIjxlP4kkFTLxlRsHzZdeUJoxWfiM8pKpTeaCmc1qlvuKzUtXjG2aLfQTtmY8ys4zIW9iVwcl1jGiF8w42Gx/p/qqDj0ryUaqigy83rSi/xNxUEgYoue+x3BFrqAMf4c/+ltzH/zBDBC/2kd/H3XwHHWnuKFCw4u5KuPEQN2TryTbPD7evBDIcVDfpfe7hENcQJMqvs4G62lk6GNddH2w3O0cNAHPzi1paT2XpQM7XZwIxDZAmBZI5nzk3rQzJoTdwhCCZ4Hhl1VIC0eqcDa5edtNlv5XFqjYtkaobxMFjtqApx6F/uAz+3ctbFtzvK9up704KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I+R1O9jv0aOReKeZ6cirNb743uKmPINJbYBmcQy9dI=;
 b=bS5G0MvUfAQa2Co89Lhr7L5lpm5kMBJ90XDEiRDsiogYEnkSqSiED0Q5w9W4m75tMXFVh2cR2GMEMVGkBQKjOwv2SkaJMNS3IEwq8SpmcuStkEACXADRTLANDtE0VRuYe/IyYVYGkTrdOLskOtU0RyWr7Y3Nxwxg1U0KIjeZhFo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 04:31:37 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345%7]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 04:31:37 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: nicholas.kazlauskas@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Tune min clk values for MPO for RV
Date: Thu, 29 Oct 2020 10:01:05 +0530
Message-Id: <20201029043105.144595-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 29 Oct 2020 04:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5843b6ff-899c-4450-b2db-08d87bc3864c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3360D9D9A0A820CB9E45274080140@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRLHBD9Ced6Nl4pxJorqh4BWEs/R7Hm0sJveZbvFFRdWQp2dvCgzcu/bn/9+1dtNGB95MfxBTiGncTvGyQ0sWQjSnQ2C2Cg+D1+aA78qaNKg671md1/Q0dUI+GIm9C7+sn49402j1FzTba8Khlwo6IkGZljgGi+CaePK+MViV+CFEINieuIc0u77JTgRcJWv1c/83UPnSwlvo6g8uhU/WzSgPhr3Gdj1wc1p3jwUfbz89H3o7AgYUgmJvBFqnYJ+2jzkyVAz+rvgOftB0Kh/uR+X1OQMu4jwm6xr32/TD8ll7QQaToILNDJLLq6miz4V9exwJiFMcW1Ry6+jlHXGjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(4326008)(2906002)(2616005)(956004)(6486002)(16526019)(26005)(6666004)(186003)(7696005)(52116002)(83380400001)(478600001)(316002)(86362001)(66946007)(5660300002)(1076003)(8936002)(36756003)(66476007)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5GWv/U+xUVpqmg+Vdn0McwYrDvVxt/2yc/s2mHdKKovz6CMgRzkKikCQhocmNzqgb3y73GOZE2Uc1OXJWxF8NsqQmgikAlVEzqEouA26LkR7jDfsQaP+HXMzyE1H1efupZqWXQ9I0DTUqxFT7/EE7dJLJrWoZRG0SN4eM7FjOCTQv8FptuKBeEVcUx3/9NBCtvrnt6V7nF2XeK9TFJpzPl51bwJOsQdCi+Ki48i433DZxDyrY4kyky2cwcZp73YmPpmTMYclSZHYAKilVbYU1rTHYYyI7NCeS4C7JyZumunbn9xdA3gayC0OmO+8dCsJDOxj9MxjepW70aTAXrwyi57s8lD6uLEB6ez9nlsJ1HGxBkGqGgOIp2lhpprsFGtFv/yUI7UpuXJfpchjMA437EG/1ZDlDfzYGd7W/EB62XJMfJx611zTukv/iPDfuv4wOVHQn/FWMdGPSabuAjxpBrP6KiRgEtChkJ+wnbF4QDavjHNlCuLeC4I0xqBl4Gx43JrFpLDVa5bp++lBcR/VHXsSIzhJyzGWz2xgJzpVXNmpnuMVUhu2MR8HLw31n364xljlZ7F5Rh9/puWmIlLMoaPhbEXj2bDFXAyGie9KkxG6stckRHSJnnDMpR/1JqMxU4i5VKOhfNomhTXiDzrP2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5843b6ff-899c-4450-b2db-08d87bc3864c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 04:31:37.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVGG6Pkb4kpxjW0QmnPb6kmy8e7Fb019JmwuYplbk/+OKAgwT+zQbffBSshdpLrA02cgpvRGAMDwxLo+6IOUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Incorrect values were resulting in flash lines
when MPO was enabled and system was left idle.

[How]
Increase min clk values only when MPO is enabled
and display is active to not affect S3 power.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index e133edc587d3..c388a003956b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -187,6 +187,22 @@ static void ramp_up_dispclk_with_dpp(
 	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
 }
 
+static bool is_mpo_enabled(struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->stream_status[i].plane_count > 1) {
+		/*
+		 * No need to check for all streams as MPO
+		 * can be enabled on single stream only for RV.
+		 */
+			return true;
+		}
+	}
+	return false;
+}
+
 static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -284,9 +300,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			// Only increase clocks when display is active and MPO is enabled
+			if (display_count && is_mpo_enabled(context)) {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->fclk_khz / 1000) *  101) / 100);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			} else {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->fclk_khz / 1000);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->dcfclk_khz / 1000);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			}
 		}
 	}
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
