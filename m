Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBEC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991BB206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JLvtnBqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991BB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563C089E26;
	Sun,  4 Oct 2020 17:20:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E4789E26
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSHBbDFAR51nTvLpT4ZyiKf3uYjQkV5QzTxgpJ3JU4f27GFoBlbJz9kAMCHNwQJxGDh589JDrnaqEjtYebGy21uBGQpW9JIM/Et1qvahxMoTRDEQEwvs+k/MSnQkHQfjICk77xcXgOBFp1iqUXVLaKjPHS2jBr/eVMFQcVNOPa0cWuySJBIgCX3RIfuclWZPA4/Ls8DE1bJcJHCZrEnnnLaVxZHP47uQEIvN4bTpC/1etK/ZZh99eXRyt0vt3Ykqxqr1x3+CXU2zgVk6GUHqLkskLNOP7QDSnGcxiofqMCFKnDnT0SerrtHKrsdX3c8mijdlQRHhIklb8+RJj6lvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26gd4RNdMGUPlK3eRtZ7n1pgWFftPvddOlqrMQModEQ=;
 b=JIBXfG3FY1d2o2tbfGq8kqv5aGGsDP8cF8AnCdVVfZUFPR4e/JbnGgj7NYp9l+0QHOw8YWfgzFyj25sr5NIC4toucTIz5ZNisDOKSsUmlGpNeqEuqE4sPUjWlLb9nMFhZ3XzW3cvHow1UzMt6h8Cr7J/jM5/uH3Zd2XpOqkMjWor/AscTPhlutXSM1+8/x6Gd4zdQM45MFSBx1pZmKotEA2bIquwym/IYjizBgO3RrIg7Sm/a/gRbXodK1qSz1pgMeznYAUKbUiUNH9He7kXIjnhWI1dM/+v09WBik+QTDBJtP2VD2hxR6rjhGYt5wyOj1SmemG/Z6l7PhggANMFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26gd4RNdMGUPlK3eRtZ7n1pgWFftPvddOlqrMQModEQ=;
 b=JLvtnBqx5a/VczIDLlApczGkVceSDmU6jfztlWP11ZkLIfhSazijdky8nk3hlhWhEI8/Q2X9/PgQ5liRo3g0xfT/Ht7NbYFjMFY1dBM8IrKtrmhem5ltM7amxrCPccyQPaal8rxC+2sOsLdbCES5QprnX3q2wWR9s55wqg3/vvw=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by MN2PR12MB3488.namprd12.prod.outlook.com (2603:10b6:208:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Sun, 4 Oct
 2020 17:20:35 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::37) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:33 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:33 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:20:22 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/18] drm/amd/display: 3.2.106
Date: Sun, 4 Oct 2020 13:18:12 -0400
Message-ID: <20201004171813.7819-18-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8048be2-914b-4212-bcb3-08d86889ce03
X-MS-TrafficTypeDiagnostic: MN2PR12MB3488:
X-Microsoft-Antispam-PRVS: <MN2PR12MB348883F6201465ADD1A6C019E50F0@MN2PR12MB3488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoU4Ejl8gMkPC3CqWi2X/eVQElBF8nHI6JQnnf7h9EHEfRMBEBdv3JbZZnQoQD03whZSO+8JU9TeiaLJWaQ5JQ0rpM5qmX76qIY3PcFKhx7TG9+HoRqXI3Yw1xBov23LgYgxBKZjM7Nm/RVlmBi9qS+ynVRSV9s2hnTIBkQGK0KCFR36iuJGrhDpuSvgxRWr9/uwBG4Z8jRR/cgsV+0SLtdQqR32PlxsuZyTzrjm5Zdg1Wt0fkCV/BrSewHh7NCGSKUcZ8SDwB8duGNC7uN8orrGRZRZduWXt5a6z5If6iOOMWNOt9cDIeccdzXdLzx7WroGST3+obQSWaG9WqPOcpJIk8yW2qsLjy0hQPVqUC6zhTX/BVGpvHQiKQK49jaXKT1gHWfqQL9YSLL6b6wEsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966005)(4326008)(2616005)(426003)(478600001)(44832011)(8936002)(336012)(36756003)(86362001)(5660300002)(82740400003)(1076003)(47076004)(26005)(186003)(8676002)(4744005)(82310400003)(70586007)(316002)(54906003)(70206006)(2906002)(6666004)(83380400001)(81166007)(356005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:34.7355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8048be2-914b-4212-bcb3-08d86889ce03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d2d2032a40e1..203dab40a2ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.105"
+#define DC_VER "3.2.106"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
