Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A1FCB61B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA08210ED60;
	Fri,  6 Mar 2026 15:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhezE+XY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D7210ED5F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8+gdfBSOX2bcRYkeis0nmv8hObge+/DoYvvIouFoeRiWBXo15UxlanJMYTzzbONBGBki/3u+f6BNw3/f7iXDPCp2RL2J4hp4NIDzlx8T00q1Yhpvi0ZNhDSU4xJjIEMzGxVt9+6Pu5Bge+abGBbP3+IsDvmcL7E9/IGBV2MAOKJeiti6Pq3CjKHd0PF1i5N30QIE4lUZ4AnnfLmitTZCYutRtsoFxHb0kmxcA9uD/X30156K/XF0mOoV3qqR7uNegvkKxM8hvFioo7Fwk4O/r79RDk+4hX3IEfSu8XSGxnXdiKNB1/tf9M1m4d48IUIOhH2GDDvvFs0kFLfqIJF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCQEKcAz8qdlv/WgXij+lBt4XhqTZ2AM4DhGcEfaSWs=;
 b=QBsGmi76rU7t4EEVNNE1WHFb/R/rhFRRmGHcxZY9E5V1avey4OHhbe5wvoLTbqtQ1wZ/vO4HXqDkW1r6Ur2Kj0O50s+r0VFJGDrTQRp1gnxw8hKXDSk4lCB3bpFMdRDfZ0e21xW3gs+ZhzDBSIGYCfwHT6SMMA4RRpF9dHHK68Rxe3IvQ2n2NdaCuje60uRr1edKNN9O0QQh5L+wWdtvsC72MacQlPslanjy2yCqvlOh6nzDIpavu/sYJ4cnCdQnO4pjx9OsruZtt/Llloq33+l525KEzWZ0gnB7tRWPVcUYViP613uX9ehm384M1rHrOT/g6zSusEeLtFWpkryVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCQEKcAz8qdlv/WgXij+lBt4XhqTZ2AM4DhGcEfaSWs=;
 b=vhezE+XYtzqoDx58D7E378XqUXvThuQsD3yhCBzK3DF2W/W7N5j5m2mh5AG0IZkZkxkgaAipIEx12HftHXyby2OarkHfKJwaTfxpZPAvgcytVo/59Z45tPtlONsdzQTeqc8FAjzldNpwYw993dvoQPGzrdWrtlR/XpAJo9kptjQ=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:40:23 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1f) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:21 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 09:40:21 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Disable reset on init for soc_v1_0
Date: Fri, 6 Mar 2026 10:40:04 -0500
Message-ID: <20260306154012.22525-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: 302d5743-8f8a-4158-dbb5-08de7b96ae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: 6NSIR7SHVU6RengtIfCV8OAxSjCexua/58nkqEOIH+1bSz77cmSlKvaIrnSDPhEyD/+JmXhbDnX/+Cp0PKD+wdTE5YmM85LompwSNxwcDCrnHCMlVKvSo5XsN16Teu8bEB+uwvqqRJyBky17wCj0XcW8CrW3LVgJLEt3sEb5b2sp1I9PQ6lFrM9jQ73ImUQ+Z+Gk8vvZSwhMyT/RIqk7LPJ0tSe7aJeVMPiciuJUQ41STDKOMGRAcHsXAOEj2lmAGEf3V0EHcW9PLpjKtmKfWAKig+UukJ03ExUvaCtF+fdVr+s1Vg0a6PoNgEuWjxRgcnf+vBRMoRPZCLGKabR65VhRtZcFO/k/b4XPcK0nKF6SeL+MgBkEyIBKjKwfm5IblBlQtpZ+k4K6rmZLrSwmch8lcKVpeMRIJVOC962lQPQ4a0rs6LSPOYZVlNyZIq7GqODVllmuz52NW3yYYg/77Vz9P+FZort2KZ/nK8jyqVuhMXyzSWFemJQk7jTgVvvcwsTNIv0oUp0wA1sF0XSNI5MGmjwYtteMl9uAb443QNdZvetpXtVoGWskmaoCzM6RWX+4VMb2vXHgQ/vB4e2cfmJeMSNCvr5FOLJWS6eFWvJWlu8yc2xpMamFuBAWR+TvVxvEQgymTfNsAR4C5V255OrTzkpEPxu8oXnZlslpePxQNAtBMvIjLtIHK3xhEbczV96CxQG5483gcPRnY82q+/Em9jYaciJFELiOAZrbtDA0jF3475EEzZ2jtNN96srKPW4ZSZXO/HJXvIvlgl7X7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PzWSOnTARRwKJhuGM0t6RZ0b2zSBqC+vUmZEo3AydR5C75F/tGkYZ+c3xgGZosfndszmKtxiCEHLwL5gTJVSmHxI5M4IkKxrkvccAWkcCiDmtDcLwqcqKR+JXi0iqWBNIl1oC18LM9Z67lU0KBmB/nZIr+yulyMNn34fUFRtCUmDsw6xDSW3+KYy5E3yoe+e6LK+eGsoZetBx+X8xFoqcYespG2xj+JeUfbzY9tPfMF5A89gXMN4yMEuazc50jlOutTK8yoEbf/cS69ArGdIN6v8rJj5sMeZc3KoRuQnCkbnV6h9iSo1pdNuZVJIR8vVSLNLszWzvaJp0mE2PLMLDvyHukzEPv+LIEuYXGP0N9ZxY4tucEdSTLo1RY/LY1RITgzfh33vrLFYjkES3zRPogsGz4BhfQdG9jkRcR4MWi7KH71ni5Xa0lqd0LTrl+Gp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:23.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d5743-8f8a-4158-dbb5-08de7b96ae48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104
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

From: Asad Kamal <asad.kamal@amd.com>

Return false from soc_v1_0_reset_on_init as psp is loaded with ifwi and
sol register will be non zero on first load itself

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index bd7043729e6a3..43209eae81bbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -214,17 +214,6 @@ static bool soc_v1_0_need_full_reset(struct amdgpu_device *adev)
 
 static bool soc_v1_0_need_reset_on_init(struct amdgpu_device *adev)
 {
-	u32 sol_reg;
-
-	if (adev->flags & AMD_IS_APU)
-		return false;
-
-	/* Check sOS sign of life register to confirm sys driver and sOS
-	 * are already been loaded.
-	 */
-	sol_reg = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
-	if (sol_reg)
-		return true;
 
 	return false;
 }
-- 
2.53.0

