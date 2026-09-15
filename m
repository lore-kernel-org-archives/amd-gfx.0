Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CCFC88E7F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2089210FBE6;
	Tue, 15 Sep 2026 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVhaCvv/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CDE10FBE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 15:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWMFmIukBIfkHvM+3w9isrvmJFTaYC9uOPgT611JD115LsPeVoHL/ITJkUy6YGmJ8H/FmzXaGO/m4VHSDNnLQ3X8qm8Pttdf2zN0kd9PkBO+HRav/iEiECRTUmaD2VRhFf8mOo8MW9HYzLZHYhVjb2ZgxIxecB2TSFwDCoysHtX92PPxqsvdfCAAddOxEU/VSE9FdYYYObfQCRsw1g1ta9mvthE4NMqxQX3xU8iTy2HhHTXiKx6ZnEkqWsEfIwAGO9biIeEiwht7Cv+ejb7479fdHUbD/PrPeM53DoLD9fbdFFsYJhM3LdbYy0Xn0zP0JLNFD2FKBXdfJQLIV/SBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIIpuleZA+l0gvEQ8oBLWWlRAE2i6/AvJcAYpXnx/nU=;
 b=a3VcXru5C10pnr9JEUF1stWEo2kgxwi1R+ptpSe8us7T8yUBoKGxL8PTzgX5c/6JBnq6eg9kdaW9acEx6UtqGDkdjxbKQSkZwyAMZCqCYoHMHUuEUUJgiLdAFhXvNYFZhr5i4yeYuoPP0CZJXF2Ozlk7NsFmgJMZ8DDOKDpfPVJQKooGL8BnGqTOPRLofBIdecgUMlYaEFc6aSXPdV4N9IA7Ii25nlpWEBVxglnngaPa1XrwDsvUcHjNWCF1oGG9tE3PgG7sJpvXag/G18rF4EFP0Hz0Ht2P2NVglEcdmoGOoTPzqWewj5lHMn914hkc1uCnQ4R5e43hScM2PR+c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIIpuleZA+l0gvEQ8oBLWWlRAE2i6/AvJcAYpXnx/nU=;
 b=IVhaCvv/VLTxmYbcmJR2BbGVGnhMVJCbJR3fRxMMPOHCBpJGQHwD2npFiGzZltofASw1k6di8JaYRK11XuhZx/Dgb5J0wTQOM4Jucb9F0uuMJWilZyf43uFrl279vwyqnrz7+hGbGN4Vk2iNE4ct2lx/ZVkrVhmXldeu35+uxqA=
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 15:01:14 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::38) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 15:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 15:01:14 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 10:01:12 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Joseph Greathouse <joseph.greathouse@amd.com>
Subject: [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE to SYSTEM for GFX 12.1
Date: Tue, 15 Sep 2026 11:00:13 -0400
Message-ID: <20260915150013.336222-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 78131446-5c9a-4bc7-29fe-08df133a2fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: XYHUsJpfLerjiKZfVI150HDbYdLfkL4R2lPaJBy1qe0sT7LzYS4C1t1rzNAd6mD6n4zpOyFYp5BxJUHFo+U+y9XlqbxPdn34QtQIM16P4bwlfVR1lFTSnLpySERQU0vqf4IXfgO+pew/+WkM9paJWTOmg9cdtyplt4o6WpgbUZTwtxnHylaJ7QKeFzfhdCZGfIjFppck11b3EEF7ktwLN1bE2QeKZQ6I8SQ6nIK20DD2/+6SdexydDmGtcl1tXhAsgM7LzIBPe1bAKIdJvBmA+H7/y7gn7gzeUfEChg/J/WVkhTlK3Ucq3db4/D3ajlfmoOpIrawd8ks6vo6JT12xH9vxJrCsa15biD1waTN0Xih9n01AjWeW7jK6yfF9AylWyRDjJfsYad4jQPSckmOQUnzx5FmFqbyuFKPlWedzP/rAV9pAZ8aGHfQ8XCJ3F1cjztX2l8oxwASPARweQrNl1PrGh8m6IpOPq0x+lBOXRDEEqd2PIs4WNTtdsKLUVdskuQnz3VTTXGdreOqcv08LvpB+5netDA37AawM8ySFc8SXJp25q38lGXcHXvkiM6939uqNPcyKqpL8bkxYqDyJdtaqiOnsneuNMw0DK4z5quJHN2BJ1ToziD4tRuFd8ExUCr+SeQfVkbudpMBXlO2wUtmkS5v4C4yZwmQzb5SB6yHb/DfwjIOTcJya8KNQPEkzoQZaq2Ha+fV1F63kYR/qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Lm1CBrWwJat3uRXjGQEZdB8OiqJVi5Cdi/5JlpJSYOU2ueUhEg6/nnbdTab4bWbVnvOqutLozPM7P2RIzqScWT0hd1S156LIEo5dbsXSjcu//8WqNK/nXD0U/0r9ZtIg2LHwVu1YDyURwfSIbNYLGnl7rvqzdSqZ6pfbaqmQ0pbnZ9Wa6w8hKQqXepTfbs4y/U35dlAR7ZshJbg8CnuIqU5cxUBWq/CYC9KX5Q+/8CWT8udrJNlUReSvyif8bkcCA/AeFOY5ZltOalDKDc19J4YQcT/zqqLEczjEKuZZiCKaBjG/tyOqYfxYcPHwerh8zCgP7YUzE1Sdtdf5GTSTYUZfD1m6Eoyy72PUWQY8ka2diorn/r8cBj5Q6KIKvGHSpiyYH5iZl/qazgigXwS7HsfyeuRegSR93WtpDGMURJoqnR0NiTxf2SsvFA5eGUw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:01:14.0341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78131446-5c9a-4bc7-29fe-08df133a2fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

On GFX 12.1, ring buffers may be mapped with a non-coherently
cached memory type. In that case the queue fetch can observe stale
packets, since the packet producers (CPU or other GPUs) do not keep the
device-side cache coherent.

Set CP_HQD_PQ_CONTROL.SCOPE=3 (SYSTEM) so the queue fetches use
system scope and pick up the latest packets. Apply this to compute queue
MQDs and to MES-managed queues.

Without this, the queue can consume stale packets for long periods,
causing severe slowdowns and, in the worst case, application hangs.

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Joseph Greathouse <joseph.greathouse@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index a69f9b9c5cd6..7459547b7a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1302,6 +1302,7 @@ static int mes_v12_1_mqd_init(struct amdgpu_ring *ring)
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, SCOPE, 3);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 60de32cb9ecd..29c20398c60b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -335,6 +335,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		/* GC 10 removed WPP_CLAMP from PQ Control */
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
+				3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
 		m->cp_hqd_pq_doorbell_control |=
 			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
-- 
2.55.0

