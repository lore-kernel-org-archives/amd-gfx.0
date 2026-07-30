Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2953DC55160
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF15210EFF2;
	Thu, 30 Jul 2026 17:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aJFvLK9o";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43D010EFF5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngOBXlJHCfMsdrECChGlmklKw4TQRQ6R+JRpspVIAJ+LMsfRm3+v+YBkU4lVxTOSoDef9H1A9biVkj/EeNfMJsdJ1tBZron8GM8p4tKfYhs3RjwVUNrDzis1QUZ89QB+RcjC6wgJbjJXpH+84P0nk52Tooy0Honnnti67NUcScZRFsuaqujTCDz67//rT5JjRQY2j/ERenOtFqTLnEJciWz3Fl/zCEml4Cy13yQ2dYEwGnFpLhu7PW20ByazHFShYYoVaeKy+A26Tocsb3Dyj5SR+LfNreSC5j0zUw5IQP4VmzbKqkv4N0O/dN0ziP0Ae05uew00u9sw3ulRyZ7f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmZyhqtN8kcQR820fvGmSnK1LIybxyG4pUcVXZAaqfU=;
 b=oNu/I6li7PBXfXbpiwjajpjo29zR5ZpXZFTOfuUfZswc2sSpGe8Fu9S00nbYgjtKz5imqtk8jE8DyS8RYdAIpWLb7naaDJBe1qnBMNmgyrXprvZNXZDGjVNqi2D7QE+QOkl6hpnYYp3zOj/JcuF+CjfFA6oVf5TnL426pBy2eTnQzQvQbSJqOVt1C5c7UQTvrlfAuL0tS/XEkiHiMuWLxZK3m47wHNe/B3RnX81PBbifTnzESUp0sKzoiBWdfyAKreV4OmTG5R+KW6afz3+i901urC3fjF5FEiouhYrXbeM4CaJQt6SOS9s5mKBHfN4O6/V4u9Bmdg6Rl+LX3fTpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmZyhqtN8kcQR820fvGmSnK1LIybxyG4pUcVXZAaqfU=;
 b=aJFvLK9ocg5zByZYwYOmYABe1DWSF5VOKaaAX25FcDBi5aoonUXaEj1Z+8RjNu08SzW0ipTK+w2jeIIi2GLScRcx+SvsI3L6jTnwwrWSoYKk4eHJftOjC6NytppAPaCc3aiR6k7Y3q/49CpyA/1Yax1PJk/ITOz5/gitwo2zH6o=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by EAYPR12MB999133.namprd12.prod.outlook.com (2603:10b6:303:2c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:02:58 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::82) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 17:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:02:57 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:02:56 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Fix UVD dpb min size calculation for H264
Date: Thu, 30 Jul 2026 19:02:29 +0200
Message-ID: <20260730170230.11930-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730170230.11930-2-david.rosca@amd.com>
References: <20260730170230.11930-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|EAYPR12MB999133:EE_
X-MS-Office365-Filtering-Correlation-Id: 998f7f4a-099d-4085-8644-08deee5c67a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: KSHNW+nrFIFz3dWNYkgISG/I7U+dkUeVo75WvzGjJfj0ix/GVYlGtsvPzSmXOpSUPMe79tapH5XaPI0Ym5zr+D/jEOSkLgd1126VPN+QRcZu8uOBOXma1EQuSBIJ7CMwVPJ6NbH1GGVicshJorf6Htd5w9tz+YeDuc8oDWAgMaslzDErftSRRBq00y/eqDtD50DfD7c7gzG7TSUSy/1rywC4nUldsPkqxq5ljuDO6TNp3ImTN06rBwhbvS1cgkjGTnTkjhgHUL617NcWt5yyAWsKByhBHrqbcz3jXL34foize6eHJM4X6cYlGsvgcVRTqWkrWEZJEi2jUmzGN8B2z5/gtaacg/wqspE9aQmKk1/FafbVMLgEN11GpX/ibYtuRTxFSqzwZTY4k76w5dKWMRQirb2V8lXA6u2jnM42MHX8D5B5tHi5yt19+gZbSF71wXwiSzD/XqWel0I9ZjE+e/KpAyy+3PbIIvkMazt85q5y+D4y96YVDKoWfVPxeZnWeqKv/XbrFhoGQgpFQdUomIILnSXJ4CqBbaxQEUV/CvZ9XpAesxzXW3YcO/ngcMl/JkIRognd4shJe3EddLbx024O0jaCYrI/nepYB2Oj/v4UqeQ6f3HXhdKYFxvK1k9a7PVck+TqWn/l2ibRbtn2nMO3n1QKm48T5Z6vzMJQA5pJ441Aea6eBKYghQjsG9wGPn8Og6623wLMfPyo8Appaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sV61Pvn8gbrHxQQGF3+A383T6vv2c2/sxxM8eTaTlN3HMhpuCJkV7B7GCs/AztpS/Zpant8vmVFJppRUkIguPtjcXcsbi0hIuV3SmAhbh7iCpa/P8qmOj7VqysPeh0G95W6xIn5D2HYjPf8JPBz+lSxyp9Pgc2djarN3u/ROXyR/xpTkcDN+kjUUBB2poDgpD35PBxVGHZjL+6uz3l0Ba5JkGkDzAG5EbErhJDGoWH077/Lh0qweedMzUWVcGS2gd5Uoy0/Zz1GS0tJt+UYE4fpYvaosmBY9MP/V+NUPE5jJ6f05F4psHr8rTaFm1+8BGiq2JY+xaeRSIbWyBhqTGdkya+x1Af7BE/jPn2Cn96EPn+05EvZYxxSJhadJ9kkCT7pMhgygWyOIp/+lv99yixg3fuwVxdugZYYvWsFseWCOvZ6thBrFLp7mN2T8Ww6i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:02:57.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998f7f4a-099d-4085-8644-08deee5c67a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999133
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

This should use actual number of references from the decode
message, instead of maximum derived from level.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 62 ++-----------------------
 1 file changed, 4 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 63561d1d7963..fa899e321f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -646,11 +646,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int height = msg[7];
 	unsigned int dpb_size = msg[9];
 	unsigned int pitch = msg[28];
-	unsigned int level = msg[57];
 
 	unsigned int width_in_mb = width / 16;
 	unsigned int height_in_mb = ALIGN(height / 16, 2);
-	unsigned int fs_in_mb = width_in_mb * height_in_mb;
 
 	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned int min_ctx_size = ~0;
@@ -669,35 +667,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 
 	switch (stream_type) {
 	case 0: /* H264 */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
+		num_dpb_buffer = ((msg[61] >> 16) & 0xff) + 1;
 		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
+			return -EINVAL;
 
 		/* reference picture buffer */
 		min_dpb_size = image_size * num_dpb_buffer;
@@ -747,35 +719,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		break;
 
 	case 7: /* H264 Perf */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
+		num_dpb_buffer = ((msg[61] >> 16) & 0xff) + 1;
 		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
+			return -EINVAL;
 
 		/* reference picture buffer */
 		min_dpb_size = image_size * num_dpb_buffer;
-- 
2.43.0

