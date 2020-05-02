Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C7C3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003CE2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kth5UcVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003CE2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D616E130;
	Sat,  2 May 2020 21:35:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF7B6E130
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr0YShi093i/HxpGrvhS7AMGqRrBhxNioB3ov7VAfg45o0V4oBT4u62FLGaKAnmuAscrOwNop7Nkoc+L/YYhOC/I11RD/lvepo2RF5Mdp4mHCvHI/1M6GdFzEvaY94OYd7RY55wGL7BOnfpDc0sbMqLrqQxJLG4jQ8oEaWIVxPhtjPlyMd8I/7b0aXwA5ALDJgiVd2kJU40MxtOc5szLiw8lsWUWKt9bKWnSQtsGEs8O8i/EOz0TwQS6xkI32GDiac51F+jc6zeF9oqQTBsROvaUkqKDKvqjWbfnurhIn4tNjuyERaQO5l9ksZZu3GV9NdEfDPTp0Qi0bOGB9d93pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoxqi0aP7UpPbnvNJHZoQaQg46BcppIbTxMGSc2yEsE=;
 b=nx8L3av6HUqy6uGxDw6NEpVtqrnYmjA3IxRRAeNI/Eh7EnZVGFQ2SMIzveDyo5UJ07o5oSVksVtkuhi9EpABDzLNVMF0cYePfH3Yelmz16Ov/AYBFQTSn/M91IzSw9FGohfkyn8vTuWyUjO8YpQUbODlBryxn/9DzXWwF6kg8yATekC4/F0Ylq8Yx3QpOxC72Me9IBh5ofYc86l+lfrUkmI0A2XIufV6+gS0g0qA6URBrG6VAnd/DCMfmCJEPS2yQj8w6GZOKL/cxROSsULjcQTREohnbWEnOci7LFcvmxvhObugw+IbGxsUEORppndRz7xvkpkogyhiwQ2qRcMBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoxqi0aP7UpPbnvNJHZoQaQg46BcppIbTxMGSc2yEsE=;
 b=kth5UcVj7ZnAHSV63GDrk8WzBO5vN0C1hcvDUjN3UrH2fX1hrvK155IXdmgL5xerkDaB+b+t75bfL1ko/haJi4gsDHxUDzuSdNLdjUfPRVrdgRWiI43PsDiLSykcdmiC4b44AAoWAglAXtSrArczCHVbYr4o+Nj5l37AXN1eLSM=
Received: from BN6PR08CA0077.namprd08.prod.outlook.com (2603:10b6:404:b6::15)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 21:35:04 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::61) by BN6PR08CA0077.outlook.office365.com
 (2603:10b6:404:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:35:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:35:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:03 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:03 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: 3.2.84
Date: Sat, 2 May 2020 17:34:40 -0400
Message-ID: <20200502213443.39232-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(4326008)(86362001)(426003)(2616005)(44832011)(336012)(8676002)(8936002)(82310400002)(47076004)(356005)(186003)(26005)(81166007)(70586007)(70206006)(6916009)(7696005)(478600001)(2906002)(5660300002)(4744005)(36756003)(82740400003)(54906003)(6666004)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5906f0-c01d-4a9d-f0b7-08d7eee0ad33
X-MS-TrafficTypeDiagnostic: MW3PR12MB4474:
X-Microsoft-Antispam-PRVS: <MW3PR12MB447456D4D841CFF8FE6134C48BA80@MW3PR12MB4474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dKCpdxhZEybEWcCfp77g1HjaXJW5wRxqvIpNR8XsL2qrQGOZ5NBC0bSXUjdtEzZ7wCSyt8yWI44L5xLL+Cx4hcs9MMeGlYq7fTTOkFDAzANqjogsWEo8QINO5ABP6nBGGDIvLm5I5GLOdXw5kvWGZ4YnlnqDldwi+MQ1e8ODfXvLGk6hgWRFFIVHfLeRZy6zGkul4Yfv5QK7LVmlgqx63d5rFN23G6JSMfS8HiAmMOvmgCQxutYLrEWonsTZomUIq+p/njapixc6BFpgHBCof7c0Fe5EpQZW0v1VsIDvIhRGbhlLArT6b48tQNzc6FF+pOw7nlyQ/XJRrKSd4BD3pSRPB6u+9Z5KjGLkRb3vZhlevBinq39QNv+7TIEFx/C1tecSco0SwihpGgD1/nsNC2KwZHONjh1BmMidJgnEP/KKx23xbmx7wkmRuf4V+DJ2x6iQUR2DUlmvR1glQYFGsnMLjCCcNAF09QLBRYdeOnVx713BmDsn0z+Mr9y2ZsIqBsHd8HdQOycOlF82uPruA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:35:04.1732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5906f0-c01d-4a9d-f0b7-08d7eee0ad33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d2f796bff522..85908561c741 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.83.1"
+#define DC_VER "3.2.84"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
