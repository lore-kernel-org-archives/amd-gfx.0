Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB33FC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 04:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711E3238E5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 04:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711E3238E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1596E4D0;
	Thu, 21 Jan 2021 04:52:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1686E4D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 04:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuMNbKv1jgNentbgeQzZRH1izV0XTiWT3rtnU+dUrf9zScj+q9XQXYK9y6Q1Nt9e7Gbe7Yoo2frWU/EFjK0uZw3RiUtd7HywH3vJV+vSm1J6H7vPM+S8F7jkkJqg9sM40N26TVu9YwdkVjYXQctQK6bcxTCoIptzyVTHM7Lx2POZWZTX2C8BDG/fDLY0lGSrdJYCiaZeuIVeAsPts3p0bBVsZPNCt1MAuYNbldLmoc93n4HjNdF7J6NC0dZ58nNhAdbg8sCMll71AKl9fF3eSUKfvF/zSIoCs8RtYVKT1xVaF6t7878Pe6n44bernqxeZLIMzvBXDY+F8yf7fUBmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnmgyD3trIsf7N60bCJQRaq0mtyiwULtc9Efs9e/0Y=;
 b=cR3m/unx8EObYY8yHrg4eqE7jI/chj+bKN4nSSYBs0lF8es9iwUkT9wollhQag4DNIL+0RTuf75Qhk8HuMNLsNv1Hm+vXUE2dcsGIFeWGSB2ca9sT3MBbWlylInUi5Ldpl1pq6YhW5KxSCJpvYbkH11O40a+qV4go9xXLNH56lpwDBXLt23rG6wsI2gofySeCCtEUeLAiZe+diMMi0NCVeKZ9pSx8Uhkp+vBTrK/v91timK4/5WYQGTCnJGsLAvKQGkk0bQB0D/IQY5e+EfDK+faDhhkGhBUzYHZeaZoTk+k5fqWpLLeDsort0UKMSXQQ8gqRrS0N7hamqiGQh1JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnmgyD3trIsf7N60bCJQRaq0mtyiwULtc9Efs9e/0Y=;
 b=CBg441VACh6wfHm39mlaaudkKEs7Dcox4dW/JMy+WFI0BpRKN6tECCFsD24kb1eWT0qg07dzVTuYaZbgaa2tqJUvkBvh5X9KQWpnLnBMPN9F1ERKg/tYjUoAt6hSpzjLaznrySSZ4KZ/4bgrc09KjJGOijh+Va6vIdfMlDXuNcM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB2864.namprd12.prod.outlook.com (2603:10b6:208:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 04:52:20 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::7ccd:6ebf:40e7:7039%7]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 04:52:20 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: hersenxs.wu@amd.com, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] Revert "drm/amd/display: Tune min clk values for MPO for
 RV"
