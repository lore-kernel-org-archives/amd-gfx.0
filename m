Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92214C624D6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E736610EF01;
	Tue,  1 Sep 2026 20:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jOqY+JKi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E09010EF0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3uBbLlHRC7CTjcIWS2unSzn2Nb7Zc2aD68pYkBnY0RHRYSHLy1XNFqaPwv73yTwQX1G40eUSXSUTCCk1o+EMTCmPHKivHIuxfWDRyClP+eBad2/v4M9pQYU/gcchE+22MiFHZrV+3f4yE20vQQVv9NinF1mZhDe/b1psMvDceHPJtEHluA0HA7xb4z14midJoRPO/4mzLIekOybKAz4gJxJxKxK/G7ZMeiRrnoeefvDlkUuoP201cTNSB3RlSJziyWO/XvGX5qjalx/lo/KWbbvkCG1/RLuk8AAoNgSHJFNM1vHOsNccSiWRcd0PRRL+7Yi1MOu9tVzljeiRjTdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiS25AdZqjr7SITMQLHwX7ZAhoaZQepADuP3FjBb39s=;
 b=OpO/BhP4lzMxexYTtWmAfW7WKCSkCtiniDFl7xKqOmm4AoHxpAGu5o4brdTv7t3gzDBIaR9kZA9xZZMeuF59CsM5eoV3QC4gGOkhmrqm9Bn9f81bqJdopoz3dd4g1pBUDK9azCBBjPbf6nmfxq7aESyOK7qto3yV7K0JKPlJZ+H2u3Sba2x8D8UGEMFEwWHRn21FEQRh3wW3hwrIcwEnbnPXNNY4MqwadAoUG1xEk3SqAHaG6T8+5rISmL1Hz3jECiB/rX8mtEMB0fe4ZgvrP3i1EykxDApeyImcrVrfakf+q+CaojaRtvmpduKq6dtfkP/spXRFWDf5F3uYz4ZNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiS25AdZqjr7SITMQLHwX7ZAhoaZQepADuP3FjBb39s=;
 b=jOqY+JKiUjJzwqe2OLAvCKoY8og0CvGxngvax1OvGDKn6T3c++Kmw6NpcGP5jWwJ6NmwjZ5d23TG/15v/EIQG1PnbyZDei12yIuKUMrVg/iX9TOmF28F+QOCkErgIOd7VqiODEmseoaQbqMMvTlOPc7K+Uh16+gEEKe7GnLNyWA=
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 20:11:05 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::17) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/31] drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
Date: Tue, 1 Sep 2026 16:10:29 -0400
Message-ID: <20260901201034.2960437-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: c998b5a7-42ff-47ed-c896-08df0865270c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 376K272PXhR4cU36nBon2MYsJ5E6exf86af2zkH+wJFCoDybhXVsgdj8F+2HH4TaNhbD666lWJ+lI8hRBsJc422DFpvhprwMA2+ei0Gl9mPwZgY9gp5bhITGAYobtm4zUb35K46f+m4VjljTtCAJMPiLbLek+4LlQOOMhLVyQZcs0fNCt41zf7avRi4ZLddg2uH0kPM7s3rKiNX3dbMWS1e90vNHJi0kZyARbZQHBnIHBo5h/0shuUGZjU2O82Q704Tf8gBUn9eIcx+gGh9y4Kos5lUFlmhHPVn5jJya8tUtQGNXCKBeH1XqKfsCi8y6Mc6SJ/7c9l5606Ss+ABe5YM3ai/EjmyWiNrfBN8+1fvnLa2UcsADvEeyLhO8kn9mR+d7vG+Mnsdyy2GbhunekP0CCUeq029vjRzBkeqaB6bm5u0WbSFYabgeZ++ZhTXRL5k+jQ42jhYFI70ZC/+VWA5PgwmBPL8ln8LZ3TiVECxWMiOSUtJoM2LiQat1XqLcaBNk7y87K2UzU3fKBgCcSKGYGoblejfmMKZ9Z5E3FvEj8yKB6F2XmCim5Z0DIEqbE0xG7S809MPPWqctYTrA3/yHR4hrWwo6l7T4jSIUcbB4ZBJ4ecM/wnsMwGBtMBsFm/9GZ/9BTh071yKskKxQQvTi4epSa+ULjPvMEPYOkVQMHqO3Ag+URXYkRiJgSW4s/cRYiNgCaLgbofJPw7kyHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O4HoAO5F4fWKolgFO/clYWEUJEZq/RIEgS9v6W8OF3PPJnnpA8Qw/wvNBsck4vFQfuMVoSfrxv7n0OVj/1RNnQkbA6pe/OalCLWnjslXRhjI3S1tB8jGfWmOtq4Aj5i3qN6Wedrt5Q8ZuV4LMbzclQC5J6ekx14rg/eIkqdrJ9swBAdG5NtaB2fNzCOGtF1ezQczyX1V6QYGETOY/ZXh5kdOJNhvXrXqGpjPKPBE0W2LD+NDXImD8CJo6RaCFuVc7Hca1RIDFascMAjalAxzEi1ofdwcHgTIeQNAD7dUw8YzH3xW9rt+duR+QwGWAReNn+lXAe1uqtvB7uKPvf+drjCq4yvtLjLJifNP9ZHTj/lmn8ofWKXFyvJuq+AAxWadG66A7yZ6lYGoTcUKCp1qfsCZv0O62ms45vDAtL5a94jID6uJbZ5FqUeNRLgv64SR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:04.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c998b5a7-42ff-47ed-c896-08df0865270c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 889c0005fec3d..6ec5798494be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1061,6 +1061,8 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v12_0_init_golden_registers(adev);
 
-- 
2.55.0

