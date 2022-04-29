Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE718C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684BE10F23E;
	Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0380910F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrTXPggvsHaUkEF3WYqOUfHRV7NxNAUWy0YwGIvaTbGLirFU2CjKyX6Q4lT1lgHSAkkImBrZhCF5aw1M0qyzwKd5GIkp88PNET1kC250vwLgDfn6PViVqquiye53z4/tACkrzgYvbeOiG8mVqzV59XJGBMRpJF82+wtC8eSMQ+l+QCwUkc/9bLkdn1lYCVegfwh8O+3fYPSyCed5evc7ICHXIZzl7SX9xpNrmgSig1tYqikU/F+mkBjbkkA0GrJ6clv8BRZbSCvH5/+bR9uPMv3GTNpX1A6ZH31ttv1vcwDuUaxB+dtUoKgMqwa8J2BxpKERO+ACz3d81+DriT9x3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL81BJv/z7QB28MpO9p4lfHzKm3RWrsRTYWSnedZneg=;
 b=Vrj2NnogiaXJXZ5HuV6t9XCbTbp6lmU9Fzd52z34iGXRc0x7Cb97St/PFaeQmdqG8bhp81TtiXIsT0ml+pGgTPRnIjGOZl1s86QysHXxh9T1wNy9vBLqMfspuuG2DjkDe148FD+u7/32sLodA5MQWjIsZQq3h8c+5XaqeipG18OmMMcjS2LXPhXKBbzwo/BHFJVmUMQP5JgV9xrXYyUMIHHhCP5RTmKS4KBikLc1t+j0BTjbYyL4DS3UV1eK1RZTdmImCzsdTtzdVs4bwv20PB6bYgWwWdhrFsyIUvhaFdiS59A1leTDSGJZJho1sPbVEDJOW4EQx4kDT10rzRrzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL81BJv/z7QB28MpO9p4lfHzKm3RWrsRTYWSnedZneg=;
 b=RTuFgSZgoM9yk/6xD2IQSNZsfNOwq6LIJB9VQF1B2SfbDzxQGqxF2itFA8NPM/4Hz27wFJcFkSjU2jTGXknFMLhQskkwEd/WowTEdabjpYWoHwyNasIA5uEp705jZAkSatpeRYtLcj9CTukucPKlKFBmB/u9ovxKOO+ZVHc1Big=
Received: from DM6PR12CA0026.namprd12.prod.outlook.com (2603:10b6:5:1c0::39)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 17:46:49 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::cc) by DM6PR12CA0026.outlook.office365.com
 (2603:10b6:5:1c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/73] drm/amdgpu: allocate doorbell index for mes kiq
