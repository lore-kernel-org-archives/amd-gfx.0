Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092EDC88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9810210F477;
	Fri, 11 Sep 2026 17:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXgLBb+K";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DFE10F4B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKfafjkJl9aEvK9m7yRtyi+TzkgQS7j0BaOwfFpb93jBzoHM3kL/mnbxr+Cw5Lf8Y3i1gOiyw27Y/HLxOzJTZgUqrlo+r1v7ZhepEGnFBOCONmgm+hwcZkbrgNZPu8qeSI3tupmC9cBEhA238PM5++H6/4AEsA/LHzlgQiYVtU1n9yYI/bm3BFT8g0lYDGn2xYn+hleFT0GJ2Y9UtfF8TN6+/JBFQIhQu8JhB3hU3p14gm4GhbKavjNDr1FbHQqZBDVR34ePFea6ey+2As3GcWiY0SJqHAsx5m6Ur6LKC9vpXCEP7FaioqEtGgGUoRtcWQPxC/HlAM2uUDR4V2LO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LP37SPy3zx7Hx/E0M9rdzllys5SDBUN5t49pQSS2/g=;
 b=xaz4Af58s7yfILMxDdkeW8DfgDv41p/6D2e3rl4SzGtKWZXNMt/q/K8XBNtujq4Ul9tP0oHu3Sn1iN916kfwYcNi1td6oruPBakExbWGwals0qr4gkxAHwy0WucQtmY62ECPe6OXX+7DHI9Egk0ZS1Rch8+cHZvnOMgvP8NlIz83Vc8DcmdrJ5tdcJfRHwA2ywY1MIULYfaf876Z9pDPzOWpY3gh4TIpTHDfSYLe1k9z3YzLxqqtyXJAga/ieAbzONjQEdbql4V0BjiA/oobDK30dyy1fdziyCsIRlGZLjfBtv9Qz34eINEJhtpHCceaSvLNUITX6IBziHX8602FKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LP37SPy3zx7Hx/E0M9rdzllys5SDBUN5t49pQSS2/g=;
 b=EXgLBb+KpdfqB9Am3SqLZ5bjbFqJ+PD38VihMkYCAmD55pWfaAY71tQnlHlpqutzZB4HEj4koBpOdosJV5Cs/xX1i8pCLH3LbXrv1DH+LBalMoeYJiq5PVBdvkZzvR8W97YHlRCNcD2A4fkb/ACKRD8lAfljTqlZsufMtumepFI=
Received: from BN9PR03CA0155.namprd03.prod.outlook.com (2603:10b6:408:f4::10)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:04 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::4d) by BN9PR03CA0155.outlook.office365.com
 (2603:10b6:408:f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/23] drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
Date: Fri, 11 Sep 2026 13:55:25 -0400
Message-ID: <20260911175544.1314467-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d421f8c-c626-44d2-0cac-08df102df306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pud5YA1+PGNhtsa9ucFEglqOPsHE54YnGRuZvok41eMTjF8OGMT15FKm+2nNFbFMbsX/7Pi/9BIwRrAqfCe2OESN6p07Fu4kRzA8YKfNRfCQN0K4psKJf8XTpZB5stkro9whJkU9BqlC1bxOFPa3cDDLCWeh+EcPT0+pxBfWYHtNP3V7U8RGDpmZeJtkfT6LASotrNXh6WYis+NXa4QesbtFjtjMg1Hx5VTEAeJ9fHgo9PKXsHLAmhyWfOiWrK73P/YhglWxvxtbFtLtGSqOxCCzcSGBZk5wr23j4kHs8HYnbtRvhzML3s7PzaLw4ed4RxfVBdLnSh0YSaLZba3VPL+/HsJ3Om15dVDj39D65cVQ8DR7CbHWtpAbR63NSUEJm6XWRK4RYy0OB8ueg3G6gKdjPAj2C6g53vejjbgIMTvVSFjiKj0UMa3Zzb5a95iywIM0OYuwIME99FzSX4xXDip7TgUJkF2g8OTcOoDUPxgl3MrZY/q6wUWp1OwgXe2BUBcjBNvn1+A7eaTa51mQLjijya/xGFK+zFWLR1s04ocYmROG2+/UvFIVN1ySMKZLiMZbxRdgNMAth2KiEhzkWLgFQ1spx/Llyfuo7MHgFMTUcafiQnzlxdHVxZu6V+IIJ+kje2TnEEkGnu3N9+bC5rFmlk2sm3FaC1/FAtQHstUDzpvYjpKjjN9fAUW9NkoGbbDea+5LgJaavGX1El9IGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: drVkfcDGbCcZh7ejcLc9u7HJMcEDBvIVwMXWvHTJhkukWWbc+S4DRpuJLyK1rgY6rrWvfspfTZT3HlHN40BQZ8lS8pxdnsFliLK/nwP+QXA8Nd1a0eo6rt2AD/wLH+oMX+1stMHneC07wFSFsrxMQmgCDkQvKJfDyXVlQQ44Md2V7UrtKctx3e+oFkLnRPGn7bWBUA45Vka2LXH5+aHsg8sgUYmTLsOD/SEpuyHXqlmlT6kiLabpt8dRLw32CxvSU1ezFAkt4Z57CMi+kA5PkpR9ohr3xN5x85KL1fHWp43T5Co6yBB4GHj4oJCMYWybDIVnq0xoRazUTCbBInB+hi8fdVj3t2eF7Cuvb7cIyWwcxgzdOgaXKqlg7zhZbmz9KiTwBpU7kGJaO6WWiEVUEGwxGvebiAmDP0/Kh+xLxVBw+vfjhdUlD3RFGxETNWUZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:04.6306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d421f8c-c626-44d2-0cac-08df102df306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use MES for TLB flushes so no intended
functional change.  This just protects the MMIO access if
the MES is not available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b6cd6babb035a..6e2168794d31c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -330,8 +330,14 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-	return;
+
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, true);
 }
 
 /**
-- 
2.55.0

