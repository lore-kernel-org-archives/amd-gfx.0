Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA31DC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 17:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92371610CB
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 17:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92371610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EFE6EB7C;
	Thu,  8 Apr 2021 17:11:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37106EB7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 17:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL/SGlPg2DHsYgoBg3duUBVj820zEN45aQLzBMhFNR424ExKn2DALIa8l2GVrOFEfoQI0LOv6b2To5OGZGMtLc5qWQRZ8cDZVIMzmW/tmOKRXl0p7qYajiZR6ZXegYQinJjNScCdMM5vmPgkVP9GmHQFQzG6dqAKGdZpC9OOZXNO0f1s5IbqdIw3M+2flwGR2sjdJ0H6srcrJU58ITw0++uJW1LrjEQD6tQKtowx18P4oPzTk087AO5ZI4b08IyNbQYB1zxOCwahtXGBX/bnOrkT/nwWFtJe5hvEemuL31XCVaEppjiihQBx6RuQvCAwiWzLQV/HKfrdbonN88PLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5e3kj5TiZV7GfBNBGgsDz0h0pY4k1nnlDtuO88Lf2g=;
 b=IWJNEnVA3/aK8G6gMHw5kkQid+JPUNfe7DKT7nNRE/Ls4Turh3SA4W+xK6TZU7lMI8NJD+LsxNUOoJUBDhw3bWgA5rVv7uCe91ShE1KSs0azek0QBQMv0U+ztNqBTY9gqckgqCo7e/73moU4kKe4xC9Pd3b5VRDL07cp4OmeRwhf51XYx8E5Zk691dz4WQLth+d3v9SotNDVx8j8QpGt0DMQ3dHH/x8/Dkkq/HQ1l4MH4eGuaZbyCrQtMqHfBsVuOOAFPHYeISDVnM8yRXDch4cqF4xoBHvs2mk2rECOle6nQe4gaJkGAgYD22+qz50CszSrGK0KqIws6XzMBYigWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5e3kj5TiZV7GfBNBGgsDz0h0pY4k1nnlDtuO88Lf2g=;
 b=2IIR7RzGpti9cdNVKfjIa20emMi16AB26FD6yIn5mC1qXd3fFJG1YgY7YN4BYtU6h4Rg9YOpsbofapxynhTZek7ujsVhD1rkVeHGbM8wa6whAbcvx+EBsNc2VVDrMCbPCroMQNp7iz42Q33p5i7VMJsOlG0C7ADu5FdsPOmyYw0=
Received: from BN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:ee::25)
 by BN6PR12MB1604.namprd12.prod.outlook.com (2603:10b6:405:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 17:11:12 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::75) by BN0PR04CA0020.outlook.office365.com
 (2603:10b6:408:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 17:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 17:11:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 12:10:48 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via
 Frontend Transport; Thu, 8 Apr 2021 12:10:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Update DCN302 SR Exit Latency
Date: Thu, 8 Apr 2021 13:10:48 -0400
Message-ID: <20210408171048.44591-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53bc23f0-5b57-4fb7-006d-08d8fab14f7e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1604:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1604B4201EB5F6AC6C9DD57D8B749@BN6PR12MB1604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: selyVHMkAyilm4AIyulZftioqdNlKFBvylD+NAbQVesGpv1UaLd1qYc+/HGsGxwTkNM/k8NXgRPYeLTbwZhPHvIq84U87ImgG7YsYlMFhE1CAMV47YUCOi3/BHuIwqp05vSI8gY77vlV04V/OuPeMdAzWcyzC0EJ+CKwEIHjbsWZIEN22K1PXSVE0klYSEz/p6j8NW/exTu4ZIuWbrlSkkAGEMJYUmDb2BiNpCzUAPdT3/mhDUlKB4TmVHQuljxbzi1KSBV4BXbLoIdP5wywaO0EObVr8GI2RY7LdUaGrEMjrMtFCMcppO05Ow/45Ln+pf6pMuaekS0rNNLTpjuQ1mK2zHOesa6dOqrwgK+JclkUu5RA0yUCkUPf7ELJPYY9U5orP4Lqn2D4Crc18hFkmy3nhcy1jR2SHS6N67JfocYhkBFObve8wmVRuO+cJP4LzCGf2eeaWbMqPKL9Jk01E1kn2ye3tqsikKMN9PHalMYfkN+Y/ZghdIXE0h3J4jAdF4eLg0jAgbHyhHPxW/vOCh3Eslv+CXvB1W43H0/FhnMh66CBJNoACjucNZ8TOOAS+hygQqp/sSUiPG0GeFx05H7wyTJr8A3bhZr1wBnejlybaDWIVikAieJK14nGLmqeDztqjci4PdbeIs5+2PxjBPDc7XYp4ywtBilqboxAsAULFtvpLqM5fcuuEcYlToRw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(426003)(2616005)(44832011)(4326008)(82310400003)(54906003)(47076005)(83380400001)(356005)(2906002)(336012)(36860700001)(26005)(478600001)(7696005)(1076003)(15650500001)(186003)(81166007)(6916009)(36756003)(8936002)(82740400003)(8676002)(316002)(70206006)(70586007)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:11:12.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bc23f0-5b57-4fb7-006d-08d8fab14f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1604
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
Cc: aurabindo.pillai@amd.com, Bindu.R@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why&How]
Update SR Exit Latency to fix screen flickering caused due to OTG
underflow. This is the recommended value given by the hardware IP team.

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index a928c1d9a557..fc2dea243d1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -164,7 +164,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 12,
+		.sr_exit_time_us = 15.5,
 		.sr_enter_plus_exit_time_us = 20,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
