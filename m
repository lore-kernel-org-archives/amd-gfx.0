Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D3C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 20:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB5E10E99B;
	Mon, 10 Aug 2026 20:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrc4DAmm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE04E10E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 20:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlwzh0AODdeYozUn747nOs1phDmRIvWAARDD0thxXZK7QvjcxBDdVr3Xb8UmI51CTeIPmkVXJh8EYRQDgMovJFbmBf+4DQEoF92IO66h8I/fFz53UeZKY9eVpkYSENpHoPvXOaIeK31QoG8As7ISWuuuN+K16mjqG7dF5TNtDEGINbufUVBQy6MOvKgIi4mve/ZgNrR9dPuTGylcYZ304dnbvLwD745rzxzQQaZBpYO4bBi4sS4jeptKwp8z8t4eukWYYwnX9QYB1KU96vVUWMYrnPzSsXJF4FXRWyn/8uqxonT+umbX9sx2V7+qCZlvpL6TuQJ44LKV/swefMt5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+3sqzVR7QbrbXAFnkiUT4ATv1s2hbWF4ddyLeurx4k=;
 b=Imus8HfN+AgpngAfeParQtiIb7PoP8RIpcw+N9Kou3t0QvoK8Gv7Po3EKZyeovEADucSoB4UWuLAgvVHQrKFVvd+x/JwFdVfT36y/KXK6bnBIeSKPQcEcXZ993GEdHcH15JZuqFK1bM9jQyAD0Romv4MvTJc22Pt5ZaJJDtyDtvx1pP84W9g5MkhVya1fphiFLGH97omsFp34PiVe+6Hb/ObawuETr8+LmRtM2d+QBgSy7v87+EFZLnqsXeAl/ubAwa8PrGIDML9h2hUm4Dx5KeL7Y8DNH31CUBZV6sDfTE85rXtA5FehBdqG5RoyrHFufnNDgL1bBFyG6xpWjq0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+3sqzVR7QbrbXAFnkiUT4ATv1s2hbWF4ddyLeurx4k=;
 b=nrc4DAmmtf6AKXN0I2ghBKw76eS/+WrrXsE28/ZX2m7jto+iGzXzEVAp8BQdv+dzGTHo7CAyt0AATCFTbVRD4v0v9TwABhHY1vQVZ1BH7bIMGRYpMCTzXCQ8E8LQHHuASpoCF5pPDSVUPAt4s+d1kAjs054ttIyL1aRtSYTMbmk=
Received: from PH0PR07CA0079.namprd07.prod.outlook.com (2603:10b6:510:f::24)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 20:04:14 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::1b) by PH0PR07CA0079.outlook.office365.com
 (2603:10b6:510:f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 20:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 20:04:13 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 15:04:12 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>
Subject: [PATCH v2] amdgpu/vcn: vcn dec_msg integer overflow fix
Date: Mon, 10 Aug 2026 16:04:01 -0400
Message-ID: <20260810200401.1203733-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0f067e-a9a2-4eba-0e3b-08def71a8c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: k0yB+Q5jzq3JwSi2MHoNjUDlDBx6YbiiJszEsUCByTm9xbKz9CF4n2z1xpvvu6yeMLZSZmewQzujhPoH8uIqfV+X0IxAe/atArOzQCtCyXQeoqEKTUJ5CvV0JGFf15850dljGDcbvOYbdL+vjRZvXyxEREDjqU2sZeDrScu9puG+OTwuuqnWX4HHVzGhHIu7/n3S1yz8DYDpfBZKu5P1iwG9E8PKSgWBTr2Hh3jIKFd5MHyewwJszRuNnN5vJ7LTrPHBlNG7DgIqpJY2CWdYGEbqTkLndOq3VhKBwbg2RKdB1Dk4Y0DwcXrMkUKd+GRwjLfZXVBMIVhfNKoKYBWOOCrxU0UvIaWXd5RnNsQLHr9WE1ePrAyTDN3FhN77hVQ2GqbeuSYaMxP7CDA95nzLpzkbx3k/Bsgk5iqzeoy9XAGTwaUmRS9Pr4+u7pyKCPyAEEzMn1FeYLC2qUHKLtV4uysNM6qmW0yMdt54Lqv2AqDIaAnBQBGIuoTtCF8ubbiVcpVoOTgHujF9w4En8CwpdC/DkAzb8OsmWiA0egVHSm7xOvBySOZTN/VaDh7iyZMzetfIrucT643XO+w/+zfzyg+NNNpf6HoyO0X2JjZfNc4fQpdftP1OP0l+TieOnouazuEqm4yN0n8m0dMdMyOHaOQzCU1sc9nfnmI5whFkv+I5C+If+Wcu0CTD0OL+KbLV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2EbY1s+CzYcCjlgleCD2NI3TdPGtBaP70lczpEvRBuzfBhlwUxkiP/jIJjp1X2TskbPp41ei2D7KkpM58vWgclLgcWjHW9ZFZnfJr8s308aHXjOLudQ0SwDMWAJcq5ePuyjGmuHsD+CUdl2w1v8OJ9OxZ2ypigcNQzn5U6D77W3uAUN1wDdtYn6INOJ9bL9k0OT33xhfaRhFjjr6AE0ZXlXQrZnkP1aEcbuk8wyqz9bByvcJZoLSwdcFYdtY5TdqCeYxquZYQ8KxWpucdyRz3yHwxydauf6Rg0MlpZyrN/3kIQ3FBZrJHYzkjXqe2Mb1HY0XpMAWV0ASBlFn3nz85Z2wJILxFl/8kmPF0pdMhMXsW/9K8dDYY2SzkwplzoWfgTbvdfb0+gwSbnP4bbBICjQZ1g9JeDMU+yMwAJOv8PN8GgEk1vdT+RLYcfCz5TTm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 20:04:13.2165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0f067e-a9a2-4eba-0e3b-08def71a8c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

if supplied msg[2] in the header is too large around
0x40000000, 4 times of this unsigned 32 bit value will
overflow and the test could pass.

v2: using kernel helpers to check the overflow.
    this needs 2 checks: multiplication and addition

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..7a301cfe91ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1910,7 +1910,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers, len_dw;
+	uint32_t *msg, num_buffers, len_dw, mul, total;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1965,7 +1965,9 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	num_buffers = msg[2];
 
 	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	if (check_mul_overflow(num_buffers, 4u, &mul) ||
+	    check_add_overflow(6u, mul, &total) ||
+	    total > len_dw) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0cce78b205a8..413854fcf84a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers, len_dw;
+	uint32_t *msg, num_buffers, len_dw, mul, total;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1881,7 +1881,9 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	num_buffers = msg[2];
 
 	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	if (check_mul_overflow(num_buffers, 4u, &mul) ||
+	    check_add_overflow(6u, mul, &total) ||
+	    total > len_dw) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
-- 
2.43.0

