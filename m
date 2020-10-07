Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D8C4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F4420789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nV6IzJRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F4420789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF40E6E8E1;
	Wed,  7 Oct 2020 12:42:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2A66E8E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi618JntbsQA7x/Blq0Z4MpmczD/4/ncYD38bsbZ6psm2wB/N01oIpaZMBSYi5lKyGxE7UCVACSmade0nM2vKAMtWIhf2eYPZW6zZXJOH6gH+chCW/nhLAWg6g3lzX8z3gGoChwBzruxOaLeAxCJA8Kc9grkVjQw3PJVCFgSQQNTRnpdNB/Vu7On7DQfxzYwDctwNRL3wH3cTNcvxgOP5fEXibMreoFzf8NvxPWz5SDbCEje7ZpLC9gelrJ+CZ/TjJXATSyXGQbCkvVvO+Jm/4eEq55trKjP5kPjCk1vOpjz6QW3xxvCUvx5Mpjgeez2bYvOMWmD9EMZ2fqlK+xpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxh10yC9m2T87pVHEKT6AW0A3Z5QfxI78uc1U020ZJE=;
 b=kOA2vMGGUpvtbZiTHzbVNiUQDDE0bVcROh3NQeZdH9LafIIPSs4mAEg+vKhCm54a8VVc/7nfCZ1K5BhsfwBcE1tjRLI9iMCq61tE1rPDr2Rvl3z+fh0ICLpKQvPdtrI6TGAwuN8Ka+419qMUtzF+3ohr5SCwi8lB/R3rddqfKwnFGL69jMLzMyi4MxnBH5bQG18D8F8aEkaluUmA0wWQrd/9Y14p8EzuMtlk2Fog7k5hK4SHJcaIUfKm40fyhvwEAWKBjwLd0cMBPygCU+egFA5xwZ5X62mfWsZIk2G2mm2UNvSEz9uZctkumA+WoANK+lXO3ArqNZjdWqNliPBIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxh10yC9m2T87pVHEKT6AW0A3Z5QfxI78uc1U020ZJE=;
 b=nV6IzJRowWOuKPHh4q3fSHgodfRUszXBboOY2FbewkoTHQzSh9YGPLdgT8ibV9FTAKOxzt7AoCqqFfDHVdhfd9N+t70s2DHwIUXtS8uAV2QMJln9cXw5g7MgIrP+zgxSXUOPYKcI1oSBp3cCgHV5GB0Uxp/u+N4WhLtqbl3Qbow=
Received: from DM5PR15CA0060.namprd15.prod.outlook.com (2603:10b6:3:ae::22) by
 MWHPR12MB1550.namprd12.prod.outlook.com (2603:10b6:301:8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36; Wed, 7 Oct 2020 12:42:41 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::38) by DM5PR15CA0060.outlook.office365.com
 (2603:10b6:3:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:40 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:39 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.107
Date: Wed, 7 Oct 2020 08:42:24 -0400
Message-ID: <20201007124224.18789-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2183aa42-cf33-4a8a-6d1e-08d86abe7abd
X-MS-TrafficTypeDiagnostic: MWHPR12MB1550:
X-Microsoft-Antispam-PRVS: <MWHPR12MB155080CF3C9A3923F922F4A98B0A0@MWHPR12MB1550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuDehPsYvnPZJ2/aMO6nTsjbq8KPBxbA12m4IRRynkbC17VKL5mhAxYb72ZnCh+AK/cGYxd+V/Lw/kQXxfi68RTsDJSpywP5qURtQedS6BK+O3CMs411MbsJKGinr/AjsM3BYMCa33V3ZUyeZ/MKGG2MalsmIIH9HTONePlO8EMmAipgWQs/cnIPf/+KM/OgbWvEoyDCl7rrDkbff4CeYciK5KBBsXPJmj1bQpr40qdOGI5fK/i6YSqqN7EyAQ7rHdRhTHZWGW5+mQEUxeCBoWa9VQNPLeT7yks1jXcLnsYO35DSYJTEIeUt/kUxglTq0sy19rG2VEv74Sn8sYeznTH4d/gMkJtpqPMBcf9R+Kzsw1dx9samAxFmuieeB1nC5vakAE1HbRnSoe+bULzJNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(47076004)(1076003)(2906002)(86362001)(81166007)(478600001)(83380400001)(44832011)(5660300002)(2616005)(356005)(82740400003)(8936002)(36756003)(54906003)(26005)(316002)(7696005)(336012)(186003)(426003)(4744005)(4326008)(70206006)(70586007)(82310400003)(6916009)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:40.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2183aa42-cf33-4a8a-6d1e-08d86abe7abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1550
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dca2b4998b3a..06ec07d692d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.106"
+#define DC_VER "3.2.107"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