Date: Thu, 21 Jan 2021 10:21:55 +0530
Message-Id: <20210121045155.6099-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Thu, 21 Jan 2021 04:52:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b953faa-5d92-4a41-7c40-08d8bdc855b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2864A0BC9210F6D165F418C280A19@MN2PR12MB2864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLnBxctuBhVd0BHjlcx8h04RaVh3eNQGQ4LcjmaLMpN6DDUw95vPif/prWupso0QfqZxFiQ9BacrmyDeGAX+CMR0FKA6cq3EBrt0+EulSjhj1sgEmnT1SoK2SOtSqEz0pWrm3rnx6V1/TrZe2HepNw2dvJLJTiK+vmsTphxXWOeeIC5r+dgqfswtovl3+LHaFqd6oMssKtsDLKtLocRYQMUxxehYElvDtNRCgX4SAvsOm4rKHlVQe24KCHal7qg35+TQA3PWu+TUDbAvjvucO6nHceoulmSIwrtiahUhuIJv2mjlXXdlJBd4F8+AADwxb7r7LulHAVK1cP3KuY2oo+4zY4F7Wmu4IjPnQXD9vueaLdP6rgSAzfb/72M97JluKD8YkV7aKvRs1f3iubeDGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(2906002)(6486002)(7696005)(956004)(5660300002)(2616005)(8936002)(52116002)(316002)(66556008)(478600001)(8676002)(1076003)(6666004)(83380400001)(36756003)(4326008)(26005)(66476007)(86362001)(66946007)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O+BGPrWJA1sLJUM+QYwrvNq69gYh+uVXj+6N3vrTgl3brBEDa+14VqeYpJ41?=
 =?us-ascii?Q?RmNZLggtK+HzpoNUAKS0a+EXx7+DQChD4hz/2QLBf0tJK6slNh7HVHXD49jB?=
 =?us-ascii?Q?0D1bOvpQixaFXULrcXoa/AMTYrvjWIIYje5eBTMWfawajAmzACBrRRv9DcFU?=
 =?us-ascii?Q?zHrqXDum/z/BZEfUzHJEt4Lh7urNUvjPPMNuXy0N9bfykcLtqCaEx1sxnQkP?=
 =?us-ascii?Q?udWOlRvubKO8waE3KqcjaXM737d9Djj9OcgqLZ2MUaif6ufB3eRZl8NxRJuo?=
 =?us-ascii?Q?t9m/DUADeiv6VY3fcDYd9IqyiLcLgzPUnMrzDFBSx3ivkO9fRAGTH1kuhULO?=
 =?us-ascii?Q?R6KZB3uKuC8Ge+abXi3eA73Ulbq3wcECltasfgd1e36ySzLuahmpvmGWvgzk?=
 =?us-ascii?Q?o6Z+AwZcw6+nXEojMZGNdasGE6vZqBluF/8CA2HOOIrPWcbRPBA2ggxyebjU?=
 =?us-ascii?Q?fDwm+FHO9GZ/23OCGMr/LOz2lccEU1taafbSQxgfFdX6yD3pgdn0nvBz65kh?=
 =?us-ascii?Q?xE/YVNqICZQ6xKXCrP+DzipMbYhGduAWGUNhtsseWXyxrxvXqDXxuE/sytIV?=
 =?us-ascii?Q?xBQzVpgcE0zEe86/TacqjGNXcI+bENKPOGfqy+lqTpbEjW/n8GcDcVaWzmym?=
 =?us-ascii?Q?nchRKzCJ7FYkRnNuk5kRy4a7V95JRzk51pFo/iOK0MyNYQqraoMCW1CJFQRm?=
 =?us-ascii?Q?Ked/X8KcfJoWSOwrpPjacOWusjTYm/JgPDxbQTTfdgrBRaMJ88O+4tgI1SQe?=
 =?us-ascii?Q?IFQU6imhTjCWfKBGJOmnlSxC7lozPgyzrXv0wzAz7PesQ/MX6VfAbcAyccjI?=
 =?us-ascii?Q?GZwtwZXRbxFEkSM9OIV5bytaA0tOOVUPvScd5WjJZY4OCIez0BywUD0fXVtE?=
 =?us-ascii?Q?NIrS3NDb3stjJn31p9ED7EVW6Ns5085KNwo2tdajkgPgix3ybVgYrgu1A1iY?=
 =?us-ascii?Q?5ByAxejS+DRfjl+sTBrHzNfcUe6RVzNhv+ffkh1+6ejfHvPYvYuyXk3f2NSq?=
 =?us-ascii?Q?xCRcZfiCsu5ROEsuH5kAkGVy6hllo+kzRz8cpGsuM0jlfd5Sm8uXlISlP32k?=
 =?us-ascii?Q?rqW6CwXgRrvEzyPdVQnczBqFT9YO+w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b953faa-5d92-4a41-7c40-08d8bdc855b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 04:52:20.7260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ium5Buk0XOfWAz7xi4IchDnrOQjQPfD19zqE0uk/MqZoYAOcfAGnfP372+3L9y+Vpd2qOZgCE4vdJHH/lPk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2864
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
Original issue of flash line when MPO enabled on idle screen
was fixed by raising clocks. This had negative effect of extra
power being drained. With the upstream commit 9d03bb102028
("drm/amd/display: disable dcn10 pipe split by default")
flash line issue was fixed and had positive effect for
battery life. Hence this patch is no more required.

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
