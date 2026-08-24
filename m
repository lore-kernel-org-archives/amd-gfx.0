Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15B5C61DB6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB03810E876;
	Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qq1U8Krt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C361410E86A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhHQoQ4MHDDw4PfJjkOiF7KRaanMUXBdkjC0i69soAfq6t3YQgcJs4t3duUeNztTNq3ffeM/Vz/+NNpZPLG14PVJB9maw+oBjKEKuvE2XKYVNGrpll7KukwMO7Qp55xchvxns3qjKPypcYvWrO+jf3mmH3UUdQdu31Z8GAW5tr/4NYXHGNMEk81PHuXPXIALXGS+zfE0uwi0gtba7lcYPl4so/1jCalqbfBH7GenDRRtfQJLzYhyFQT/R62yluG/2QKDeefUjd35pPCTPjj0tTZ0OTWmwZxnZSsfRvpZpLSImLJ6vYBPNxjnWVFtO3sKLkFnkmuC9NPa+Tzvqr/Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obvmG6DV3AaKweIDMadKVYGiDGvwc2qymz/9qbCTklQ=;
 b=fE1K1WTIzfeu44VxGYZqbU0Wfk9xFRgeGxjBETPCkfzsNM0IrM7JYAqBUCBkYra4CmD8eW4Ow9jKLyzgKN587qlFwb1m0UISWj6EiMKMjCZzObyC1tnYbU3/x3fpqylO+sfwYKZx4dO4x5ADpqUibatVWp324KbxOwPMYjy7uc5hZhVX9D9RJkqV+1Gl10nlabe2fipYoP/FgJ/2kvtUpRIXYA7MH9MQ//AVywHkaDHrCsaNPolpI8T34bbmYpY36t3qkds6UzXiIYAaqRL+ROqiAtLoog323fU4MqPQbZwVU51wLjlLGWUh6a8fNh3d8FTp5vsA04QdHRaXsqG+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obvmG6DV3AaKweIDMadKVYGiDGvwc2qymz/9qbCTklQ=;
 b=qq1U8KrtQTfEOqil2UsN7/YXqOVVtZdXn2jIQtCIQ6XjLUax+y+eilnglpCbogA5xjeZg8MMIEnydgLUs6xGvU8U501rzCY6j91s9kVkPpJ17Ghytjvw0QWAd/uZcDuFigVzYaCRu+2nGTQOB5MeDKtEnHCyAx+E2R8pl827OLw=
Received: from BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::9)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:10 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::a5) by BL1P221CA0003.outlook.office365.com
 (2603:10b6:208:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/30] drm/amdgpu/gmc12: use MMIO for TLB flushes
Date: Mon, 24 Aug 2026 18:13:31 -0400
Message-ID: <20260824221352.1793542-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: df4cd0a0-a3be-4bb9-3964-08df022d0597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wsB7zTdWR4/iLRIkAts2UYttWJiomWm56iqqznrr20X0rV8ibDVzMJOSuYqZ93GeHhZ4ePtk8TOIQpM7v14uP4YdgWvK33Fnf86+nB8P1oJ7m0Ecok0QVbMxMPhR5gXUtvLTmcHN6Zw6eW3V1UqkI2zUTY9DmCXAfXo8mWvapnJdqWSzweSHWFn7iVwl1d/itwb8n3s+eiuBgqGNyARWqirjSAfJhq3tOZVL7iIpR46IbyYWP9gt7ZoJ+70QpSKAm7vbGYLgEaiwznxTWvP8KTFD7G8Ujob1rvStIqiixfG1ogyjmP7q/ZP3L9Z683ZhsceqTQTzD2jgnl77lfnKyD0lYL94DmCPWtEgjS1QWqzK0t0l3eB/88Jl9mPRkFyo4BEjCTMFLicU7yU9AZbe53vTeh2sFcoOYevCQLRHWflU+X3xLpIqRxn3JLzELpZfO2wQQcrUH1VnIvpDu8GxNRCN8FRhA+fG+ca6colkNht35PuEiSF6fVukeUt8pHMDhgMNLjza2yvDa2P1Deh328WbA56NmXsXlR4DLMFsYqR4G35C4ZG7hHPlrg1FUywYkpbLqx4tgLhOzMlJg7cOPzuY5DCTwjKCGolG0LLl8go8mIpgySvRmgfWVXFm7phTTjLefz2y4jtDE9vsXnVqCSNcRGETJET6CznrusU52CdEmfWF9C5ayM2tmKUDDWTWg/B3FtW4BRfS1QcQVTZ3ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GgIb9Nee1yU0hEtWL3oDoiyzmOL06rZp9QSbwvGACGd5Z7dCcSbJdhxiGbcn1/jQh5LfPvJNXApo2AQoyps3C6o3C/gkCU5jtWz6rRpcYMMaPvBgaOszTGmbHN7xb8SRiM4cCMyGvSFdi3ZwmLKN2ckDlsDGl7aUWzgO2w5wZ8quMW7CmgqmID3EiYZv1NH1hXPePCSHMn1wjwlZRl+Zmhq3rvxU2NJlInhMjrokNxxps5TOYOpnlepfGMwfOL3uCvO205f8K2ZDO7pOVfGM1Uz9piJcgdv5b6nDcO/ToGDnyR3wsghjQtYIl7FpFLpMteVFKAX/O9/kDZAOWSFJG6ipYwOBIhST3yf2ts5J9vJEcBTwpceXBiww7djaP12gTzu8tg88372m35gJsCR4Q/disUTqW7LGd3ebum9xSctTV+RLlACSJaLbL8qY6YEY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:10.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4cd0a0-a3be-4bb9-3964-08df022d0597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

MES has a dedicated pipe for these sort of tasks
on GC12 so it shouldn't be an issue.

MES is used to avoid disallowing GFXOFF, but since the
MES will wake GFX anyway to execute the flush, just disallow
it when we flush and use MMIO for consistency with
other chips.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3b1fe15fa1c01..cffc818880d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -968,8 +968,18 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+	default:
+		adev->gmc.use_mmio_for_tlb_flush =
+			!amdgpu_sriov_runtime(adev);
+		break;
+	case IP_VERSION(12, 1, 0):
+		adev->gmc.use_mmio_for_tlb_flush =
+			!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		break;
+	}
 
 	return 0;
 }
-- 
2.55.0

