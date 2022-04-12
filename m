Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C53C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 18:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE6910E059;
	Tue, 12 Apr 2022 18:44:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610F710E059
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 18:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0N7rc4cGQ2F+bmXdxll4ijPOWL5MJgoQYa7I+wnkLInvtNquYdeGPKilRU1ZCDi1OPZygKvkgoVWoA/Slq2vPxRo+o9SF9kohZVZBPkSiGZOWI/Q4/j70PSyZBm4EciYVgqzuiGqm1p3ClNsBclg7zmeIT3H8OoGiakEkALzGNW5zxDGyEJ0VVsLpukRKcJuxnDA9zLFFWwO6Zj+XtK05UVVXM8ht/fpX/X6wFKm8jTP/2dGjcVvvcVYQLzhoMmlAQD/lks3+NERlWeVezutQG0p36aPSAJm7xN0jp/0e/DSybShsc4ygUjgft6iklpVmf+8rRcf5P2HVSnqlXVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfq5SwBIEAgzeTvws5gM/Jjt00UKGahF43k0C2GiPEQ=;
 b=WbvRgA1CmJmHmbUqF5yhyFucuy6OrJN5qOzPsuOxyj62TquI7sqpNj+wwZrefUYz+c47BLkxN67seFJYDmJYph0LXZJFYWCgEl+w7Rm+iE+Xo/V9mvFEtW7KV7pBjulnsHjzPQvlWM73dGuVCSVuX2Dk96/UzLgYsb4NfukDUJHr0qzkUPWeFaBy4ZMvuLzYWmY31QXiDEMCo/46t9M7NXaj8LjA5SqQjkUFHt9Rc+Yyq9JKrHFoh7qhseg7MjJLGAo6T8HRqNE+VuJgVkYZp5n0MWuK7u44mxd2Bx4SMb+lG7qn8zPFb50m7qll7V8kKTe8L7ZMDnhFB3ddy0QGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfq5SwBIEAgzeTvws5gM/Jjt00UKGahF43k0C2GiPEQ=;
 b=hb1iCD4NQGueq4/O0BichIA4pxrT5mKZ8CnRvCt5qszBH+KQhbjyqGB/oeNyKyzmTTC4CRUtx2Jnt1x9JTs3hPgctD1eVxsXfZWHmOSz0Tr/Iax3JtX7TRB4sgOPVGHiOiqyJ1fnEp0GF2eAofzEgTSlqjHLAVuQG3yoLxR2KQw=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 18:44:39 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c0) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 18:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 18:44:38 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 13:44:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: Pass HostVM enable flag into DCN3.1
 DML"
Date: Tue, 12 Apr 2022 14:44:21 -0400
Message-ID: <20220412184421.573344-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ad5b13d-080e-4c83-bbd8-08da1cb47f95
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4797BB0BEA69C95C5B5952C598ED9@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6+mbPTMw4AZjCLz2B0UCpwsST/YDl9UlbTRXp8FXxFqf9ywPm3Yd6z8QFv8fnN3vkd3fONgrpuTUh4RtTnLAj8jcAGaNq2sfj6Y2M/DFfq1ba45OOoNb12PFciQ0aWVzh0OLQrL4/aQPuGRv5kqBs5phZyNQIUIEvcrQs6YvQ/f/lgcDit5swS0C7wV4P0041oxYLBCd7eT5o6/ZWDWEduwAvjegigVHbuBmnjq+VoH58siOXRKurpbeUW2GXB+Lc2zBJWWi+BZHGjylPLl4k8oRRVxJHNJTpa7LON7aYh2dTUVZ7myJerbktuvHXZNY6l+Pk5ZYvjRt1sgIW7RzX6PsMqvUxrzxelyX/zm2yr5ZH/VUub7xHjo6HiJxX9jXFkvhSrEJmymNBEqKSk18W69rrm5XpjNU75DfILRBj/CbVtgh/c2Rk2gVbCQRVrY5sOWzZr3/J6NdHkueTp6e4QyyOqy7qnETi2pUv+FKyyPzGdgN2YmV0mP9DkbJ75GDeGGI9I1q6YCaMgrcbOlq/6ySMxBGZ+WPocczsVhU+CJZ4fU+Gn3M5scVlVlcma3X0KfJ64Bml5FZubScMAcsAJuIYgrNkgB2ABptGjK9ldmcv7YJLgp/0EfSAORMUwp2z7kn7M4BCO/s1LkgO+zuC9XpDQ1dlEjCT5UVBO1Dmrz4IoQPkgKIu0Y3yp20V/9uHhl2O5pFKjMvE8/5YRiVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(426003)(16526019)(40460700003)(316002)(2616005)(1076003)(70206006)(4326008)(82310400005)(508600001)(36756003)(36860700001)(6916009)(54906003)(47076005)(186003)(86362001)(8936002)(70586007)(26005)(8676002)(83380400001)(6666004)(7696005)(81166007)(5660300002)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 18:44:38.5775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad5b13d-080e-4c83-bbd8-08da1cb47f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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
Cc: Michael Strauss <michael.strauss@amd.com>,
 Mark Broadworth <Mark.Broadworth@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 367b3e934f578f6c0d5d8ca5987dc6ac4cd6831d.

While we were testing DCN3.1 with a hub, we noticed that only one of 2
connected displays lights up when using some specific display
resolution. After bisecting this issue, we figured out the commit
mentioned above introduced this issue. We are investigating why this
patch introduced this regression, but we need to revert it for now.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mark Broadworth <Mark.Broadworth@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6cc580be7c79..5b3f0c2dfb55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1668,7 +1668,6 @@ int dcn31_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
-- 
2.25.1

