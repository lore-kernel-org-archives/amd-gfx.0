Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16F606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=puCtXvIS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FA410F895;
	Tue, 27 Oct 2026 23:21:53 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0489410F895
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK7iW5MhkF8R+lpoa0qeUHKQVunGcneLkfX9+s/6MSzKGjDkXeZ7EJFvpVWqgXNI1OAtdV2i9Bv1MLbBc1BolZAOSE/R3Y6jNui0r/PdhWLuD3cqUB+HrJuhNyQ/V8NLDIKSOS6Wrm8AQReAa2xRvHxfkYUSGu/oYt78T2SYqOjjBhm/FH8s0kIIYr88kTTTy/Hqfjqeo1ZMCBSKVZevk1Hvrsqc+/mfL4Jf6pjdtg2XWzso+iKDHHqPvN2meojMcw+WvVPQE6qOUDsswnJiNxg5Iv3++0yVgcEQsFEvaUlbEFcNv+M5Z0a/liuURS7LmMg6FzfWWJoFNuI7S8iYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGjEqC3xvXCRR1/iBVYV/FHmcvuTydGOS4/Cz8A0Hpg=;
 b=zFNRKirqUj/3ntwy669BdMhGTtjkLnvUhscstY4noU/DabkGJ0i2vDWb7OxTzi/juuz4N5T4VZcBovOdvHiLMruKl/okzTQNdP2apANko6PGbV6rTSJtGpzQhBGQ2NvHjxTJK1MTdv2D4ntK+zSBkP0gcWhBgwmJ6C1BzE25KI1f5XZvPtyIQcgqL2Ukx699y9mj85Rtd8iYW3EDqQgzRZ8QRfzGncLVF0pW2W2ISxPr/1YuexSMozUAF4ElsT4u/YtoJk3dZ73sXMEAe5RRIR1mnmGbzF+mkGmjwP1Awa4GFlwR2t9Q4BgPL9xQ+icZf50LKj4COM+pCC18ge6LNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGjEqC3xvXCRR1/iBVYV/FHmcvuTydGOS4/Cz8A0Hpg=;
 b=puCtXvISimw5KrdCMFpyQa5ayXg1pEjXEBo7XsjmmigFlFkyPdXsN35X4RlOcN/GODjM7FH+YwMTZVYhJ0+4M3U1eYuD2Y7HuaE1tPyfhtIwuCvFPQTxbaOxBU95boVyPiTeU6r1TbYZl05qrNdGgez855M7UTM5u4y3qDsTjpo=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:21:06 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::56) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:21:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:21:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:21:01 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/28] drm/amd/display: Clarify endianness error
Date: Tue, 27 Oct 2026 17:16:59 -0600
Message-ID: <20261027232005.2879750-4-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: caf29314-4ea3-46e0-a984-08df3480f9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261026121527099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|10067099003|261022105027099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: KLw6TWH9CJc7Z/kCihGXlP+EtK6MC+RTMmPvThfTpTR5KEu8obmXYN2YTp5u9rpC2cUbk8xAlvCdHWY9x7Qp6Fjak9fx7e6HcghyCKf11/Bn+j/aBP8bgdBE2GUpiGNI7aC7zyu9N4v+EHOJkrWlW0bErp7wdNr6zM+3UoApFSzazCRs4UZMZMwp5CkQJfLYgGtYpCtlpdx4+I69muTVNfx9XpcCGr0pm1K4g3eBpxOpqJqNqNessu4b2Amfscslf1rAkhcOFqw1H+bWHQ68Oy4uZ42bq+ja/Uduf+0y9gQlLS9QrHpiULRtgZPWuK/Q5B7uzt2vSdmrwgSy1nlYgxTM7ddT886zkAEOPFLbNG6HflgGLDXfl6LpQWPQ4z78dlpfYsD/34gZZEXpO5nOgUGH2FQx5914moylNZvaOI9PXboEzJucR7T58dbwLkde+8SJRg0Qno5BTvWm7VgtvoPXE5k8qYEL6dR1F+vqyG7a/0SpkQZQ/0irXDSr0YSr9s1vpZSGziEop4gDy5W58N95bay0wvPh9g+udItoU+ZbGDLHYg2xMChHJujiEwYGDYbLYs0RcFf4tW1VHLmR/sOZJlY9thuBdBVZpEdUg7xcPB9w9hIUtWjjQi/t/rl+p9my2lQX8kN/t+9y72lds0eNdnlba0KUDzCGH4umL6MQ5Tov61qGNcMRE4GqaDCqH2WXHg17quAp4t73ODeNtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(261022105027099003)(18002099003)(22082099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n4BUvUyhPwy98/6E6RqKzCNBd6+2dJLcnBIIIU3PaknmIkvW5wdDRTAEpwSg0pUZ48mU3L7KRu+CnOc4pqAhENxoLM5hfZGTTapLlxDb0IhBHuw7GkWge9dWZztTd3zGJMQ4kknzh7WTaXkERGHGQ9eKtsc7EOPSJD+WpKpE8Nt0dcU/zpitJxNEldx0gL3Hk/vp1HOwZD+ARiWTnU5MeYdj0NzQv0TJf8CIVIkc37qnPlGJe7lJMWasYqcbNjO5TQlfpFl5q+wei9hWAJzxRECvhQP7izmNtp0E4i4tY2eZ6D6G2RWANbNEFiq5Y9x7DtqpuzWMn119Ht5wkL7N8oSkJiVxU36gau/wVPxA8CKdF+vCKILIG0kq98EyQ69ZZWmVImysmMSl003nWy3/pJRsv5rYI6KCT6bBeQzBPPTbGU3qGdB6rnKvrS202qFy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:21:05.8486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf29314-4ea3-46e0-a984-08df3480f9a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[WHY & HOW]
link_service_types.h requires specifying endianness. The existing
compilation error was too generic and did not immediately point
to the cause of the issue and how to fix it.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/include/link_service_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 798d83238828..9026cfddeeea 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -229,7 +229,7 @@ union dpcd_training_lane_set {
 		uint8_t MAX_SWING_REACHED:1;
 		uint8_t VOLTAGE_SWING_SET:2;
 #else
-	#error ARCH not defined!
+	#error "Endianness not defined! Missing LITTLEENDIAN_CPU or BIGENDIAN_CPU"
 #endif
 	} bits;
 
-- 
2.53.0

