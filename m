Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25973CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411BD10E41A;
	Wed, 18 Oct 2023 17:42:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017C110E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJs3xVA0TiK2PPSb9hPTrWcVvHIRGhU0Jy1CBv9gGMwYAmd8B46/1XBrsq/9/KcJphuq3eX4nL1pae9liLDQhx3p28ZdsMxnwM++ECMGGQ/BNnFMP3Wt9ohI5zvWO8nNORwiVCZ1WjcHNqLox2M+QUiNBFeDjkM4ZDdxN8UvKmMAY8GMArZaa1+34Vsd7F+WXgy4GqdXC0O7VTlQgvMHb+G0EO2h5BgLSrs6HW/cqwVNaWXMXH4ueRUPajrzhtXzYPokPnMnmmHXy28oXm2pMMCfN5qHP3wsk5dgJu58NAXEPOVzeq1E5LnoEzdlxUZcD0FRpkRY5ZAQA3i6xNF1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuP4cbgB9a9jFlzD9Gc6NDHiOJ3L8r4zNQBd/+owgAg=;
 b=eNNKQsbnTNFTg82N5jbKqzQEaFtHCGoVUbb0nznKfsKVU/YBmXBj0t6lhwLWtRrsUTyE/IT+MxAu1s8lYdYEBQislG3sg8lqZvyjpFfA2R4EcZcSC1fARfEiOW1pWbG0/JlLrcKJVvXK1txSbnOYtIDsWuJxKqqiChnhVZLTSiuj//2yz+hBX/r/vqgHQI0S/TGte7mDxHQ4UEMEZSm4KNhhk3Rdl/vEd1/EsrHY666usLFiB/908EPscUtHlJYZWB/j/BAND1M7BGUb+fTSCEl2taSAj0mTTx2aDSJghy3DfADTmUjlC1Tsea1SaXxGhftYuuczCFc0B9Lc4nVD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuP4cbgB9a9jFlzD9Gc6NDHiOJ3L8r4zNQBd/+owgAg=;
 b=nMKkaO1rvWeNvrKY97qCR5dV2umO4J7iwDYgvS3WdYkcERZ7R0bLb6Xr5L4M3nZxCAkEtUW02TUz/LzdJKpTi4SofCFtay7CJ+PTveK7FnuKF6e66Y9362tlA1Fxz3DI6G/i6eXEidzy7yZHesNhaGeSqlR/DxDwIUvM47GkqHI=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 17:41:57 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::46) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:41:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:51 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/26] drm/amd/display: Remove power sequencing check
Date: Wed, 18 Oct 2023 13:41:10 -0400
Message-ID: <20231018174133.1613439-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 04093c9c-2679-41d6-8d6d-08dbd0018636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbZ1OtgM4MnC/GUijMI4ndaHHYNNY8FKhcCEWnwwx3MwgVYiSBm6DKzzq1ihXFdv72cT4Qdoacw6eK1CX64YGToSssKU8GqJYHmxbumojpo8RblibmzR/X/6ecuBhLfwwQDAZlDZuWepa2YZ6KrJ5uWWwQ2Ly7NBCsYBuPcbTyoQkvyEXSPPuJBY1NxRxG4C2yYgFo1+XYenEvmdGW56pG535luUF7bX+UiWgfw/yUoud3L/dMsrHMfB3vPOXSMulr6DrNsFB5L731+FPdAQCHi1A8BnwEPJogZvrRy1AVqABuYbyPwkTXs0pK59bjl0ioNj5WRGYuagIyzhICIHymir+ANJqx3K1Tltjz7eUKweBvXnjUft+iUcRRhSUhkKVWBuJRqL03G4KlwU4TAHMdaY+jAqClIZoprNcnzT4X0ZGKTxCxJu55ZcQTgTn9QH4/ueJnMrAZAZRbeJsvpbyZoRUeKkHy8G3OpqfWuZzBVzF8a2KOqj8Xf4bSoEFN0oOpQSR7BigLVLV0mZaDK8YDatTH8oLmP17le8AbgM2Tsqj4nfx0FKxISm8tYiwkBs/FOigVhimEycfhQt/Nl/hb7fDFwrD/GHA93cJxDLadRLGexHrJY2T+NJuvZnj5Ce+VDGp5KDwYztJmpRkddTJUBrrhbhbfjZOK13cyH1Hzp9lqkAzqHRvDNlCHjLcTjWr1KSqKVzc6LT52LNplFn09ydY9rbdOfq7MrQ/14Acj9ugzFLnuhzGOE5JXHe6mIEzb42tRgA/ZDfFx75B7g7aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(86362001)(41300700001)(2876002)(2906002)(478600001)(36756003)(54906003)(70586007)(70206006)(6916009)(36860700001)(6666004)(7696005)(316002)(8936002)(8676002)(40460700003)(426003)(336012)(1076003)(82740400003)(26005)(2616005)(83380400001)(4326008)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:41:56.6917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04093c9c-2679-41d6-8d6d-08dbd0018636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
	Some ASICs keep backlight powered on after dpms off
	command has been issued.

[How]
	The check for no edp power sequencing was never going to pass.
	The value is never changed from what it is set by design.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 4538451945b4..34a4a8c0e18c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1932,8 +1932,7 @@ static void disable_link_dp(struct dc_link *link,
 	dp_disable_link_phy(link, link_res, signal);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing &&
-			!link->skip_implict_edp_power_control)
+		if (!link->skip_implict_edp_power_control)
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
-- 
2.34.1

