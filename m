Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450F606A32A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oSxBlh7Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BE110E9D9;
	Mon, 16 Nov 2026 14:48:06 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC1910E9D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 14:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0Pn1klJIbuJ9H4Q9XJcI6so+4Vp9b9CPjOxr2FnjFtqAMdLEWSD1SIEp7bmuBxxTk0BCV+HknXK4nOLdKlhi23tz8dokDnI+UkM35oxTtxqMcmbRiDiNB18z49FYsQt+iEyLVjegoVEBcT9/p7r1UtTfUpKODC+3A/Q/ZT6zYosrHT0hYt3p8pn9jkJeDW19Wrj3zyHT312xKvVYznBMcnVUlFScIbOKr0H0NIfac7DKBZp/hvr6wtW9HHMorv4v+ql7c6VRJLoc2H8mlvW3nzzX2pRWOvKKfFGX9Y1LA0Hl5875Pgq7CBVE3gbrNsCMBeVfF7x8BzJrrXBKTWO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP0924Gv/Lq+T4PvlxGqhnvIyp/AT06eTUjfBJs7rw4=;
 b=x8qd6ojX4dEGxu/a605OCKv3xgfa8jt18cVgYgafc/onYZh6+7CokcpQAlFic2zPiM+uFxI5gPSFVW8xviedmrh+ricdGPDPQ7+6yidITjui81gLlDwcTvGZ5sk2NFUouwtziwvUNrbgEbfDeU3+yGKOyhHriw/qxUb3D03dMZOaNwtVVhohrD9FRYcpklY0QXMCV/49XG7q4Dr2ge7/ti0Z+dM/c8rvMpRgwdLmRkGJQlDSWyIGK+6gmjsiGaXJYS8gXHeU0PudxiIzTfDgWWysN0LXGzkZTY3usC70ScJ9YPLo7bYmECvCW71mYVpFIfub6zlSOSU185j1vIHIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP0924Gv/Lq+T4PvlxGqhnvIyp/AT06eTUjfBJs7rw4=;
 b=oSxBlh7QOnYj8g75kw85MQxVtBpAN+1bJVlzx8HC5lK818WjvCviyvqA7zbkc1hebScMngdc4AwxzH6z/l5emRNHUGFPHbokNcyUPKtMNbtmN2AHr07uuaJYVHWUu9w5Qv9HMrOkNJsocOrb24xmAIpFw29sgvlJiqCmGWUk8vg=
Received: from CY8PR11CA0016.namprd11.prod.outlook.com (2603:10b6:930:48::25)
 by IA3PR12MB718185.namprd12.prod.outlook.com (2603:10b6:208:61d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:47:54 +0000
Received: from CY8PEPF00000053.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::70) by CY8PR11CA0016.outlook.office365.com
 (2603:10b6:930:48::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 14:47:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000053.mail.protection.outlook.com (10.167.247.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:47:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 08:47:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 08:47:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 08:47:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Vladimir Indic <vladimir.indic@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Philip Yang <philip.yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: move TBA/TMA back to system memory
Date: Mon, 16 Nov 2026 09:47:44 -0500
Message-ID: <20261116144744.1904011-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000053:EE_|IA3PR12MB718185:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ba81cd-b03b-4c3a-fd1e-08df43f09825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|261021121427099003|261102123227099003|261021123027099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: /ya5KyU4sKQKBbAM2QsZfayMB/3EKZUAxU26uX18DDIeHwatH/iMo1nNJjwdGOI3bHxX5PghuJsP3DBLmmjFwtEIrpE/kbADN+v2Ajnlk21bTdWVeCxoes2GCd8o8wyvkLSXlbc2+5teizilhAdB8zfY5SiEmjtid7TWPPwoAyBPN6sZZ0BjobLVD8ITFMSvyIa0D846rh0FfS4h6z+4eA2aqLAXdeQjlM7zl+CxdUZEJdBowVB8VJXD1sQD7/XvJDgnKbckAZcyF0SuS9ZHIdqBitYpS5EdRyxE/4QBBSMvOWL1A+bdgDAA4XuggTZmZnMoP6CF2LtpGCTVUSn0BjXHTaZEGnnhH4HIvZR3ELuqc84saLAQgJ/HVUkEByY76q6dhCSnuSGRVVJWZmflH9z5dhczYvmby73GiXlra+rxdTc37XVNYkipDgb9bOVBPfRCQBOeneTDlJGjxJrhuJpfIU1HXzsHQPHhjv0GOgse0fwXU+oL0a4zo8G5cpDfKsju9ay61WmBjkz65qxT/7peShmNEPTrn8sl7/YwQCHhetum87Q5XslHjeWClqzkm0AuQXTGF/w4BQQT/ZOto6U4bbAkSCbKnP+/9f7Ko8IPWtM0vbMnwbd+jYU+Aw/SQOC3FIz/jpWnHwQgcjD/xZnHmu1obz9ts67B/6Te5jU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XciE4u3A6YJlz+YsYj/I2j82/JYj/++kd8ZfLeJpeG1O3j0ZTqI3yvy+u21G+v5+4i1pE4dbErwZiK7yrkLAaStjt0+jcSFvgNDmbYPlOfTLiqbcV35RLhTuzxySQ3T1PP5k06Gvbb4tQCUIAQ8GmFnZmol5mX8yHYxwMnW1MfTQVPhh9MTKspQtyM8w7LgewR9O8vklK/UeXNWChXGlrCYwlfc5qwJNOpiAK0acbeJioQecdsJ723wytWmkz/vnCMp+myVswWWXQlIkP6UqtjyQR1Vr1TIRJXV/ZmTxuxqj4Gk+hbDlD/pOUSa4c2kDjWQGWI8j6/tRpsLfB8l9FZudy22oM3xldIB8fNiQNMGBz0KaLthyDxJw4uwjddGpEP0d+ga/WjFZmGg8RyseDmPkPinQHYaRQpYbS6HppnReKCzRZCM5D4GcpHasFIM7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:47:53.2851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ba81cd-b03b-4c3a-fd1e-08df43f09825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000053.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB718185
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

For non-MI parts, move TBA/TMA back to system memory.
Results in GPU resets in some apps after suspend.

v2: add additional IP versions

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6116
Fixes: fe5966d4fdcb ("drm/amdkfd: move TBA/TMA from system to device memory")
Cc: James Zhu <James.Zhu@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 546721b4d59ac..b1b641ddbcf68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1554,7 +1554,12 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
 		return 0;
 
-	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
+	if ((KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0) ||
+	     KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) &&
+	    !dev->adev->apu_prefer_gtt)
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
 	else
 		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
-- 
2.56.0

