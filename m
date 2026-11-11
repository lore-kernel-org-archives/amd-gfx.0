Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88A606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QnC0Xonl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C958410F8FD;
	Wed, 11 Nov 2026 01:45:52 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E913810F8FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVc4x/n+rb8owjdnwOX59CRxqYOY2Tv4vlquSkWB8ePl7hxEEGIrz4JFXrpE+ESmM8rcegh6jWyL11AyoftLYiBxa8OKAlUzZzvlnM1aYucAds6L15RC1TKmE7eRbO1/HzM/ARDIkUCsrepBWq1o9c0SmJMlyZBnfYblpOygJnACy5/z1yZX0ksniM0CKq6OIptvlzXw6H0L/9n3om0PA9+MlmTEAczknIGO/bKFHmSrigoSwSdTgfVZfxDtl+sKa0+Aselso9gHUKY/ecDZ6K1E0ZZS1Wf9o65OJAx8CczstddpYte9Mv23EecaJi9c4qC5aq2YZU9zO60We+eKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV1K1rcvJBlFOCBL7tWKxl2IXcaXuWfRgTojlAQ3iJA=;
 b=mwSemHJtRe4h0mFaAaqKmMMMzD9f2lP2KxBJ8RKRIqmh0jo/H6111Sa61OK7zSa6/y6SyGnDZe2bYKkrus9DSSNU/IutGtAQhhPzLGdmnVQ1wJGjAHlvMzWy6Z6t4lvwh91FG3IkU4hzNmSSCMFR7n+vh+tKi7+XKzjk725b85Ba6hUFp0edCqdFanJauZ73U5iTX+cyBOc6mRkYD5XpUSS83+SX9bXTfF/WeYJQXuB20JRMPfkcsqoIbPk3OGlLsgHVncLaCH9kKX4f5DEuYuHnoQmi3zqOxSu0Nb7+B4nDi6lkEMg5iBeWeslLoQwmZk2eQmGzrUWZWuyiZxAQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV1K1rcvJBlFOCBL7tWKxl2IXcaXuWfRgTojlAQ3iJA=;
 b=QnC0XonlVAE22RLyl8PAnkej6cwn7GuX0Rc5hWSTOlLrntfYpNQM3CvOyHLK1LrEF0eu6xKtoLchSUkWJq9ZzGUpVLASXF1xM7P2qv6SzUfPvGGOJIZx927s/ZcBMX7RVTRNz1suRraRxvA0Bx+Uv0o+mxCBbRnWK0+But7UGoI=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:45:43 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::34) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 01:45:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:42 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:33 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 72/74] drm/amd/display: Enable Replay timing sync by default
Date: Wed, 11 Nov 2026 09:29:18 +0800
Message-ID: <20261111014100.3596072-73-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: eb384762-5922-40d4-ad6e-08df3f957f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|261021123027099003|56012099006|261009223027099003|261102123227099003|261022075727099003|261021121427099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0/hLlByWzRn8Q9v+sWsPtxd3vRlHDkbEds46uE+SutCjueBFHpA//JE2sL0XHeMpTY+6bHO983WONDVUt1UwC8nqHSBg9D2xwMCd1HUJA6JPsBxqmP9C74l5kEh8rrZGH4cAKRDVpN5dus/xjCdZXlQDKXOIwLyWdE9azN8+PwuO2lJAvkeQRcH0sVCYS8UzakEmCN88L2rtqRPvokjNeX2dnpsPwKzy7mMrMtRudkDkGU9sLeE/j/Hi1dxjwBFJnTbS+7Jp+S5UxCVTn/dqdNfRQbHNeYLdgqY9/1Ydbk7CtqrGNH0rciiACu4+lCmNnpUPVQGH1FvlNaihp7WngMIFbJAPg/YFNdwXRucfy3t3Zb23V4CbGIW9zrs3olqk1IcjYjXkCE+0YfD4WMrXQsikFt/YXwchr9OPndwQ7joXSjWDrEVeQ1xlMDllPLTRrQKSNw0Qo+b4myGhYl8rSdj6PKhOV8Zb5pOrObRudC1ONbHi9cS3j+kgCjzsYQ0XmCJPkvJaNPktKhBGUkiLNCbgr61nLk34Klx0i/CAE6dtcUSckpqQ9SjbA3zLXXyJMMievQg3gkWAah13fOyvv/hMLuXA1yAXbbSKuFrWM/sK/qPVZ01vM7pYAx2iL8xVynhncK/CIO/k4hXClXq8Rl3lE3IciqO8vKc+igqRb7i0GubfagJsmqmnh8Ly+A/jMgU/avzAG0egHIyoMbO2Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(261021123027099003)(56012099006)(261009223027099003)(261102123227099003)(261022075727099003)(261021121427099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iEAkcftdJ+mWMaxxvFFzqDE5xA7Tc/zhHlMLF8cNcsrUeHHd4pYK5V1XIqAZSAsxT+Xg0jNmdjY/qU6L572ZNHvf+DwZg0reBxkMmlccexiTUgBndaygH1osJbsIr7OGiPHUx2bsH2lNha+zLUsyP2b4i6h4wuBsK7PYsiVoz0XBuZMgJmioGp2o6OWTbAyxVaXxiWe+e8FpJyDq7P3gWNiF/FkULip7AIEAn/Z6sGlq+TdgL39n2yj5whHR/mTUETWqM0NS/ORJiHG2SFUVYTxXDU8lbuBE0fqfLTsJJV+/Hegl4gaDUH6sWS0pqRCQOingF0BdUh1YJ/uS81qXhCtLRY2kxL35rUpSkd+/feEEn71EmZgD4NxwJYicOb71OpxsFV4iJy4wWcCwKr5x1kMdD/PGb1kY5NQbX27cAhYSiSMhWqEfdNIZLjQtQYPe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:42.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb384762-5922-40d4-ad6e-08df3f957f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Enable Replay timing sync by default to allow DMUB to resync
during active Replay. Remove the platform-specific conditional;
scenario-specific power optimizations can still disable timing sync
when needed.

Cc: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index 666585b7e00c..fcfb6066066c 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -162,7 +162,7 @@ static bool mod_power_update_replay_active_status(unsigned int active_replay_eve
 	ASSERT(link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_NOM] <= 0xFFFF);
 	*frame_skip_number = (uint16_t)link->replay_settings.frame_skip_number_table[PR_COASTING_TYPE_NOM];
 
-	link->replay_settings.config.replay_timing_sync_supported = false;
+	link->replay_settings.config.replay_timing_sync_supported = true;
 
 	*is_full_screen_video = false;
 
-- 
2.43.0

