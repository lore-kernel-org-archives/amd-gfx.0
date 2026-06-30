Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB48C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF41810E166;
	Tue, 30 Jun 2026 04:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OzhNtUWB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF3E10E166
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omJ2Rpi3rUR8tkZ49sAkkhb/HjdV/5+26MUH4SfSaa9L8GHjCPCkXtpiRD71/728Qh8AOZgnWWAsuV3V0ZkQqLuOPB8A6E4xRT0qaPcbsitGAfIp1tnr6Pl9C6DJ2etzRYvF9lJKqRdNS0WovH4QmOxzscZyD7LMk0mIjp7wUVYrx7Kq9BwJMi4apweriPVsyhA+qgEFIPUIjIzy0qbj+KbMCxzE6n/JN1dnQ6yZka9ggOoMUNK+n+TSCPpAs22tvlBmh6W+cWXD9kgROZ4eGLGPIhAkHFovjYR3SQjBTYza1B77xJIR9IM69ucLh7K+zoqMhdkh9X1aFIUz2U/bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7C7Tp2kQTTpG3UgrZtMylobo6AXy5DNBRh5fwlHtGM=;
 b=pfCuzphlpiNA9+ngOBt/4/yXFjWPCg98IpqjzxPXJtYW4PU+L8A38bSWxU0SWEgID7f+J8IqZVL8LJrlTr3xTa9mxjFurrOaa6VfMjMNodbV+oij5TeVkldlizmbR1dYcSFaKEN6DfuXYfmhiD8fHQu1y7k9flZyDmPR4GQzdruIhAAdm6aX7Z+HKC8FsrT4j1QAPSN0Qcp3gd2G1M1siW86ss93Kd2j1l78SFu6102EJMgze8d3Jk5Vju3ySKR7cGvLywN/6H8lRStS3My1CS632gT30w1SAwUlSUGNhWdCkR6Ws/GxBwvjp9XdC6atNezTag47cr4+GtuWSg3UPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7C7Tp2kQTTpG3UgrZtMylobo6AXy5DNBRh5fwlHtGM=;
 b=OzhNtUWBhkkpsz0p63ooY5+fXEI7at8TTEe4kXMaBvdOgUdrEaPPd0uPn93yAM3cDkAyDalUAUMkDsPEnxPxna5tk4Gl/4KqUm64mXwt/06s562dILmwSabQDMd81LZHst1yvxrkkz5a/a2bpq0D+GewLEAtB7e/Aah6wFad0oA=
Received: from CH0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:610:11a::25)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:37:34 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::87) by CH0PR03CA0334.outlook.office365.com
 (2603:10b6:610:11a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:37:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:37:33 -0500
Received: from granthali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:37:31 -0700
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, Suresh Guttula
 <suresh.guttula@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: Disable JDPG on VCN5_3
Date: Tue, 30 Jun 2026 10:06:55 +0530
Message-ID: <20260630043655.1284069-5-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dc06a3-510a-48dd-e648-08ded6614db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aPCDZgUKCmgdHdB7XM/vesLby4YUykbVLkX/EreTPLsfHlWAycIDBWtst5IEanoaoPv+HDwSY6XNSm0SvbwtaFLGH3/qxUfAvK+2jnw+98vLW8zhrA8xniBRSk+/ju9ljKslibVZRDF1zCIaE/A0XxleIgcwRt6XBpZmcfeUXZHLBoM9+tsdgCjCZgP+9IYF3wHSrhChhIT778zlf+PzrS7i4tqRDdrWs9Kvn7s0thBGcAvd7bqssXDZCATKXLxYWOytiHPEnvUCmDoiMoT2AKXBrjnIU0ISJFYmQiJqrK/CMyTp2XiY8WTRoqkJXByOb9izeKYIpr0yc0dhdYmk1xATIHMyNKnOHrxXOImzkMD2URro964if2R5i9qgtczbBDcoNJD2MAEN5Nn/jErOijN7veFCNNO/ynQsz2bEELGRs+4qYYfY2CvagmHWcfb+cNQLFWdHlP62PD/jwY1z/uAPvbZIeQM9EnE9nuI94tkHyc44X+h745zgAb3EFc9T+Y7MnL35MyZfuPZlseAJhL8ocpYJ7cjkkryi16IrmsDLBldMK3BuSg5P8jLytt26/EUuD4FAnMITv3wh8kht+YhqGX225GFo6qx7xQhZCQ7C0jdtZa4IgeB5gVNk6RlZk+K/ig2QHa2EPlo5eqyBa7+18pi8xrPICB93ABrm/QIg4t8eQh0TYKYasi/z7K11BSYrfjLkxtYBbqGqs3TuhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gYxInm2guCpqy4WaM+uRRSqbirABmsHavuVybo841H2mrx3sTn7pc8H7IuC07gNAOs8NCXDiJyNxlq/KUNdl4tTakF7oqBRpWn9Z8RG5BKSw9gLPXb5oVhOSyGxtzod5sksUMFgQcEi2AZPIcY/Py6bhR9juZiI0Wxhq/0PfLgansfIuw9U7l5UYNAx1mTWH8Fa1mfFNignvHXv2S3xu4K75RPBYiftNkioMwatLBH+jnQSaA7rNNFrIASNGOFzIM96PrjRkJlDR5hUgp8Vcv6GzfLdnuFNKBRIxXVYrgGcepr1AzknZxLwWy8WCIK4qNrZsOxEo3EpnG6RiXaaQIdvAT7SeL1/5FXXSVWlibS7UM2VqO1sbgAlNrl4Jt04pSdaS6EsZrh8tZzCO7RhRc6vI48BNjMS5xu8S8ojcHl5+cWmOEiMdJUrw3tO0aToq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:33.6654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dc06a3-510a-48dd-e648-08ded6614db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
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

From: Suresh Guttula <suresh.guttula@amd.com>

JDPG does not support on VCN5

This patch will disable JDPG, because DPG is not correctly
copying the JRBC Read/Write Pointers (R/WPTR) from the PG
(Power Gating) block to JRBC.

Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a2733d1637f0..e0b80abcd075 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -862,7 +862,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0xF;
@@ -890,7 +889,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x40;
-- 
2.43.0

