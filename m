Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13225C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C732F6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C732F6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA476ECDE;
	Thu,  1 Apr 2021 16:46:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA426ECE7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUJXvXen/XaPY5ohuPciaOxmreFvf12qqGsWraAL/7fiqCe9V+KluPCsJf+JGyPPB/5NW6imxpgKy/CxmC/pEWryM9Ctz09IGqq+Qk3LuqTH5yjZw8totZhEwhPWF2H4adWmfdfVAqGhr1sKygsCXEcmQ7fYpPbg/DrnQiF7H++SevgEKdgGT+ytLjn6LR60PPc6WiLYwAQOFk4t4C4vOol/emo6eUhV/5hfFgLA8opRk1P4PkLcjFuh+iEld+9uusvCJw7lf/gJMYqasqja7Ub7bwzjC6vzEqmru2tqVzwqG2gxvnvskwOEhwZs7stopmhBHZWjKRJtX/oDJvXK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhFTZdquvorkjZc9zUQVfu7mHHcimT5Qp1+piN35SBk=;
 b=od3/sigC1iVFPrSovSt2y4yIDzNxIiMkXm2gJU40+PUjkQSWKhxZANOX/wl+XfblESqVcLbQsSOrsDG5U+gnhOBP2yYlLOflY/xXcz1njMCtrFPTssO/PjJNqgKT8KHSQ7e448i5pgDk/4Gv9F9J/kyGKuMBsF3QlqFuHSxRz+hCPJajCMRusb4leli2WlNmT33OHk3tf1pd58RSZPQlCmA4kbSBdSAPdfFQJqzgbCJ37KzGrWoUpujYgHaM0KO9l2nSaSdqosJcyo4aNe3VM+Yse814XcFi/sgN9VB1ulCddtUsJzPGXicKpp834Hx0eYYqfKKf6YmM3F3T92IURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhFTZdquvorkjZc9zUQVfu7mHHcimT5Qp1+piN35SBk=;
 b=jiXCAyMCp6QfUiBuffRk4C3Ud6FAMItP6Pq6ozaiqRwsdZaCiwtvIVMGaIpKuWrydXjc299/sYztX5uEHGKFCZgTrOVnlYgQe9116UUth96i+i4+879KtFBKdRpZ38x5meB/o1pgkbpETGTjKMkP7DRaVMjb4vKITvjJYe3EHX0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:03 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:03 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/21] drm/amd/display: Add dc_debug flag to disable min fclk
