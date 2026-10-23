Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B60606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HSgF0w0D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64309112C6B;
	Fri, 23 Oct 2026 17:13:03 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D96210E4E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 12:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRTG/oQRGiFvSy8LEkyoLLPt3GZozQnvzBJQSzeL+nj8/BZxt1nuqTP7xb2ONAJWopCOwzN/X36mXG9z8iGE8r/aVcHvjMJfRM6AdLGnKf2pC+w1/3Q/IxHScTdZGIrwgmX3VZrQQ+SUzHBKRx2RXDz2ON1KYfeYRbQyhj7ZpNEbshLkqD2nAiOse6YdU0MbUQjrUsVMxIRQEHucPuZ6CaAHjeBt1yUaE3WmbBC+45d9kI2B907FYd46FVgnccmszVDZW2fvZt570rQMnDAp7Xeu5E9vA4LM/8N+Q4zdzHxKYEnp0nWlIifrUJaI0YAFO98KjW+H0mlNmcH/bIon+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgOnOM6qrwIpkTP+c3VbyLqarJ4GaFrg+fbTTazeZFE=;
 b=F/ir6RSX0rnrHG8WMGq6asO+7RpJZn1BHr5KQVce8m/CgEy2F5tTXtIysj0ZZ3/kB0qdrrlYBOOSyqwlJnHSuB6UiZzdMPOjDyqGDOWVFP1HpXJULCw7qd5bFGYUhvi95oqXGGzFXK4sipQixtvf1sPiFGuSh4pw9I/Yla2Jh0dMAduwM3r86nLcgFww4YPhgoOdyno6vES8K6b6sXpuhjrCEPEaJTNMujHZAZD5+LZqZUD7Em9uACVeW5QSk6u1CnrkmJ39Yqzc4lDuR6S2l2Il0Nm6tcX+isNd3OxufsJAOOlrCgXB5qZubxRqwsWn/4AHBw4eMlT4otwgnmCoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgOnOM6qrwIpkTP+c3VbyLqarJ4GaFrg+fbTTazeZFE=;
 b=HSgF0w0DhtumtSf9AjwB8Bf/UBmbLZ0q9EWYWYd0+8INHCxKt7wRwd76GvF6IXzk7AFqy8Ai2gVYj6/McRhDU6Q3sBecoyUU3NSfOOjlfRReiupnhR3JiULuBQ/JiSuwvc+lwFS6hN/1v/5m0wd+f/M8Z8YZPbAuwsZVZ0Xj2pk=
Received: from DM6PR02CA0135.namprd02.prod.outlook.com (2603:10b6:5:1b4::37)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 12:59:28 +0000
Received: from CH7PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::31) by DM6PR02CA0135.outlook.office365.com
 (2603:10b6:5:1b4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:59:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000015.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 12:59:28 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 07:59:26 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Advertise NPM sysfs dir for smu_v15_0_8
Date: Fri, 23 Oct 2026 20:59:07 +0800
Message-ID: <20261023125907.3229593-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261023125907.3229593-1-asad.kamal@amd.com>
References: <20261023125907.3229593-1-asad.kamal@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000015:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 35acc4e1-7680-426a-a17a-08df31057929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|18002099003|261021123027099003|261009223027099003|11063799006|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: tFFCHQ5G0PSDJJICgHc+4raWOxsCF7t8i+0bbp+71uCGJJDdwoYbQEBnbGHePDNTqmi4OvvhPw0MOAqKTcCqWkdlZUJkltbibDa/+miE4nQNYlvCkB6Ia8RF/WuQq3QAlGMhnpoL2fXrrFHE3g/n94oiTlbTjvGd3hIkBiF2tuuLU2/oACcs9XL5R0kKHeISr1MHVX5lTnytsRdARyAtZTOHi6EcfsFqEI9hQ5tzSJlReM4Q/UjMCv1iAujcWafY1coiq4/RaZzI0Eeq+7JX4oXhlSm2Da7t/Obpd33hGNMebI4+kXjFzlDSlq8n4SW05jdHWTFyDivmHHItZ3QGUT+wNTYswWCmEHnN8jNRP8xyGuRtroZ57e4bB/Ya6plWsfocrsw0i5pEPqbxw4uTn/SZH4L0x1cl8VySXvSyAffX05OtsszZI2UQMI0R/34vhOzYzrpoxRlNtRLnWOtv88MMS+CX7F6bKAhEe6Kd7jnHq39xKG10pYAysrzB8zyCl7aFL98nc9Df7z49dpkrgBzagYD3HspmzBxchv2O1S3f68tVXChJYp2k2kL4f/9b8WNFlLntdMVz5vJ2S7ip9Zr/hT2xO8SBfAN677XtV5uWIWiaFphKAQYoExvKFhjFMT6RL3zvSWpMQL0ENVxCat1dvmQ3hpjccbyLTMSvDlxu6/0HDVw8nwwtFe4QAihiGGPl1yN2KHWXRsZbD7cbsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(261021123027099003)(261009223027099003)(11063799006)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eQM5O57iE3UWfKjV39m0IW080ICE1KPdYXFhB8feaiE/+J5f0ai7QPh5GlmFkivxOcLFHnh5+tiLRXR35O6KmCOrp07q5KTZefV3E1RHks/GWgRmr0S9KIy/d9FXbTTDyhHYg/9flLTWYY9Ni6Uti5vKHIEOMOPeNllAPwqCPqO0B4VpyUWlFDV0ZBWWQd/1q6KKm/G2rW4BSqpLi8/OykZns9bfmiskzwniWCT6+Rz+mUoKj8ZKozV4MRr2mPWvBRMArkY4uhbo11k+RG4J930tLF6cGWg5g8PG2VmZuSY0Pl+zM3DICZpUJtnLPKPrg3GRNYe7Od6OGvKztrQ5fYWJOrYVgO1engdx8ruOebK/mOOU7pKqryFHFG+HZPTGTgp67j3auyzjl3A/MKXgEacqM40GiJIWNm3ShkeCitY/UrQJijmo5UebGviuJsX4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:59:28.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35acc4e1-7680-426a-a17a-08df31057929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

Set AMDGPU_NPM_FLAGS_DIR so smu_v15_0_8 NPM files are
created under board/npm/.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 82c2a379ba4b..ef6f0a0e3973 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -665,7 +665,8 @@ static u64 smu_v15_0_8_get_npm_cap(struct smu_context *smu)
 	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NODE_POWER)           |
 	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_GLOBAL_PPT_RESID)     |
 	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT) |
-	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NPM_STATUS);
+	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NPM_STATUS) |
+	       AMDGPU_NPM_FLAGS_DIR;
 }
 
 static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
-- 
2.46.0

