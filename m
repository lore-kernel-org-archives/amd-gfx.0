Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A5FCC04D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41E310EDE9;
	Fri,  6 Mar 2026 17:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+ITEz1F";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E99810EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1f/MnQ/IFgi316/kByb/Bxeh7O+kxZGKjIi3l4DkhMbrk6asm/RpKWoU3dFEuy5Pn111NUQAt1Ynu8F5BHp35HxuayIA36ZCbJ8R4vWYEg4EYVDgXYezIpH9ylxkIlGy5y/albJWRPqgvOBOMDOSLPsHo7HTLwbHCbnsTnEax7WM9oyEbY5usCUEkT4xWlvVEKEKejuJG2EfjRTImvtp+/SsDszTUlGimTSEzH1WbyOlkpitIuaLJkaVgiDAXtQQMDFIe75a8TLS16pCr3Palan2OFnX4Tr8RBu9O++SjzCqV4BSUH+EgxjwtYQNJKUfP0E3d3ebEazGOljF0+pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx8u4sd+06ap8KLB+7B4NWSipi87tiwJo4i0uigvp8c=;
 b=i6a1qFp7FKm3laZKx0wB44/+wPeOeFfo15RqmM2q4wvYV0Vpk316SHl9aAB+JQLdWZHXSo9nL73qkqgMdv0p+8HGg5ROYUElegcfglIoeyWH2oIhA3F3LWyp0hNxeaXfhqgEbxoQ0i6v0Twdv93l6cJURfYxrOageAS7lrPd54ffSuR/0pDsYTRIlvLHmkA3iMRHJUO6vcm6bNr1B4KQczFgAbK9YVEyqUAu/Y6ZkEc3y4W5hamDGZglReykC1JWaUVcE9dS/oZBB/7J9wNwEFWGbUShGB3BqrFIygbH9aHGrKmSziDx0TVqzxiEfsgfq4tt6T3XImjrwW7C4N5wtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx8u4sd+06ap8KLB+7B4NWSipi87tiwJo4i0uigvp8c=;
 b=F+ITEz1FccQJ0haL5tyAXZfkrKansbqL6GlR9MUPaSIImK3d6YpyQAmmZxyeZ07eZMLk4bUqWiB5eO0TtSNJgf0BjNDpZqufwvHQ5Q9/UriZNL5EG6tblszLBqA4bRlSj0A4eleJnN817JnE4XNJazO7n605tv5lnqYzZfcg5/E=
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 17:24:29 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ae) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 17:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/sdma_5.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:15 -0500
Message-ID: <20260306172417.325169-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b44a296-7596-4aba-b18d-08de7ba53875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: 6ArLvsNlOPszoTNp5XgW8wGkdmMd6ECwxEFKiqBf4qLcC4TwAxnvaTvyrRJ47UT/A5BjWmnlsdnXaVJKyjGmz2j6qIndHwmWqZYUZgQ5o3KX9RuBJSSqOHvUDWLmJRjkOMzSqxiLSvVSal0Zca1O1qzxvBIDJ0XOtYfKO9LciuNr8Xvx4JDr0Z34bb91g2zcKp3i6+I2PFh0BzzOteK+uq9cEU8DfrXPURf5/3jm/rZYrz0htC8RvLi/qqZVe4k6Y85bArTxn7heytK8eRicfgJxqHdDExSRBY6c0gWgEefYHi/AvvEyELJwfw78O58NScyBb+39tzjVrDKHYhXinjMt+kITCiX7/zzzk3WSFiXj+ajylV7Kr1nCpn5yrBemU6sVmi1bYQE5Gbdu7/M7qqZi66oLB0j5Cq4Tof/ZxYNHPAnWqzDUa/yFfdkXK8VKl3AsMvqUQJtH9ng+Mo6HTdSRzDsJIM940zWTwJWYJJZgTxxwtichNTgJS4yNln/zADfd40wMJZLELHEXgZG+XfDrykahmdDyEgL4lYdumAllrXvVjfehepak30RjjzOnoc5RgJbMZ3euM0Fueb9TcOzuauit7RdqlMXzTaKwtNAIkL+6wgS+LTJZqkfQMFXePzu0LBydtbBQ40cKS8W14xcA3WjGRG6h+og8vU6tvyiREMw8rfwY4EzQA9LMjEqXkHo0BJuy67Qk3Y649izdnHbHBzIKa2U7W4k7sEUOpA4NKPA6HjbAmLR/OGQ3gwueXwv2Zh5vUhz+8ARjh9v9LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xUPG706MuxZvJuhgdRZzI7GVwTIkU0mAjG+FwEFMxA/t86r0nUnBLlKB7pUo1D0QsgycZjRfjO27I8w/oRKmtSB/0u8g5sHIBL5ecCAoW33bb/7inDkLDN0k1YaZ8ccC5av9DXLgCvz4ZWcuTPe+OslnQHiBGJirDmyzszDAXrFZw0dqzNwl68YEu5a5yUnFuorsRq0bASpDboLAIa1FKZ0PZ5zJ2BFJLEedvx121wuDtSXafnwIqPQMP39KJmMnAcDd0OyhRsSJTVQfS4+6aBImHVRsRJceSRWNtvl+hsspjZ+KexfPCkzyvPEG8agAWKtpk41I+8qKh8r+2eFNK0BNbU9VgzbGL2BwWC//Ra3KwwEwe8H1mD/A9j7GPm3frbe/ibCgXPZv8/sxsfDTxJzeVy2OUUbHt/Y6U91bBuSQl/ncxTPYyhDBlncAWcmS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:27.9813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b44a296-7596-4aba-b18d-08de7ba53875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 52f4e9e099cbf..a1283553f0a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -698,7 +698,7 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	ring = &adev->sdma.instance[i].ring;
 
 	if (!amdgpu_sriov_vf(adev))
-		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

