Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD43C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62E8206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62E8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB6A897B4;
	Fri, 15 Jan 2021 17:32:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3B9897B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvjrLDavHgBoc+wE7iKknxZdqqyHvT3oanDBNg/ucSikCHU1Td/VnYTKjj5NenKFtYqFPbl3xTBoWlrIOGqPJnTRNr5btMVFgwbJahBHGLK2gZfZk8agdxhjZmgdm+v0d/MpJrvNSz7EIJubLWR5LCJ+O1EAQlhXrTy2NjlvKYtutMjwp/yaAKcLmUzFR5iP7/LrFhCN1KV4eWAkeuUzkUDJZjcYynIBcCChG4AoWjmhW3g1jOuLjhcldTWT2t1OENRhaKsfxaEl2yN7RFhQXAgQ/fq82fj5GocoZQJ6C2RJbjA3/3v+t6TwqtIlwrodJ4OQs/OXMir+Oyb0XYLI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLRu+F/n3TJaHpjYkBnzHhdSqzMBc/ZU/eDJ0NJRinw=;
 b=a4L4FjkC4jd4xJLrpNwxNtc30hfkPfKuTTRg7oSTTg5p/MSK2V460r/OHvVqFWw7/iPurejXZf77JDRnGjAQ4CiJwBprNzke1GNs2KZoD6X/WZnXhF4Es1mm8GH1ENQBfrP/MizpK1xntzYwSfyzeoz1x5ISPiTes6UPprxkolQBjP/H9af8+dKPASIy3Q4MAL+V4g8X8Qr0dfZ8hHBMQGJlF73NRuRllcele433/voJ7PBmRAThQCM/4iyeEmGBZSSB3Cy/P22b9lkpBHkKWw1y/72YbAhe7TmE7FWTdp1aTUs2e74ObewnDtj8s6/dT18kuYV8lvzafQP8TO/r7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLRu+F/n3TJaHpjYkBnzHhdSqzMBc/ZU/eDJ0NJRinw=;
 b=W/9+vMUMfZQdQjbdEwL1s9bhsCz4LEsxitjhIVUM+XD4GSdwutBLaL0/dJkV+F6csNTCK2mjZYU2h9yFhCvt1f5jO1wRiRjZp95VHITSDL2CtHtwoiGQZ6G5Ih0keg3gJjDFz0pOYufcf1AMD1P9DTf+TfUEEcvxuYNKkXk2D3E=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 17:32:06 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::ec) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:32:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:32:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:32:03 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:52 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.119
Date: Fri, 15 Jan 2021 12:27:18 -0500
Message-ID: <20210115172714.126866-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86ed8ec-e0f5-4860-21b9-08d8b97b7993
X-MS-TrafficTypeDiagnostic: CH2PR12MB4328:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4328F341ECA9C1BE7E5CD9B3EBA70@CH2PR12MB4328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9kT/PIyL4grhWqPhzqlA4CZJww50ko4swdN3ZCmpBdw2d4we2KSaFs31P3PO+5irX5dtp1c48s/HTQsibzdunKP3jrBVAAww50YtqCSG+bHS3Gs6NeaOAJlu6Jp9l83Wis22bMxPxyacbodHJ85Xwe3D7S5UHlvhEj0g6LW6vyYudLxz4e+EjTV9PuhYrS1wGN464rsSjybGRW1Lve/G7D3Jo+nFPh7fb5eXWShu1JIH4tOu/xhQmbHeVJk5I6VhI+SjPzpgNyN70XkrV76ce1fDtaKvM6KMl9gkcdoH9iHXp+KE0xpSjdpD6TliDeeyOYCrD2Ukpdw+KciBxSghrZWYxKLEqTZH/ylFBKNCcGnh1dmNtUEyEcYXz5ceOQlWUZ7HjirzAUz/mHqziTXSzOumkLLcChyzUy2GRrwOGwzeHtqUu/6Ax3LsKGQsRoI3+6cM7PqbHAYIl5HXcN90Ua5theKoFhVf8w+DvEA9VYIAOXiOBrznrMRidFSGhVi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(8676002)(4326008)(6666004)(70586007)(70206006)(54906003)(47076005)(6916009)(34020700004)(1076003)(4744005)(26005)(7696005)(81166007)(5660300002)(316002)(336012)(186003)(2616005)(8936002)(82740400003)(478600001)(83380400001)(82310400003)(36756003)(426003)(356005)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:32:04.3487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86ed8ec-e0f5-4860-21b9-08d8b97b7993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f3ba02cc85d2..28e0b6ac1f50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.118"
+#define DC_VER "3.2.119"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
