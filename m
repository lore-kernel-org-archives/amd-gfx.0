Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69474C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0213010E629;
	Fri, 21 Aug 2026 16:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wgh0rDcI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A75010E629
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h48Cw5+7CdBmVpyZAIZCe4mDrfoX5PN0S+z3lI74ng1T5wdfTN2qGUxu+avss+OQ+oAAEVHXv4bw4mQp1Stuh0nwFluoZWhXsyTXVpxXxMam7W6AJzaMEGlBi6OCPJ/CvQtXkt4313SC+WpF22G+IblmB3oI0dWjiIIv6F6kqvWwXaZffFWLoUtQrsiRxkrD5Xa8ZfqXOE+bmbFlAsKQa5emWuEne2ZaKLcgf0A0n90usY6XS8BpRJ+Ok1u8VDR1Kq7L2uHrf3AWdcpSlpowiHST1xKog6jBoMZSfC1UCHhnx4YxSbjSfSJUw34e54ofWZsI8+EDHPExx70ZzUfHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FypxYUTZeVnZCUA/dp7hxc7OIeQDM5intjDiAxfb3Q=;
 b=hHlRpsbKn+wv8FNoiXvtpkUawnbyCgxTpn0psmUdc5s6H6TnIhX43K2sOTGt1klZchBaxaVIhcGkZp52NSTvjxdsmpxLiVj1lluQIvbBNZlFiTL8577ZNo59NlACaMuA5hN3uttOfR0mAhYpqGcPFSfkES01JqBm6tVM0u4+7mk714i1bPgH8NKp2QAnPEjRjmZff+ecr9zKttX0V4n2KE8arb1HCazv00qrCZFsk8Oaht90fSKHqae62m18o0Rb0ptiemIS20lUv4RqjrIoEmXQFEEQnWPhLy/44P1XjXNyXgd6/rAjwXDA71Evq8VSNLbDt9RtkOweY4rvEb87uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FypxYUTZeVnZCUA/dp7hxc7OIeQDM5intjDiAxfb3Q=;
 b=Wgh0rDcITYgTwxK4mAksG0om1mjbZRjdkVs4tPEXLKdPzCLptf00yODO4Slhq1ktDAnBlxq5sXNU4F99CGnXliHcv+jjVr9XeDp2knacDQ19EYteCX+ymvvEjZj9U1nrgAn+ixe7O3HMFH2R8JkpTW5qQV7X7IdPM5Zp7resrOo=
