Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B417CC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A3210F38A;
	Fri, 21 Aug 2026 16:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ufTUAyr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8538410F38A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtT9x8G79AlhcjtImjK6mDsqps5LGg7oOqZNwhvpgjF1E9u3sEd88XISLALSzx4Ucg9iXVUf2nnXlb43qMSEIBrVOrgC0ny6H+lQHlLPLxBe52ltzWMAvJul4W1oeLWwKC9no/+8jmMb15Sk0LvmzUCFtmcD9fmbV3c3yIh1VG440Jj9EJMFxr4DaUzgfybi4Q4avQc5I5hRGSMOmtVkqVlFvDHv8ltPGqU6xApxCUwSk29CNBLoxBcT8WJffU7guO2+Hf0w7cKBprdKhVcoOQ4F5KPlf+zbGT7rzHGhQpbKR1A07gM1gV4Of3edwOnqozc6q2Y5CFsz3Jrrvu0E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPy8Nx/3CvwQEZ+uD09bW09h0noFbCSY8IoXXRLHew0=;
 b=UP5lMR6BfeykIpal0X7nzL4IxLn9fX7WUyXvG2tFYvwqeC8JxqfHvd2CSoM/oagbYd8XlB8p0TDjnbEO92YLY7cp82IxoVAAjHBKMB20n0Y+A/zfVEsplXCTB1mwkwufhj8BO+O8Uft5+TUt2b32TDoTNXZaqFttMrjuCKv2w3RgHicQYxWNQtxkxNMpHvgWP7guMj8QCzjRNlSxLz2dGlHGIYA2WVSiVIjydWzp4Mdgn2kVokRDwqe9hY6G0o1EmZeOHFSoWP78CNcDPMEtSEuvATMrCGicVFS1CvoncEehK3n70TvVJxqYxCRXpnYwIcA/X+WrdrNf0Uqn20IlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPy8Nx/3CvwQEZ+uD09bW09h0noFbCSY8IoXXRLHew0=;
 b=5ufTUAyr4rBFOeK9tnBC1NTZHMEZTdFvH87hIKi6gZXlEM9tNnV1Rv73dKujcc6K+D9hzdsM30st7Z61v3diO5h1YvclbypACAC8Oc/R102fjFQlcs8MdunB95q5/DAN3wNEkoVCXh2xg9iU0SKLTtOQ7bvOPb0l0+E1RlDq/EY=
Received: from BY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:1e0::26)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:15:22 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4f) by BY5PR03CA0016.outlook.office365.com
 (2603:10b6:a03:1e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:15:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 12/14] drm/amdgpu: handle MMHUB harvest information from ip
 discovery
Date: Fri, 21 Aug 2026 12:13:59 -0400
Message-ID: <20260821161401.754042-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9ce7a1-f1da-42a2-e23d-08deff9f6674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jID0z0csSJcUGIhE0jfwbG08aCIxvPZMkATJCwkGG+Nnqgj4UrNpyKY2kEuxJnM8KyedTkSQMlmGt4u8m4lm7h8skF0JTVkpqDKm9pQN7MI2k0dPhaZl6eJ3iHgm0uXrNiAOQIacJAZhwsYV3RvEwJfGqBQ3n0gPkWA1WHA/oLDDMTbQFMWs7idDZVBrtki6kZdVph6pOHmfd2AzEkeIPHwcfY6tGqUrD0gr8LbC6fq9KD2KgPDdPfte/EE3S+1Mqxnfzc2WUOCmbTh9cik3LBSz6Pptkwa8GzxyXwsLIPDBj4v1dLq9yslsOlg6ViOE0yHfRzSwixepvkgtIuNAu2uZeKsMdfH2Yvb6ozKll/TBcDBAJGyZdbewFWJePbRfkqy/e22sz6VvyUZSSHV4U+LzKNs8Ggn9FjhDew9UHQNMuVDmrY7uZ25L4VKVHsPEjdjcHLpkf5Qz2BXMY3HmoFO8XnrYFNQ7+2NluugJttJu0T6204uMljW1HP6nvM8kabal/J/Ot92jIoLKLZ4IgRzKhIl+RxnS3nQriMamMZ3MOPNRlxh1+edT1RJtsUVj/dLFf9CTiirmnKMXW3goPsV45JJPg3i0jCrfpVvi2bZ2GtBMS50ox/n5P3Q2uB8lGqSlFshE+XdtKVWnd6dy0Qwkx5Q0QWnkhlyJ+cctc1FBWkadQwTIa/st0oVm67Qm1MwMJZG6M8tosnulN4BlnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u+qApRVMgikZlrKUrgxNOu1qNTKzF615HaKv9gdZd1ESVr/oWAJZN55tI/l6jUtJeD+nbgy44bhDRBBQxTGvwsDg307qFq9acqxQT1jht72ZZf5egcjDyOI/B0PH61VZd13WZIT6bISUMfVpoSPq6L2TwPCAThoeNWN/mvVmRl59WQ/iRddeY4GMvbUzpODcMKr66AIkiinm5l4iwBgnr7SpiYxDqVFW3JiDEuDhzxSsDmofbWYp7Y5OgRZ9aNVB1iU7OvIyn2s0UjXwh8FUwiYZgAFvZ+KMvMUpu7hi5H93zgse2O20i7oU36IW/0VJaT/VrL9VywIyOd4FWce/HRMiJyTMGRm8h5rK8/z8hU8fhqGZn1gNRQtKx2sFUuQOuDc22OCtPHuTk01B2VyA3j4AB5l+c5s+8rGcQ1i1EPuhzA74dbcSyK/a1Dl8X9g4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:21.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ce7a1-f1da-42a2-e23d-08deff9f6674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

From: Le Ma <le.ma@amd.com>

Clear harvested MMHUB instances from mmhub.inst_mask when processing
the harvest table. Report the harvest state through IP discovery
sysfs for MMHUB v4.2.0.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6f3da085939b6..4de9af1af0e4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -961,6 +961,9 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		case SDMA0_HWID:
 			adev->sdma.sdma_mask &= ~BIT(inst);
 			break;
+		case MMHUB_HWID:
+			adev->mmhub.inst_mask &= ~BIT(inst);
+			break;
 #if defined(CONFIG_DRM_AMD_ISP)
 		case ISP_HWID:
 			adev->isp.harvest_config |= ~BIT(inst);
@@ -1251,6 +1254,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 	case SDMA0_HWID:
 		harvest = ((1 << inst) & adev->sdma.sdma_mask) == 0;
 		break;
+	case MMHUB_HWID:
+		harvest = (BIT(inst) & adev->mmhub.inst_mask) == 0;
+		break;
 	default:
 		break;
 	}
-- 
2.55.0

