Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D32C624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA8510EF0F;
	Tue,  1 Sep 2026 20:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2oRqwz27";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A5610EF0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olto3d4X5/GMCZ6+9jJ+RfOTHSp7Q8k43VTwEbyVVPRTedsklBCvGrri9dg3Kuqzv4IsqQhbhdUSYFfT0UNp2ISmc/lJYpV5yTaKJx2W5G+nMFDgIA4giQbXn++/7VC1qN2+KhS5fxYdQS27M+RfjX8dPEa43nqcN2GvIwqL7TRb/M/5eYl6GTlAH+VE4DccdaaUUVrE43q3hscxVSuA548/n9oUajK6OaOfuS5V8MwzV2lyWsj/PVloMiFVSt/uqwfUM+19yOLwq4nT9ngna3Q/8uGOF3ddhckcb3+imh3xJEhkkSc4n2UGyiYAFuDVfrIyKu+rbuC2z71MU2lJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2hUW4WHDU8VN/VTQKpeWc3Po1hJPDCU1KjgJIiFP9k=;
 b=ImYds3H3qvqFO669zr5srvvdmDyvO1fUBTxubBZgmFrHI8znJVu2NfmEDNGjOpx6xu9OZ8aSa2qffDMe2tfLnloGeUUNTacUQSxzjptVWkPCSVz61QqToXOgtAPe4VyVsKsAelBMpOFnBUoGhXaBKObDjEoNsgJCcnSFKEWyGic8ZNVNgOyz4Jn0PnBB1DGEswfthn5qP/Ff+9+GuaalozfgX4m8EME9OtYoyQsmWzRHiNE0QKH6fExKTvQSSkvmtt+VAF4QJoAl37HHT7l6XCIm+/putDmmccHqg46sV41NqSVPDnIIb6GbnM+Xb+4ls77Pe6lcZ6FL7KKz01wYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2hUW4WHDU8VN/VTQKpeWc3Po1hJPDCU1KjgJIiFP9k=;
 b=2oRqwz27ugGxXyOVYbkjBAY7mGSpZj2q20GhK76NDXuAh17kfXvdmDYy5qNQ+piWQ+7khSSSRu1WEDxelqhLddPPWB2KC56dljrDqgn5L9TkGpzZqD7wFO2mYDw4PKOZxkZhk4D/8E/saCvgiBb+RFcsifuBWwapi9PXz+gsiI4=
Received: from CH0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:610:cd::13)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:11 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::a9) by CH0PR03CA0098.outlook.office365.com
 (2603:10b6:610:cd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/31] drm/amdgpu/gmc12: use MES or SDMA for pasid TLB
 invalidation
Date: Tue, 1 Sep 2026 16:10:32 -0400
Message-ID: <20260901201034.2960437-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1138b4-3881-40a6-6e69-08df08652a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 2PmQcx3yCrgklhf72QrRwYayzqPewnYlrefu5jrK5cDUBs0oey1Ny9vY2E27PBjjjNgU7yZsIpjVAUHIxCwx95rk8bEaKw1XQi7CxKa5/4xgBKeHBwQrATRFWXp2NINL9b9GejPMi6U1icRebqMs1ND8pRN1u1pyEkXfnb+62OIm+78Nk765XCStMQhOWXVgepK3Ga1O+VqXM7llzB651L36TbT9kx6I7uTwmmFjvAPXYCREzgswAFRwkYedFB3dnJ94WNUhnCZaqXloEef44MziuF6TAxskWs7VxVyEj6NNvg0tCdg6oUE6AVO55zCL/2bKiKNJDe3zdaQr8J/fAp3/l6aNaXDTBpccAB6vuFURFied9Q1IS+/b1ksp87y5FKnrXx6D50fSnu4cy9+Y2x0b34DNJhbUpg9TgtnK3Yf5W6bi0zp7w1CdkY8TzVgbvS2AirR+Ajw0nCzoGIXlqoQCRhHMhNpUwk6m7UrONWu+/2KxTKAcpQUdd+b0sCg/9duYBhKt8DgrLvjg1a8T7m/1+BjbU9LPYs5ky93/C/Ls15JusxWaV40wSEDnMeKUUKwoZSEfM5X1Q3XQ96OTxL6uwe2Bbynp18HKa8tuNHUp9fO3sqUOZ3T8GHlyq1+vqV7HjRLbxTOAVMKcsCwAryTH1673Q5mSHJ2qis8xiAax0uEkxAm/eYj7r5oJoxdkh6giXaXUmCAOXn/xu2+w3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v5aFrKHSba4DJGXCSvE1viL0sI3EkOWqUOwXEg364d6Y4b8ADPxYXtpANQfoFj7eqiBOLsfViCW+aUyBux0D9k28KUIqmACWuGprgX2G3lGk2Z+gezqe05qSkTkhMCPjJx71jq1gzaPhmmo2fK2gZgCnWnhZIVHt7kF3wcJxJJWZVUKSor8inDscSVd0uajk2wT03BJHO3F471/IoOPvSGaDq6xUk3MJlqjQJU+g4ZUcKTqflSE4GByNKiJxf7+sH7z+fBBGfCL5EHmLpant+faJ8ImK5o08VC/4nUQvWjs1cCHSgWeXCPF+RfhVoU1LJE0DZ+3XrTjpulreqeEJEMP1z0V8qfGWn9Kk78EBTmNBFW+acyTSPLSQrMd5YnYWZvRNaRrIKWHZoN439rpB3Sx6DGxKYhJcjaxJEOoNB/MjuAqzBLTfV9Bi3JMAIVNy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:10.9123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1138b4-3881-40a6-6e69-08df08652a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

Use SDMA or MES rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.  Default to SDMA and
then use MES if the MES firmware supports it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 6ec5798494be1..67eb1b595abe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1061,6 +1061,7 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d3..dd68db14c43f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -2097,6 +2097,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c05..5eac7615efff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1962,6 +1962,10 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 }
 
-- 
2.55.0

