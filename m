Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91167C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E4A10E5E0;
	Mon, 10 Aug 2026 03:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5auswp9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E29910E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/kOZGCvu5l8duZvl/tU4AcEoH6+8TfyTZFg2wS9HOMW/yNiPnhQhDYk4cLMAQfstW3VrZCRDZL0cFt08n2C5R3QrwAzO6GUa8LnRiDF2TLMZOccnlS5aEMVXGLlNFsshNrU7TCOxllZsB/faeSoAtvPTMw51A47cxOvy6DBhT0MHEn8gAPce1bgf8wNrc77hH0HhvYwy1a+5gt1YeV3RBu4z7AZWiug4qPFCPw95wdqIKU/A6f1pYZGRxXIHydFZcnOOf7sxHcUYIa8GcZ9OFhjf8a3/rw5VczefSg2IfZFdY9IMon350u2KS1zHiq7g8PQCsCLm3QufTZpXXaN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWmDZ8n7egdjzxdb5lVvt/nIVlgtMW4r4zHXSBBZhQ0=;
 b=LHYjt2muXBDC0ZYnwGQ0cJQoV+mUAlWJKeaHWWjvQNafOTa2tQkWp/xgG0YySfsxTg9ZwetXM6WlZ7N/DwbGNs3zWbahHzISLpY0nP21AV6wGvvsJOJC7eQSXfiTBGuTEmTF0QG4Oc1locmVXUm1LqU/RJ1tydUrajXZI6GC2hC1YaJjh9DbuuKT8JF05ETcobbZqcgVLdqRYeJ1WRIqeYvGjGXL3yZEI7jpLAgXAtCzZUNchKGlbVNtBJn66IBnV0sjK0zBlkDt4IO3NZzgarCwITqr4qvC0O6vJJ+EF1CNdyptp7W33BuZCBJj3k4C4ySaRoNWE7IJTv3TLmfnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWmDZ8n7egdjzxdb5lVvt/nIVlgtMW4r4zHXSBBZhQ0=;
 b=Z5auswp9Vsbl4ut0PxkM4U0Rp+gTTCBB1Kk9Nb7A7r8qxETnSj5IOAgolakhGBjgwSJfv7UQq6+iOjCcSd24qFrJ5u0tl1jYETr83jS9nSjMmA02smOV+gBQAklivfenEAtXvhjmfKxUKEYGG80UOxTQ5cBcuPXIFHIJTa/hWGw=
Received: from DM6PR06CA0089.namprd06.prod.outlook.com (2603:10b6:5:336::22)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:08 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::16) by DM6PR06CA0089.outlook.office365.com
 (2603:10b6:5:336::22) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 22:41:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 06/13] drm/amdgpu: VCN 5_0_2 disable VCN_RRMT
Date: Sun, 9 Aug 2026 23:36:37 -0400
Message-ID: <20260810033644.118194-6-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e07622-a892-4f12-be45-08def69136b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cLT4Dvt6pgukLToxsMN5mR85O4sRShkqeW1SX7oHa4eKDGxa+SoxgjW60OR2EtHBjsRQIObTuVgtYh2vzOI4vTZqx6+QP55mKfC93tCBzLfFwk/Q4zjqlCLuD+8Bw4S75L5uevaNIOHn97BjXHf+uykSUBCFAsJ2RXWZ2gt0Y4I1IupvN+Ad8FEWjWjwvBhUBum0fFGm7+BbUp1xXgdcIx1csMr6FBsr3GVTYE83yzALulPD1dyGQSca30Rt+SOLIhUVXXBikwjvjqLkVrZoGdpRGgUbnW5LVr7duWUgl9iSGusAZiI8AWSy90dLFNcfS7c8HUM3/Txn853A71N/aNFJ+Ruf0UBs02yZONFIK5RwSB9hJnqimbGCgy26MqLP67t+LrDF3hUn0O9Tur2QHlwvMZuDn+V6i0SZRdTgUnyYHkzadMrrVgcwL2LFGNJyzR4qzirNBa2Hu2lXnK8ZjgKa0xfylhZVtL4tI1Q78dVstJ9thGB22Uv5Pk4EW7nBRW/TEbDFKR+Utk7XRM0lntN3/b0OF0ZuthI1lYk63CqTEx3l6f9CywHgGjffLKHGXx2w8lGNOO1mtZVoNlacyXFIqJP7XCAQClZ/DIxjirX4ZnzunSOyza+Cdlz6ryhq720EH8bhxriX1ORHQMYOGwXbi3iZ/tMFO1O5n674UukVJ+e+tyBEJablcn+5WSWZwqsJbUpLzEZ3NuVi2hCHiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sgK2bQd91Lr67csFFuX8f+bhowLSeVi4sxyMAbLzAllTm4k7v2n3sfrnFLgHCUWi2+8/gBrWPs2ID2OHSy88agl0PhC8eUyC4cVWt9l3nqh1Hw414fnd7SKAhniQXLOu6coOxkPo/rhrGtorKRXT2th17kUmHcCx4IykDRRzckXfiNWeZX3ynRODD1xC3m7zFd353ybCfBsbhAvChPbEe/H1ck0ShiFrmB2ky6/WgT6oUwi7paxynQEC1BdBC6lGgzX39x8cQxw+MTqe7tBr3HmMPTz3QaOEdSVxR/4XKV32xHCBoCJ10fJ9m5zy0isVuzeq2KlJSKVwf9msXrHKgSB+VNuhXssWOvLTjrpGmO68giyT17rSm5pusW3tqC+WCURqc/fYQ38nA6o8Of/bqra8ep7dSdgC8iTsbpX83o6yJu98kcc6y+49Rs5oAeUy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:08.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e07622-a892-4f12-be45-08def69136b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

When RRMT is enabled, VCN firmware's register access is remapped so
that VCN instances on different dies (VCN0/1 on MID0, VCN2/3 on MID1)
require different target addresses for the same logical register.

Remove the RRMT capability detection so the driver always assumes RRMT
is disabled, using local-die SMN addresses for all instances.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 6ffb34974a0d..2842d8a9b42b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -208,8 +208,6 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r, vcn_inst;
 	uint32_t tmp;
 
-	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x200)
-		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		vcn_inst = GET_INST(VCN, i);
 		ring = &adev->vcn.inst[i].ring_enc[0];
-- 
2.43.0

