Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B244C5B572
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Aug 2026 10:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767A710E3E7;
	Sat, 22 Aug 2026 10:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBGDKzF9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853D410E3E6
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 10:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT/CDIY8aWee87XNcrOO8CPi6IDpKMLviwA54pdR4rTL5WsZnKn/qXwCjWRFdPW+ZGgSxMGmKkWqMrKP+OnC9e3kFgp4XUmErDmLEFbOjuoAnmqMWpiVJALbO/7rxIkRuqSiFZuvmx1bmjqazDhoFy+B1jKlvVkccUgd1Qq8JzFBa+UHYIKt/KNRaNqDp6kbKTkat+aY/d9k9DXlsYGvBcpG7r8REBzVAlsq3uqZZKX80f1n3q9G6DZ8h4RvBUWam6XXm8i+3Hp28ReF4vESh1CI+fDVvnzXftT9XOsLdq8gsrYIQFcwXlrEYsBupLiSZvYXumsq2a/zZO+irCb7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CHe73Az8ldaS/Pc2s9lk+lUzsYE/mYgWw84lpcVq48=;
 b=nv6zQ2nkCaDq5xdEY5h+QjDK1nwkwXRmuraumSGeZb/qlQeDfVMsGhk4EnNmoD7ISSuHe9kVFT8dbDGdRpzFapMGRLS3j1fqJ5UejEuHqXm5E2hD/uSSJIXWLeJ6bj7PSddYKfNPIXON/5P4eHp7nSAoLXyCzGzDqmLnsURAdO11KlzX87XZMxA6Tkwx/qsRWcFnyjw6XC9lAM+CawuoqlQTyeS/8zepiBiTiLNfUd19oZcN5HmF3tV/nP5WV3a+1PluFe1OnoVozJ/GGDmKcOHo6cJOW3JFdC1K4yfi3VGuOya+ZZ9r8TfLwVNBspSlTUIzExK1N+m9PcRX8R54Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHe73Az8ldaS/Pc2s9lk+lUzsYE/mYgWw84lpcVq48=;
 b=lBGDKzF99LxAf2rH4OZYrQlqBOD1NYlP+M/l+TFdTYoE3aO+XAIz6hcxYCKubmCw1BcCCoSkRp+J1lMyS16lw0PnVCp4g8SClfqIeJFlpGb6sAuvrbFxKUy1ySiD4VRwv2RrORGqt0kXiwxPs+hl5V+YPbfoAE8j0ABFcf1Mkxo=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 22 Aug
 2026 10:26:46 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::72) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 10:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 10:26:45 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 05:26:43 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
 control
Date: Sat, 22 Aug 2026 18:26:08 +0800
Message-ID: <20260822102609.84913-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf9f51e-96d3-4e33-162a-08df0037de0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GGvO+emNIGj2QH9/4nOoFzttMw7Ufopr9+BIr0zfYcFfhCkBolDlqGUco+AfbIZl8UFE5s2QjrcBLDrgEueocV3N8Z35ANvBT21uIw6HGtq6LtjR1JTN31la8tp9B7HZ9SWQuLouMc+iCmZPQsa0HeXEQv6fPgbKu2OksByMdC4hRztC7rnXaqwj+2pttJnHsAm7TtsnqWMm1jIo9Mlnlxf1SfJEHb1CDFeLPUNy7CGMckpMIDwxBHKxJdlkV1Vs4ztdZEoNBzPVZAta2SGWwVU0QUP5I76Jp4LEOLHLLkrbLauHOUZLakAhTzpWzOYALky/e3oYnyfUhfAZk+KOnyxqQ6N57d0Xc+yS0yeT3f5j8SsmrnDggncQGUgDmVZ6VIAXD3U+TfccIv3AzQK2nrN/9gDrdATqttZy7DiOIgiw4xL6l/Jr0VSLUC6Ma31F0BLQj+lyNclDYUUbDQx5jIK21LwlPbCOmI4EfSC6PcTpoyVJzTc4Bey0BhimtFf8MeC5PBoH4ghxoywr/5VdM4UNY8eJW/lawpjN+5RJoEdDQk/nlFPPI5SCqff6ZXJPrp9uM+HU2vnAYM+y1z/i+YeZBQd1DB3M3vMeRfAs53E/eRapUlWgA1gWu5TBS7gnynbcukPL9IKEubodd+T77/0CDzoIObA+V8brWYOUhYeilr459FfXRm4rqCAjST+sIWPtCRTS2wR/IUSMmm4s0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T60JSZkGheKBXr/kc/Cm72j/RllTsK+vV3AAV9/R+iSr+CeKYuH1avYE2zqjr1bfIjQtnUigS9GEtuOVdAWkF6Y1tPu4EtOhwATQI+AGIhzZOcW0Ej4zfk3mKQxrBanQZTzwkVOstDYWy7Nn9WSX58HrDputNFbO0zW1png8O9W7zMdzlJgCG1kn8UOTXwjAUIq5aPVO0+8atFOyF4s5Yxg0P9GFv1+voKi2m3VIkfgQJaHLSUCLIExIR6eS0mlMUzENIKbKWmLEy8p0aS84NPxojdiACS2+wBSzG1zVmSFQEnx1RCqB7yHriJB0sPCPuxwcpou+m9nxDlSUFyePM3fQCpt8pzVcFkQQ/VpaquA78UIsLNtN9RJdwVGVjNJ7KCqLpJbJz9dmwtqZ5c9FVLaks+IdbPvR/GE99UA10VDo98Nu7ySHt8TcC4uK4T0f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 10:26:45.7555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf9f51e-96d3-4e33-162a-08df0037de0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ras_mp1_set_debug_mode() reports -EOPNOTSUPP where the control does not
exist, an SR-IOV guest among them. Treating that as fatal fails
ras_core_sw_init() and takes RAS down on every VF.

Nothing else in the MP1 block depends on it, so carry on.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 2452448806f6..781faf6a7529 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -203,12 +203,12 @@ int ras_mp1_sw_init(struct ras_core_context *ras_core)
 	mutex_init(&mp1->op_mutex);
 
 	ret = ras_mp1_set_debug_mode(ras_core, false);
-	if (ret) {
+	if (ret && ret != -EOPNOTSUPP) {
 		mutex_destroy(&mp1->op_mutex);
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 int ras_mp1_sw_fini(struct ras_core_context *ras_core)
-- 
2.34.1

