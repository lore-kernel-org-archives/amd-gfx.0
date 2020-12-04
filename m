Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5BC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE8822CE3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE8822CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EC96EC81;
	Fri,  4 Dec 2020 21:31:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1A36EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bozRz67dDZAU02o0pNYph01NnAxrRDKjw7P6QGrVpWltfgjgSIqCWuqqKbFivl0TBO+immc0MhHbMOUSCMdxNSn6VcQTrhDu+adnNdNu2ZbAsrxGBw+jB0mO2V/onYPWO42q98Wx1eLxyYvNLdtfWIwfJ0cRHLVUmM20gYRlI0nSlPgIBKER11hSMJSAD99stX5FnDbr1awvKXctIFL09O88Gl+KmXKieEq82ZttRACNB3uReO4JpmYSQFHqzC044pynxd/UO23fNYkFeQRGyKJnbhJuwtuvI6rR/IlAymgwEkC8LdbX++RDV0SVAOPoVuM5M67wLzzBZx5XymUi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlF+/aFzkYxRMG2a8aDPCvpoZByKqiZ/TNuqj3vREug=;
 b=IUH8MwIfL0Zvj0qw4VbH1mJrftBoZjGGZiofeeod8/6wWjWYX+clHv/CyytjqChLMYtonLWuEYGZbHBHjpFQ5cjDkn3y6OkrIdj9aeu1VxKAyEv6YAtVET+zzAP+2QOCNydBldjB3phT9RkVUVRmGsYgWkmdFA8tY5nx8oVxbsQG9/SMP1g9erWZUWOD743GVmf/u9ZXZ28b04D7FeltQGkqeo0C5wNkKt4xR5pJPT5b1lMxWyg8LdbMbFMbWnSlTflzLriN1SKvnmBwOUrM5HA57xfiBCkkPe1LAn08inWEIlWfbFBK0MEiQEufyva3GnIfsHE854FAlI/D/YOXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlF+/aFzkYxRMG2a8aDPCvpoZByKqiZ/TNuqj3vREug=;
 b=z2Dm6JBjiwO4tFrjYMVN6hlXg5vIllkCOtbQ9e5qGPsaCzXCTbmkJDA27Lv4BUjaMYoBI52BkYw7EH1K/ByLjZNBNmoW6cdO05mPFV/Jv8CV7hNRzBKsLlc2nAk6YrouHXasNWtgiXC+khqKv+QQHgamqiFSnEJJk2BFPETdJss=
Received: from BN6PR10CA0028.namprd10.prod.outlook.com (2603:10b6:404:109::14)
 by MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 21:31:01 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::a9) by BN6PR10CA0028.outlook.office365.com
 (2603:10b6:404:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:00 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:52 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:47 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/17] drm/amd/display: Prevent bandwidth overflow
Date: Fri, 4 Dec 2020 16:28:44 -0500
Message-ID: <20201204212850.224596-12-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85f6b410-3ddc-4b70-3428-08d8989be50f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3117:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3117FD6DCE0E052CACF72493E5F10@MN2PR12MB3117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fjn2svorsbLkLcxu27OoJ5XgnkADIDJZRfa0c0Yet3b2OvCr8xfg/oL0D9g7M+BtAN9Zt440W35uuGdSKQVinvziwYsEYEaQk8C7ad+L+pF8awtV4wAcEN98qgIt4P6IK5+ygUCgdLKrDXrYGUfy5k5INdJCqpjoBy2rp1s6emJS+X2uV8rq/zqtOVRuUSrKErEDDtWyoq5u3KxPxarY0zv2r36PZDOyOc1wghOyoR+ACvwJh2zGkpV8twg2YHTpka7lJR2lyP/XZdzmcsw61JBsGZNxsTgwG5UdhPLIOlNU4JzYT8QWnfBzyxmz60UlN/ebE9jxxUCoCD3U+60MU9NpbU0ERFoNr9ycW63l7ZBb94aiz1Cen6E9ZNplEwiPuDUWUkdltNXcJ4u2qH3KIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(478600001)(44832011)(70206006)(82740400003)(47076004)(83380400001)(426003)(186003)(70586007)(6916009)(26005)(2906002)(8676002)(36756003)(8936002)(356005)(54906003)(316002)(5660300002)(4326008)(86362001)(2616005)(6666004)(82310400003)(336012)(81166007)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:00.2817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6b410-3ddc-4b70-3428-08d8989be50f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3117
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
At very high pixel clock, bandwidth calculation exceeds 32 bit size
and overflow value. This causes the resulting selection of link rate
to be inaccurate.

[How]
Change order of operation and use fixed point to deal with integer
accuracy. Also address bug found when forcing link rate.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bd004de107b7..0052247b4b20 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3444,10 +3444,13 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 {
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
+	struct fixed31_32 link_bw_kbps;
 
 	if (timing->flags.DSC) {
-		kbps = (timing->pix_clk_100hz * timing->dsc_cfg.bits_per_pixel);
-		kbps = kbps / 160 + ((kbps % 160) ? 1 : 0);
+		link_bw_kbps = dc_fixpt_from_int(timing->pix_clk_100hz);
+		link_bw_kbps = dc_fixpt_div_int(link_bw_kbps, 160);
+		link_bw_kbps = dc_fixpt_mul_int(link_bw_kbps, timing->dsc_cfg.bits_per_pixel);
+		kbps = dc_fixpt_ceil(link_bw_kbps);
 		return kbps;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
