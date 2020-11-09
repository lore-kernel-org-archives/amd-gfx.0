Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 05:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5485F20897
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 05:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="skuZ/YGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5485F20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B098940E;
	Mon,  9 Nov 2020 05:39:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF968940E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 05:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7+2oAAGI8nXUiZmUksc2VgLqMMKexDpLKWjHYJRQ+WLyG78AIG5s1Vwid+L3TTM588FjWLo54/rrwDPKbOZCBDTI8egtFJgp+J0chHJ3FBXHVUlUyYNN2bWqdrUnKKNwf4O1MVDzsZAEPH1i0UozmFcJXDR1tIVrpxYrb69kgXmQDRiQmQkKljkATxuqNDnK+qkfP0l5uQUgY/RVh3KJpVC3V6wvRz0jlqwmfpoIgr83hhuGlzq8dhnzvyluryf06O7yM/VcYT2mRW2s0Pv3SfxX5nsBEbkAaob05NX+uzcF7GVn+Pnkg3mxtAhaE7G/RmP0IW6wVYvbKPyATLVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOPWsvMIL65KoD9T4+SRGs+CPAf1XRHw4rvFtlR5kPk=;
 b=lVWY9IyZ40CrKydaTlqA7ZCln9oFfp7hgefTkUBYF1jDPjtT2BHqmU7og/6OBbG+6PTy0iPzCXtqLgCjT4GSqS80mewI8xMC7ADjK7+PmioaXhgG6nq52YwsebVdkYxC6PaLJNV8kPLDUFjMP/O+8vI56e00t+8Isw3w+CB1Z45GDmqavozqOO4rKhYIqntWg7T3IjcSy2q6ZJPbsr56V5vk6lTALKJCCUhPBy5N6HHHTpVHGWc14rj5JguvzzeWHI22vZFjjiQqstlB608cxgJ52rJvxIuNp9TNx65LbRJcUewuVZ4d+N2jfkGsBm9DY0fCj2hU9nyVY9HLYs3ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOPWsvMIL65KoD9T4+SRGs+CPAf1XRHw4rvFtlR5kPk=;
 b=skuZ/YGIvriQ1UNGjjzk67Erm/nM8FOyDu5iJfDYbFNbA7i2D33l8BuR1GC66NSY7sM+J+whNtSxrzJZSP831Lj/JDXTrYkuVH4kxQ43H3iN/j81HXZRjCR/O1q2PXzppLtiSV46RekIKS7FlnxYK5oh4GCFQyBEfcrvFFdgPoo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 05:39:04 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345%7]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 05:39:04 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Tune fclk for 4K OLED display
Date: Mon,  9 Nov 2020 11:08:41 +0530
Message-Id: <20201109053841.3977814-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::23) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 05:39:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 921c16d0-e201-4418-893f-08d88471c4bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB2960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2960341DEC570E35C51AE41180EA0@MN2PR12MB2960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG94VXG0nQPeMa1PRfoXwqgteto6mjhcH8WIVH3LTRbGO465MX4xCAes3SKyOzlO4gciXcjnAZAWIoU7HpsQHzd7kS2SNvz+a6VFegY6DEIksPSMg0gUMnnMcgDRPKjEMqQvT4TrxU/FZf195QVsBlo6tBxVXXIBC3nJ4vfgo4vPoiK93kbOfiwO0ao/n7yq7YD2pe7+Y9PlU/vx6EC4Wls7EsK5M+8GuH6LHhYzi7FzsOy/C+50ZQR0CAt6LEgHTxqAgWNH3Zhxbvx6mR1++u3fGPkesETTT/nY8hT/dvoA/Ncfo4GvzkMuKJiVyNSL9Z4VMIoRXGXxVTM78o47WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(8676002)(8936002)(1076003)(2906002)(316002)(4326008)(36756003)(478600001)(7696005)(86362001)(2616005)(956004)(66946007)(66476007)(66556008)(6666004)(52116002)(83380400001)(6486002)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nQBIWccYT9x9NQmRPFspLqT2Zazp/UqR8fWDlFwwkt5RuvbzL+slF89UOwaCQeqKxXZBxIFTL2DSSdw46aMOAwS6u2CA0+qVWnUQ3aDvIl9yuTf1bZqyQYgQVAPSBkMu3b4XJ/EYswwDaeyfYZhtEMT9LMehWYfK0Nz8ULyqoI7exGXECdfA1jmeWSyRBMOyucSqEbRJYCEjI4JRRGYg9CdogYicF5gAo/ZpsnocKZxqcAusWIrEasMRhR1JM4jJGwm4DRjJPWEvsUPwepB4zkMmCh35qcjE46hxTRvQZreyC/obYsl2hKWg/dAIWNNQwRWxLs4uSOd62nPQTdPwGKYH0ASwKB8MNjCOoXpBm64K4ZzpeLNlM3xTf0/bp7k+Tix2EogJjYJELsPaQvTMcoG6zZ43bSKtqQPV32apVpVfds2/aYDzZnqWEvdxy0DXVxJOlHbYim0oMEkMu08FRGUB7OTlq2SgrBNqJJytRa+GF73nbavjkFtyJgKWzN+86Ctc8MCPjAli/+wiEOQche7hclIKiGnE0KqzgcIrD8QtrX21Wibcsw7+aqPIe3YMADwI8FHTf2MKvMpyiOlod3JJOJ/V095BPnG4LCiWkJ/IfLMveGoTrBgZxiU4UKR9er4CwDx/83CP03K7IgmJQFJn7pLdG4xBoggW/d4p5YUfT0vZRr4/gjmfC23m7BKvyNq6/yP4qBQSOia+qSnRvaT5B+2VP/OBs32upuhiEzUsrkG29zvyeHhGSGtWOVLIFChY12NEsRooo2bimnDEjPkjLOwb5RoJYU46sMPGfDOCuaVQOt41OYMpFVKFTa2mf/QINg8PBSdAvk7bA3So5DmWgKgF1DS0vm3vghgQVF7jFNXKsrhrnYZaDmL3DHWkVS5Ht9SDjCBIss+jII0u5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921c16d0-e201-4418-893f-08d88471c4bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 05:39:04.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri2rkLe3sN+Jo83eGJk4WHcCroPyLN2Egbgaa5cKj6FTDlQUBMLMDC/dLYXCiBV9pHwtPXI88IuJLnkSw0yQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
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
On 4K SKU, in DC mode, there is a visible slowness
observed on system compared to AC mode.

[How]
Tuning min fclk up by 2% resolved this issue.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c   | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 832a43053420..ead009628c48 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -210,6 +210,7 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool send_request_to_increase = false;
 	bool send_request_to_lower = false;
 	int display_count;
+	int i, clock_factor = 0;
 
 	bool enter_display_off = false;
 
@@ -217,6 +218,12 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	pp_smu = &clk_mgr->pp_smu->rv_funcs;
 
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->timing.h_total > 3840
+			|| context->streams[i]->timing.v_total > 2160)
+			clock_factor = 2;
+	}
+
 	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
 
 	if (display_count == 0)
@@ -302,7 +309,7 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
 			} else {
 				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
-						new_clocks->fclk_khz / 1000);
+						((new_clocks->fclk_khz / 1000) * (100 + clock_factor)) / 100);
 				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
 						new_clocks->dcfclk_khz / 1000);
 				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