Date: Fri, 29 Apr 2022 13:45:30 -0400
Message-ID: <20220429174624.459475-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63dc872a-4498-4b81-2268-08da2a083ca5
X-MS-TrafficTypeDiagnostic: DM4PR12MB6325:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6325E515DFD88CD2EC7223AEF7FC9@DM4PR12MB6325.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2x3yKIDOlE3ybPXw/VJ2quzZvAw1O2JnzEKpW5DQ4/zRFKFhQAuXkesfgz7wvies/derFrXxHnQ3nxn7sahknfHSV8oqaspBDM+m94miWCwz190r+Xy0nbXQqPrX9WUy9/3UJ05KSJWI4rhboFwSKsXGnqcbin7U6YfjjcNXE9jcqk/dALcXAxRfALtYKBor8Ac1sRVqNi0M6ZDH5h34PFOtVRCTb9bvWxyve6wAhytjPjuBZbitLplNazHIHoDRNkM4xZs08IeRK9tm01QvxOTVALQdz/bGu6Oyfobi5UFohkVCVPfA7CTUKcGLHBQeikRgS/GYe8PUKhEj+MUaVAMEQLyiXhWUmkuVwrX3Z8BE+xuE5FvV+pxqllUcWZak/F7XXxaS64etRNlM30fRXIa8TFYvwxKmKy7GxRaHUZhAF6ZssXX2JAR0WU1squPGUaiQzu7X6R9GYWzYrT4cUDOBmtDZ88K3d7oK52sU4BWvRYDHwW8YXt1orsG79KlIUuDolVJnTd9u4v/huvD/gVSoaKP+96wYXPPuB9vJx5R50xTkhJD3jH02hbwtc2YPKFCBKO9PCOsHeDzkd4wi/2MSf1eePD8/mp9Nm+fmNCs0OsZL46dkQcUmAZInIVf9fHFtIL1FCrsLTn2nMth9z2UHwZjC0pM1qZ+QSze2y3xiM2kjJgXaeuYBQ18vUPNY7IqRgLJgJaV42OFLJVbEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(4326008)(70206006)(8676002)(70586007)(5660300002)(508600001)(8936002)(54906003)(6916009)(336012)(82310400005)(36756003)(2906002)(83380400001)(86362001)(36860700001)(26005)(7696005)(6666004)(40460700003)(1076003)(2616005)(16526019)(356005)(81166007)(426003)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:49.0969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dc872a-4498-4b81-2268-08da2a083ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Allocate a doorbell index for mes kiq queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/nv.c              | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c           | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 89e6ad30396f..2d9485e67125 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -53,7 +53,8 @@ struct amdgpu_doorbell_index {
 	uint32_t gfx_ring0;
 	uint32_t gfx_ring1;
 	uint32_t sdma_engine[8];
-	uint32_t mes_ring;
+	uint32_t mes_ring0;
+	uint32_t mes_ring1;
 	uint32_t ih;
 	union {
 		struct {
@@ -178,7 +179,8 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
 	AMDGPU_NAVI10_DOORBELL_USERQUEUE_END		= 0x08A,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING0		= 0x08B,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING1		= 0x08C,
-	AMDGPU_NAVI10_DOORBELL_MES_RING		        = 0x090,
+	AMDGPU_NAVI10_DOORBELL_MES_RING0	        = 0x090,
+	AMDGPU_NAVI10_DOORBELL_MES_RING1		= 0x091,
 	/* SDMA:256~335*/
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0		= 0x100,
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1		= 0x10A,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0a7946c59a42..8cf1a7f8a632 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -607,7 +607,8 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_NAVI10_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.gfx_ring0 = AMDGPU_NAVI10_DOORBELL_GFX_RING0;
 	adev->doorbell_index.gfx_ring1 = AMDGPU_NAVI10_DOORBELL_GFX_RING1;
-	adev->doorbell_index.mes_ring = AMDGPU_NAVI10_DOORBELL_MES_RING;
+	adev->doorbell_index.mes_ring0 = AMDGPU_NAVI10_DOORBELL_MES_RING0;
+	adev->doorbell_index.mes_ring1 = AMDGPU_NAVI10_DOORBELL_MES_RING1;
 	adev->doorbell_index.sdma_engine[0] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0;
 	adev->doorbell_index.sdma_engine[1] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1;
 	adev->doorbell_index.sdma_engine[2] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE2;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c3069f5e299a..68985a59a6a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -409,7 +409,8 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_NAVI10_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.gfx_ring0 = AMDGPU_NAVI10_DOORBELL_GFX_RING0;
 	adev->doorbell_index.gfx_ring1 = AMDGPU_NAVI10_DOORBELL_GFX_RING1;
-	adev->doorbell_index.mes_ring = AMDGPU_NAVI10_DOORBELL_MES_RING;
+	adev->doorbell_index.mes_ring0 = AMDGPU_NAVI10_DOORBELL_MES_RING0;
+	adev->doorbell_index.mes_ring1 = AMDGPU_NAVI10_DOORBELL_MES_RING1;
 	adev->doorbell_index.sdma_engine[0] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0;
 	adev->doorbell_index.sdma_engine[1] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1;
 	adev->doorbell_index.ih = AMDGPU_NAVI10_DOORBELL_IH;
-- 
2.35.1