Received: from SJ2P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::8)
 by IA5PR12MB999323.namprd12.prod.outlook.com (2603:10b6:208:605::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:39:46 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::7f) by SJ2P221CA0013.outlook.office365.com
 (2603:10b6:a03:5db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:39:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:39:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Jinzhou Su <jinzhou.su@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: correct mcm_addr_lut value for gc v12_1
Date: Fri, 21 Aug 2026 12:39:01 -0400
Message-ID: <20260821163901.781602-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821163901.781602-1-alexander.deucher@amd.com>
References: <20260821163901.781602-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA5PR12MB999323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1131675b-f29a-4d68-f001-08deffa2cef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ofMDOC3VwJXKDYaQ5ugc4V8MGXrRXhdnEzV+KxDkgVHcxT46W78GoErrniJqJew1hEPtmWRlxoqhyPsHEt/3tujOZVvtnRJNL5w+0MMjH0RY1Gj4qFAdnwPmT7WMinwkvCrOlNCQoIyzeZOjML/35D60aru+lMxEtWnK4pjuuHWMs4jcw88aJHuJQBVB1ljWc37//xJ0Q7DrYuy0GNMHxqcFgvG2mHeRCQ6Ax4ObFQuXav0e+Di2EwzJWZMcVgzq2vFo9yikIUr5FYL1Doa67vqRtSBOWRb9H3lTA7JcFmplFyBo13XgAQwoGBLROJB16NVGLlEVgpBtgX+a9ljuGIg/qvz7xo6Obw9LKarVIkX4gsbbi95ZTSc90Tti/v47kbeORnk10ZbNBPV8hGgr/+K2wAylS8cuT1dm8cjaeYpHPocUjmA+EeQvaRwOvjyq+ZOTErAnb3ZM/NGQ3iiWNaF4e46idB8MkgQZ8tNUS6xb2K5U8UfdJUKR26kXq9yVwbzfgHP7EkmPBOWKU/EWgOd/PPkSjLUOPca89QDEiljkI/yKgb1iY4s+UrUs91wI0thrW79aUkdNLEyCgbQb6zErlg3sMaL4STS381/A9WzxSNWInZ7sdieDY7KrObr1F2lUdIFFxmUB7jYE63RoEDK/Lq3CWi2ejrXMlL+QwzNtgxT46guO7CVPKErEjWvgtNm3dx13l1R3fjxdKKj30g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3LoFTFhaOcz4WJRVV2YkSthsicXyUcOPZ3RUteRNvm6MpXOmDMBl2V3Amu82ny1rwh8/WdfW42/6lXRKOTP8c5ZcWD4MXINxGEq782NLFLs/jFJxDtUT3Fljq2BIQU1Jd3PhNl31cUFKW5duKJluVnTmZneciQakT36kLEqhhO4B30enUwCLGo7F1pSqPOcIHqU26YTbwcS8FMCZcC2tgbF/nC/0RUdL1L7GI3L+eiWDXhWCnphSY/+4WkKVRM9Omornt74w7fJeCyDILH6KNDFs8Z7O/S5SSni3dzrOjWwSCyDsg1po1vUmMZmT8lsLITCC1KDeA8ZQng3sVOyxDhOTNkRa6P+wa14X7YvqtwshfnePZRuIWIONFzK8Pq2UmGgtjg+irfuLW9ftLMB5CRqctYgqS+v35hX1mevDQ17h+Lzbg2+ohE0s/heqqjsm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:39:44.9182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1131675b-f29a-4d68-f001-08deffa2cef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999323
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

From: Likun Gao <Likun.Gao@amd.com>

Correct GFX_IMU_MCM_ADDR_LUT_PF register value to suit
for xcc harvest situation.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jinzhou Su <jinzhou.su@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index ce5c53202b34e..8589419f14bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -218,16 +218,20 @@ static void imu_v12_1_init_mcm_addr_lut(struct amdgpu_device *adev)
 	 * XCD6:: Bits-[27:24] AID-10 XCD-10
 	 * XCD7:: Bits-[31:28] AID-10 XCD-11
 	 */
-	int data = 0xba987654;
-	int i, num_xcc, partition_num, encode_data;
+	int data, encode_data;
+	int i, j, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
-		partition_num = GET_INST(GC, i) / adev->gfx.num_xcc_per_xcp;
-		encode_data = (data >> (partition_num * adev->gfx.num_xcc_per_xcp * 4)) &
-			      GENMASK(adev->gfx.num_xcc_per_xcp * 4 - 1, 0);
-		WREG32_SOC15(GC, GET_INST(GC, i),
-			     regGFX_IMU_MCM_ADDR_LUT_PF, encode_data);
+	for (i = 0; i < (num_xcc / adev->gfx.num_xcc_per_xcp); i++) {
+		encode_data = 0;
+		for (j = 0; j < adev->gfx.num_xcc_per_xcp; j++) {
+			data = ((GET_INST(GC, i * adev->gfx.num_xcc_per_xcp + j) / 4 + 1) << 2) |
+			        (GET_INST(GC, i * adev->gfx.num_xcc_per_xcp + j) % 4);
+			encode_data |= data << (j * 4);
+		}
+		for (j = 0; j < adev->gfx.num_xcc_per_xcp; j++)
+			WREG32_SOC15(GC, GET_INST(GC, i * adev->gfx.num_xcc_per_xcp + j),
+					regGFX_IMU_MCM_ADDR_LUT_PF, encode_data);
 	}
 }
 
-- 
2.55.0

