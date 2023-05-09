Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4A1C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E1A10E418;
	Tue,  9 May 2023 22:12:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B5710E422
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L21DF+vAQxFp7TJUasE2BrE9wV0tJeoEesxVzqI3Xv8qvY2QCG6HQY3lkDP66UsLZ7uAvhh7A5VHHBDzjkIpZZN3BA3gWkz1FtVYEdskjdEqsk6EeglaAkGQp+ex07k/PqySwtLOM7vy93zxhgJgD37QMEqwval0PIRIDPSkvaG5OKw1MDF3tT/IRbDeqNtSvNHy+CHPiZ9zLK174Hog+G+9MYYH9YYYuUJF/FbxydjFCN8fzsGIJoARV5xL657VUyxiXKtWV7Vf5chcNkD+pAZKCCbC2hefmtgCpjg52lyA86hSv63Md4HKQ8gtmS+V5XsDfadQqZ0MMK9q5I5NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w25I2lRTIBlql+f0h+ula2QXBm0kxOIJpzae6IhevaI=;
 b=TZLEvDPjwk/hr2YN84xDxj3klxiH/JsX8jQSbKeGVW0+L9BpIX1P5c8qlteEoBEUBky3doSmo4jleF5VST/4NvE463w2AT4XJ+7U62BbjD2myxPGc3j1rE6p8zlVmPVrt+NWFxwmAdZnJ5lLDR9LuVjdW0tPk2JS0Sr+HN5CVZrNaXILpSFo62UlWGCpSKnWk4YolEOHYjnp+mp0OhQRvrzgef7KPRZfrjFEx4siOnyW4drkzUadfzt9RUlu87jPWqFUnZ+rQWh1r8gT8NIUaEWzTp13Ih8WVTfe3PcW4fEgV6NTLBU1CnbIeCie7MiClT+l/ZNdm3z8yF3mD3Cp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w25I2lRTIBlql+f0h+ula2QXBm0kxOIJpzae6IhevaI=;
 b=pMBqV3nFb6BjhuGzwtJS+gXVc9t1bfHlVvFcSYh4TRv5e8qDQXCaOFqMBPulHOfCtPY3SaRA1GkXBrat81xD55UBhYkrtR4TLi7hL2zUXSilWfFopjkQnGIeNxaXa0MGCa56N3BAyHcIztFr24NV02/LEaNCidDy5ic/GgLVteM=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:12:44 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::93) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Simplify aquavanjram instance mapping
Date: Tue, 9 May 2023 18:12:26 -0400
Message-ID: <20230509221228.476412-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed34f07-7401-4a94-e96b-08db50da8371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWPJoPDpD1fpn+KcHPOZieApIUY30FWxAVjmkQjS2K+/PnYaNlYuGfIKB7axcZ7ZDMqx9p35Y5uNwCsjeWj17Z7hVM1ULR8HD29OIV38NEfU24MlTp5wiSiZoHTqccWiX8smpnOOnm8wVKwuyYrAqKsn5V71Gt66Qmx7TQT0RPZ+vr0EeRR9o0mvQ0+ket1sVXMhQUFlOo5ou4WOwa7KwVk8n4RquxFWIClQxoKgDp/AhaQdENGeKTk44AGiOqMGMzUwsRJakVJNScRWfxXvTp6CNCniWFgbomanjx32Uq/AGPqWp/n9JK15y8vkOGIniROEZP9C/8So9Xq7dYvu6NLT6EtY00NfvaqaSKePboJqtl4BhMe5Qmb85Ds/ywsKrr28Xkx0OWdeZB2nDHsgnt1zbf3F1d39F1ybaVDBBUgbJ12Ol4m/ueQ1b5kcuwIHKYlzBrFdYn87NZ3lZnKJcgF/+ZzKte5rYZceLwWoU4fVX2Fdf9jkCdQsaRgPCYfB4lgy3hVUeJCFeusv0RC4soC0fGuU141E1L5NXbe4KE+Dq9zg5RAzX9UrjbvbBApBnWwNsKbzG0wUhhkVF6NWY5gKwum0MGGpxx6mvELTi3edUCVXzAydBbMXLxXSihiK6Sf1145R2VpcLsAhN4jpvwnjKxCp8acblzkYGTHfD6Zcl075+u+tbpdS2ok5y6uWxN2hY7HzcYZhNr6OpNL2GzX4M1U9Pcwq6skXl81niSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(8936002)(8676002)(47076005)(83380400001)(336012)(36860700001)(186003)(2616005)(426003)(2906002)(16526019)(356005)(36756003)(81166007)(82740400003)(86362001)(82310400005)(1076003)(40480700001)(316002)(6916009)(4326008)(70206006)(70586007)(54906003)(478600001)(26005)(7696005)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:12:44.1117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed34f07-7401-4a94-e96b-08db50da8371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Simplify so as to use the same sequence to assign logical to physical
ids for all IPs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Tested-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 33 +++++--------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 51d3cb81e37a..68d732dd9ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -101,32 +101,15 @@ static void aqua_vanjaram_populate_ip_map(struct amdgpu_device *adev,
 
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 {
-	int xcc_mask, sdma_mask;
-	int l, i;
-
-	/* Map GC instances */
-	l = 0;
-	xcc_mask = adev->gfx.xcc_mask;
-	while (xcc_mask) {
-		i = ffs(xcc_mask) - 1;
-		adev->ip_map.dev_inst[GC_HWIP][l++] = i;
-		xcc_mask &= ~(1 << i);
-	}
-	for (; l < HWIP_MAX_INSTANCE; l++)
-		adev->ip_map.dev_inst[GC_HWIP][l] = -1;
-
-	l = 0;
-	sdma_mask = adev->sdma.sdma_mask;
-	while (sdma_mask) {
-		i = ffs(sdma_mask) - 1;
-		adev->ip_map.dev_inst[SDMA0_HWIP][l++] = i;
-		sdma_mask &= ~(1 << i);
-	}
-	for (; l < HWIP_MAX_INSTANCE; l++)
-		adev->ip_map.dev_inst[SDMA0_HWIP][l] = -1;
+	u32 ip_map[][2] = {
+		{ GC_HWIP, adev->gfx.xcc_mask },
+		{ SDMA0_HWIP, adev->sdma.sdma_mask },
+		{ VCN_HWIP, adev->vcn.inst_mask },
+	};
+	int i;
 
-	/* This covers both VCN and JPEG, JPEG is only alias of VCN */
-	aqua_vanjaram_populate_ip_map(adev, VCN_HWIP, adev->vcn.inst_mask);
+	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
+		aqua_vanjaram_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
 
 	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
 }
-- 
2.40.1

