Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7B4C28B26
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2227010EBCA;
	Fri,  7 Mar 2025 15:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/RPVHnK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA2810EBCB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVTC2+ZsIIp9hGKVMAEYkM5dIjmlO1NYJhElrRArjX141SJGqQitdSCP60iYcIx3KylqR+KO5p1zrehyHunA3+dKLvskDQC7HKGT+Er4aS8fiNdkst3IcbDQGtbZL3/PHIw1i9+OkVQP26sP/cpMhu/+Q+PdvhUfS0KKwHazQof3vY4mGMeo253b0EZBIDHIRJLTS3gkd45fxucHJIScNhMzXd4NWoX0UXAP0KNrknSG1R68FuifUUu8w+r2j9rcQZzk/2aN8iSGSYySoneAy3QS/Ook9xWQ+WxWtS8H/XZ/19QZXB+9rutQ4wiX7nCiMcz4vY1IgcpDPSjTtoHNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8I7n4FYIXL5JB19nXbhRxggfIlhsfRJ5RC5fwuhqOY=;
 b=EApwAOnOsWYV4gfP3vcDt1Kfs9IuSjN378VUjeC02CTFE9etRz64biL0xx6t1Ctb1FJsS+7Ldf3tKpYL8doOYylNkA1TyOz6CgBMxgC/sFXYsbdymOyQ43KAqp/aFOxEWtwtmlSrmgJRg1MUbOfNHUmiLAlXUanK5fZea8lTGlW/qTA4tHHOcAr4WlA2rIHrklfubMVLDuQfFAirihkDp90AHRhKO7MypsA/eUypbidj8jQDEsL8Bote+l2sP368GpiLOFmzqd/m4XLIrtMf0HhwmNOVtfXr9FP49XVAaHuF+L3WrFk8uPW11UEOwZ94/RUFpPZZZgusasLLfPjAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8I7n4FYIXL5JB19nXbhRxggfIlhsfRJ5RC5fwuhqOY=;
 b=2/RPVHnK7XLNou+2q07ii25hnC7fwZFILdlVxd/k7mgPRQpOShl2GHq9cjR+mBlMq03DGb+NxOSBESCyUbKngCYoRSJ42ScOq0v0eZP2E5z3j5u0mkHOyR8JmeTBq74ox46ASgB9b1gwKQF6fohKs8LLTXhbFjXZ+YGGvy+ZDII=
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:16:22 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::eb) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Date: Fri, 7 Mar 2025 10:15:58 -0500
Message-ID: <20250307151605.946109-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df727f6-4911-407c-f76f-08dd5d8b04c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SsRQ75mnJ0MCU6NXkSRQA0Vc4rImHOxpOfOjbxqos8FXtKBTcuveXxukuqIL?=
 =?us-ascii?Q?e5VLImaqTNpajMyleCcquOKsHkhq+Yq4GKRs0NQSneRVQyaw8D7OY/WOCpgx?=
 =?us-ascii?Q?0T6UdDIhHf0yc0PaN8uzgkUW1gb2LXZ0RndR8426AIOSB1Ut1fxSr3iZ761j?=
 =?us-ascii?Q?CGpuujYv/2RCs9gP7+RQbpyOv6VKQltLcweyHhir11hDlKmDDvBuPbuZfYTb?=
 =?us-ascii?Q?Tl+KwVUqXkowiOiDM/ayUbaf961mDJ7cC38rj62DtWsNXM5kForIgPhhWGvQ?=
 =?us-ascii?Q?3hy+8zfpBct5P/knTL6gpN9fYdHXtBnGThYljN2+VjuyNB0XyEpHW/c0rfAh?=
 =?us-ascii?Q?rJ225peZZxx5l7qdowiqMDvTAdoOzuIHOJifTQAxkrYAyuAkne/PFCzrTJF8?=
 =?us-ascii?Q?S6Jzix5LOXMecOajL15xsbUsReb2uXPcOCUaL+u4w7DtetH0EMFeXyFgoorV?=
 =?us-ascii?Q?NW0ckw4/rU+zDhSfAUWBAS2YunSTSGS+LUK8iOE0bGPAvRu48cZvn1udkdjv?=
 =?us-ascii?Q?gahrZcyLXgl+6jd6AGAyeLLt/LNpBL+4AatLoCHVM7nGJaxYTwdgfelBK/w2?=
 =?us-ascii?Q?9LibHCkCa692g5Z7zAPzqOiYJBTPEkyGwxWi5diFsq7bGFGHdVwWqnIGAY3r?=
 =?us-ascii?Q?eAtEeR5AcYccFT1kFcBNAAs4xB8DPBpyZSfeClIl1NCGQF+rhHXjADVh3b5Q?=
 =?us-ascii?Q?ymHVr13+JJec4RpZNn9F5YNXo5iQ9pwZ2U6d0zjoUsTjbvEC/lmlioOtk5fM?=
 =?us-ascii?Q?up+KA+7p4hQPZ9SwZWj/uQVy9jwIprkrFXa9EjS+ht9iZnlwm/WvIjVFFlgr?=
 =?us-ascii?Q?H6cTjmha91fkcGCmxPPFLi7Ei4cIMpsDc7S6TAPRxJUiYFWlvugo6jIzanIW?=
 =?us-ascii?Q?QmFoOBP/cTmgZgxOapXL0A8qdRNwsb5vy6Em1Ilv87F/xxFyneBPEOdh5ahq?=
 =?us-ascii?Q?o2EuRQqw4cnlxJVCJPGw79c+5vv9Zp4eLbWWxGx5OYNpgxVBRtTuJqblCAsL?=
 =?us-ascii?Q?FdGgUdSgFSyRj+HnD/iikU3aYXyojnmZZ/dnODKiPC0xpU+b22CxVBZ2SfOV?=
 =?us-ascii?Q?0u+1exi3AobRHmnHsXs2seqiL/BUDDo7MzZphUs70qsJ1jkyzbte1nYp4Are?=
 =?us-ascii?Q?ja/lgWSa9DN7BIJZY6dlW/OiHDVk4K34+PJUVTx/Tf9nVPg3BJTG8FULYA+C?=
 =?us-ascii?Q?t9XuRBeZAhHy7yFkM483Vud+X57MrcGX+6PkVjGAE442Wrc6PGQvmN88Bddf?=
 =?us-ascii?Q?qVcldr4CIFqTWvY2aP5mbGWZCOmYEfkiTcc6+jfVGK1odyclDIu5hcU2O2fo?=
 =?us-ascii?Q?urjYdBqXe735L5fvPKo94IKJZnBSJR5GUChGVFnT2e7DnZJniR+jwsZAKQ26?=
 =?us-ascii?Q?lFqcIt5CTVATNaemy12eDHkENL9GUUmAAxJIk1sfOJ5F6+5CTHUtF3kSA/8e?=
 =?us-ascii?Q?MKxB4krf1TQQlrRGquPbxcHq3djdww/vssIKVngJz//tmFs0VNE2uvojmPOL?=
 =?us-ascii?Q?oSu9TxDrZvyzVIw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:21.7198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df727f6-4911-407c-f76f-08dd5d8b04c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

Move it to amdgpu_mes to align with the compute and
sdma hqd masks. No functional change.

v2: rebase on new changes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ca076306adba4..5913c5ba85ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -144,6 +144,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
+		/* use only 1st ME pipe */
+		if (i >= adev->gfx.me.num_pipe_per_me)
+			continue;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
+		    IP_VERSION(12, 0, 0))
+			/*
+			 * GFX V12 has only one GFX pipe, but 8 queues in it.
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1-7 for MES scheduling
+			 * mask = 1111 1110b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0xFE;
+		else
+			/*
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1 for MES scheduling
+			 * mask = 10b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0x2;
+	}
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a748..39b45d8b5f049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * mask = 10b
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	pkt->gfx_hqd_mask[0] = 0x2;
-	pkt->gfx_hqd_mask[1] = 0;
-}
-
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+			mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c5..519f054bec60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.48.1

