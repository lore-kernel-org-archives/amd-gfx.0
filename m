Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B2610F894;
	Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3DA710F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke8UVGFdYuIiJSGqRz/zqmIeThFxlA0sXTL/cPfbScb26Q5n0ElOc7i5G3hcBJarMit5o/OhSoouTaHnRanQEQ91GKhQu0rNSpmQiNEUQVvXc+GhGE1sMejNTPbve7/clmBEPLc/sC870bxbKKQnFFIkhtyCtnoMQI35ICvOZl3/0xRwjv6cftsGlfBcOcYd+3ckXzHgP1BT+01jN/AAxvg6/vlPxn8JgnROSUkEvPCmws8fMeEib0piry669GP7FNEGVzYTaVVOxDYQieugJSZfS3/6jpg+3DxYJ1qAEuQkzCaPjYsvn5dU5T1tbuck52swUN4vgO5CRqV+fHLkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2OvUPPykbgbmujKOdOBf6zExHMcqPh8Hbk/AQv21As=;
 b=b4FGUDL80SIjjuR3xy78nAsnhrM1e2YmftIgiBHkoqQjjC/JHeKkVGq4qej/Ed0LVTopDcqzfcUBPqMcvTxjdWnZm76wcBzmhnWpMAdP6CDhr8nqqDO2XI/A1sIZ7X5S9F1B16xucefjBiEBiTU5MKdqJPYXXOvNMWXBSuHJizv/Cs7xFBAF7JG4rxSjJmOcXZhErb/nlpcEgUSkAmi3gpuy4DUfD6Ouwfylb6liapJ6C3EbihiLtjQL3/Z9L6yrrXDPLv75K+muN1UKTwDjxhsvH0r4Zp7MBBhsT/q1NnWmhI6LS21NZiUu852EacIRacDyif2PLPP7Q9l06pnxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2OvUPPykbgbmujKOdOBf6zExHMcqPh8Hbk/AQv21As=;
 b=Ty7/ic7ZBEAauP9m/AtuU0/Tp3r693pIFih5EU+1l7TGGZ6yEtYIlulCzXkn0A2YhoAPlFDGm8VZGjktwPnAKouR+LIufSV5TZyrlBb5eau++9WqoPCgw9i6ZNK13QuEfPF2RHGvMLID53owJDdR3ecpbhWTED/uxAPMFxf4BZw=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by MWHPR12MB1614.namprd12.prod.outlook.com (2603:10b6:301:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:47 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::74) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/29] drm/amdgpu: correct cp doorbell range
Date: Fri, 29 Apr 2022 14:02:08 -0400
Message-ID: <20220429180226.536084-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9b4fcd-92ae-4f8b-6f14-08da2a0a7788
X-MS-TrafficTypeDiagnostic: MWHPR12MB1614:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16143C3A5A642F8E8FDE6A19F7FC9@MWHPR12MB1614.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Deux4oGVV6WkjU1nCYMImTdXi7AhkZ3Jc17Abrg0cKH/hOpZ3sYLGLSvzi/L7Kitf4lpqRpSqCWHjxoGlqwqY4Y74zplDgIJDeBzaMhFiG9CD21R1uHuxj/2XPuUHbiiUVKFF9DeQEI9g89LZSTmsFOVKF8jI1ipKgQi4bKkfTv3AGm2LGLN0RxznVSm7MGiDJ2nNk/Pj6+d0tq9qUwEhdYFQN9wZbffcbqsFhugL7Cr79sk+MR/SHeZf4r9i9AzvtawmzcgthOseV6i2GY/VRzHcLzbIm5AYYHA9ZVDOfgfuqBgZHZC7NnUwDVdgmZeZeYPZYrgH35laA0V5cecCFUUDSJzkFXVWImnRYsKNQT+FM4X7Uo2ne8r/X66K32xuq97b4oJ0fKuCD15U9bvFuIZslc7QcxA8YE5Q4r9GCQ4WY6vmefIbiPXa9ombhZllPTgnM349TNVv7UacrfAyMfTvkLnKUY+bbkaLAB47qXkdc7kKM7w2lN4NRIManil/UJVEMTBBpKVvqN7YgSTimXt/R7tQ6WExZhEEuFW081apoa32lGIuPHSDMdnxiy/2RTXy77xpdWOJ/OaMnzM5WFuYVxgG5fnJhW6rYRggTdo8Wf6biFUXmRkWpDQyfDl5iHhvb/flOJ7l3E9KEfmY8SJR9RLwFQtaCyBZCOTwn0Ax1xR2D2rKezdyHwTE/5x4ZiepFCQQOxmoE0yr3NdUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(2906002)(7696005)(426003)(5660300002)(1076003)(16526019)(8936002)(2616005)(36860700001)(186003)(36756003)(82310400005)(83380400001)(26005)(6666004)(47076005)(4326008)(316002)(54906003)(6916009)(70206006)(40460700003)(8676002)(70586007)(86362001)(356005)(81166007)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:46.8097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9b4fcd-92ae-4f8b-6f14-08da2a0a7788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1614
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
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

