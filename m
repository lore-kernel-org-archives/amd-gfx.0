Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A0C388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB00218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WNa19h10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB00218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F696EC54;
	Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700084.outbound.protection.outlook.com [40.107.70.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAAD6EC55
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7wK8jqz3vUXzVqRm8HIdKxwydbwX+Ggl/PD57dnhr9UjPCVTucKtasEvKMwKOcB0mVW7kiUCB4GQQBxkmhmc+XY4sG4ByqkJ8p3VJx64bHeym2g/5VNePQfNsJrjv6tc7y3yX6ViuBAxuY6hRFVqVXMil+lWp8PUMMkPgh9HCA7p3OSeYaQ7GUrttbuQLB01M/ZkPp5S8uvblXwuh6UJ5vk6OM1kYGwbsgWNFUtwh91KVbi7N/Mg0lh6n6+8rP4TiuDz3acVADjjwhMQqANh5S1mYKnE/pWjCcGS1E/ifUzaM6KDlkGhWezVm2JAEaC9mQJ0+cCe+7/C9Aq6nUZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWu8Zk4jIyZSkKOeNPYkC900hW13QtXTZOaItPsrE/o=;
 b=A1INVfDSwcwT7ZH68tlhAW654Zh64rIkj5t6NdlU284P/OLtKbmW3tUL8XFubpfB/Nek4IJ6BnR5rHsYXd8TgWqH9HTYXnJV17yTemgSyzzeosrgudvKOVNvlRKqd7xcrD0//o2iczUsyByniu1IYB/q71BQyJXl8k57Dqqk+BqZuVHgKO/C/A6pTsneqmVIC1QAJlHK2PFquz7gx+hd0QXMMoBESavZ8GrqAuqtkbX+EBIQrU5Do041fj5nT+ZhzQhJCGzhVInJpOHx53rb6rFGNbZwu1uY6ACYbuMtYnOWaqFWdWQg01j71vqZK5nn5FH/SHlxG1ZgT67XDZCRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWu8Zk4jIyZSkKOeNPYkC900hW13QtXTZOaItPsrE/o=;
 b=WNa19h10oRjeJCSVIzqIl1vmmCylvQfn5haTDQ0Gp4paGVRhX5v3TN+PnrW9WVXkw8nlg6nzniN0Zcj2mApIxHHmHceAN+qwStCT+aDI6F6GGM/4XBL2oNDg7cdsCz6hO6+khN8G0oqMIbyHCWvAOvAirnckGo7BV8xOUdCMCF8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:54 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:54 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/25] drm/amd/display: Force prefetch mode to 0
Date: Tue, 27 Oct 2020 16:52:13 -0400
Message-Id: <20201027205234.8239-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fb64d65-e03c-47ea-d503-08d87aba42ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595A84E31B3C5DCC0D5842BFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rkkNt7JFZK/7VHOhkpw4GiirUHNEJXWV+6mm12E7jW8DWRCY2eSTtpm7SIvZ1ESG+YrzzYKGxYUnyOaZI3kDursJS6U1iHuuXERhHbdJWltedBdHfFuBN7tK/mTuZuNZRydcNOrKSS53ziUyuLLlkJg8v+5iQUn0v5oG6qESYDR1DjCurOpR2YmPn7+KKVjo9O5qZVXAcujjXG7hHe7Yk4AuNCujIvLlQhHhjbs4lyDSihL2Gdhs/668LESm9tBVhefhgHjEcvleebho4duRMmmWo1qLc4NuAI93RTQFpiaX3a4+mjKMrwsa17xyJzn0d4oTtgog2pMnppPH354aY6Inyp2LEg6UkOgn1Ur84XHSbPP3b0lEYhogQcehJCq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kPS0SwRSbyWNwi7omrE5/zHw80uJsb4btPFNxYkpgJpFWtU3RcDFTRJYmpUUi0UqgG6EUlC73Eklm9vGO3ma28fkkINMlmHMhKtfEAAKqznjwfrztFHXM78qxuqES0FNzcFajP0RliYFkytkHXrS0HHeny397IrhFfyd5y2pKVaiWx565DeKqVadr+pIy43Urjk7qgwHBvV8OwBo6fZCeHFfVUaZ/SkmyopHeU5xPfDznxpZm2rF0dk26vRqts0Xo1MfdAGPyDhiu8gp4XUkUmW5zj2S70FPEObrs5nSHbgKqvg+eFXMEedi+1ChSLw1WfwBCxO4ps5FDxktQO+b/8sBxEq9glVJv/geeMVLsyuWssIFTv4zAA9DbKpWPzsJsS8n0pch7hNNMhwVqEkvBSqd4BKlJcRcm1CmK4FJ0RpdG0rCaNNSxpXAOf3OWZZqOcfkXd13HvE5L/aGeGzt2UjXkb4lhMRcjMXZFSLkNAZ4PnMkNI/oCOjaXB1sBq678rglx2fLRpMV+V2j5wFU94x/LpSH9QZYQxbjYlAtbtVu74U3gFF3ogTmN+ldVjjB0Y8gN2sPlfRgkDkCilcIE7bpMNiKHV3Ga9OeRGNyZ4IL2RZL29wKiFCsWL4ebaec9C2FPx3PeI81f4Mg+5u4FQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb64d65-e03c-47ea-d503-08d87aba42ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:47.9480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZh5g5wTT0wnEyzZ8sZcLiH+QuuvZbw4m45VxmsVxMcnLTuB84KJsKldWVfyNiKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
On APU should be always using prefetch mode 0.
Currently, sometimes prefetch mode 1 is being
used causing system to hard hang due to
minTTUVBlank being too low.

[How]
Any ASIC running DCN21 will by default allow
self refresh and mclk switch. This sets both
min and max prefetch mode to 0 by default.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 70a18271bd2d..5ae3419682c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -301,7 +301,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.xfc_bus_transport_time_us = 4,
 	.xfc_xbuf_latency_tolerance_us = 4,
 	.use_urgent_burst_bw = 1,
-	.num_states = 8
+	.num_states = 8,
+	.allow_dram_self_refresh_or_dram_clock_change_in_vblank
+			= dm_allow_self_refresh_and_mclk_switch
 };
 
 #ifndef MAX
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
