Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 11:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92698223E8
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 11:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92698223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AA26E1B5;
	Mon, 18 Jan 2021 11:04:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CAE66E1B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 11:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDHKxujckxwStTDg3b24NQh0r3BPkdbaDP+ps0ujk2V5XVXntYvA5bfvF3LOmeq/bc9r7fGCOhg9KgAkSS4N6jcS9fy3cFtvV5E09xnoBx+kIcCFOJZEvJIwtqGlUvvRqM/2wmHwBl90cLcE9zzcsasJSPubCv+SKGK2gNF/tQNyYxCydcQnGZTSsXbRbyl6exL/2UH2UWHV1aNsVFFSeSdjc6EOXWJgO6MJ1wgX0CjjIv89WeS6Kxkr1tOi7/dmki2QIlw8KwRfYCftNu2c+Qeyn/IPJdx6kZWmRjVzPSWabJ3MJZOJcMksSAv3jyK8hac+HvYGGC/gBMHJ4xhAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRvqew8o7V3hIxl10R9RYFXEVs7UvMj+86SdnZRBJ7o=;
 b=HBhgAt+yip0+hq1wtCcnSQKP3TdW2HxdG8HrbR+8YfSYmCMBX2f+SXO8Ja0iVqUXyhvxaefzjFRQzEKrxkuTU172bzrBcGKrG6uTs4l8A7GRet2puRwkgHbv/dtfHiMoMPupVMhkxr47R81jK0IqZiWegf4FvmMuHrERhho2rIK+5VQu+csYu/nKjinQIFkvbBggH/z934w0rTBtyUa1g8lUzOQ0gtiGOigzoTprHQmaeAkkUuYQRqUUAjrRMh01y6oHdPEGhxe4jbiWbZr0ELc0JcWO+SuWhX6hP98SU2Njs3pAZEFm9kOWXAJ3JcFDnrr7TcLva/RYlvvrn6L0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRvqew8o7V3hIxl10R9RYFXEVs7UvMj+86SdnZRBJ7o=;
 b=nf5JGuh+K0NxlgSmmEYIIRkrdLxzdeUshu+EQ3eBXCNJyZtMcrlUBv7J/PXENIk5SUZAEjizQYWp9lCqFE0HAyQh0E4RBcHhXA9CCZTmAoBmes6oOTxsa3jNUy3GJjWoR7IRXOuOZJX0GdjtW3Lth4LoA1eZuBejxMmPap42FAY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3423.namprd12.prod.outlook.com (2603:10b6:208:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 11:04:11 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 11:04:11 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Tune min clk values for MPO for RV"
Date: Mon, 18 Jan 2021 16:33:41 +0530
Message-Id: <20210118110341.489585-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::31) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MA1PR0101CA0069.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Mon, 18 Jan 2021 11:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81e77b78-fd1c-4565-fd48-08d8bba0c8ba
X-MS-TrafficTypeDiagnostic: MN2PR12MB3423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3423039724CCB4018300AF4180A40@MN2PR12MB3423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1YuAhgoG71YqPtUiHsF911Afiw4RDD7jJUPJQxDfQP4Uf6T9NmHbOnEoRi0KUC2mJKaOGZ8RyOyG9mwYj2CdpQbbhpHXU1rMuEMYOA+N96cAdT3fmRyuq/ntnZBrmOOsshqqz26PI4gB/qlI3hHFYMzhHc7OtxkQcxL66z7PTYAuTMLg5M+70v7IaXvcQ2pwwKXH2qxb6NxcjDstH/temTD7OEytAhmO5uCPhaRN1txwnk2Xvw/RYrs89zp0dyCySrJ1P4oC/+UioAb+4bVwbegoV2NdscbkWEQ/3WdBhZufL6b7XWOUAryFQDGB5Puk5hYprsjd8OR+wZurRnqzlTpk7j1Lrvd0pxycew3vur+lnOiT+e5NDknyx8kSNAwoa5D1akUetarB0KqVWlR6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(4326008)(86362001)(8936002)(1076003)(5660300002)(26005)(2906002)(36756003)(83380400001)(2616005)(6666004)(316002)(16526019)(66946007)(956004)(186003)(6486002)(478600001)(8676002)(66556008)(7696005)(52116002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0NvgfBq0M9+j5vlle60e3emBhqavqpeYRNimuNSMQC0K4WBPjLZKrOXZYpMT?=
 =?us-ascii?Q?QPnwqZPsodaDBhUsx8stgbdRnUNrOV+YN/PJk8iHbHXKlMnYALGyQr7A03py?=
 =?us-ascii?Q?3K637pM9TEhe/oUCs2JsxE13fxCVE5FI37UQE+81OO68SRcjKO7OcLeZ3D0h?=
 =?us-ascii?Q?nt4EMQrGJBXZAMDI5120Q1988/G6Wnl6rZMLOBEXKU5THLsWjpyCrboCfESQ?=
 =?us-ascii?Q?+RyT8NykKmyAVfDiJs3J1WKA2vfnMt0BkxBmly7257RmO+PJAYvojUCbHHis?=
 =?us-ascii?Q?rlt7C25shlFjzbr83xQ30BjkbRNyuIQYPXnyflgL2AWOyXT/nns7Yei4Xusn?=
 =?us-ascii?Q?hJXA6N+O4HOwW8ED2D7BBbdscnSii+Vk0cun2pLb1egIuPXObDWWB9H5NXpX?=
 =?us-ascii?Q?hTmJKXyv4nvVuYe4cbRsezKw4I7i0SgJQHWt9ctJRrBvq8LzDQejjcJo1cAt?=
 =?us-ascii?Q?xD8puO9NQGvG7i2MOmJEcFOFJBECgMIWcvNiLHvsdYPOlmPzBAIUyOSO/mh3?=
 =?us-ascii?Q?WveagdxonIx72rK1bDs5/2llOhj0o5ejwsTu/pNrEfHMDXLMfse8zr1Jip8W?=
 =?us-ascii?Q?iy+YmMssMSPKjfNchYNiBrVLBos1DRujNZd6uEnHz81P8x1K4Gzn5aA3Dwpv?=
 =?us-ascii?Q?adk50YNGgKPwanzSV5csk43mSqxrgT9Kjeffzo5fH2D+MSa+PrgbjdItCs8S?=
 =?us-ascii?Q?wA7iriSEFFamW/WXvfpTYEqDJZKIRVKGmByUAd4mqSxKDtRsO8Eidtnc/M2n?=
 =?us-ascii?Q?QFNm1xUrU0sAsUPdMfv93oGz+bpWfeQbaL59OQAQHDjMf7fBbWApScheUErN?=
 =?us-ascii?Q?UdVKznpp16eFccfobvi29yw0aF4tExiL41vDDfnjCwLaEGm/T8c1Zc5j1EW9?=
 =?us-ascii?Q?Sz8MBSQA95eT5ZNg2noULIvCy5arJ6eLly0G/3pc8rZ7P2g6phDGnejXodqC?=
 =?us-ascii?Q?WtnBNguZDvHAiZCAp+x2s7Qd9Ty1aA5d6+8pC7/Krc0aBZdvI3c+d48Pb+ue?=
 =?us-ascii?Q?5XD1j/kmvAT80xDfsHUjNODBwnLyFM6uKTi3Qq5zFiqRtwS4uiDCR1dZgu7N?=
 =?us-ascii?Q?wrxB/Q1x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e77b78-fd1c-4565-fd48-08d8bba0c8ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 11:04:11.1133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpNnBqbuSCOYcanidrlON7EQKPHo0CcqE5iUCBm2abxjFWR1rVmYmIuXdMbPaTZCkrCj/0ylj+JjZxnou9NaDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
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

This reverts commit 6f3fca64cfb91fedf9b34ea27b2581e88d48c9b2.
Flash line issue when MPO enabled on idle screen was fixed by
commit 9d03bb102028 ("drm/amd/display: disable dcn10 pipe split by default")

This patch is no more required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 75b8240ed059..e133edc587d3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -187,17 +187,6 @@ static void ramp_up_dispclk_with_dpp(
 	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
 }
 
-static bool is_mpo_enabled(struct dc_state *context)
-{
-	int i;
-
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count > 1)
-			return true;
-	}
-	return false;
-}
-
 static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -295,22 +284,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			// Only increase clocks when display is active and MPO is enabled
-			if (display_count && is_mpo_enabled(context)) {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->fclk_khz / 1000) *  101) / 100);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			} else {
-				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->fclk_khz / 1000);
-				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->dcfclk_khz / 1000);
-				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
-			}
+			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
+			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
+			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
 		}
 	}
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
