Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFD1C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 04:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367EF2072E
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 04:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rHMXIO2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367EF2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41406E408;
	Tue, 21 Jul 2020 04:35:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D748589B05
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 04:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B10yviKuA2nJDl1NLO3uMnWeeRLR7abvCmvXkFbIQ1nO3oM5DBWw3+YD51pRglbwIGth+i++Y2GFRGn6PC2tXpLBwr/Y8P9LFzcUpj0hOoIqTSvTL3zaCcQU9G98nG9E1YknbTFLNJDCK3QmVrlXvMDZszVEIo+DiMhYTJ9G0IR8KAKxe2iCRpa+pUjNtSqZMG/G1oSOqTaBtvi4hpW7QMHWzJs7RU5UTg0Y1eeIokXX2mKNf4pkJk+BgomsAXvIGTleWBwJ6motgRMsYLgCWxR1xtpkpT2N8Fr4dUafdrDr8Y6RBsjsX7R8OVVwLSanDtSXigwAu6gPfDqqoBbc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv927JSB1Zjml9TQOceSStxcYQ/2WNye9o1WypENbE8=;
 b=J41NpQ7iMMctG+idJ2EE0aH+hNwsmJgc1010jP9f8wtC+y9t/QSZYHlYMnQ2KkfH5pE3+/DClr8Otkc16oK2ZGDSlW+lwnG57iGIQ+oSs+FVp7oan0NYitVbCK4NvinJBenFobh4WaSFf11Kq1umDYQXjbvAzjsjbeDVw5nlJfTimB2bka7URlt79mAqJ9tqpOrzDekYQcAohLQnQHQuOLoNTk46IEnASow/c5aK7xwNJXATSbRGV7gKmv7tlqKaBaMHGtXd49yTRkeRZky7cVLkpcj3XRWYcG+FGg0yRnIZ15Mgsp1pUyZ6d89SKAmizMfbLoaEsZHeL71tPb4hGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv927JSB1Zjml9TQOceSStxcYQ/2WNye9o1WypENbE8=;
 b=rHMXIO2JYLU5mwNqO9GRDNOEdbj2hpVfXU55X1JJkACOPEg4Sds+7C5/mhGIj223zuaxyZT59ecoQk8V6RbJLJDONREFGvaZLDxQd71bnJoeQ68n8MuclEfoGu6FVqudyW2bR5lp58X/5MtpTIWmwDuLk7c3uXMwqLUUX+rfQoc=
Received: from DM5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:3:d4::34) by
 DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Tue, 21 Jul 2020 04:35:45 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::50) by DM5PR05CA0024.outlook.office365.com
 (2603:10b6:3:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend
 Transport; Tue, 21 Jul 2020 04:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 04:35:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jul
 2020 23:35:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jul
 2020 23:35:44 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jul 2020 23:35:43 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: fix typos for clk map
Date: Tue, 21 Jul 2020 12:35:33 +0800
Message-ID: <20200721043533.2227-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(83380400001)(186003)(1076003)(70586007)(26005)(70206006)(82310400002)(356005)(7696005)(36756003)(6916009)(478600001)(8936002)(4326008)(2906002)(5660300002)(8676002)(6666004)(47076004)(81166007)(82740400003)(336012)(2616005)(316002)(4744005)(86362001)(54906003)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a19ca74c-1bc3-40be-9064-08d82d2f88d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4106:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4106390D8F7F9044D8FE7CC4EA780@DM6PR12MB4106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9cA0F020eEa9wPwaBTt+l5/j69T8UVETTppuAuPzYG06PJL3n7ESIjCAnPMC8o3r9IeYXkgQuDn5z87bDHiQBYQ4/epVSs4d7rLupdZaUPw8ZmqU241u63x53q4S+YQr3bxYLouHbjyA1z6jb2yXOJX3rNMwLLO6bk4OB9kvMWoI8Ee7ua3yZAbQnqLvvA/l3+gBwhN7AUuS1qeQ+SSEnFqRGAC37oS9EbVnBqT0rp6Ex3fYMTB3xRgVEb1vGwwd2hGaHrH0G1ei4qbjkCzV/fhf5S2Voq+KvqIBdZ14nb+ydjvr93gZbGEysAoNrJ2PmzDgyQHkrXTYo/fTqv/WDM2Pi2ZGC+F5as3Roc4kRJzehMyBTuNuJE1tBguMvhO2eaFfxp09rfSVZ+WDLnQ9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 04:35:45.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19ca74c-1bc3-40be-9064-08d82d2f88d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Likun.Gao@amd.com, Tao.Zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should be DCLK1->PPCLK_DCLK_1 and VCLK->PPCLK_VCLK_0.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ib2239b35840d3774a0e1aa3114d2f965e6d88e7c
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cae8e776fafe..87eedd7c28ec 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -128,8 +128,8 @@ static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(UCLK,		PPCLK_UCLK),
 	CLK_MAP(MCLK,		PPCLK_UCLK),
 	CLK_MAP(DCLK,		PPCLK_DCLK_0),
-	CLK_MAP(DCLK1,		PPCLK_DCLK_0),
-	CLK_MAP(VCLK,		PPCLK_VCLK_1),
+	CLK_MAP(DCLK1,		PPCLK_DCLK_1),
+	CLK_MAP(VCLK,		PPCLK_VCLK_0),
 	CLK_MAP(VCLK1,		PPCLK_VCLK_1),
 	CLK_MAP(DCEFCLK,	PPCLK_DCEFCLK),
 	CLK_MAP(DISPCLK,	PPCLK_DISPCLK),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
