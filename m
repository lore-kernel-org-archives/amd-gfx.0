Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCBCC63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F421206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s/3IaK/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F421206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FBE6EDE5;
	Fri, 27 Nov 2020 14:11:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A056EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTRdZX0zGtXECVNMsO6UI9UuTMwI8iPGNF5oEm4osTXVwpD/W9Q/gqo+edWLI1t2HyoAIaRhoNrs3RCP6X4IFhdvxYnuAZukV0eIkt+uiOydo5pOYlp+m8BTIdFhOAhOsZs4KkpZ/2bGiS82Wy1qbTnzL4P8umlC9eNKRbIoH1sP2bquTgDGIjH/9nG0e96L9h+LiHnSEAi8A0j4Kb5Wcx+uHGSKULQBkGi/W4vAJaf1WDIsZFx6MJCXnQNcdUXtlfLliAFQ6hfeLnreZY1UazNqGuhyHqjPYufXpFQAssOS8EotyN10aB48CYfT0nh+QH4U2eYQI4iAd1tbusNddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T6UWQyP4yrfLuutk5oqk1OY8idT28+i9sK+BARCHvI=;
 b=DBJxqf8up838IMyis3wHVsld8qTmNjRH6VgeYZNITlRBGQfSBuTj2g5Si5rpJMQif8Je+0lgIV1JPxRCyIsEjOUv8iiiXnl9HyC4tqmfCMHl9z3sr7IsAYU3LOG0A8tVoMCvHdM/QV+wT3yIl6G+a9gtTEifBdLhCGHeZTxRt1WInQoL0x+mKUWvBxhATkHLvANm6yBXFYmt6nmrREMiofbB7pg0IzDRjmYQtJymkA455t/vzDjkV8FRS+EplJDk1ElTi/W0hgdLdSluSGcRz1a3JVYphUeDP8XuVu211BG4X6Omh5V+N4zBMkT47luL5jvHnN7P02Ng78fIH0HmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T6UWQyP4yrfLuutk5oqk1OY8idT28+i9sK+BARCHvI=;
 b=s/3IaK/o7p73dz40VaDPoxJ7OfdnQb6O3QU1yzo4RuUuBdtfshs7NqOfipkwHlGQa+qTv7Dq8PyG5T6x9Fz+VSsz+/+q40HHl6khXxPeRFVC+g27geRYOwg4esesFmIx7q+txJQ7UdpO4LssxG6KzytQL59dxjIEvqYkTHa9Sas=
Received: from MWHPR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:301:14::34) by MN2PR12MB3005.namprd12.prod.outlook.com
 (2603:10b6:208:c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 14:11:22 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::3e) by MWHPR1701CA0024.outlook.office365.com
 (2603:10b6:301:14::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:17 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:17 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:16 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: Check link_active instead of
 lane_settings != unknown
Date: Fri, 27 Nov 2020 09:11:01 -0500
Message-ID: <20201127141107.7731-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa5d842-e8fe-4908-1fb9-08d892de516c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3005:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3005C077FAB4E1B76FE7D0A98BF80@MN2PR12MB3005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd1mxoHrb5pn69hTzscDBM8VDJNE1fPAZOj0furRlNnvZg7groPKOHxMAqpsAqEKi6QiGrrC2QzqpfzR4B61or5wkrnNMMxl2KOjSUcjbCqxyRVj4LEDRIjCtx+6/wh3XpC/xWEKwn70zvwgbG47cnIQWmgfe9goYZIazFvMadY0q8v8V5F2PdZe65GcBF+NW8l74pFgTVs/Xk/kNaPA0eJFVyUefcpVcWXFHIyllk7oEm1WaJ2E3/TU8Y5tNFTt2Qc6u29N/OcSSuAP3yFNIyyqfyDCLj6IagU/W0lmWJhLXHHYM8pYXaztoo+u6BBjVOIKEyIRZn6HRpfdHtSsFxMFjXZiO2QMPPU/vcwXHIxXnCnih7eplOpUzdelYfCSy30xLGe84+VbZVNurGgPUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(4326008)(54906003)(6666004)(6916009)(36756003)(316002)(1076003)(356005)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(426003)(8936002)(186003)(336012)(26005)(8676002)(70586007)(70206006)(81166007)(82310400003)(47076004)(7696005)(83380400001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:21.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa5d842-e8fe-4908-1fb9-08d892de516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
enable_link_dp_mst checks that cur_link_settings != unknown to determine
that the link is already enabled, to skip redundant enablement calls for
multiple streams on the same link. During dc_reinitialize_hardware,
cur_link_settings on previously-active links is not cleared, which blocks
MST links from being re-enabled after a reinitialization.

[How]
 - check for link_status->link_active instead, as it's the real intent
 - clear cur_link_settings when we clear link_active

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c               | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4a897c326aab..a9c52657eb4b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1738,7 +1738,7 @@ static enum dc_status enable_link_dp_mst(
 	/* sink signal type after MST branch is MST. Multiple MST sinks
 	 * share one link. Link DP PHY is enable or training only once.
 	 */
-	if (link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN)
+	if (link->link_status.link_active)
 		return DC_OK;
 
 	/* clear payload table */
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 90c85b3e859b..4c230f1de9a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1530,6 +1530,8 @@ static void power_down_encoders(struct dc *dc)
 				dc->links[i]->link_enc, signal);
 
 		dc->links[i]->link_status.link_active = false;
+		memset(&dc->links[i]->cur_link_settings, 0,
+				sizeof(dc->links[i]->cur_link_settings));
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
