Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC647C44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B92710EE14;
	Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dP5ZAc8F";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B3E10EE0D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0ysoZIfEwE7r4blNUTJHQfe6pc8eBu6fEjc76Y1uyCc1nJaLtyn11tFjKIdSBjiUL9i8GKiSPiJTrpseiMBBdzOjJam3nosD31e1SnU01XCYe+EQKwLxQ3O36YGwgWtwt1iFRb/sdSPnPFI8RuHC9w+pV23ObWUMiAoPZvUFDlUeL3ScEHftT7n6inTkvnk2F2C2dBIqRvdIUEobv7BuF/UpH0afD60gKnqCliq1NzOz4s/FSTAoRqmtUtvfSRzJpKT9iGiTW8o9hNyeE5+Ak1x8yT+niX8BfTn8jOzhPJGJI7yySdna4hjF+NWaUitVvrxGyQmLf6VuAR0uCbTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwyewTWdKlUPjN/pM+sR9SByNGI+YwyzLTmfVdywNdI=;
 b=PEzwFPqdZwJedL/NdmtsEKDoaRSUVxJyjjFuii0Wq+fclpe4cBQsD35QJ8QGzTNK+k3w9r8Hw52yMYdt4hzfQJ1m7NXFdFk+N33OpZIw1hS5jBH0LtQI2YNqBP4GEL2yxpZ66pfUJmRod4edovbo+wtV41x3AHqvUpPi2U43afraJHNEbqQtN/OM0knUOUsVpUt46elZfLg131XDt3eWPsRN0oELx/HRJY3qlTbAX6FMkm59wUpQDCdSyqiARgQ1BQkAtXqfkGAz3NHV+elbhpYx1Mn2Xju9ZpLWXp5BZDVaJslbcfckFG6yMfzK6M7HMgr1amgRSfjZYwE28Optvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwyewTWdKlUPjN/pM+sR9SByNGI+YwyzLTmfVdywNdI=;
 b=dP5ZAc8FK/GIm1EEp74MCZc8uFQKw7/9srHC9Ky3Iv5D1JyFx981WyusY1LAXQRx1i/HDFrS9LcyfSx4+frVudqV0crJoswf8Oh012u8BpwpbRs/Z4NO7INy8kERz3cSNXkCgLSTsKf5MOxw1sws3PouffM2P7e9orhJgQow+Bc=
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:20 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::3e) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/30] drm/amdgpu/sdma2.4: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:42 -0400
Message-ID: <20260707154203.2603209-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb0ce47-15db-475d-c11e-08dedc3e5465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fC9ixJ7ogCE6vTXwlA6jD4zaJUL+zubRcC3SYZsttn9HO9RuoZ/jUTdXrBF6xS/aYVcUOt+XlMv/nxTZDeCpFwYcunRCI+LY3dFppJ7YT6rEouI0cJgnghYji+DZ8Xeu76aNEQy7IME5J+3hfxFOd0vxKZ0I1rrL5rkXs5TPPrLAG34uo5o6eGPIrh5doRV7U0lyJ5OI5onATiXg1qdVGjshnAzSwjqMUMWqQl2wV+psExWEpa1q7xZ7W2lHLdIs67yYdi6Evw8IYpJ5YbMgj63ii3fOuSUrR9zRDuRdNRnWzyrLy36IVBRaoPg+XiO6Z+f3LuYpkF69wVtuq/9pe6AN7xIE3UHnhqsvC5wGvJ4wgLZxDVbHcK/iD/j0FhTt2aB5CYZyFrjaJauMt+UUg2AWC6BG963AgJ4QXqSEO0EKvkDP97VwFp+Cmntj0tqXv8XW6vbL1yFRvlLswClPwEKkzPnn7zMFINIyBkiQoaUKFSvn1lQYJ228QjXcGlY/H+RV0RFDSx11wmmy0C1ihW5leA2reZetdpw0UKBOVpjA8+vffnkn6BbzvKhwNvdN0gDFnuwGwljlrK0jXR4WG9DksJii7n9N1yzKsOPvQUK2DXmbWkpZX5fyt5V25KtD+THdQrQ0f7q62dc88OlW04dZgzNsOFWtc4zPunPX1+4BkdGTstC5IyTVRzNc+ppee+LhR6ix/YmSShDHCJEUPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yrbInMt03ncPG5I7hxJnUrRkp13ji8peQiCeeUFK3HDaiO4NLY8ztipF2rx3MVPxZve7ivtnxSJg5w+r1p2JBh0f2nce5gbiv8XT7JOFr+55U+OaLJZy2arzVbPjCNp+sSbg7sHNP7Pw0hZzk8dxDrO9xrYcN64Ot0J4yxftH5v+uvMRE6D+A2r6Ky34eVh30LZv9EyGrsuRXopkGpDjc4N1YE/Iqq4UzHuIOQK0kcRHB2pJZzit/d+VG/iaOp7k9pOTb2pq/QPB54PgUG5p1PIBWm0qszdy5Ld2D0q83PkNFlFkgfjtDzZXmAyhtuChjJH+Chn2t/TzR3lXmzUKNVBvpbhzS6fT8Cdtk87BLLVwCL0zgzmTOiwLwy3XOPlHaPdmHWaix7trTq2xrS4uC4NffA5+a7AVRiHNfzPVATP31qBCyvfKLg1/lYciAuXn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:19.4886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb0ce47-15db-475d-c11e-08dedc3e5465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 397b08c7173ab..c7253b908351c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -138,7 +138,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 		chip_name = "topaz";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.55.0

