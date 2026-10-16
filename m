Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C9CCCF2C4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 19:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EA21129B7;
	Fri, 16 Oct 2026 19:58:14 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A802C11299A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 19:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyhrwHIOhCB72b0XvqZxigzhOP/CTvEDidCrIotek0MP7QyBmlSOobUoOxfAh6D2x/Aika7/Mauic7hxV/SoxPPFg66H9ucVEb7LTr+Fh2wz2tOFx1lt6/lHX2YxxX/fTFKD9YQc/EnbRyATLU26zzh603+w1xQYO8Daz7yfRzZoAw2IYyjnTQgR8iNHbaLGegAUNECTfNYdE+Tg36FXeQAGxBaov5LYb7hWLGJS4nxc+Ou/jyaba7RtzV2yGv2UWVlBjeBeLqEzXEJ+s7LdoY0idmm0TtEn+sHMeBaE+4lHj9iI/5z9ZUurpMeb5s2ZMikbmgivufSukvrGEOmKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLPrjpCqcI1rZxR+kXdwgMJX5V3hnShKEtJxilAV6ZQ=;
 b=MFeclk6Js8pvc/LbmLJaVRdsN2vgk1wV5NIafGa/k/AfVXIzNegsMrmqgmfLcbSKNPYxfD39xhQOCxvj0w4uk/M4+2zlpOexWjnVVoRwysyO7ZKVUEGlb9gjv8RrftdzsK+TMmOeA/pt7Gx9jBtDPQLYN71U/JIotjuBcVjgIBswDCYlGQuy33t/YPcAJ6QADUY7DAknXnxAKdP8c6n8b4AHUX6gNiIMj8Io9WjZ2RA0Ckf4msvaCCTpYUclHFMVyPCbXjzYnOkn+zF2YGvDGGY1HDAphIhIMrtlgPP5FveambmJno9Jih2/4DuNGOZfe7OgFFvxh5jcXmhIKYhPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLPrjpCqcI1rZxR+kXdwgMJX5V3hnShKEtJxilAV6ZQ=;
 b=nja43H4ULwvMt7WemY0uTxYl60OovOAARuMb63X+XthUQ3HdW61QZR6F91oym1bLGZx93OOZNP8xQARsQyhauPv+xQurW8nal0kwJA7s0sR4u+8FPp+jW1QdFGVqGh1YwlcO1wFkb3ktKh3bQ7OngetvUEszKDE2yUHExHP+kcA=
