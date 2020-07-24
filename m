Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B275C206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qDAICGkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A03D6E88D;
	Fri, 24 Jul 2020 21:08:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF2C6E88D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYh/209K0c8yMOYpwTRccVbT3BA/O4MVgZ8S7Qwxe2W5/c/gQjjXJHpMDXkzCLgx0i6WS7yba654/DxrirvJbtlns5Jp0iT9bSoPN6jLyTs6+W/ySumBl/PmeptUxPhH8blwF8vNowA8F575ZIoq7CZuY51G4vd9j1a3d7Br9ytw7eL7VSpx44Dzp9TrtDFakcBIVdc/aLZCXk+e7cCwwy7vlv9hOOBCN7xLNFcjE/0BQ+Y/Fw9iupfUC2Kr2vrv1rPQaiaOQaX/5bPY7BFdsRgkpViQX2krEJ4vYgBfOI3oGGpZiSnl1hFWwf8JoOqIoLgUCsvEEzSQOpmFhbZGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wcjkj6PCZiAtCNx/mVlTf2WV25ngJ70G5K9aoRKN98=;
 b=XkmOONwoarKc3bJMyW2OAVk/zD3x9Z8eA12YNMpHYNSNhuBaGtV2L5kusz/EloG2XZqynGTA3emOxLFlU4tUMXqLDKXJmuaVTrxtZk6OvGVmqkQZeUXD6QDDd1ZJsZPxXRogohsMoQ3etsZ2T7X4cqODZH172W5OlHApoIrcyKNRxAjbN4OU52+s+7RS0ebf+2ovyvWkktTiLnrKzQeHlotkN1KMiYY2tzLHYU1b/arFBoHrvUojXpjebSUE8D7CaiHAjiv8BN7g5qvNZuFFHzsCbOUSQDaC2XHoDLdtv9awYCSRr0u4e+0uV1hkPNL/5KA1kYakUjxkgDRVVvAyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wcjkj6PCZiAtCNx/mVlTf2WV25ngJ70G5K9aoRKN98=;
 b=qDAICGkgUnpbao0g2ktZGz1eV/M/tL6IO7JSzO1TK/FvGqa9KTAsx2OO+QUer6Ltxn1jN36VmDngfLlXdx1AuuBQOFdM4MLUiZAmtKhSlx51BBTqJkmHnN8TN2HGX7RAnLncO0XxmfJVeOIiYoua6H9Gds0EFCp9RARJVz9AWcI=
Received: from MWHPR1701CA0023.namprd17.prod.outlook.com
 (2603:10b6:301:14::33) by MN2PR12MB4341.namprd12.prod.outlook.com
 (2603:10b6:208:262::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:07:56 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::6b) by MWHPR1701CA0023.outlook.office365.com
 (2603:10b6:301:14::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:54 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:48 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: [FW Promotion] Release 0.0.26
Date: Fri, 24 Jul 2020 17:06:13 -0400
Message-ID: <20200724210618.2709738-11-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5027bb2b-4c86-4706-00fc-08d83015a2f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4341:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4341F7BB6916A6BA42198A8DE5770@MN2PR12MB4341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pviG16Bo/4wbAhDChN30qO1swe6HNCpr6ZrdFfZR2OYBDb58Gr6bEQBbhVsOr9K72m03QsInxWr114q6DWJ2JRLsMtBZIv8hWt6CP8Ezk8jj9eA0In2pXNU9TbyKJmvnoI7x+wjBrdV4ieQR2TiOOJ9lX59KsKkmoL3hN7kHmAia0K8E/HpKIZs7A80Aj0iaDAOXOUZE60wuzfixMDJSLmDY4U1lLkkqhnNMTodOAJ/7AF7y7FFkRE7wM7c2smTq27cafrfgYZ0wFVLisUhUZSifCJQmnJapY+qFOpDeJ0sIiyrQ2u4uLmIKZoWgg09aBr09h3xIwVnS54jh5h1qB80z6zXkfvyY37M8Mak+E9PodQ7ODLewlwG3sL1IUtJ15csLUPz6nmKKUaalNfo7xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(336012)(54906003)(2616005)(83380400001)(316002)(44832011)(426003)(8936002)(356005)(6916009)(82310400002)(8676002)(478600001)(2906002)(186003)(81166007)(5660300002)(36756003)(1076003)(4326008)(6666004)(70586007)(70206006)(47076004)(4744005)(26005)(82740400003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:55.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5027bb2b-4c86-4706-00fc-08d83015a2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e013875b89ed..8b27cf0f1d51 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xe6d590b09
+#define DMUB_FW_VERSION_GIT_HASH 0x636e7b294
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 25
+#define DMUB_FW_VERSION_REVISION 26
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
