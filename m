Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40BFC433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB9920801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B41F01Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB9920801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D376E479;
	Mon,  8 Jun 2020 04:59:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6016E479
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm69g+kjgGsTVlLp8VClrbdNXWaOaclW/9D0X1xefrEVFyy9e1mOWHyPNLwmtSj34yp69GCVaGJ+XAUzOSxvQlReAmR29udqhIbGpUK+6FQ4xz2xjEtrGi2ejnAo0DpSvp+d2ZClGjjjWXJ0Ipn80AvqK2vgMn20xnEnfGKXlJfT7ht0Lhpm4U1+EcHWz5ESegJPyemmRUNFSNKx9Ru9K2OBbWQ27hC+2uJl3x1GeO3MyuI8j2CvHdafXRDzTAmBK5lq8Fm0sFr+TRu0dqrdMo2mz+JJPfFq3TkMa4dAS0CJsjsap1YTTOFxM5kMrsncXIcq/Wo7oRf07lMXR0Az/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTnopXRBYVwAQI3ttoClA7qd85/MSrVw2FE4ZM27JnU=;
 b=Yo4SeD1bYLIkVknqA1zCZmYEI4lwBg46GR+UN9uFaRbODYTFhLUXlWXcmlrDUUpR7scTpzRQ41C4U/CI86YlvMXO4Z+Towrrk6/I7oZBY9GJJdCA0khnyfy0KDCitJu+pkKF9293VDv9sZJj3iTdIyryJAjrNLR9nsC0KNUkC2NZpSK53IitmUjEsT7qy7RiHTLkY9QaZEynIYmFKdw2X0AHL2tzA+pn1nRKh5N4U8k9rIQMvIHXiVmUyCDN+rj/JIWOwctnCOCf5paM1Xk3uvnRN+ooeTTKymWPpONoBi0k2hPPeMe6dtKINukw9X5I3Ab99FGd4DlmmbkwkXORCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTnopXRBYVwAQI3ttoClA7qd85/MSrVw2FE4ZM27JnU=;
 b=B41F01HaCMpQTEYR9orDqr8Qvrh5y8muADpJ+WG+jsVK1A6jHWYzQTECTl2S85mDDKZb87c7I92ka9QnxRZU8s+ipAMu2GLzB89h1z1hq443OCpypdZzS77GKquVz53ga9eZxzedxjME7HS3C+uqGxDjISBEH3XB9m5xqxRYoeE=
Received: from CO1PR15CA0113.namprd15.prod.outlook.com (2603:10b6:101:21::33)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:39 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::ed) by CO1PR15CA0113.outlook.office365.com
 (2603:10b6:101:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:33 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:33 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/28] drm/amd/display: Fix VBA chroma calculation for pipe
 splitting
Date: Mon, 8 Jun 2020 00:59:07 -0400
Message-ID: <20200608045926.17197-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(186003)(81166007)(6666004)(8936002)(86362001)(6916009)(356005)(26005)(70206006)(44832011)(478600001)(2616005)(83380400001)(1076003)(316002)(82310400002)(82740400003)(54906003)(4326008)(8676002)(47076004)(36756003)(70586007)(5660300002)(336012)(426003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ddc80f-01c4-4dda-db7b-08d80b68bf5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2795B2675DA7CAAA269F1C00FB850@DM6PR12MB2795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5aTcTw8fuJvd6EOGE7vnhVH2nsuW0oh4Rv+nPYoXyXOr2Vt5QglrJbdLgsfX3LS18MeSP3CUu7vHfxshOyMNG8yV+n4rsZsPiNY2tHs+BDzyWgJKSGTzOG/g/RelYeSqo/xOsLpEqvkuahDKIEX5O8ps1/4ee7Z77HCmp40Wm6xpgnrLuZug3StN3rlFt05Hhak+LMlwqCIc3QCpthyPPsPY9UGjH8p3HEggyvHqUdT2ENeTAm+tHS472owYlem95vzpneshoxzjMYL/WYHDQLghwMSlMC0BdBEKDyjm4ycgz/ojLZjaFmUdxDZcDCQb7fvD1PAuLJwIYDVr18cAjmseReQhwto1XK5+zRMrP9Pb5sZbOSwgB4AUMB7VNbw2FYowzTOx+k91j16LqeEng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:38.6495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ddc80f-01c4-4dda-db7b-08d80b68bf5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DML failures occur for 420 modes with dynamic pipe
splitting enabled because the ChromaViewport exceeds
the ChromaSurfaceWidth.

This is caused by adding the viewport_width instead
of the viewport_width_c.

This similarly occurs for rotated modes due to the
use of viewport_height instead of viewport_height_c.

[How]
Correct the calculations.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 5a1ca8a5954c..7916a7ea9336 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -623,14 +623,14 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 						mode_lib->vba.ViewportWidth[mode_lib->vba.NumberOfActivePlanes] +=
 								src_k->viewport_width;
 						mode_lib->vba.ViewportWidthChroma[mode_lib->vba.NumberOfActivePlanes] +=
-								src_k->viewport_width;
+								src_k->viewport_width_c;
 						mode_lib->vba.ScalerRecoutWidth[mode_lib->vba.NumberOfActivePlanes] +=
 								dst_k->recout_width;
 					} else {
 						mode_lib->vba.ViewportHeight[mode_lib->vba.NumberOfActivePlanes] +=
 								src_k->viewport_height;
 						mode_lib->vba.ViewportHeightChroma[mode_lib->vba.NumberOfActivePlanes] +=
-								src_k->viewport_height;
+								src_k->viewport_height_c;
 					}
 					mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] +=
 							dout_k->dsc_slices;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
