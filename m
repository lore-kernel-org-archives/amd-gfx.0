Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3719C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36221208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ICWJPMpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36221208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3E86EAD5;
	Wed, 16 Sep 2020 19:42:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAFE6EAD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNBhkA/hvs6vQgcR0025orjskyT9p+yZGbx6ns6ajmQ0MZkgC/pAW5Ya3wW8f1ynehfNeMHaN9naO4havy1sGow1fuXffijSmKmzAuQX+poT+Bgt8MHkrduF3IphSRKSmPXDzVQiq9WVJ8bA1usj0sqYWrBaXHZ884rjfVxYpjb7ZJjjbuYMlXKcqilh1amsh6W0rtCVlWojljT9nXZ3cMzhcvfSRpgAQf42LjUUtp/i+yvgz8tvOXX5YN9ZXoOQtmuuqgxFbKDEjRSYVLCoAxq5h0vpUtkzHQEbrtaidi88f5Yzae1yXVXRGua34BVQy8eEc2CZE9YJ5FLsqAuEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzydMPhD/98G01ho+xxJV/WhK/RBtvYaBrnK3rEEoFs=;
 b=HszPWx6dNGxaGqOSqvL40ILSceGd1I0A8YGZ7kml+rXjggIjQdwrfbxTmF1GkyloHElKIlH8WaBIByCXZewayjmPgugZy8IszUb+9Ht+fTEGIclgFpLAR3HgKyZMEHGNTfwKcWAmBkItL3Go6JxqPAwrd0H7LqEwZa+yOI8cBcqJv5UZJnV9/9MXp9dBAGQ/4sSy9r9wh0bRhG4Vo6LSOhX4I/avohhaAu0W97i7UfdANaudHSpJ3Qu9rcdAxxbJmRjpCT66epO8mhWCj6fkpXTahgmJ2UGz3yXOwl4AR4ZnNDkTUVUI9TGvr8gFyRZ7JztJ03rK+ti7YR/f7du9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzydMPhD/98G01ho+xxJV/WhK/RBtvYaBrnK3rEEoFs=;
 b=ICWJPMpSjHO8AP13RhUhR2deyjQIbIyWXjqfxN6WNVXH0a6Q3eJYujIvIGu9rcGTW8+1STv1NWxqKBT6CBzKwifwNNUXBafYDLPD8bCgoA4Pt83d1PRpyPoq/n9JgxRi3jMa67mduxt9xYEcOPYUMWTfgx+9RmIeSsdOLWrgsog=
Received: from BN6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:404:65::16)
 by BN6PR12MB1521.namprd12.prod.outlook.com (2603:10b6:405:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 19:36:38 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::89) by BN6PR17CA0006.outlook.office365.com
 (2603:10b6:404:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:36 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: [FW Promotion] Release 0.0.33
Date: Wed, 16 Sep 2020 15:36:22 -0400
Message-ID: <20200916193635.5169-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f62c93-6f0c-4e18-36ca-08d85a77d42f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1521:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1521B85815D9F54D80E9BB95FB210@BN6PR12MB1521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gDw9lr8oNEEPJ1I5xkTl6gL6ymheaWQ6qFTSApQoJL2s928u2AYettJJxmwqxc+qG3oQuMhbxI9nq/PwNRXlPA8r53gzqu7ebBG+guL4JCVasOkmoqLrnRyANn6EArHhweY1Piez/aFzou8z8vkLPii4Uogp/TTO30Y1y9LKHHfP6lwiRq13ak6gO1tivQNTAwI7l7/EArb+WIr5jBVtKULbUFWYGKjsvMadP4uvtQqEne18LfRi59SZcUuI7rS5iTGeLSPXnqQZANw5cZqIZeh4B6ir/fxUNQRatADye4lFHSlGO0juRf+CdGY5owxPcyspaLUz7OWttBjQRAxv3NENU8+iGMs0NWvYdNA22D6i6C7/rE6xN1dvK/jYKd1xqC2Btin0nHWvTvSa/eTkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(46966005)(86362001)(6666004)(4744005)(2616005)(6916009)(186003)(4326008)(54906003)(26005)(82310400003)(83380400001)(5660300002)(316002)(81166007)(478600001)(356005)(36756003)(70586007)(47076004)(8676002)(336012)(8936002)(426003)(70206006)(82740400003)(44832011)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:37.9967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f62c93-6f0c-4e18-36ca-08d85a77d42f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1521
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a0bd502dc7d7..f20d6df6def1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x82f998da6
+#define DMUB_FW_VERSION_GIT_HASH 0xd0772ca1b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 32
+#define DMUB_FW_VERSION_REVISION 33
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