Received: from CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::16)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 19:58:02 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::23) by CH5P220CA0004.outlook.office365.com
 (2603:10b6:610:1ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 19:58:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:58:01 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 14:57:53 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: enable SDMA indirect buffers
Date: Fri, 16 Oct 2026 15:57:48 -0400
Message-ID: <20261016195748.418177-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddef77c-0691-47f1-b7df-08df2bbfc8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|6133799003|10067099003|3023799007|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8cyVT9kzf71b2XA+VdvwH1nbGEZSmeSXpEVflu6zr2K6KqJvhAw1MAF04zpv9Evlrnji3q7y4Eppe8C8764H3mTtVSiHhu9gCl+HHlKSYLRehIauBtazn1GQEDS4oNy57aHaKLzeJgfhtW3fYZB/2ab4xrqH5yCSn7hKh1smlKZa+0vSsV9IoECxXCV1FPO8aVg3MztmtXmOgRqvWNgMwgDm3dB6HC2YrWVZxFNeXX5LkOG1o9PuZjGGVqYsCn2+GM5CNW394CY+7W4KneB0N/UzxuB0j+NYy9A4cQI6+oGd8EoBvgBRys+5YxEEZqn4lkp7FTnZTxh5QlMTdk0evnlIredK3/9JTRa0WrpEnjZPMi11zvLsbySpWxZsUj+1rnXgrEJ7OQf3YkZMaJclfLEOWDJNqXJ47njSaTxJWicoGux/Re+3kbn/UOC0XBt8qaPAOYRGhOScT0HohTkIs8zmQsfW3CSHa+xAT1BoqE42DE0lg/f/W3GrZLGVCkwloLD3eJmaxonoLrAth17xEzS7/YJJWrwIYXHQa3E8KUDduBNEgxzgvD9bfJ8XD0IDUVqvHg24L5dAh844X/r7iiJB04hMfae4SgWLbSzqKgIoJ3QB6g/Z7W/1KxVMphlmEtCVqcMB5H77RhPgloWGDj+vlFTJeSNpL0o9aB5tlqUxMHM7/WXQYuLE1Yb1ldEAd3LRadDchh1hB0icroVR6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(3023799007)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zZgKdEvlh7VcnH/3Ba7pdbw0T9TAc0RkApoXlew2L7P86vdAo150P0kJSTcs0emROu2ni3JXfUORORrx/FNHj6ifbZaubd0RlEHZZc/e3jR4W/9qgddssw2OVMXPdEQ3GHmKptNi4PUiHCpxWcXEf1JWtDJmTJJqOlY/wZrSOaqj3H9gv4JaAVegzHxliG0LTejvQ6NlQ+gKCInGR4+oLCfBFR/t99iuL4xlNpYP/f06X3lAWzv5WXT3glGbpNJdiL5flwNqmiIf1yIvmEHDDoP3VOvMDZZCe3MfZShQz8r7RhDN0ZQ3ZtMuqzjIfQlz/vRIi2t8pqPshVcBs4VQ5C1i1z66Uf9nEDE6H8A68iWOxooAPPATcZoEnKUCDIiHD0deFKu2CcGUu8P/8FgGwT8tZXYFktf8D5dY66yuI7RQ4CKHVrh6GmMrT8OsJB3d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:58:01.7763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddef77c-0691-47f1-b7df-08df2bbfc8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

SDMA MQDs leave IB_ENABLE clear,
causing INDIRECT packets to be ignored.

Set IB_ENABLE while retaining SWITCH_INSIDE_IB.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 10 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 10 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 14 +++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  8 +++++++-
 5 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a8a1a6186..ee7076db300a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -396,6 +396,16 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/*
+	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
+	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
+	 * of a long-running command, including one fetched from an IB, so
+	 * one queue cannot starve the engine.
+	 * sdmax_rlcx_ib_cntl is the SDMA_RLC0_IB_CNTL register.
+	 */
+	 m->sdmax_rlcx_ib_cntl |= SDMA0_RLC0_IB_CNTL__IB_ENABLE_MASK |
+	 SDMA0_RLC0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index bf015dc5b868..4ed00e2d7bf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -478,6 +478,16 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/*
+	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
+	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
+	 * of a long-running command, including one fetched from an IB, so
+	 * one queue cannot starve the engine.
+	 * sdmax_rlcx_ib_cntl is the SDMA_QUEUE0_IB_CNTL register.
+	 */
+	 m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
+	 SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031caf..3f2234edb1fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -355,9 +355,14 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	/* Allow context switch so we don't cross-process starve with a massive
 	* command buffer of long-running SDMA commands
+	* IB_ENABLE makes this user queue execute SDMA indirect-buffer
+	* packets. SWITCH_INSIDE_IB allows a context switch in the middle
+	* of a long-running command, including one fetched from an IB, so
+	* one queue cannot starve the engine.
 	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
 	*/
-	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK |
+					SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 2bbf5e63f615..e71467862436 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -457,11 +457,15 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_queuen_dummy_reg1 = 1;
 
-	/* Allow context switch so we don't cross-process starve with a massive
-	* command buffer of long-running SDMA commands
-	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
-	*/
-	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	/*
+	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
+	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
+	 * of a long-running command, including one fetched from an IB, so
+	 * one queue cannot starve the engine.
+	 * sdmax_queuen_ib_cntl is the SDMA_QUEUE0_IB_CNTL register.
+	 */
+	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
+				 SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6e6bc1ec0b64..c21091745869 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -571,8 +571,14 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 	/* Allow context switch so we don't cross-process starve with a massive
 	 * command buffer of long-running SDMA commands
+	 * IB_ENABLE makes this user queue execute SDMA indirect-buffer
+	 * packets. SWITCH_INSIDE_IB allows a context switch in the middle
+	 * of a long-running command, including one fetched from an IB, so
+	 * one queue cannot starve the engine.
+	 * sdmax_rlcx_ib_cntl is the SDMA_GFX_IB_CNTL register.
 	 */
-	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK |
+					SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
-- 
2.43.0

