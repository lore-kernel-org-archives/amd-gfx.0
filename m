Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E69C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8200C73D82;
	Mon,  6 Dec 2021 10:19:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4066E483
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl48Lt/X6WQxhExJv7n8AIdIjGGeq9LDkF9xNhxP3LP1zL8RTmBu2q8sEaVW9Nam092Wu1WbSyW9diSXtMryO0rytR9QiJh1duCVxNG9y7LJ4Kup0Zd0T1w8DTh1YYb/mmYLqlOkKYU4GOeGdnz3fu3AUwOKKIr9QtwQFvzO8IPv9pM/OKGNpRBp8WZND52tb+wHZGfysKBnCfab4SPiB3lJZxrLg9+Lk/Mxkb6cBRs7OCZZrcXDW2PNp4WB0qee4odvDxIr9/PbXnZaFyWcXAa5k5h4qgJICiGghDoonlCY1Qkv2IOZteXoP4howartXZbzOez1BzbO4ryS5QEcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zma3no4R3XZ8c8vi5iuOeuwoTo4/4JgJnzajuEwFKCY=;
 b=DhoM1/qB94dmVtBjVuWxIryZXor1f0kAZoJ+UuZNVXHqwd8sNiCUeqrIFKhJ9p2nLQAFC692SkMfMM+cnP2CoeSwP34+N5hWD2Jllgcj8jSgShzLNJwTHokWZ0Wwq/ZvzOIKLOW/szeMjcZxSCWXA7eTltV8YR2vKvcHGA+Yh2rjD8VjjyTbO+B3EhCjwZz2MDZzWWZo/UQtctyxpTMoQd8NYABmIkTphBIpT9zxmmHPdXYrkeMoV2wUVzcgMYkvc4NRgX2lOz0NGNApUwG0JRuaf9TkwgtquPKHSON1CiYnfkUxwzjvz17pSIvuH8zdei+nMPlwisNxXFj3DpqsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zma3no4R3XZ8c8vi5iuOeuwoTo4/4JgJnzajuEwFKCY=;
 b=2vYERB/N1+gaKzzDIl0LABVTthjgijnSwuW9LtZOcKNNxJ6xrRO8hAgbUXDB1d3jbpS0XwQceHmTND15n8jHFmBfX8sDxTTdi54GkiGa2yd2dEx5Py6tuQufX7CUyad7Tasd3ytfCNc/BvNgDse6GoUg8kILemgnvSFbM1DsHeU=
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sat, 4 Dec
 2021 10:39:22 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::77) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 10:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 10:39:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 04:39:20 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.17 via Frontend Transport; Sat, 4 Dec 2021 04:39:20 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: read and authenticate ip discovery binary
Date: Sat, 4 Dec 2021 18:39:17 +0800
Message-ID: <20211204103917.15237-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53567eec-d075-49fa-f2f7-08d9b7125567
X-MS-TrafficTypeDiagnostic: DM6PR12MB4927:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49272824D1581F6469AE4135FC6B9@DM6PR12MB4927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5gfBPDwYb7BnBkYlNc/vUoFkka641RTvhX3vmD9cENOouXIN9qsYvtRQiCXVuuVqPo4aFjZ1Th8fDkoJteuyn/m40gDuccslXLC7MGvlfSlSLzq+EM7ZYirISAClIXWLHHeTOFrVY5WdHzMSkqJh3CGx4NA/kHVKzht8SYFmZeuJgwr4wrK1TUch7oBhz57JFRJSk1Xr//hCHPi69txjYltKW5qhyZ63HiVq0fVajVc88aqmMhleF2nXDNOUr9FX2Dzeh0hGrqI+vw1qITWaepgknfws2Fud5FimrFLZcCp6OYQrvScQB08YP9zbNn1QUTVQhPcAP15JG0G/q4kuk6eC818mtJakuxLe3wAzghjLkYHPt34gDFXdLHHIKlxLvqn6L8oLViJhFIg+fyuqhOXia8K+fmDiYLFk9bZ99YEAMVgJtxMQtffC6RRI0TBINM4O5P6APJuZYw08P8ERb57r/wFZDKLwStxJNPwOKnT7XuBqxqa8+g33mwMAdSA9p+aBdqZ3z1LI9JO8UArx7EC+JfcGcQ3b109sAv9fXArqcA4dxZ5EawhBfXJkALkJb2dlgAxFJ9bBI3QfCu4TMHiMtiqoxE+DgAsyIhujq37Kd4SpIp4ORi7EUWPT9d8I4afuvyIM1QHYhdJsZJBz3l3hX7g7OFYcD9uJku4os3E/xkcBVT87w8K+mYPFX1xpm8i0oohqJWZFZ12yI7VOHR4WemmsaaT8fPHeBbB+Uj04IHMUrpMg0WZW6+yTK4GwAab92mbkvsTUg/Wd9+OG4+3nLFIf28JB8SZXnl6Ir4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(40460700001)(81166007)(356005)(70586007)(82310400004)(36756003)(7696005)(2906002)(83380400001)(316002)(47076005)(4326008)(186003)(2616005)(6916009)(36860700001)(426003)(336012)(1076003)(5660300002)(86362001)(8676002)(6666004)(70206006)(8936002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 10:39:21.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53567eec-d075-49fa-f2f7-08d9b7125567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

read and authenticate ip discovery binary getting from
vram first, if it is not valid, read and authenticate
the one getting from file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6064a2e3b0c4..039031c7a55f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -249,7 +249,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct gpu_info_header *ghdr;
-	const struct firmware *fw;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -260,31 +259,32 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	if (amdgpu_discovery == 2) {
-		r = request_firmware(&fw, "amdgpu/ip_discovery.bin", adev->dev);
-		if (r)
-			goto get_from_vram;
-		dev_info(adev->dev, "Using IP discovery from file\n");
-		memcpy((u8 *)adev->mman.discovery_bin, (u8 *)fw->data,
-		       adev->mman.discovery_tmr_size);
-		release_firmware(fw);
-	} else {
-get_from_vram:
-		r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+	r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+	if (r) {
+		dev_err(adev->dev, "failed to read ip discovery binary from vram\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
+		/* retry read ip discovery binary from file */
+		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
 		if (r) {
-			DRM_ERROR("failed to read ip discovery binary\n");
+			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
+			r = -EINVAL;
+			goto out;
+		}
+		/* check the ip discovery binary signature */
+		if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+			dev_warn(adev->dev, "get invalid ip discovery binary signature from file\n");
+			r = -EINVAL;
 			goto out;
 		}
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 
-	if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery binary signature\n");
-		r = -EINVAL;
-		goto out;
-	}
-
 	offset = offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
 	size = le16_to_cpu(bhdr->binary_size) - offset;
@@ -292,7 +292,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
-		DRM_ERROR("invalid ip discovery binary checksum\n");
+		dev_err(adev->dev, "invalid ip discovery binary checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -303,14 +303,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
 
 	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
-		DRM_ERROR("invalid ip discovery data table signature\n");
+		dev_err(adev->dev, "invalid ip discovery data table signature\n");
 		r = -EINVAL;
 		goto out;
 	}
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      le16_to_cpu(ihdr->size), checksum)) {
-		DRM_ERROR("invalid ip discovery data table checksum\n");
+		dev_err(adev->dev, "invalid ip discovery data table checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -322,7 +322,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 				              le32_to_cpu(ghdr->size), checksum)) {
-		DRM_ERROR("invalid gc data table checksum\n");
+		dev_err(adev->dev, "invalid gc data table checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
-- 
2.17.1

