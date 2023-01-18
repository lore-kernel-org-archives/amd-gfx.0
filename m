Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BF3C6379F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 22:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791FB10E864;
	Wed, 18 Jan 2023 22:47:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC73410E862
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 22:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyofqfhvAnMWeW5hyCelG3wy2iAeJ8/PLK49ASM3YvOfoA1zNGgrhd1Bu2pUGu/VdxwpV+oimdd38Es2jxBm0JX+1YOP11wbDr718MYHMr4ZlEgEiGYSZyR25dZbwq7a3w/nnknOI6h76ZMs0cTgCQE4RpheFiYjcj6kjFetZFgXN7F2fvq7MoHUnMNCNnlLUNrXlpaIDYBiZZBrmLrCI16Z0ZzBthjtl8zZBbacwArgQbmt7c58ZrX25ytM5G4q1nL4MJ/tQLGXfs2SrFUb3OUiKPzDv37j4BJg0EvAgIzQPxQDy1pUMUtcWum/wnfmXnRufXHITWGpH+Fvy+TwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDA9Ix50sdvn78WUcwSrqVm0j4YMSDcfZJdf9+EoCfY=;
 b=Oz5x9EiHCz2+43Iwt4k1fWRHsp2ic+JgrrNV8wVVlPQk2tMXXTWMaCq0q68sXV7YRlPKV1NW1vOtSyFsKxHeIjHMsSwNj2OPIOuSYanGYlrIvD+L/pL3TOETxPrMtOFmreNRUsptCPtguYaeia2X/1nlP5Rs0NBOPGpBzJdTalc3ICPXOJJE0RICOp90+iegVp4rvKFYvbCuSjdDP7KJ83nb5y/Ec07PsIvgWFEvF8q63s6/9ddYaPJbbLw8w1dRoIF7/FZlHndSBmueWbz91Hye5jNnNk2T2YF7nb1WzkeLv4Af7aPCVq5vlSHgqbrFZzbJfYj38W0LC93DbZQGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDA9Ix50sdvn78WUcwSrqVm0j4YMSDcfZJdf9+EoCfY=;
 b=wgLqQhR1bmlyMR1UGNVXqO7gXo8nuItwzOc77CcEu9qa7GFID/o+B2xpGIY8e071tIRmNMWP+gjJV/cmzhnQqJ/vpRR/sphE6VYl0SOqK5eR+Hb0Uapaqf11kMaSHNpSEIjU7FnyJuWlXc5xVyuMkCIJyxFAmwLEBv24v7ct/ZE=
Received: from CY5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:930:3::21)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 22:47:15 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:3:cafe::7b) by CY5PR20CA0027.outlook.office365.com
 (2603:10b6:930:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 22:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 22:47:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:47:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Decrease warning about missing SRAT table to
 debug
Date: Wed, 18 Jan 2023 16:47:10 -0600
Message-ID: <20230118224711.6832-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118224711.6832-1-mario.limonciello@amd.com>
References: <20230118224711.6832-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|DM4PR12MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: dba5b5fd-741c-4bb6-c861-08daf9a5f1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlcHoOQ4S3G6DChwhnwIas6UQJKwK2FFV5MtX6QnLD4G2PVX1BvbrDGAYMfxySqxnr1MGIDWNzhvgI3hnFEfRp/tMZzK+ThGFU1nTQrkQ5qIjineDgphfZPm1dGKfUZciNKDoqMt7oZESNFf5SjBhiUhUgX2T909+m4u0m8Ilkj53GU0aqD6CZOACmUngElxGYKbPt128hKfnSX8QfXBIPLZkoyArh184DRZNJHTLuZe5QQkzOHbWdo3qpbQ1f+7Pt7A/fEasHShaOua5ZLEFd1eQx0Rhk/Gny3FNuxjrWm1CYHCPVh/Sqk1gPUm8m2E2JZby//FBIgDs+8MdbGlDEBin3WbgU07pCnM3jPVI+fObAG/RIqffWJ5/G6hdooGBrsx3kDXIrmB7n1/cHLrI9FRtEwEwr+cce1QW3RlnOaWF1MUd6icxHdq4d3/uCYVBRPyKqCbQ7Th4NMIqS+NHswLq/WDRJiLxMW8Dg79J8a7+xdJRVd2xt8/xxJdj3utK+/9MjStZu4gcWhWCr2SFRi1hVizzD9kpL1ODGeN5gZAJfhwh4tlG87lG776B/qiEI1sCi5PvuwpLtQbzLqoKEh5aSCgCfEcf+zYoTEAvZkN7UrwaEOvPfJLKjfCE19Qr0WztfBpYeSfHbqUo0hTXm4PlDJEpNhDreqNkxRU4S7qCUdpTTihUWOQ4n2PhLgyeuRBZ2pz++igbOzsAyKNseTQdM+1oewlJXXoPAKLMfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(8676002)(6916009)(4326008)(26005)(16526019)(82310400005)(426003)(86362001)(41300700001)(36756003)(83380400001)(40460700003)(4744005)(44832011)(8936002)(47076005)(186003)(7696005)(5660300002)(336012)(316002)(2616005)(81166007)(2906002)(1076003)(356005)(82740400003)(40480700001)(70206006)(36860700001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 22:47:14.9942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba5b5fd-741c-4bb6-c861-08daf9a5f1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As OEMs will control what ACPI tables are on their systems, SRAT
might not be present. To avoid making an assumption that it is
there but still be useful for debugging a missing table decrease
warning about missing table to debug.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3251f4783ba10..a309cbc235c61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1904,7 +1904,7 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
 	/* Fetch the SRAT table from ACPI */
 	status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("SRAT table not found\n");
+		pr_debug("SRAT table not found\n");
 		return;
 	} else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-- 
2.34.1