Date: Thu,  1 Apr 2021 12:45:16 -0400
Message-Id: <20210401164527.26603-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9547cda-a121-4e04-7aed-08d8f52da319
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46195DEAF7B6CF891B58E21EFB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYc3oYPg9rnjNQ1YaDn7sfOpTP+on4d1LP1Ol3jD+HCzSDng1tt6CrZFtMdd+cE3epp+72kgjiwzFzA2MBWS3ZGV5PXFm4USDXmOJMZ24wRRgVZ3zvWPLvqCnT2KOAjkFW00hR98e6wu1k2oyBKyNuhH1/TQz0/6SEh9hdpINnCmHI/SsXIw74Qu5jVlTiAPpSQZXyXHGtHSwyxOI01UnwEL4CJOs35HTXPIgoorRPNeIRstuvWzsSxD2um/EyR5+7S/M+9r7Nnfnbmkbaic0arwPhgCVmf1VCFZqRWS46fScyNLTvUeSXJpUhA1OnGnbMeaJTqLf16pgn8bdnfoyXb9i+sEhRmikPzhFLpTV2QUBYRLrxB2ni8v85r7F8OZ7qfzmGZLaf0vCue+7brENO1D5bEh+kym4W+t5zoD6XZQp75aypvLDtWKhTCT/hnfcdKYrchKTWaGkIGDIwL/wVcSia7IxAwLu4pv01jmnF/VuqarijXALW+6kGWF33wukgP/OaB9piRRSXG5moym+pKzg8oYhz1RCAuETOiHtpdq+zEGkBVtKyxTkkhF4s+mZxo8D5devvdqQD9hsRZvgJnq8FJVwFS6kclTKGjchNz4ceoaOqVx8rAWwOb1TQZ1OBMnlmJZBm2BgbcxsN0KOhst1WiF5tBaJJTczOx3ahXylzS5y2Otu8VbCGEX7JGM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YBjlNTk5eZ3MW/mBpRe7Posru1cLh6PNt0VFXoiyuJ8eGoDlrQZpPgfF91ce?=
 =?us-ascii?Q?ptxEZHqL8xuT+1dqfu+WUx2xFJdkFmkPgaYTPE9zPTaEUV1xh5AVe15PXvt/?=
 =?us-ascii?Q?MoDjX4/S84j9+6IUxZqrGKlWArfaJZvjUqt+W4rEUkvc1O2WjASaUP/aP6ek?=
 =?us-ascii?Q?S/t7bXY4pjeD0S/O2GV8M7GXPdhpy2WJEyRD0kx96oCBqbaa8jNzpZes6FIO?=
 =?us-ascii?Q?KoeO5ZAn+ScC5KOHpmHIix8q6fP62KAPKzz3poJM5A8f4AdtQK4RnlxO7lYG?=
 =?us-ascii?Q?KCNBmv/O2ubpcKQ/Hfl1pIbEnEXDyhsHOUBLa7Kxw0QtZRxlFbbwbkqUHMLp?=
 =?us-ascii?Q?VXF9vZYFBcy4FtDyMfmL3mtC/Svo+rc0KP0+2Y4M/RFlJim3dIUxhyWF94uG?=
 =?us-ascii?Q?kKmtqyc1E3VBmurPNEpo/bFckLbblkK48WV2b/P8BWjNfj2NUH0RhRb6BvCV?=
 =?us-ascii?Q?tjK0xnFD8SBL90PqNMfMo0ZLlxqdL+Oi/pxxSSLL9ptXWXwh+7+FdNzCxRIS?=
 =?us-ascii?Q?x5YBB8llcRpvtHuN7jGIz+DHpvXRDQb+QX48vmkSWE8d7cCgLSLLBmCaU7/J?=
 =?us-ascii?Q?sYRjj9aFstexZip6W0ykfzwlO5Ak8sICRM3af4nPT32Ip3wX8I++ybb868su?=
 =?us-ascii?Q?LvSUeJCqCKUDsDMa7IKVpN7rjGV30t4IDS6y/C0Qya1mGyJshrxNtxD+v+C4?=
 =?us-ascii?Q?u1zcfSY6fvgknyhj7RpLCmDZOd0zeodO5+PYX14fQeDh/MW11h7/SdceTmS3?=
 =?us-ascii?Q?ek7DHBMOrxURx7Hkd+OXEMmCt1njZrDiUvb4E2gjwUdugi1aGQPIfvBQgpG1?=
 =?us-ascii?Q?pBVWCGRa4elcLnv6PMmrWz+j7Zd8rFjSjX1AZq6h+2L3UDhd8+6qMA7E7+8n?=
 =?us-ascii?Q?lRgVpvPjzyH1ti1e6fy+AprsQ0DoAluo+7M1sU0OrmiP2B34SmpDz20hJntr?=
 =?us-ascii?Q?ThHEN++ad0Qs7qz7NfcLL5GdLxigsgG5fMxDhbM49ACOElZMq0Edrzq3M1QU?=
 =?us-ascii?Q?dADmk/ouOuMsPGmhUefVWxDsSb5WfkwT9Ep4xqkmPmjL5xz1GlYIb1tWa/9b?=
 =?us-ascii?Q?ZR8N2ez+P1advLkYPaqd1dkkfuBxiaW9rQqWJTWt2tuRWa6idUxseKvFYKHj?=
 =?us-ascii?Q?VG+gaV470GZRI4CxOxMDfcKASsHoBcjmcKp0jptjr91FMGXrzwGiiB0Za7uG?=
 =?us-ascii?Q?fLcxHpAzt6GlqP7Ko0ayQo0ZXl3LQ+r1xLDIQ1/crgqIpEqKZnVpRN8todPL?=
 =?us-ascii?Q?qRq2/D1zT+u0Brrhi9wPTUCRuMal0z4tC6TI7eFn+QOTNmNH1fIEJoNNle82?=
 =?us-ascii?Q?wz+OdG7VNIoie1HlZFzmqynR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9547cda-a121-4e04-7aed-08d8f52da319
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:03.2813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGzDNF/7m18B3MR0c4uFUjdwjShQUp41coKHxCvLF8Cddm0b7XIkF0/iOOo+yH9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
Add debug flag for an option to disable min fclk.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                        | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index b47e3558e176..c636b589d69d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -136,13 +136,13 @@ void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz) && !dc->debug.disable_min_fclk) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		dcn301_smu_set_hard_min_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_khz);
 	}
 
 	if (should_set_clock(safe_to_lower,
-			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
+			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz) && !dc->debug.disable_min_fclk) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 		dcn301_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8b725347e2ed..cf5abcb74601 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -460,6 +460,7 @@ struct dc_debug_options {
 	enum pipe_split_policy pipe_split_policy;
 	bool force_single_disp_pipe_split;
 	bool voltage_align_fclk;
+	bool disable_min_fclk;
 
 	bool disable_dfs_bypass;
 	bool disable_dpp_power_gate;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 10c1884e3d30..2127399cf464 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2019-2021 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
