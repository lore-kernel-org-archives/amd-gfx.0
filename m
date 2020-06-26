Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C4C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016E0206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lcCMBreN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016E0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA876ECDA;
	Fri, 26 Jun 2020 16:19:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBE26E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahUfNDww3lFhndwHu6DoA6lfigC2775KhI1HG7xcLNy0c2a/P86cCJrXLx7u29oPhSt/X3WsTrUEwy77OyYOTsuVEMXjasRyLP0GZ0aWFSkOFXYF2es6hmCSHgmeZL+nwSnYuxs6XzLCDA+4WjRMuQZsjclGX/kKhZpHzzPMJvq8XilHOLQsj2AzZQa2d+z1uP+aOPkM4I84dW93+qPS7BTLvEF1XY91xn1rc47h6n+aLTdZilG0kmtxZJ/EBX3sfOjnhzg+PAKX9D3+Hr8MiJ7E2dtE5mXRyoJAycEvJCFU/xVSWbPpRiRIyG+kuL0Pai6dd0FssJJ2ziwxV0x7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcqQJqFwP7btk4RZbsxQKbz3Oc3lidJVjF9wmLS7rSs=;
 b=NfuFEubkWlcuXZXD9vmQzL1Lz+Gg0yZ3XDFo4F1c4uFGii5vcGlx7jnMFOGRH7D3kGbeslKeC7SnHV+IfteBh+UG5F2wJdlj5r5+n/lT6/eoRNJMcRnINxXSIiAtx8CiYZPFogxtexCZsDT19UkvA8V0QzRyRim6ijjD3+E+3oki5YDH/rGj/Wm7lQ5CGcfuISXFPJc/ntup/3WHuPHnyMDJapl1C68l1vFAnVB0YKIBMzZjspj4vh6ZFOfdLX7XBPRo9JvVLrgbOWPty7Gnat3rxTnj3UvhFVnahb6n7Oiic2BnU2l9Fj6rjh/UIugrfz3HZeSgIcDg3e97QYQr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcqQJqFwP7btk4RZbsxQKbz3Oc3lidJVjF9wmLS7rSs=;
 b=lcCMBreNPUnyeQheZQGVz5LvosY1aqGLRAX12Vv/BGGUQ0XUb2WBKNlgoGWzlVmXltX2Y5/e/LaTa9aMYnh1fKE8duRXdqSzmMRFA6juCOAIF2sl5LexNoNqp2cJKA6hMhP1WjNk2C2+sCb3D3zgGI9SZ0rLvk0egn2rcXfCyEc=
Received: from DM3PR12CA0081.namprd12.prod.outlook.com (2603:10b6:0:57::25) by
 BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.24; Fri, 26 Jun 2020 16:19:49 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::ab) by DM3PR12CA0081.outlook.office365.com
 (2603:10b6:0:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:49 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:48 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:48 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amd/display: [FW Promotion] Release 1.0.20
Date: Fri, 26 Jun 2020 12:18:39 -0400
Message-ID: <20200626161847.16000-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(70586007)(1076003)(5660300002)(186003)(316002)(336012)(426003)(44832011)(36756003)(2616005)(83380400001)(8676002)(54906003)(8936002)(82740400003)(4326008)(82310400002)(478600001)(6916009)(47076004)(2906002)(4744005)(26005)(356005)(70206006)(86362001)(6666004)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 200b2a10-5b3f-45e5-2a0f-08d819ecbfe4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2547F4EBD68824A642BB0840E5930@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJYw01iyMzXinllpOumcb8AiYvnjsMh4Y6vJkKi4ayEAln3zCERaNEeyBHxgm7D6xuY+iRrZniM0wGsi1fUeyaEU5+tDmteTQpLCqnl6yhFvntXIRnknrFfU1DLjHrBgIP5BmISm1kYooV71Gn4D/b24WgV75FkArjRVtspoHZhKQA63Tj0TGFoSciYGyuKxmmJ95xST6dH/V7qsrsmxhd/uBWPuTQvpDdVRdIO6MdCSicNTB8XaBoQ3xR/A4gEKtVhBtq54sWmzECjrQ8V1TBTZ9SEWgXfBZcLfAK3ADpNgpg6/Pqnutm+HgSCBYr+xUodK9i+fMNt+kAFq2c12/FpkA7pbOAsJ4s+JsRqt53CDbfdOzke3s2fMuAH78LTu1tRQA5duNqC93WsjYUWf7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:49.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b2a10-5b3f-45e5-2a0f-08d819ecbfe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 68b5fd811d26..5f2dc62ff1ff 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf87bb940b
+#define DMUB_FW_VERSION_GIT_HASH 0xf88215ed8
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 19
+#define DMUB_FW_VERSION_REVISION 20
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
