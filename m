Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D9606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oZDX4Ij8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0D310E04F;
	Mon, 19 Oct 2026 17:58:38 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3590810E04F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 17:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG1kvf2PCEaVw1FEKy9sexr5DbTooXWGHQl+rSa+ZBx7BxzZoP8oBuAqVAzdfzmTBLwX/3DvdM6bDC/oCKgZNBjbHVVENgkwVdL8HTIY41mtrTzsmhSJ5QZSdxraq5xtSVyAOUP3UAkkasGncS7YeQLYfHnYTfqnwbf/d4G3QryrjNgoMZrZWZclfJEjeuAmRu+5QdUSfQ2Et5OqdTmBtCzlNfxnUSlyAsi8CemlqZfeI2Ikaq3qbe0O4esAIbrrLutAj4//Dg9ugAgZsTTri5XqecKJMadNdqA+OcjTnoXG/5fC0kG9gRQ3XilhNKDg8FULnoq/73V+BEs+35wUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhRBrbaLIbcDUz5u9rSxnz+KB23aAaCKr2fJVvibRv4=;
 b=dGiosY4CMzqpPtE1g5Aq5xto01sQHYfz1PmvO0pQ03LkAkPkQtPq7TTLk88N0KaobN+HPoRplohxe/yj7La15DSwi+M3pYajyhcDtVCZq1MQ4kg8XkXBaHm+ZSOc9sU/avRm7ov0Elq7YdA20mk/c31ziCM9pI9QgzoSibZ/sa3lKsm0gfQKrjrTW4gSBaaiCSfVWCB50BVNcr5929amfLH9yDYSe1/J3ILQUaIlqSmXbpZRJB0hLIUqFz6tfewQRHngFcH7f6ivaRmKg964jkhJkBKOI763PIJw65a1GWCeuts+hpKxGyFPa/TC7O/l1Q0n8WKOOIlGTdkTe5QZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhRBrbaLIbcDUz5u9rSxnz+KB23aAaCKr2fJVvibRv4=;
 b=oZDX4Ij8x1TeVoKe8UStJFwRcl6/0Tv2DFyrCKtQiK1vhQmRK5I5n3Jkypj1Bto4CMQ8Dl/AIpdrAzbNri3AFi0n+dWdeOjoVu4daA+DeTqEBC1xI4wNQodDmATesK62HNE8o875pnMu+hv+cnBnMxxTj8Iwv89xQsOo30ofBrI=
