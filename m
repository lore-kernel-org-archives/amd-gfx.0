Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC8CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C6F10E55D;
	Wed, 10 Jun 2026 12:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NLYwRpFZ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EB410E55D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwkCAWGOCdMUlOT/2HREWUOW8JfLxCj3hVL6cw8PgoPqsjvURNIqI/L/gGfXaksOv5zlSD70hUu/iegB4lhooz8siHDMYHYoY+kLx0/+HAEHoPhnDyHANoVaU4uSqhGZQqWrhZMXoc/eGthvbmCSQ/lYqCdfuQqhTKvMfURzfdtl9/vPUSEcViuCJPEfExSp4WL37/WxZYCrTabh4D+w3VnasGsUVKxvYJyShpk32C1TJCfiAsvAnuXfI0fsQiKRCPlvIAY8shfROM72eG4Z93nSkh6SFQI1DPV2nRvv8OSHqCQDUEZHomKnrWfghgtKMq+k+8DSscyzSiaw0r921A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljj12r+yiNEpcbP1O3SOg6RC9y8haSEzmfMAez8aLlM=;
 b=W3juNurMr4qo/2ZABUUXo/fsMkvg87oKXScgKL4rHeF2IzJ2d7VbEjZF4nsxI+szokhIpGLkg35mWfRcUp4wskpttqH4CDmyN7b4KigPuCuqwxegx2S/YOFDxLoa+tOE7D4F/A33q/kHdAik+4ZjmIau4XkR9ZOBoAOL5r+nee9261kLDEXxpbsxjzLSuIFj2rFdD9l4ZyC1sokxr2+BZo+K6HbLRCc9PLAbkZ2E9kxepNXQemM+I4P/FQ7rFPke0ecBzpc5MQOXbftuLTCdGCQ31DMkubpXuBtftzh2L+/lT07mSjZhieFO6z2dS+yy1hkS9HPQ9WWyDz578iwIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljj12r+yiNEpcbP1O3SOg6RC9y8haSEzmfMAez8aLlM=;
 b=NLYwRpFZNKapeR3zs94D9RCGbVgvtxqQD0c74ENZ1iPp8Zr+szzlrXTpQE4gOqAxJZViv0EM0dQqamMtHzLe8vdy5NxYy4INEe8Vci3KzOHGLGdaDtHE/DFftuTCYcaEkxmCLiEwx8ac9tbfoCoJPI4rldGHgX77Q/cMZ2/A7xk=
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 12:11:49 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::2a) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 12:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 12:11:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:11:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 05:09:47 -0700
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 07:09:44 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: smu_v14_0_0: fix pp_dpm_* clock reporting on
 SMU v14.0.0/v14.0.1 APUs
