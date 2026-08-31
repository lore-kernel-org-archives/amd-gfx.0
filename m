Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2CDC624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B5D10EA9C;
	Mon, 31 Aug 2026 18:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SezOtBOC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0ACA10EA6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us+GOcBHJoz4JBaO2afj7zAtPtpXqF53l71803KZ9vexxAcsHRZR5bhBKkLsdnnA2JHXTZAVlEnfrovCc2e/3VsjmOAR5INEThCLxrw5G6q6Xr5kJ9WI799IlA3EHZOHrD5EeTUIJPln5j0HWe8o3wDpP+/o/fSqeRXSJfEqbEdysY2pODwSJw5slk29J9Im3GQ/d+3m0T9bgY31hsMvU0J2rfSmQIpYdWBFJ4qWYT9CeYmZ5QeFf97F28HIea2QryIb2pVhiyGNb5vASo11VxpDIihedyM6lef3FrHUvCZER/m44nHtpJkEPVaImXhbtwlMUpTgLytVTflPunQy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7boC3cHI2Bj9A7r87yjIpMyMf5p6sbOp5ldQzxwEViA=;
 b=Pi7xtKZIhPogmTswVlVzMpF9Xehb1rnTsVqDGYrC0t1KQ2vOwBuuAbgeDDzJ+8aBpLTNafOKOXW+pRqkUJL2voymO7F/9RrNAIvd+L4nnuCnAfW6Uv2MSL0uWDLOWZN+Yh0SC/W1k4ECvKzodwM2lNi6qsS/m1tdYfpE9pScig4u/7pI8md0sTBou2SrT4s26Rv6wki4bETritL161iMM72RjEt8RWnCPIuBsCQugGDfa0DWrKmanPt5eYVEpZ3b7DZ5fidhxsoSHDv5uUI1yFXMIpD5kvk8f+rp9q3rLhyvOrYImzkLngYDwp2zBk6A5DYlygKO3zdouZFgsdtbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7boC3cHI2Bj9A7r87yjIpMyMf5p6sbOp5ldQzxwEViA=;
 b=SezOtBOC+VG0SAt1cA/ScgxWcL+Qxx+DJ4AHVhbtcxHCYyDwum3DVwj2cyGJIQ+36z/RdMZdauoLuuezIPeIAsBFgLkyGyyaKqZ7F0l+TS//oyenJ9cLSAedmDl4okRdz/QGlE3uJzNXpEGGw4pNYVF07IJiSUi5qJalO5IQg0U=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:08 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::27) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 61/95] drm/amdgpu: Temporarily Flush TLB on NPA mapping always
Date: Mon, 31 Aug 2026 14:27:20 -0400
Message-ID: <20260831182754.1089811-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: a811f5ce-be99-4769-292b-08df078dbd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zS/6GewXUrcX6o8CUt3jR4Ea2jNQL1VH7VOGePH6r58C7YjuOserzxftIwclmourLBmMVgmZWJtR0kqsE8rf/kTTMDMtvBkPuX0fUUJdc8OIBBc2qeZG2HX1tanX8wyUAL6ydTKnrOyS8gzbfOprn8T7yWxWvhqUS+/9El98g8o3xG19VGX/H5rI6zObWcqBQ/tzvYNuJ3hw2422AglmTkDLlHz8sdWRFOs7Lkxht+RL8+5zsCDy0oDmUd+iIeVXs5NyxqF/4JbvJZZtP0lQVkqQ0BgyyHTJKoEI4vIhD98gB+0RD7JyZw+8t8zxTkS3dwhT5l41nRzu8fG9HYgru2+TOJZFCmaU4RDPgV8bniodAV7l5hUu3UOu2XBLVUfv/ewRhVpKUlONZDmYX2h2EbHBOVovd81/dMSGJru/+ZzItGiGM22u0FWz+FvQMjwu6XC7ID6zol85xRmOoy1DVwuhSughi4eGcp00LmEKDtV33IyZUaT9N5B1k0YV5O4i6Q4OuTTgFvSHvWBjjHkmb47PgESLF6R3shKl4Sj2ZEDdwqsP2gWtQS0CDHKKLgT4B2X4cpb1T2549NkonOyb+TmyHoG4/D97p4uE3uVvlnNVshWRrKXEMfdpWxn7tRza44kgNDq5w77iyiNrvA2Ezq1Wx7/42l7UKmWsjTEQK+xOiQlG3MVcpt/wLorAMJEY45VJW40SOcmqBST4OVnlTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KPXRG3KyOvKyyvyScdqit/jxETRIYW0Kikqmc7nFVZHMwZ9dCxjR2hoI84FeavPR+p+tA7X5guRptkLzn5OWxpzGE3zmvH1UT9+R4PP+o9ornRZhDMOuib8PcjqhLxAWcpCkWLzBu1sueFXgl8WoYsSfJQcHkBS5HK4gK1ibQds/Qpw58u8d4kemQroekBqJnN+KW9HH5pw72it+pwpF/ar4EcS+XDklrDGjU0Nn8OHuvXUH+M/+UouL4J6gyuZWKLF+ujEQKYQFbno5NI02TColpWJq7jUeP01UAdYR+Z886LSE3SVzc2FY7QJiioa0qQORQ5m8+45/9RE+R//Hwy4Lx4qPNXpFzP8rwfV8SCCw2c50mx2+YW5TMCH0CFVriZqjvi9IjTAang/6RFSkPW++PTU+aou3v+byE3LlBxHy1JHvCZEONo/5l+YiaIKk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:05.9750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a811f5ce-be99-4769-292b-08df078dbd74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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

From: Mukul Joshi <mukul.joshi@amd.com>

This is a temporary patch to always flush TLBs when mapping NPA
addresses.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8d767a91172ca..69cc35c24a2e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3713,12 +3713,8 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 
 static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 {
-	uint64_t tlb_seq = amdgpu_vm_tlb_seq(&adev->ualink.npa_vm);
 	u32 bit;
 
-	if (atomic64_xchg(&adev->ualink.last_flushed_tlb_seq, tlb_seq) == tlb_seq)
-		return;
-
 	bit = AMDGPU_MMHUB0_START;
 
 	for_each_set_bit_from(bit, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-- 
2.55.0