Received: from DS7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::18) by
 SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 17:58:25 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:8:25f:cafe::38) by DS7P220CA0121.outlook.office365.com
 (2603:10b6:8:25f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 17:58:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 17:58:25 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 19 Oct 2026 12:58:26 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mukul.Joshi@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: Enable SDMA IB processing
Date: Mon, 19 Oct 2026 13:58:07 -0400
Message-ID: <20261019175807.970192-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b9a66b-7df7-458c-7f8d-08df2e0a9278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: NTfd+On6u0w4DXm6D63jCJDhgTtOWbqbyPV2pP3KlvDjEq9cV/q/Uj1zIEsklcKptMBnLG3wu3t+6/mVeYoOIuPoHiG6c3YXM4ZRXkbZ0yGFq2rplj5COpn7nEzdgU8Nk/K7Hr/FcSm4vEIsc82M2v38usvVXaXn5VqyoHu5yWWVkfA4/udZVNoeQuHMCzqPoI9bAThFpPE/zYopPUbCP1/Rzkv9vl0Fa2OukQkMG7wm+6B69X4NWfyRWLDsHeSH2ufU+FkMRr3p7vpOITVzHA9hloEWHerd46l7ugv4SwHvrM8VkMfOnHvWZmjlfDNxPsABFMgaCSjPMoG444zIQOUXE+wVHGZD+9P0rCDXOe2KXJ8fcspDoBIrlfn4D77uOHdCGQUU8JO3sOKFkNpSXfl9CG/poyUIOiatuCk1lcej0shhCkBSdEt88jknN8nrmwxUND6pzxQ9ertLwmQweAR+D/G9twVEW8TFzIGax7odURh64KpZm7A7mFp8w4EGk3J1hzURZxTeGoWhpJA+fWgjIYRKld02JM3KqqIVlbFH3A+0pXPdXHXoXM0cZ3OFP6WgBpD9G42bXvfYrkVNj7J/ErLr/gQ3L5vNVKrkScPFRNiVPRzKIonYsgr7nWkntNybIdJ33COMw58h5BNwR0yu3e3NiAWx/XOE9mRUn1QZ4AK3lJVrPfCRxsn/pNfd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b2VSOYd4fuNy/LeOc0MlHfmGAwxy+RNKXCXXAAy9YX53rm3a1KDCWtZxALsPP5oYYQNxYBOguCmilt3KQSDPqzsBETn6+32cZxUFpirh0Tchid1SR7sVnjcBiER/OAAfOAm3CGUfJznAI9HWzMNwa+NKLeqp0KrRK+b22Gv8vTtpDvYaK7JEHcZh7hFm9x2eOLaPqfnpJEc2IPXOJ7UC35UxysHl63HKGhl0tB/2gg/zPh8Z846Nvmhob8AtbnbcmCMBcxmUtrMAGoQClnYffFbeZ9DRbKrDirbSXIU9jwar+uYw0WwOmoTvz6f9xqAn6Dmw8h9VWpz2VdG6BsYwlGvs7tjkEoFhY4KiG3ojTZEJ7+IJjyp3efMgJ1RVu0QjJNB0MxDJrSROoOdoD5PotrKRxv1oqUAAH1oS2V/1Oh5G+PY/cu9t0+ARQD5XeoNK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:58:25.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b9a66b-7df7-458c-7f8d-08df2e0a9278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SDMA MQDs leave IB_ENABLE clear,
causing INDIRECT packets to be ignored.

Set IB_ENABLE while retaining SWITCH_INSIDE_IB.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |  7 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  7 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 11 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  8 +++++---
 5 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a8a1a6186..25f5a2cf02ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -396,6 +396,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/* Enable IB execution; allow context switch inside an IB so one
+	 * queue cannot starve the engine.
+	 */
+	m->sdmax_rlcx_ib_cntl |=
+		SDMA0_RLC0_IB_CNTL__IB_ENABLE_MASK |
+		SDMA0_RLC0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index bf015dc5b868..a1eecdf63b0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -478,6 +478,13 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	/* Enable IB execution; allow context switch inside an IB so one
+	 * queue cannot starve the engine.
+	 */
+	m->sdmax_rlcx_ib_cntl |=
+		SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
+		SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031caf..e0574fa325c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -353,11 +353,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
-	/* Allow context switch so we don't cross-process starve with a massive
-	* command buffer of long-running SDMA commands
-	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
-	*/
-	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	/* Enable IB execution; allow context switch inside an IB so one
+	 * queue cannot starve the engine.
+	 */
+	m->sdmax_rlcx_ib_cntl |=
+		SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
+		SDMA0_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 2bbf5e63f615..04e1575dfe76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -457,11 +457,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_queuen_dummy_reg1 = 1;
 
-	/* Allow context switch so we don't cross-process starve with a massive
-	* command buffer of long-running SDMA commands
-	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
-	*/
-	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	/* Enable IB execution; allow context switch inside an IB so one
+	 * queue cannot starve the engine.
+	 */
+	m->sdmax_queuen_ib_cntl |=
+		SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK |
+		SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6e6bc1ec0b64..80df86f7c4d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -569,10 +569,12 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
-	/* Allow context switch so we don't cross-process starve with a massive
-	 * command buffer of long-running SDMA commands
+	/* Enable IB execution; allow context switch inside an IB so one
+	 * queue cannot starve the engine.
 	 */
-	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	m->sdmax_rlcx_ib_cntl |=
+		SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK |
+		SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
-- 
2.43.0

