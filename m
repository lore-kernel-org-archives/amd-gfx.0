Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17EC2D0D2
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 03:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE82206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 03:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vubRCWQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE82206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5563A6E139;
	Mon, 23 Dec 2019 03:23:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FB36E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 03:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfZSnryszqzyzyHvJw/WLcXhdJITnxYfLG0KbmjDEt7CfM2YcdB1Xd36qS1eKCeqql2WdvLvFTpN9Bp3yPzeOZXJdEDdb9I1ADno8dy4OyLx9zpbtgie8ESKEO8EuDqW306DPk/R3CUledMWy8c6Xg6L2eSCoLqsiViEgPiXCOtbNiqs2VXd+uiqogPRvPdSLZTQs+LzvOLrIuYVCSbmcAaizWyvkhTMNh0lMdYRPzc4p7XZQcwaL7AlWJ84hRGUNgr9pMuGhOPnbAAUnNwUSd6BqS2NHjlg8OKTpc2mVTbbRAoeBkCK0pKI4AB8LuvM/XUDRFL6G1RCiWmC/WtbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt3CLoEpu7oBjy5eCygZVmjG9WLX6WblRNkezuumS2g=;
 b=JprnnTzpeaz6h3Ric4IxDV/5+/8MMywvLF/lOXXh/y3jfo6K05BvG+QQIAj4VHPMa58ciS4UVQhNRwOUvyOKvcvZwcgGwram8bq0vfFMya325STGTndhUpmT2wgb1yuTj/gYXSMaFiL7wHjxzr4B6Ge642QE/7O35A6KZfXAJkQM0CajPQ6hwJL6k3kMIpPv2gqSQB4IPPu+5siz7Jd8+4N6DoBFyG/wbQfnigYjGU6XKc9cXpaCq9cR7fET5JQgJvBeB7+u+9UsqbHF74Ggx8s4gZLATi2ivTNoh94X52KrMSwjeg3S7uHsrSfurlxbGCz67CuB+PC/dpbhYGRBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt3CLoEpu7oBjy5eCygZVmjG9WLX6WblRNkezuumS2g=;
 b=vubRCWQLW6IHaRw7F9JwEgXdFTLSNeTsUTsjBm68CPs2/DKPBIh8kBUfLOFQgGga2PSIz7/Sa1x5/eZUwRGoD5Jxj/Gq9ZmKRDLGP/c36nX9Ocz47zYN9oq3Q+c4Q6YhhPHQAu+4B21ZKzT3tILeoRZtm31n05JYHHKHgpGXORs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Mon, 23 Dec 2019 03:23:15 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a%7]) with mapi id 15.20.2559.012; Mon, 23 Dec 2019
 03:23:15 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix kernel_fpu_begin/_end() warnings
Date: Mon, 23 Dec 2019 11:22:58 +0800
Message-Id: <20191223032258.7327-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0204.apcprd02.prod.outlook.com (2603:1096:201:20::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 03:23:13 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25c109d4-c44a-487c-bdf0-08d78757723f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2878:|MN2PR12MB2878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB287830EC86F05D4B2643186D892E0@MN2PR12MB2878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(189003)(199004)(2906002)(478600001)(66946007)(66476007)(6666004)(6916009)(66556008)(6486002)(1076003)(86362001)(186003)(36756003)(44832011)(5660300002)(26005)(52116002)(81156014)(8936002)(956004)(16526019)(4326008)(316002)(8676002)(7696005)(2616005)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2878;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yiM4soQIxb1JJ0nr2kuuCcYulb0s5HgYPsttphZRp9CDRlfPvkJWw/DrK02B+6WsxZY3BKNyrCcdYnzqqrMt4kY2EtgxlL0FBi9SZFdsyNM7RbWIzjehTPcTCE+5XAPw0uzQNlDVXFK4WPu9DK7Z8CGLKs3NnvOSKx6pSx4JkGNYgr8QJ3udJAy+ss/grcKXD5jowFjVEJJDzp7W2JG4LNi7IqTShfzVAgiaPFJpDr+puuIz1syTQ8cgtNzRXZW3gsIuGkGNd1FyG2MJf0QRcbCTYolWvmUQyYUakB0QD5pDrnqvPpClUJv0RC1xmrrgF/55eqzEh4xRKA7bMgj43ayI6MLY6isgSyv8X6iHQ13IrhafBCsHNm84yUU3IxsbwIkbIq9v+GO9A7ITkxZNAnjnUoSbnFN/mB40n7Nc68zogSGWJOM0aLVrAhWcrAD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c109d4-c44a-487c-bdf0-08d78757723f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 03:23:14.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyNqo8lA1guQ+6ZetnTrgQbXxA88HYFO88Vv42FqpKlsSBorLn1E22Eta91MVLia
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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
Cc: harry.wentland@amd.com, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kernel_fpu_begin/_end() are already called inside dcn20_resource_construct,
and calling kernel_fpu_begin/_end() recursively triggers WARN_ON() when
CONFIG_X86_DEBUG_FPU is enabled.

[  107.060434] WARNING: CPU: 6 PID: 1370 at arch/x86/kernel/fpu/core.c:90 kernel_fpu_begin+0xbd/0xe0
<snip>
[  107.268197] Call Trace:
[  107.270751]  dcn20_patch_bounding_box+0x17/0x100 [amdgpu]
[  107.276204]  init_soc_bounding_box+0x1b3/0x5f0 [amdgpu]
[  107.281536]  ? _cond_resched+0x19/0x30
[  107.285307]  dcn20_resource_construct+0x3a9/0xa90 [amdgpu]
[  107.290957]  ? dcn20_resource_construct+0x3a9/0xa90 [amdgpu]
[  107.296621]  ? __alloc_pages_nodemask+0x16a/0x330
[  107.301476]  ? _cond_resched+0x19/0x30
[  107.305284]  ? kmem_cache_alloc_trace+0x197/0x230
[  107.310063]  ? _cond_resched+0x19/0x30
[  107.313783]  ? kmem_cache_alloc_trace+0x197/0x230
[  107.318691]  dcn20_create_resource_pool+0x42/0x70 [amdgpu]
[  107.324315]  dc_create_resource_pool+0x12d/0x170 [amdgpu]
[  107.329851]  dc_create+0x1b8/0x6a0 [amdgpu]
[  107.334013]  ? kmem_cache_alloc_trace+0x1e2/0x230
[  107.338832]  amdgpu_dm_init+0x13e/0x1c0 [amdgpu]
<snip>

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d72e921fffa0..9f346ffb6e78 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3225,7 +3225,6 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 
 void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb)
 {
-	DC_FP_START();
 	if ((int)(bb->sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
 			&& dc->bb_overrides.sr_exit_time_ns) {
 		bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
@@ -3249,7 +3248,6 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
 		bb->dram_clock_change_latency_us =
 				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
 	}
-	DC_FP_END();
 }
 
 static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
