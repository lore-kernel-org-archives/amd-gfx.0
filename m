Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E1C43461
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AE1610E7
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AE1610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917A16EE08;
	Fri,  2 Apr 2021 06:43:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C059F6EE08
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFtCqcpHh6i53mudjf0DCMn/hPZXJFSO8cfXU3R3XiVVY7K6OObP6mG+v61sy4Cdl8ZY/UOBmOqKqT8q3ooHqf08PD9YQ22BQzkUj/xICfyOd06CQb0GyDeVSSJ6V2XdZr1a7vCfC4zJMvcCiJvc6yjLBBPNNgpQkKborJ0y+7gtrRDHdFLxxrNqO76lLMElOzilaJ4LY//Xx2QwMYaRcSKQvbYkhJIwd6vTIztfI/2sHvD8cjvmAmsu9nP/9k/evcY8YrO0VTKgMlkDZgj6xUFqc6ZQDgpmc3tocuEFahZPtazGkhiSwVMBgNiYSCNNVQMgWeQxY8cGvuCwcTdXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmpluSBk5cJY7HUSq7TTg4ZhKTvLO1YsI3wcuJ9AshM=;
 b=SxZmyu9msnsF1vpWbPQs3fqyAjxT8TnsR4kAL/XKDeV9lWG4pgWN1zV01/BMfkHatUNIDAgJtT0Caq6DVJBLhlEJOIky16Pr78yrstTkDGgRDozy19eL/2xFcDGpUsBBBwjOvsr2ZdYgf58Kv+e68QqOmRPbAyx0dM2knHVk1f4UbRO6sMchPR4G3YURnrLJugvuqrLSEiQvqSjAgTn74crTwnj7o72OpamScFIFDb7zi552TKGpryUvgQHbi8PINZ7YhUxdbzE3RL1fmiDcVepbH+GgU8csh0/ZJs/s9lcvG1+ZUbLbExdlS2xg7Df/SCzI5e+2G49AxbZZs0nS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmpluSBk5cJY7HUSq7TTg4ZhKTvLO1YsI3wcuJ9AshM=;
 b=D3Zz1oBAHlKNJHpJ+dOJa5n9jo/373g478eNx1sU7cPiVgAPFGgWXU/MUcq+j/ENasbgIG5Sdmx5bFPMCU0skGSmVAOZaRfGEpykibw0L3vptJGLZC4mAFQUceyJKRk/Vx9H3QjiKR83MF15KmHI0ij90NWRsgTq+akYyDtx9RI=
Received: from DS7PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:3bb::25)
 by BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 2 Apr
 2021 06:43:53 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::b3) by DS7PR03CA0080.outlook.office365.com
 (2603:10b6:5:3bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Fri, 2 Apr 2021 06:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:43:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:43:52 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:43:50 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: initialze ras caps per paltform config
Date: Fri, 2 Apr 2021 14:43:35 +0800
Message-ID: <20210402064345.14093-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8fb8496-fc30-4c14-28e9-08d8f5a2ae40
X-MS-TrafficTypeDiagnostic: BN8PR12MB3124:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3124CDD8E529369201448FEBFC7A9@BN8PR12MB3124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjq0uTLKeY5+4mW8bx7152hpNuLAXLXdo7lcOsPH2ZRLblFJMKqvh5hgCfnG9H9SkNr1Vd96pJQS5VGfv8iwd1PP7oj4ja24pWjDtmVkDSuPllBmjfBnVZ90NOABBZq2U7qWOd99JwSEZKFoLPj5e3XFGA1aX7n76pQMv0l9yMvIrWQ57mAIRdTNehN39OASPCkPgVBjV9Ysb4/qCJ4Lhp5nDDD19okp64EEozr3quXO9EMhapfZybNMa9M/wXlbIv8/CVYJ1PB8yeraNKZzi7/H/FrE7zMR1QAmzD97soMksajzkJEnlpBwzWKXQgzNREwIl4GDk9pcnh7QBzRHr0/5BX6RwHB4Ao+6diP0F2sWCZzpDqL3mRVZKvZJp538yNeykrrfQasjjWTIvf/AIytj4UXFQks/nzOvfd6GhT+fRT3wQHazkBUmUDjY6pBXWnT9WrlYNWTpu5XMXF8oAVj8aRpYnkCc5JRiXDSjG/lrQbFQ0DEsfeVQZv19Y2a4mBqSQCFEjKxdHxJ6BhXH5H8rwEnIPagnZew2CeGfFr6ypmT6gqr7OuFcFlg8037vmaSBIl4H65uRbz0dd00VfbBegsU9U2q0XwuGm/c76xgjdPvTTQ991AyTqd3zAxUQNvUpWhZSuJc8JWAnESlX/VrOrkAVV720yGgOxfdkwYltlUhFgHJqajyy+y+ZWxpV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(110136005)(316002)(83380400001)(5660300002)(26005)(82740400003)(7696005)(8676002)(2906002)(6636002)(6666004)(8936002)(82310400003)(86362001)(70206006)(426003)(47076005)(70586007)(186003)(36756003)(356005)(336012)(4326008)(36860700001)(2616005)(81166007)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:43:52.8973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fb8496-fc30-4c14-28e9-08d8f5a2ae40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3124
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver only manages GFX/SDMA/MMHUB RAS in platforms
that gpu node is connected to cpu through XGMI, other
than that, it queries VBIOS for RAS capabilities.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 26458946145c..1708045e2a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1936,6 +1936,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 	return adev->asic_type == CHIP_VEGA10 ||
 		adev->asic_type == CHIP_VEGA20 ||
 		adev->asic_type == CHIP_ARCTURUS ||
+		adev->asic_type == CHIP_ALDEBARAN ||
 		adev->asic_type == CHIP_SIENNA_CICHLID;
 }
 
@@ -1958,19 +1959,29 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	    !amdgpu_ras_asic_supported(adev))
 		return;
 
-	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-		dev_info(adev->dev, "MEM ECC is active.\n");
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
-				1 << AMDGPU_RAS_BLOCK__DF);
-	} else
-		dev_info(adev->dev, "MEM ECC is not presented.\n");
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+			dev_info(adev->dev, "MEM ECC is active.\n");
+			*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		} else {
+			dev_info(adev->dev, "MEM ECC is not presented.\n");
+		}
 
-	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
-		dev_info(adev->dev, "SRAM ECC is active.\n");
-		*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
-				1 << AMDGPU_RAS_BLOCK__DF);
-	} else
-		dev_info(adev->dev, "SRAM ECC is not presented.\n");
+		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			dev_info(adev->dev, "SRAM ECC is active.\n");
+			*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		} else {
+			dev_info(adev->dev, "SRAM ECC is not presented.\n");
+		}
+	} else {
+		/* driver only manages a few IP blocks RAS feature
+		 * when GPU is connected cpu through XGMI */
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
+				1 << AMDGPU_RAS_BLOCK__SDMA |
+				1 << AMDGPU_RAS_BLOCK__MMHUB);
+	}
 
 	/* hw_supported needs to be aligned with RAS block mask. */
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
