Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA90C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F7C10F6A0;
	Fri, 11 Sep 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsn+xVN7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413DB10F6A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4DIsjuXvGzPp5KNlRisByeWDX48NXCRnt/AvrOLod6WuAoBQoWbqOEIvkUFRrWi5jL7tjT0Db0xs7BnttPTaTe3y6uibtoTf6rnhRVXC6tcMzHZE6yaknwznn60Ul+PK9UAcm27C2KkjOqbyTp+ah9aHXQj2q8s2vK00YWOxkNFJIP/O1TWjFWRZpohn8+S+WxP+zoz7IwNrW3rUKUdcwlQZQ/8QapWIJWDTKoIXE2oRLPKuF87DrKv0fd7adwvqHwuTmjSJlOPYeVE1n2o6xfAqnPNZb1CEVxIcK9+mdkxxI4m6y/yrslFxWNtcVzfxzC9MoqANKsBsz2oC7lGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3EHWH/17JLl40vf5XiKSDH0VaPWF2P5CZpCNTvuA/o=;
 b=rzzNUQtJviqL/gZFN0BzRjtfijr4S6xeZilTUbXYHd9AN0bLQGI0zybaXuQjQWzgBcyLSdBf9fs8HI26Omre10JZSKA7E7wMNabK7ujjNB80381KSTd4jM+47Y2Mo9jdA5Ue+unmRp5sXWX59SnYEoDR7gYar5DJ4LkcC0fYAw5c4YhXz7fVf6L4hP6JiiRFnmkKTQDCS95pl2MKpIZnqagUDrF8mMk17bOt/4L+PmWfiDKvhdT/OD3AmtSpP3H8UhP3BKWU14XCaEgxwh+Tn5MT9Di/CmOkcw9nL3xnt74+w5Vl86+aeKvmMacyGXhcn8ZNTV2yLRq27C9G7f5toA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3EHWH/17JLl40vf5XiKSDH0VaPWF2P5CZpCNTvuA/o=;
 b=fsn+xVN7aMNw08T0S+VpUML/5Ju9vu04yNOPPWrT93eo+G1DBptzmUvzu+5Lj62PhHD8bkXUHh63AmL2xfiG/fhVP2HCs+jF/pTiym2bkFFR8H6oO/fNxLdEBwKo2NNP8OwzXJVD63YEHEXUGhLKJcD5kpV5guwrJcppu0LJBZk=
Received: from BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::6)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:11 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::49) by BLAP220CA0001.outlook.office365.com
 (2603:10b6:208:32c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Fri, 11
 Sep 2026 17:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/23] drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
Date: Fri, 11 Sep 2026 13:55:41 -0400
Message-ID: <20260911175544.1314467-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 82066879-049d-4b73-82c0-08df102df72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LvPg8YfuFcDga85LkpX9TuqakiBSADB//d/MZ9VtHKkT/XlrENvvCfRNUsCodXPhH/uOTy7Gza1JsNlmTQ/a4jxX/9vFPwbLSphDWAhYK9oOBI9RpmgbA87C+q6Wgb39mfs6+biUymk4dgapR1c8QnRz1IuBqiCEO6vogt6E3epIzswCtZf0iQlqoSAjQG1SWjzT9zwTfkqLsC7KPGO3mrbQIOgR0vX5mckRpYRA5ilOP+5w1H3AUiImhRtHov2fW0p3tCuTQnR7xL2DRwr0jRx00MgN/JbDorXDeHdAQTuuDOw6/ijtfFcgDEdjgSwQhxhiK8KL7gtbjYeuj2UUUlCJkeXO9GDbKo1CvOIaCXvOGvEmpDHmaOXvYwjzPWVPZf4SP7kCFWfqm5uQLrlF8LpONsRe7CH1ZvETaNiAbuJrPz82ApZwf6YwIfyKSC7dFBNTeN0qXwq6xIvS3WnPUPI5Aeky2j9NYAFudM10bfwXuGEXW8FjttGwNmHcBC0+jh0wKWNfMlX3ijr/PgxX5vNuOp2MpdESJWBb6wcqWuJ04fui89FcKpndOwSPa+oY0yeep1J/3EPCDF4/6ODbYvBmKiv8ULvpbXHYWrWqbh7DmkEmYp4UsCOIgyfTFtKL189kDXRC7SMz23qiL+xg8apJt9dMMUruAw9ds60dkPv09qQAyrv8oHMEJitEqt+/wYdJmxk7qBSzfZFlJhT3Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DrZiwwD22DZK6gM5S6ICmkcO+bqv+zSZpH2J3NnmaEcRuIQU3ywGnzwXRuq9zin/2uIb5ou0hSUoGr/cYkugnOTtguwSEASEEnEItol7FpwgfWAY5STgCdpmYSvmDunj5DJQ5glgi9k5jKE0BQyjfqdV2yZ3fe2afATXMHq60YjjR01VKLSoKh/DhEXDs6T9V9izjsGmZ9JeY39TylQngL342s8oasg+XtCbtUujuD8ElTKYIUTQX6usyoOHEyWPMwvXIVB6+ncWH2acwaypJPXZ0tlurTTBPgR6bbICS6f3s1SLlKvryCgFSXSkBgiO1fXZZmnPMqCvvpj/fPkJCBw1QqeAcRNzUq6uqmQyjxWk6ou3tolCQ9iA7f97IHawqqkVKKCh6f7D+x/kyqJ+MN/MwG7tCGi3WDygZmMBGxsfmyfNjQTdp4gXjeZLKNej
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:11.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82066879-049d-4b73-82c0-08df102df72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

Use SDMA rather than MES/MMIO.  This is recommended by
the hubs team and aligns with what other OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b1de39704fa75..b5db3f966ba5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -850,6 +850,8 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
+
 	/* The sequence of these two function calls matters.*/
 	gmc_v12_0_init_golden_registers(adev);
 
-- 
2.55.0