1. move MES doorbell inside the mec doorbell range,
   for mes belongs to mec block
2. setting the correct gfx/mec doorbell range, so that
   fw can correctly detect gfx/compute work load to enter/exit
   power saving state.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Tested-and-acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/nv.c              |  4 ++++
 drivers/gpu/drm/amd/amdgpu/soc21.c           |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 2d9485e67125..7199b6b0be81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -52,6 +52,8 @@ struct amdgpu_doorbell_index {
 	uint32_t userqueue_end;
 	uint32_t gfx_ring0;
 	uint32_t gfx_ring1;
+	uint32_t gfx_userqueue_start;
+	uint32_t gfx_userqueue_end;
 	uint32_t sdma_engine[8];
 	uint32_t mes_ring0;
 	uint32_t mes_ring1;
@@ -175,12 +177,15 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
 	AMDGPU_NAVI10_DOORBELL_MEC_RING5		= 0x008,
 	AMDGPU_NAVI10_DOORBELL_MEC_RING6		= 0x009,
 	AMDGPU_NAVI10_DOORBELL_MEC_RING7		= 0x00A,
-	AMDGPU_NAVI10_DOORBELL_USERQUEUE_START		= 0x00B,
+	AMDGPU_NAVI10_DOORBELL_MES_RING0	        = 0x00B,
+	AMDGPU_NAVI10_DOORBELL_MES_RING1		= 0x00C,
+	AMDGPU_NAVI10_DOORBELL_USERQUEUE_START		= 0x00D,
 	AMDGPU_NAVI10_DOORBELL_USERQUEUE_END		= 0x08A,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING0		= 0x08B,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING1		= 0x08C,
-	AMDGPU_NAVI10_DOORBELL_MES_RING0	        = 0x090,
-	AMDGPU_NAVI10_DOORBELL_MES_RING1		= 0x091,
+	AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START	= 0x08D,
+	AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_END	= 0x0FF,
+
 	/* SDMA:256~335*/
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0		= 0x100,
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1		= 0x10A,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8cf1a7f8a632..8ecfd66c4cee 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -607,6 +607,10 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_NAVI10_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.gfx_ring0 = AMDGPU_NAVI10_DOORBELL_GFX_RING0;
 	adev->doorbell_index.gfx_ring1 = AMDGPU_NAVI10_DOORBELL_GFX_RING1;
+	adev->doorbell_index.gfx_userqueue_start =
+		AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START;
+	adev->doorbell_index.gfx_userqueue_end =
+		AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_END;
 	adev->doorbell_index.mes_ring0 = AMDGPU_NAVI10_DOORBELL_MES_RING0;
 	adev->doorbell_index.mes_ring1 = AMDGPU_NAVI10_DOORBELL_MES_RING1;
 	adev->doorbell_index.sdma_engine[0] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 68985a59a6a6..80b558f649e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -409,6 +409,10 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_NAVI10_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.gfx_ring0 = AMDGPU_NAVI10_DOORBELL_GFX_RING0;
 	adev->doorbell_index.gfx_ring1 = AMDGPU_NAVI10_DOORBELL_GFX_RING1;
+	adev->doorbell_index.gfx_userqueue_start =
+		AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START;
+	adev->doorbell_index.gfx_userqueue_end =
+		AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_END;
 	adev->doorbell_index.mes_ring0 = AMDGPU_NAVI10_DOORBELL_MES_RING0;
 	adev->doorbell_index.mes_ring1 = AMDGPU_NAVI10_DOORBELL_MES_RING1;
 	adev->doorbell_index.sdma_engine[0] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0;
-- 
2.35.1