Date: Wed, 10 Jun 2026 17:39:40 +0530
Message-ID: <20260610120944.124040-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 232f9f16-cadc-489d-6dac-08dec6e9728e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9VMpguSklcDy47NTf0rO9+vpage7JSU9X1XstOKpIhg12+n1MKp9s8ESkmmkNdUrMo0abahvK8gD0oY5s2Y3ZKgQRLzRhqWzRcJOsfgCgZsdWIUf8HVOZo1Tc55EzX5VQBapmu9iFcrcjkJ90oAJjm2U429eXyNYIqzvV1FnLV+xdzr1D/Oej9paoh+asuhFWtIcD8axa7WVahUoD7EhAujWtECQYwFMmwo3g7Lx0PLG1GviCvU5XhJUcRWjN87O0ruw3/v0sZag1GrWO12yOHAxdFbWplSZ2oSL+pUzVU0LMhPY4dnHoGdqOVVBRt+IRqQZ3zikKzE/ZUh9q8l4hQc7rl+Jcftuw0Ek8JD4s6/PXPynSY1GMPPjaDk31W7QI5IiSyScl7QvLjqnVjzaahsJ+k/8Iu//HZCoLJoBOuvakMXcAgIA6YcyGAMBXiI5xTAn51O09c0owAFjNbnsv6JqmMFf0IOWQ6oe16oIHqt0D7Am0q89uG7zxSWBDnfDsrOMjGZDw9Cl+RzIsHvXaTghK/CznZt47jrjmkfmHTyen0O6YkACtPejXfrZB6+ppMlefxHTsp2w4HHhwoA9koLtrVMPDrYEZluSzims64IBo38WzybG9UPdhVlm32KUsXBppQJXQuWB0zB3O4zUh0FcGBMfqBqcJtMOhgbs3/IXLXj/Q+cVoBxb1YJPAwDHXYJv/me/Nyo5bBk+9ki6PEfONdXeLvPHtoxsLrJ47S0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VZF7awjSDe72i+yc+jQgIKEjok1qVKTNrtvh16nAU43uIvX6e8Ocy3kg1Z0T97FpVPuG0h9i8NPxQpZybDCr6HAI3oDh5v16uuQisFlaq5P1xJIu1+kz3y535VCs+zyI93TAgRsCDT0+sNWFVsEEgv/mtqcdVw2IvPc84fkhsIPW/uTrg/Q9VABjH4UQZ+qr514sHVy3lysA+kloeGlDDcMY628oAFUAD4A3tvD/cdk4sckVVAPDB3mhfGzdGoGqb4ncaV0jBAgzq6UPwXSrdJJRzRwrGs6z+pWqvWR9CIg+DjS5HhGZSFdUMqgboQujcTHQEC7cv+WNaIwYFxqyVjbP456Iz7vMvneJAT8w4+1zc9D5/nzGG5yBlfIGzN3tKderG7pN6AEpfdkkWqP18fcrzK/CtYxMTAJQPxoumnJB+X1J57Q1Nbmzt+HM2aYS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:11:48.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232f9f16-cadc-489d-6dac-08dec6e9728e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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

This series fixes multiple pp_dpm_* sysfs clocks reporting N/A or missing
the * current-level marker on SMU v14.0.0/v14.0.1 APUs (GC 11.5.1).

Background
----------
On GC 11.5.1 APUs, amd-smi reports N/A for VCLK, DCLK, VCLK1, DCLK1 and
DCEFCLK clocks. Additionally, MCLK and FCLK show DPM levels but lack the
* marker indicating the current level.

The N/A clocks are caused by missing IP_VERSION(11,5,1) entries in the
sysfs visibility whitelists and absent metric handlers. The missing *
marker is caused by the SMU reporting time-filtered average frequencies
that do not match any DPM level exactly.

Fix
---
1. Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
   fall-through case mapping both to VclkFrequency (SmuMetrics_t has no
   DclkFrequency field; DCLK tracks VCLK on VCN). Add VCLK1/DCLK1
   metric handlers returning 0.

2. Add IP_VERSION(11,5,1) to pp_dpm_vclk, pp_dpm_dclk, pp_dpm_vclk1
   and pp_dpm_dclk1 whitelists. The target APU has two VCN instances.

3. Add SMU_DCEFCLK to get_dpm_freq_by_index and get_dpm_level_count
   using DcfClocks[]/NumDcfClkLevelsEnabled. Add DCEFCLK case in
   emit_clk_levels.

4. Add closest-match fallback in emit_clk_levels: first pass tries
   exact match; if no match (averaged frequency), mark the DPM level
   with the smallest absolute frequency difference. Reverse DPM index
   for SMU_MCLK since MemPstateTable stores levels high-to-low.

Validation
----------
Tested on GC 11.5.1, SMU 14.0.1 APU. All pp_dpm_* clocks now report
correct DPM levels with * markers via both sysfs and amd-smi.

Priya Hosur (4):
  drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1 metric handlers
  drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
  drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency
    queries
  drm/amd/pm: smu_v14_0_0: add closest-match fallback for DPM level
    marking

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 76 +++++++++++++++++--
 2 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.43.0

