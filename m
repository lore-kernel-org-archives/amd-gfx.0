Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161EC636C8
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35DE61182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35DE61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD8689FAC;
	Sun, 18 Jul 2021 14:06:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCDD289E15
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egjFCf5pvVCOEcxgSzJNiCQ6zMrb661LmvjgdQLqVKNqkscCE+mCD8IZ1gIMXpZ6tQ4O06/ftACS8jJemTzF9Fq2Ip9MSdzx1vwGYHI7+cA5NBpJ/RxBfsriO4K+bmv3bTAoKztPKmIYAqg3LuGVMV2i0KFgM5OfBesZO5XVDd3Z2iuJKb0r4uj1uzdOEw1vei3+mMkZnwe9v1RebcOt0s6r+tRU+CYEhzouhOgBsjywO7WdHSccVnXNmsNEb7VA/DejyY3bKXlG+uyYUDfJXjWssb0d2AN657FHBCc2zzL1y3b6DAqStQq0X4GsK6SXHa+1KAcMOPn/EAwmjrhCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5PCPJDsl9GbcPZcIpucSpvROHhlDLf0hC4HIRuc408=;
 b=aekbku2d4gBA1gBaIiCQgtzzVkvAVoa0CE2yKydhbu3CNeQxDDM94D7esbLcjMF2Hef3Qwyt0WUGDSjAypffCB6ryGudlLkHKSMdA13DWREpAI0IRQgaUGWyyDnSlRSoggryECXBR1t6FOauSZnZFEMN+Wezbj9V59lYRMM2okeASGuUOsILCYZ4TgJIo8YqCdNQBsWuyobJPLs4uOGx4qNBWx/xH5oHO7m3iX7gffEWtm3eO8PobH7iOnu4yBU2n+lVeu0TwEbkyYNbtyzW5rX8cB+HTHh/R756sCLNeGzb3OalprUZa48EZs4s8VzAB9VfhvWXUJkgR3xinldYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5PCPJDsl9GbcPZcIpucSpvROHhlDLf0hC4HIRuc408=;
 b=mWv/07GK16Y2fM3hwx+XHH/AH/dZK1hFNFg5M+wNh0+lD6Yug3liZJ4jxSaEAjblJyu+pfS+C9a8enkR2uGflA8BOPWaDvp1fmMBoTcbqu6Ldt9yPYl2WOXsbSU44r4nbjXoXN6fA9HeYfkrCJa4A61Gv87guCY0y4KU+VR846s=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:32 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::79) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/32] drm/amd/display: 3.2.143
Date: Sun, 18 Jul 2021 10:05:48 -0400
Message-ID: <20210718140610.1584616-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be17ccea-1024-44a6-6aac-08d949f53e9d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364E908481DEE70E1AC439198E09@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYfH1zk7KpOavJwEayY9B3RS9ZYPVZbqFPSx6MWRUAgKILTmJ/K/My+kTj5ag+Vp/D5RXZkdaYiXU5/W9oXnaQFZiVY0jFEc1wgRjikz/a8Y4OzIC2Y9WP5ywh6dbhOifjK8E3pzXxOZFu+oOn31/3URG6ikWDYw2jgUWpu2Uyv1kVmOPqeG+dcbC8Xi/xv6C4xc9CTvlHNbzjDyuJ4DCDTFNPZcZBBvqiJ7WE2PAUF2BlTcaCqj96sRcc0CUONGx1ToTEE3ltRruUXy0Sh9jI4i72v9Il+fd1oteg5pDnrSWYCP5rfdza6NZo0Ocj30NwSlTjf9n+ut80hhBxRVAByUMjzHCJcc/IgGQ44ZH7uhkqUgQMRc4DmK3rR2yJsAQ4kwVy05Nzvnfh5lsX7NbpZSETnJOr0qNmM1/kmum/aX0gJye21tBgwjBia19rcQ9JV15xhKXFOepXV9XITro9AzMCf3aAhnt8tF1aVdRECVdvi8EqSYSfNCUKujwLUPTtlBCgGVmVcGlULg+fJWmXlu+2F3u+IIqpssvRgbmFEvFA0XqEEQcdOVybVZXw1EORTSr8vRRXiaRk3obKp9ae7084e5wATrJPtRDta1ZrXgCMEtm7DWGHUSXu1pFJrSWS1A0FE4CnTWtToVnNF0yr69vGgOGUwXX3Tl9TLXsQ8nfnaB8xE/515mZgzArY4/O2wx8t8nvdS2A3/NJVMz2Rxi0M6dSi/W5TpdJD0/VdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(36840700001)(36860700001)(2906002)(54906003)(1076003)(26005)(86362001)(186003)(6666004)(70206006)(478600001)(426003)(336012)(47076005)(70586007)(81166007)(16526019)(4744005)(4326008)(8676002)(316002)(36756003)(82310400003)(82740400003)(83380400001)(8936002)(356005)(6916009)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:31.4215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be17ccea-1024-44a6-6aac-08d949f53e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b62d21131af2..282bd950ac91 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.142"
+#define DC_VER "3.2.143"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
