Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD1FC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D04289F71;
	Tue, 22 Sep 2026 13:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYMYnCN5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6372E89F71
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH2ItKRapKCVOcoUV49jpwr+zoE0+kd5BWvQ2A4/8zR1vjLATcQAfAgD4X+lgizRL/oaJ08BMpxVUK1rR89V1skmEXEBoNUYjwN/wI81EgH5CqG8qurj97wihVK+AgWon/MwzFxLUeLW/Cgkl0HIZUmKL7OaErNZLAXb7MDgczonokM0lQK1XyRXQjqpJkuXwdnWkvlJktgBdaYpXI1nP2AN6oUnUdY6wLisjCc+OEWGeQ7rCZHC8IFEJcXnjr6W7qaN0udH1sMiIJD7mowLUSJb+dY6rj9e3xuCWoA7JWcx3BXBT3qZHDsS+abql/NNSHCe2LgCHoPcKKS5/uXQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIK+rYaZnlqWQ7jK9N59kcy++fBBeTjDXfkJoY2HY80=;
 b=E+vsvIbbSRmUBXCHwmem9OqyUt8ZKrn+FYoSyAzydtnqqV135fa5uvEuYibm41RBV50Q8/oKgZngV/Z37UjNn2PMzW+fH6aFcxgx8TPC3kjaORX50V//jRI2bg7PtivIlHXOJB6cA+tEBIpPy74vq64oQxaAfDM1piM9XYPRwnrWr8maBHSYfcc3YUl3R2nFOJXddBKT/GWR1xBQ23kug3nTiFoPyDmLfsyDa1eDBpReTqyNmrqpSDPmgAe6/rxzcNsS7cmMcva41HySBv02iCKU7TABMUZbVyhBK5PUYCmS6fl9/igWln+BM4xGYThIYAfzU3fPBrzn9dyIjJJi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIK+rYaZnlqWQ7jK9N59kcy++fBBeTjDXfkJoY2HY80=;
 b=nYMYnCN5ipFtdUz/0bVyuN9vpHVZJr6QtDvNJunMsBYSdEFE0JAwyw34Wh9P3b3AFAVuabzgmwvXZ5iV9mcupb+UGOqIxoBEYGKIHK614u5oMoPgbTaJ/SXJWoNpexEbAI79CymnL+V2s3deEfXOc2xaZQ5AOxYfL84MCUqvlUc=
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 13:51:48 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::45) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Tue,
 22 Sep 2026 13:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:51:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:51:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:51:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] HDP v8.0.1 Support
Date: Tue, 22 Sep 2026 09:51:29 -0400
Message-ID: <20260922135130.2145721-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 023077c9-8d77-4b12-b74d-08df18b0a3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: NopI3ess1mrtLmQcO13W8rbrd6MiJo74B1g1cQB3jnPj7SMgn2vUwUDKwYUGM3zrDkMf9RPGmMIA83Hxk5WrRd0At0VwYRjP4xxuiPRUJSBcEsEKnthxAWMK6OOCzdVFbXy3lN6EwvbmGbx6rAAa9jq+4fyalCY2fPL3zoHproE1hGhod0BpXX7SBkHcrH+5c179jof9AJxuqzTXwXm4xO42e0OWrrXt/sVWYy79ZcXC/dGcvr+SrIb5wL3GMR/yzRrtEJ2b2DDuOYBkRT1Yx5iKe3kTzgVIylNc7xx5uV0nB6/kyxcrjlju62HwNTOZS64TXXU4pPzgbVy2xGvk5uEcHEYZCLkhjIWum2rLFakoBWBvtS2S77eIA1jwZY00yT848BW+JrThCwLRZV5TBOJfrKHpqMCL4lx1V4oZy2r48Fynxcw0LyRbCrzadAM+hzhcpXZijKpuOUhnvmYTLZaptVzMjq4SQV2c+B+VH1YJVWttd5T2qwZ/g5lVxTJNuqLMBKQ1caczA7gXfpwN7wUNohVETA6ZxBQXDnCUHK7QF8T8Pw7z6/H9RQZELvHrA5qlB4Hiuqwe49EE4gRCEuCSPy9C1HY9i/4i6Ncu8UukJNlWSOa4jhimyRpT76c3oSaD23FI1zL6it+N/yGe2UpojlECcxFw/u+ibtUFlitEkdHimnA6kgl8ANFOrYqcTC9Y8GQsRavaeXZo56zDAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W8NRiNRCLhOhDwalvjLSylrFqozsfNmINUNiV4p0rfqRBN/sGx8QqOgsLKdV+ITb/iWJLlAC2uxR30kJ/GMUBoBlP+ViBIOdcHxDmg9qRTm9QkydpfSTPM5BgRZcAGPRrTJQPm0VldFzOjtuEUpLkwO+WiEGqHrrPmzJVwJrlp84QEJ4A6FUncF0Vkc5dmkkTMNhhavU292xYA/Jf6VpxeJ2o54dwnKe+wWPVr/7dch51zJpQdLks6LhJoh0BR54RbijYJU3xMGwmLshZM+3slgya2fdaaADp2wxC+LLeP+MmkLNdE9Pi/sRk/IfoHKoxxTtiX5K1A3H5kkxSrbEPjutiPav+NEyHSWWwGs8bA45KTV3/HAvYkWZdsfXEl6syqWkS6B5SzQq/ed7Ag2kSVn6RRHVV9gfFIjeypnaByBwT9mNjdD7G8kxPFYjXW1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:51:45.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023077c9-8d77-4b12-b74d-08df18b0a3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

This series adds HDP (Host Data Path) v8.0.1 support.  The first
patch is new register headers.  Skipping to avoid spamming the list.

Frank Min (1):
  drm/amdgpu: add hdp v8 ip block

Hawking Zhang (1):
  drm/amdgpu: Add hdp v8_0_1 ip headers v3

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c         | 132 ++++
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h         |  31 +
 .../include/asic_reg/hdp/hdp_8_0_1_offset.h   | 213 ++++++
 .../include/asic_reg/hdp/hdp_8_0_1_sh_mask.h  | 665 ++++++++++++++++++
 6 files changed, 1046 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_8_0_1_sh_mask.h

-- 
2.55.0

