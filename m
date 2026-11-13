Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758ED606A332
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Gr1FFDu5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACA31123E5;
	Fri, 13 Nov 2026 13:12:15 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA491123E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSuRxW5CcnGT0p8lzfIP0hCCOwD8CgODZsJI1MgQKUT9OA1YWHxQM6tCFDATgT2I8iQzc/cy4n+FBRjaeJZcqE3sxgWQ8p3y8dglxLEyAirbKWDZtS3ckcJcX2sSmZ3+WI5pCs11bXUJDCVHUVGXHyiyeTf6Fn+TbLn4nyjQo7LZ8ZrqgaMs2Z3QZV9KRwpNlp55/TCJKweo2L/knJWbdq9LIKwJlTDBD/JsctqQxSNr0L+D/sFp2ft4u7pecFioyyHJF4FWTdiZKv8oiLKQsS+Y8mUfqsFodoIf3nOrSDeodU1FV3xUCtPqF9Dwzt7lX2wvHh/mTJQhjkvK/VFzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=KPvDVtLwL4sMYqn2bh7N2O4fUXUIs8BHOjpJ5+1ahQJnY0h19ACo6AyLk7wrwDaDpleJ+7Fmky2Wz/V1RhRMLmIOqOYwj0sFU9tU7yF5tozEk0iS/mZYT480f7JX574S/aMN5NStwzkNdZNwUV7zWVUXAP5ouvMKP9ITq/E2PSLEN1kAGpV541PShgjwBIYazU3ROpMIus25BeKR55aOMHgSHBvlX3H1Z6gaNeKCo9g/3DEC82iiZdTF6cpex1omWCnw8GhdmCzcfjgN+Joi+bmk2AHNG1zshFs+k9U7BgfEuj6BKWGdb5LIMMPbTbo08AVTmPs3KhzKR4n7zXoqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=Gr1FFDu57oEKo2ew0uvF//gHWDrz61WAGOneT7ama14mG1ElY4R6S/RawLhrLw/23ZvL50ia1GT5NSjjEmSxa7e71fGdwS6LW2Mx7Sk98P3H+LMOcv6Ibm0FtK2ez5OC6WoLbXJspqj5rR5gILvXyJzwnSyegESN4DmLns4OROc=
Received: from CH2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:610:54::38)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 13:12:03 +0000
Received: from BL2PEPF000352CB.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::93) by CH2PR11CA0028.outlook.office365.com
 (2603:10b6:610:54::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Fri,
 13 Nov 2026 13:12:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352CB.mail.protection.outlook.com (10.167.249.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 13:12:02 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 07:12:00 -0600
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Date: Fri, 13 Nov 2026 21:11:51 +0800
Message-ID: <20261113131151.1807-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CB:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa61c27-02a5-46d4-b92c-08df4187b547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|261026121527099003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261022075727099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info: xpQDgHKW2+mSBNg9wXK2ywPwZVUpe7qK26zVlObCBDa25ckf+SanzRZwUlJ7LBclN0Yqaqh6jRK1gQ1i0lPu4VKHoW/HZM8LZLVwDFWP/S1M5CEdOcN8vLBhdBUbUnfBe0VS1pdTTkX5SFT9LFK4zC52wb/MRRR8psMdlysFJi5USGIK5b6Q11sf7X+A3capmWv7GJghL6jJbKQJihhjGbSIIgnHXLBONjnQFdu6/P7Fy59jT1uhLudf/9x9MvhqVPR+G6ejs6D/V6TroKKQsgxS+kcOfjOcTa8GCgh3YpwASRFKJval6lFw9fHxoMInsa97cwxGIglT5Rmu9Yb/mdeXrcLQP4xSMtuqpMHp/VCmFB/G8u4XxZT2N+3yBLElEW0a7YWgiNopaXBHEYhuHs448iAM2EMbOfcE/FMTnI5PY7wNPQ2127rZys8rfWNy00SW5ZUeSjBx3PR7SKsghAaTaL490FRfWbQ9p9xanE9tE3lNKiGlOBdySGs7LOaOBQR9a+KVIOJ/bkcFjqktN9URlF+ZrDCKfbT1N6F3vSiBJ4pEAfKifq8eZJ5oy9cI0ERc+cqsHZzaIYd+4Z3PK8kwM9klD0+hy7RD7ogi+/fA0A1abFKwhVG/i8clvXnKNfYRiQgQtoo3klgQekqzglJq5bAx2119G4hvX1oQ0IxIe5yLXVaE8cdTJCA/9UNhvF9kbLo8yujnh+neH5zsjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(261026121527099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261028144727099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vra7+I7GTn+leMSWx5L5xFEXoRy3VhtrvkKWSbZxjMd7g6EWlml3935J7u2MDKYYL44ZsMuqyPAdTjsjnDFqam27LU+hQ3VUNMte3iZhb+kYszvdGOIbN92lqXOqJPybjljP5hyVSLj7+oyEFK2XOxO3D0DQNv2vY01eeCzNERgqH+utgT+AX/QFDdvpg26SnW/h6twvqh2Sk8bK4eT9ni9smt+DD9W/2SL3TKdmHyiIeWg9htbPc+QUa+hvUXXEkLEV16lcU+40p3hcZCOf+ZVu1b+k9vbwj8o9Atmx5HjeUZYblRZaeM24l84pXPvYF0WVDPoYeoI7DHnMMi5ghro4+vYpvxoRsXfpcgUInEmFXnqOLUUKEPk6b2ILkAhRT+7LSrZwlX7yWvtTdRB2iQ6en7EU5zxNs1aSjLsyCi5M/W/LOC9baw/Hw+ctATXD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:12:02.7246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa61c27-02a5-46d4-b92c-08df4187b547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset.

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		return 0;
 
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+	     amdgpu_uniras_enabled(adev))
+		return 0;
+
 	if (amdgpu_ras_query_error_status(adev, &info) != 0)
 		drm_warn(adev_to_drm(adev), "RAS init query failure");
 
-- 
2.34.1

