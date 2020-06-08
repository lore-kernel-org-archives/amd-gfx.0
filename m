Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A82C433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CE220801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cXPBNTW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE220801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1876E47E;
	Mon,  8 Jun 2020 04:59:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6762D6E46B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKnnEj016M9XbXhUed2K6MUEDjOroWK2SSGDw1kmz837q7ckmrCFIKErahSCuaL4j3JoXGO6jy4EHjMOkW6x3IhQA+e6+6XARQPQ/SBTnQ8KZEJhkx0whWGOe0dfREp/eRL28IVQJVkW+Jpk1hC04JJc0ddWByt98DeiE2tGg8DK0X1ScSdgr8r9f3oEsJjvos27o2ugXQYyzmpJs7j4M0Z4m7t1U1jikgQJDlKkPj1UE5mjjblpC5IQtbSlH6hc78z+OybWf63fOE6pMZr6EwoVvcAVeVf9PWm78sNJfBG0JA0dVRs+D+wN9oBtFEOMHbqPCTWlJCqGznaUixIVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Nwu+NYzw4dHqr4OnC5eQSfW1/B0VixZHSQmG/zc8s=;
 b=KfjU2sHubZqWmLzYihF56FEZHlmnbAlf6/pfiRnPGm+c2QnQ5jfAw99mOVczZVCT4z0ZuDqaRxLhv19/hQxA+yNOjfwQ+sr3r5TgHAorWyiorW2fMEC8/bBIffteSJ5TBGOx8GwUsGCIiyhxBHUpOhk8teg6nf0xqo8M4egxEKmU11tkZd7ameBer8yjDqVfge2J+Zd6shBkkD69Rgw2TXVC5QIl5JNjKZJ3HPIgq5kBZ9RAOS+8fuKChSnwAXMGJa3J+FVL3yoiZnCVFF74JpcqkGQeCCJkE/EzmAYFDpQX/n53yWrnsL/97XZ8QKh0ixNNPt9JUxFXRTbwCrL/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Nwu+NYzw4dHqr4OnC5eQSfW1/B0VixZHSQmG/zc8s=;
 b=cXPBNTW+ez1P16YL59529g5pF2tMhrZjjjP8j9zR7Zgc9bVBt2z2xB5/5W++DJ5KjKDxdFbjyJnYKL3E0rJSBiiCgTvvNwEB5g0++JFugA82ldYFdXjGB/b3/gvxQy4cW+Gwb+5cZDtyCCYyZ6nyeZ4TFCarsBwzmKtomNSUa6w=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by DM6PR12MB3530.namprd12.prod.outlook.com (2603:10b6:5:18a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:32 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::e8) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:30 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/28] drm/amd/display: [FW Promotion] Release 1.0.13
Date: Mon, 8 Jun 2020 00:59:02 -0400
Message-ID: <20200608045926.17197-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(83380400001)(186003)(86362001)(5660300002)(4326008)(6916009)(426003)(47076004)(82740400003)(336012)(81166007)(26005)(356005)(36756003)(6666004)(1076003)(8676002)(54906003)(70206006)(2906002)(44832011)(2616005)(316002)(8936002)(82310400002)(70586007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89dc3441-6375-4aad-d751-08d80b68bb31
X-MS-TrafficTypeDiagnostic: DM6PR12MB3530:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3530223EC0F2DF05B668BA54FB850@DM6PR12MB3530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q3+H/nlX9xAwehGObnQa48W43wh4/DER4I3h2v4N1CIozHcIq2fg1X0Cm3xB/jCALP+0lhuqj4fmeRI8vTrWx4LSzUk2qfUPtZ4c6/FLrG/8sg28+3hKHnhDJUoJch2mKE7PNuzgG1utDECB6BrI0ifeEP2Bm6G8c5tHkfxf+d7xKU/OyPg14D08hPED7P6WEfrD2s+mXvE3jyqaF+22nC0zbJRs/1/mTDouJ5TvJPMrgORtw1ayk+FNvW6XzEQUyugGmAc5xS5T0Yu37z31lufAWg3lxdSjTtX0aUtqKAFbRQUa0flWcRoFoO7fHCLASshIwjtw+HHgVCVOmJun+C2YFV/9GnGgAe2baNb+dyLvN5huJBhXX18axBMBqI3ydAn+QTwHJTOjzcbuBOOzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:31.6436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc3441-6375-4aad-d751-08d80b68bb31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3530
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
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
       - Version bump to 1.0.13

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 15ff4e471c3d..d04d2fc9ea61 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x718f63a96
+#define DMUB_FW_VERSION_GIT_HASH 0x3353119e1
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 12
+#define DMUB_FW_VERSION_REVISION 13
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
