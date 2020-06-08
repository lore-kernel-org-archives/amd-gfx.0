Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A163C433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC8220801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZKSHXmMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC8220801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC4F6E47B;
	Mon,  8 Jun 2020 04:59:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47B6E487
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrRJiwQN1Gl+mFI1jsdQhSSeNtnYVEsrnyEMpbe7TXM7z/gHD1pG9LxRoiXBu54YGjNEZzUoUUR28+g/m4IL8HvkSoHpt5h5pvwOxX0RxIs91wmdaTwh2DK59iQTmFgt8sl6lRMXZ1FUFJVNTNdAGKHuS9mwjBf8XNramclb9by43sMpgn767ImCK2fmHGNUu612dxx7ZvPvB3N3/FklWJ23iI0858+mMw8LUKEiVNkSFgEvD4AL6Of4cTQLukrMhKv4/+DCGpgNmKG0CEssKrRpJ3cKlUzxQEJHcJMHLD8OeerHjcljG4sjPw4+n+IGO7OpNqpa5GLDw55CkPPgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhrALKGJ34l52fBLyqMjzKlgI70UHmVp+mDNjDdgRoQ=;
 b=S+lAs2iaL721w1nMYij2caadnsO4lkt162kAmfc6g6xWa2UVG29xHBpfzrgei0PBwevErFvL4WS28rPyfol7WDKiGrywncrG92hVc3y0UuAZ8gwc1ar3Dr+yrEKP3NWwH/1TrFWOgOnPqmrzQVp0zkhfeF48T9aeXv8M6TdzfG41PMw5uF5FfWZaEvX1sTGKrNMAxAbztvYVe4AWOVKCNN3owivTcApRA4EjAcq/yzvBQUcA9t2Y6ma7APsaNyixRFu1DGFSJUZr+HWIjkHX/UXyJ0NHYw1AA7PDgqC6Xfm235uVkmCXtQNLl46GxVM3OJEUB5aJ2zZzcx+kRM/VRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhrALKGJ34l52fBLyqMjzKlgI70UHmVp+mDNjDdgRoQ=;
 b=ZKSHXmMbRccioNiBbby+0e7jNz1O+fqVjv5b+do9tCovDno1WLTd4i9AFaMQsnhOe6/IudHpkc6qYcwNRNE+KTRzzz/L3Lqf2kZBENpFrrfRj9LxDSEmYmwTq1tUARgNYUgw+HU7gaJZuZDAQkKoLreU2097j8eTpEg8Dm0ZiWQ=
Received: from DM6PR11CA0028.namprd11.prod.outlook.com (2603:10b6:5:190::41)
 by DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 04:59:37 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::b3) by DM6PR11CA0028.outlook.office365.com
 (2603:10b6:5:190::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:35 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:34 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/28] drm/amd/display: 3.2.88
Date: Mon, 8 Jun 2020 00:59:10 -0400
Message-ID: <20200608045926.17197-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966005)(186003)(2906002)(8936002)(26005)(86362001)(82310400002)(83380400001)(478600001)(82740400003)(54906003)(4326008)(81166007)(356005)(47076004)(2616005)(4744005)(70586007)(5660300002)(36756003)(1076003)(44832011)(336012)(426003)(6916009)(6666004)(8676002)(316002)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9e5541-b0e5-409e-579e-08d80b68be5f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1356BA48D12D63247A447FD2FB850@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPa5q3ni+tAXHrMkrSZpaMLQevfk+f2O6JukM0VaPJzVuMm3MnbTtmerSIrRhzAWqG+ALZATmeGMmfySL69mS54qKL7aXKOqxQVbXPC84PGuf6hvg4VhADdmPJtAnfd+zxdactuYKxnHJOCQ6mkPqXvJ3NGQ9HP0u8w/ByF5soqIbZk7zPr4pNUitFvfiiDx9xxGuebij8/artxHtAQcecILp2Dwx0ePOAlhg05cQLsSzZX22Sr68qOKI/ylawm/YSz5FMOTPi+/K7AXS0X3T9pY1gm4xDz64PyWl1NlSNd3gspEVtCN2KgUhJwXiOOitNhCNP3VMswMAS84SOp4Qw8SHoe9M9REBUEWD/YHiQJigXd+CgMijmnerOcQy8H+VUR7F8A58cxyPEwTTg66QA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:37.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e5541-b0e5-409e-579e-08d80b68be5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e09eb876a366..8cdbfa15874b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.87"
+#define DC_VER "3.2.88"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
