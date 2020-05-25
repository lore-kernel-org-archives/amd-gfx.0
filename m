Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565192071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ywH51G04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565192071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5566E0F1;
	Mon, 25 May 2020 18:13:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACCF89C13
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmKM1R60SJCgN6gOjuEleh+vhMhaxyYPddGtXg/IaIKilRHZffMVgCUTkRuwRmGbWAy5aU2yQOcjioHmkC9JuuMBJSEe/qLGEI/5dicFNkeigw8i+2lsw2dhwSvXIFYJBzEqDlmMHeFjMrYcFZkNevC6sORceZS87ykYrAeZ7BHL7i2tVHb7GbznLlHPrP6rGrMqm01TPVOzQ6YpZcCl3YCi3E0+HAUxFL0pZIebJ6+zTx4tiALOVWDfF8tDmbZb/5qVuOEsSCNQTYCKDxg61N5IFc0EgpE2fUjERb2g7uiMXrwpM1X0Z9mqJCDGfsbKv3/g5nB8T521YuZuJt0kcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9YvUCce1Nm8s1F1s+jblvJAf32fGEexnsbt7guf2Eg=;
 b=PGfLyjTqX2qVwhYEk38fOUAWkz+3jr944W86auJhuSZx6VC/44RLpZktNFqhSLfy5ltPoW27ixrbEcU5Bp7o06gvygA/gIQoio5i4HgJPrtX/XXBORp/A4bWi+I/qSiUQO3Lir/hP4yKGivDD/Mj1B6FNpSsjuUFwmRzYk7tl3lcpuhSxEv8JcDmCM26u0XHs/jmHZpI7d797Tor3b8Bh1WcSCaAgf1IJmIVbLcXNB+8SRYopJzJY2BeCtQX3iLNbb165CEofMxoPYddsH9CpGoybBQaPzMfQgLN4ARowmFDuxNcUB/4QAjqDf9reaHthM2Lk12QTl8LQ52jtgISTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9YvUCce1Nm8s1F1s+jblvJAf32fGEexnsbt7guf2Eg=;
 b=ywH51G04F/LxwT41XFqdHORc4SmGWgkRZu9Dr+73voxxtArAsDgIGv6wwXygF3xTutOssM+N3OEpT2Jl0DJ9wHCA2G1UsK7bQscD0bbERYDli+jsoXeJ3dhMZcFUjvuQ8MFYvvIIXHY2gjQC1ycOGIoY09JqB+d/MYSDFyWHmsM=
Received: from MWHPR22CA0031.namprd22.prod.outlook.com (2603:10b6:300:69::17)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:12 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::59) by MWHPR22CA0031.outlook.office365.com
 (2603:10b6:300:69::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25 via Frontend
 Transport; Mon, 25 May 2020 18:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:09 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:08 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:08 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: link_status not align when power off
 encoder
Date: Mon, 25 May 2020 14:12:52 -0400
Message-ID: <20200525181306.3749-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(82740400003)(47076004)(356005)(81166007)(4326008)(86362001)(336012)(44832011)(26005)(186003)(426003)(70206006)(70586007)(8676002)(2616005)(8936002)(316002)(82310400002)(1076003)(4744005)(36756003)(6916009)(6666004)(478600001)(2906002)(54906003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b2bd20c-9a3f-4951-8f4c-08d800d7495f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4043AAE2A6F69555B9D412E4FBB30@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhZbYsmAvcrYu78a/eKG7Ll7KKxIm/gALy71rIx7SgoVq4EE3OLAVKMd16eJGMi7lLx/FfRdZAQO35MBD6nCF43Csuk3XOtqLyb3tUOo/FJjDehR5ykQ6UGKEnpo0rvWj0DHZmq4nuzEDnzRQEbPOlgveEMp22EtqW008w53b/kn+BDktpwAKB9QPsp+MySKLuGaXOCB9CXerbVTpi86e2Tk30WzB6IQZK/nxy9boh4ZjUl6q60Z3xlhEhzQNXQdvBZsptrxWCRPAWHt81DDPYv+be+G23rGWtGjHED4x1hrE3Sh5zWeP/l+hfoVIWR35qh6aY25e076Y9qqHIZllxXAWgfnp8bvBmw9RSt34iNP4cgIH4QjzCwxTlUeY7ggdZiym/RSRfbi1F03mdycTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:12.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2bd20c-9a3f-4951-8f4c-08d800d7495f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
The link_status is incorrect cause driver power off eDP when backlight
on. Some eDP panels may show garbage on screen.

[How]
Correct link_status when power off encoder

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a475e529ae1c..2ec5e9e1bdc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1443,6 +1443,8 @@ static void power_down_encoders(struct dc *dc)
 
 		dc->links[i]->link_enc->funcs->disable_output(
 				dc->links[i]->link_enc, signal);
+
+		dc->links[i]->link_status.link_active = false;
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
