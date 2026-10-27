Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B6606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MGNP9Cj+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B3110F899;
	Tue, 27 Oct 2026 23:22:48 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C79210F899
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMaA/h6sETBiKfwiy0odQ0nTAbxaAjs3jE2+aO6KbSmyjVFPIPR1DTafmdlgJohnKeyiOQm77gGGLfr8eAtmLsAoKrZ58CtIF7w0RB4aG2i93j59ePCRb2NAePhwFnNkEpkyk2T9F5xW7SoOfy6MJBddU68dob96zochh8X+czbbUCSkkas6oNlrbONvS3Icp49jGQlRJyjtl91C1xdidaUz7zreeNHt38NMxLpwrGyyl8O3VY1imuXEgTOHl8wEB5BhkYmlhT6sLflJXaWMozmzq4obQA0ehyVLcEWCjSUeLoul3NYUHPs5AT/ZHq/d+uxVE4rrbc2+ZbMixMcNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhkkzEdxfsXg6WuWh3m+zNF6AWoYy12cbDmRnsxBdwg=;
 b=wOGY7M/OGtgmsOkUFPxMH+I1cIIuUWruqgm1ioSh7lsZE5Dn2TQMhjdfLCwQgK5dIivybIu7Uc0hcw37H9QEkgMgZ8aAptqvDSv8OZHxxXSKL/T5gsyxy3iljQTH/tTLrhtCP06zIuZe2qWZ3/L5Jo7e09/TVg22QrCvwlATW/OArd6A+TJLLEaQhhODI8HtOE1cbBolZa17OspF4Qoe8iIe3E8oSs7yFm1qJyW8zPLbbAWkia+/CEtbUkacrDWaQGJI6eFPGRjmYa0vJ/trLPsfTSuA2aE1ZSiqwuEXvq5P8cTPdUitJUGcmCZGKGjDLxHlIPci15qn9XNFzo/I1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhkkzEdxfsXg6WuWh3m+zNF6AWoYy12cbDmRnsxBdwg=;
 b=MGNP9Cj+k7/E67s4ZRPzvc74uWIGvOsWm1wyecNbBlAcm+AtQYS4iQSrfJBxs6vrc5djbShm0gncv1yav79KWGsQF1RjBXPpMESM9ws8EUttXGUs1nJcxFtZQtX9wRD2cs/OMrEyfG8nViq06zgNadslXJLs6n9ZDCROhs73wVg=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Tue, 27 Oct
 2026 23:22:38 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::8c) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:22:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:22:38 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:22:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 10/28] drm/amd/display: Indicate wait_resp based on FAMS even
 in disable path
Date: Tue, 27 Oct 2026 17:17:06 -0600
Message-ID: <20261027232005.2879750-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: fae91a6c-7d8a-4547-fbda-08df348130a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|6133799003|22082099003|18002099003|261022075727099003|261022105027099003|261021123027099003|11063799006|10067099003|261021121427099003|261009223027099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: kGL19JX1zfhdm1bjpAZtDs3rCB/5n78VpoJj4wqn98sYAcxHXYDdOsbAWDb1VifdGN+tgWCt+WvTDj0a90hlAqKalul3l+M2Rs86mwQ1cc2e6P8vyO8zNtkHLxIrW9DGXSnp+jptnFJF8Qo84HieHzdMIDhFgfM7modqy5Q6DfbzrsnqsWXsmRVbt16trvKKpdE4JZjDKSp6vBkNOqAH9Ojmh+8ThfsobUWnRYLsG9crwaRO8CHcBGzUUfOlL/7/UC+GCKr65XSSenMdI9IBTNnqRG3N2y1E/ZyiJW4PN+t4cMtZ8gQjUBkRoRblVTr96yIE4QiTZNgON1HzT/fnw7CjIHY8fF4gGHM3sSFZDRCUnnsWRQqWLS5hC4TI923r4mCXFByUw/jNUZfLd78Esq+tyHdeYq5I4QyT6DNVYtWQvBmZAiMepBWeuEsrINujUbymYF+eFKKnXdgHMCszqJtP7Zq8vEwzY457IqbBd29QbIlsLMM/doweGPRTGdYoqYZzo2+2Nn8TEwqfLicJePmkgFM+7/TBCTdi9xOe+RhZ2+nklkv+bh8w4jCg2atiPV+vmKmDRCEHCmd3XCcukANqi2iDLKW5Iw46WUQoNaGEr0ehwqOjQHMXQ9R6hLn4B3qiTZQjN+DhDM6bSNmMMdWpQkbv/JPzskGMorqNfyfYAkuG69bQYJZL7lEl3/LKAKpT4WFJaZXqLPm+FozaqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(6133799003)(22082099003)(18002099003)(261022075727099003)(261022105027099003)(261021123027099003)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vsFDvonPhb+B/Pyff75QF5Mx+U1yGrVQLRszX/B2jJtXKLkkP2PzC7Bq3b68l1CykcWqywVlCBUKZYbK9iIFjbZ0/6VSxwOye5d1fWAhBC3jGKtp05uA4riSbWVE566Q2wMQ91JFvCWHxbHWq1pumHa9Co7Z81l3KjgyQ3Q66asvI5o1L1wonLUGGtPfZkMgw+KIdPhpjDi4z34Oy72ksBBcTAUkUYwbVKFgdZNi9Qgp8oNV5d9ta5l4sNqDDe5slxVty/XYMeOfubaKezXSpozX4f1ve7yzaPGq9Yp2ZeneOZXPPXK6V4NKYzK/N6wyw5nkhqS7KOVdNmBl+ZEpcwpmVTtvDJEhAjLOx/tAAHfn6esHuUkKo+uWL7Fi9siJhj7+PgcLm7EZeiuZdaG+SzLG3wuO2YgLmFSWh1AfqnMeZ3t4TXH4xxownDOXXaSZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:22:38.0873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae91a6c-7d8a-4547-fbda-08df348130a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHAT]
The "disable" path for indicate PSTATE status can be triggered due to
disabling alt-ch, but keeping everything else enabled (UCLK, FAMS).
In this case we must assign the wait_resp flag based on FAMS instead
of hardcoding to false in the disable path.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 1c8daa7d46a1..98d146bc25c0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1458,7 +1458,9 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 				!action->alt_ch.disable
 				&& (action->alt_ch.enable
 						|| clk_mgr_base->clks.alt_ch_pstate_switch);
-		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp = false;
+		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp =
+				action->fams.enable
+				|| clk_mgr_base->clks.fw_based_mclk_switching;
 		block_sequence[num_steps].func = CLK_MGR60_INDICATE_PSTATE_STATUS;
 		num_steps++;
 	}
-- 
2.53.0

