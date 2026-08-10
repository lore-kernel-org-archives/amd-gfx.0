Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A08FC5AE5D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCF310E5D7;
	Mon, 10 Aug 2026 03:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uD5/HUiY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2E910E5D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy2rhLylnjf1dSPZ/rELV9+mKuTHNNR9+egip2WilR8v2bBQFcZMDqjHFWTK5xnIcFoLyaruEOxDlXigdURFEP6GBxjICtUKzbVUDsNsZyjYKhoFHfmg3G8HMMdBz6vPkRVpvX+6QRrGZMGsnqPidt7WbYVGMHm3sJnLkMF7ysc2ADPWNUNnthaQjqB7blE36h3Bcg6PdZ3Sj8lYl2XurPqgAQi7QeBESjuAGu8OEak7GOkRT/kyQrMmHijX0QEn17kVJ0+h+i2vnmtg/CWLK41f/Po5kFU0fejMnwngeiDIgsWMlVoYunhFQhpW01zxIseObBA7zZD6jm6rfJvZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyyLL6TOd4MolN4WLIeXolNV2sOzY5QMWr9NwGCMgzc=;
 b=favkrP5/ag3rikNW50+XJ1zX9z6mIu4PO6Stg/e9L3F4Zsgiw7brh0wfurBt+AVRyrTKdzhkx3YGi9dTr92y/xwr/7mbogFhHsSEejSQh1rfkfxdp0zLVAJqnCo9dHMSdw02r1VKpgThymNeabihFx4M+DhdWDUJNOD+EMsaUM5HGmKO7QnPfn3oRAtU+QIeDebO56OXTmCrwJg4pEFkKJ1i56dxrNlWdVrz2jesdF2LXInBlvy/qViRPmkV135jKMvGClONZ9jZGzAFc+zoLGTi8cM5x/ih4pNpOeaNtLDM0aASAT8HDexdXW4fqAWIxaa6TVY3V1sHbOkXNcs9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyyLL6TOd4MolN4WLIeXolNV2sOzY5QMWr9NwGCMgzc=;
 b=uD5/HUiYDPBrT1ISjZzC5XHUKpj8012FwVIj3NUAvdsrC/9RGO/xl+ne0uFp9iEAeGluDn1urv01dRf950geg9ecTL3NU2hqbWTS6C9G3FrforTeoZCDiSaQzJLUVMwwkp5YWsAby3YqIvN9h5PO0OMnmyfTbIOIaTfMh8kG5jw=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:08 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::57) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:08 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 07/13] drm/amdgpu: VCN 5_0_2 enable multi-instance
Date: Sun, 9 Aug 2026 23:36:38 -0400
Message-ID: <20260810033644.118194-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: a4160600-7890-4766-c75a-08def691370b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: zoeqQ2WAEjearY7uJ4zqLMEEnV02FEvWvFqHQb1nCwqL8HizvI4afNIgaCWRiGQS7lyoH1rySWW7uULjm38M7aT/5q01CBEvV0Zpt/yu6cvge6xZolcS5JxLH1fkEYmRX486KEO9nQaScm0pZNoeo2U6gFh3wFf8BXjfMaNzKo+oVE4FIJzRYfWeO4sCIjZlm9FGPpu1E5cOq1ogvXoRIUg8ELMBGCjE11FGbyFAzdHyeMnMTuJpiRhEr9e3ZXETXOZgOdSPGlhDjm1Vkzk/8otSJTfD3Ga27yLly0MYYUmZl3rWC9X5a9en1deIIkByCVctHaxxuX0VmXJ1kLqwuY9taVkkoEUpZ8J9gkwv6Gy+Ddz/REbXqaU+E/kiZHL7PpzBr79sDTQFmnv6rnLabna9zo2IzgU+I3TUB2NYpG2oKUmRl4S4e5hb0kjUSLMeTtsv8NLt5tyiGWTjqXdZq0j7LNUVGONwf0VZABMKXSUGwWwaH/tpIfJ3kWWfVsXeRbHM9bp8JYZxCEqs4y8KSuqGLPvHszGM5tvmPU60rEJtvStkfbc6wznkf5qOZUUoaPWZp9J/Uw5D9MDRabFgjPCst2e+sNzjPLtkeojv88+H6Abwp0y4/opVqyyEzEMJga2+Z9RDv9et/3kiONeSHLvLtZ6daiRzIgNu8i2dcCKXEDYkENwNfA5/mkx2FtcDP6U8fBphLzh1rl5UrhiX0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VkuvpCJLc58IqeF0X4fHKIDfQ5omUJ0NtrIvxzT3vKiu7JSB72JKav0NAtqHjDI4fZZGQY2LB0wLUfyEbfAXiWyTNbt9hpYczi5sLO6/npC7yWUwnMOl+haydSJvJLSy1naPbbGOnSGvbDTIhCeL63WbxWeaL0NZy+KVa4xUIdHk5ghXqIj7Z92umhzLB9x+alH2uI0GLOXsN2lSbfOD4ahn5z6bk+l3BRtsOuUrePBURZauWeGjtUw4uiTSuD889KTIUT709V9LJ0XASy7EX7YLJ0VserpNPIY/fEDEF3poPC0X8SV15L52p/oZ/PiUH+4vPojms+FPMHy841y1jVqMj24UrQZpjdEC+TWRB15HnVQHGsSNIg19Be+bCUk7Z+QA163UFEr/EBdZp77ivO7uitWh7tzMKtSWV7DEOKF4fYDezvxZYHD/ELULPos9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:08.6533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4160600-7890-4766-c75a-08def691370b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
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

From: Sonny Jiang <sonny.jiang@amd.com>

Remove forcing the VCN instance mask to a single instance during soc_v1_0
SOC setup. Use the configured instance mask so multi-instance VCN 5.0.2
topologies can be enabled.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index db48bf2bc213..39224d4c9c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -851,7 +851,6 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 
 	adev->vcn.harvest_config = 0;
 	adev->vcn.num_inst_per_aid = 2;
-	adev->vcn.inst_mask = 1;
 	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
 
 	adev->jpeg.harvest_config = 0;
-- 
2.43.0

