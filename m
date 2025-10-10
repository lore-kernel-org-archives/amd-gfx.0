Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E83CCD18C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 21:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136C710E2BA;
	Fri, 10 Oct 2025 21:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWILQgti";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571B10E2BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 21:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecLDpL1/PakyxYb8CP176tFpYD1+xfccNwm2r/jWocy7Gu6SciDmP9EgBBEs6JsWELdcsHhrWq/Q2phTh5VzWIR5H22vWtTdfL8YDO8svF2m35RqeFA2S2tp8WCYI9HN3bxfwG2va9xoh6DwHYXlh52jjvOPV3uOH9Z9EICphcnfII3HV2HXvRF4J4IeZtkA0ajzdpdcfIfomQxa4xXpPL28uan/0+r3QxOZC+fZQuukXsKBOU39O3z7ngVaV8jPgahotXt8URsgZStq6AVSP7G2GXQhmixJbtKuU706/m+4PTQoip8mAyIE7TQnKFn+fbHdCD2bUV84G6BriwMngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH8XIfzAKSxWku7TWdTaanIsQ9HynrScsah5vMSnQKM=;
 b=PyjTAfsYuUnFIu0M2Pt/p+4OoJT4oNW70Ht5aHZw1Yull0qvEpcb4o3PlOIjDFunb17pVIKKqsV0mFtzaghi+IS84rEbZamdFaNObUm7LUvZfBrJ5SdvzD0VOT+5qYyBxDFkBU8gJQiMuuK/j2VUhKk8MIYud4EkIz1jD0r3FGMAqmsMYVehtQWDkm40Fuioq9uC3LgUSz18vuWWljNVj+wpQqY2plMEisWKnvdfh9xiheBvbX94AdMwR4ICdLYdMiRbSBpDH+YGpBVObwOaq1d+gZ4UNOvjUSvHogj1Zu8RIc1w+nrnJ0WtaODSwFdPgbnWbQO4csCMcHtdANqn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH8XIfzAKSxWku7TWdTaanIsQ9HynrScsah5vMSnQKM=;
 b=pWILQgtibxH/6mm/qyUN+JrEsgw//XaiobEQzYrWU/tiq+27p7bzSu6w7IZ4arg3/MJ0hoKJfRR5PD1XoIjkvRsiGQkXOd9tkmKCNWvfSWNJfr3Z0ujmmf5wXs2XuOAKlTUvnr9uJAHCCMt85mjnzHJRykHubTCW+ASlxVuzhiQ=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:15:40 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::c7) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 21:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 21:15:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 14:15:36 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/sdma: add query for CSA size and alignment
Date: Fri, 10 Oct 2025 17:15:07 -0400
Message-ID: <20251010211510.1528572-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f8d300-83ed-4304-48e3-08de08422a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K5YjYci/utLEAQVIK2b5jgyd5M9+GqryqlWJlq0mSW5GNFhU6y/Qy6LPQJEW?=
 =?us-ascii?Q?L6i+VhQvJ7xf3YCYAmLLY0FsdYMLmMKw8bykLsZ7/0tjEsGLMyIiVCP/6DIB?=
 =?us-ascii?Q?YVjUTQEPhn5vy/eOFqarg8gcXXHv9SuxQycIvu8sbkI0o6uCamJqWxFQdMCG?=
 =?us-ascii?Q?CjrSRSJGFnA6JBrdHMnwy9PXrePvekfIW65lFYeHIgyaVvsua6OZTqRQAbCe?=
 =?us-ascii?Q?5gKtiUBM6OBiI5yLg5wRsohxbyzwicS8JknP7oMAbSW6bwq4w2G3dLk7vOuU?=
 =?us-ascii?Q?KZgPBElpzWUQ8mIxfLW829tqDV18fXzklBpECCcpZSa3mnBnrA3/mIc2jv8T?=
 =?us-ascii?Q?kcC//dFwTq++boJtLGg9MNZ+3UPxKHM+KyZEU3qR5wH6uvNnE/NoxlTt56iK?=
 =?us-ascii?Q?sa6n+DUrdpLhF0ZEbaNLQaWjugK98rUnrxbOqdOTwDDZaqhOQh8iqylGt9/Y?=
 =?us-ascii?Q?2WCCuHMb8koldq170Da/Y6Vak4vNIx5xfVpBv4qeSrzBXlfOCxvT2c4Gubq7?=
 =?us-ascii?Q?F2PeFQo7C0i2ZK/BnvApenx4Ptm+jgvEm2kMwHAbHbgdOan1crR898BD422j?=
 =?us-ascii?Q?V+NkP+rDD/QULDZ2T8+thQTfaOnVTXzJhI7iJG+GKx79DQuWv6+m1L+oRo3f?=
 =?us-ascii?Q?JLwKBI+fKsqj5EgSSXuGKHqMGzSClbDPQQixmNJQsEPTd59zNfAZbAn0HSNy?=
 =?us-ascii?Q?bfaTt3gq11pDwK0mubXVi5h/Zt6zlmKwSg59HMOReUxhjhMsEdFxFHTlEZ+J?=
 =?us-ascii?Q?d5ZpVeA7RbJrSC8uMQjrFaWzxwUSFrx1xpzM8l3yrUKDx1TXOV9oo/PiVqDL?=
 =?us-ascii?Q?uNtub2hJE3zXnbhU8mbGEKTTtkYL2cFFeeoWarHRopcalJkI05MzMKIoiRmi?=
 =?us-ascii?Q?5jPdoCaG8ncWXMgEC51hlIWPlqL+Ooey2wdRVSFbRXJFV8NlT75Av8atZBOK?=
 =?us-ascii?Q?N3eTbAnT32DAmWKnkWkT0FqyvIW0CwnVGlNYGW8VpLb16i0QY2/BtFdcnUMx?=
 =?us-ascii?Q?cBCKCJ/raL5b5FEsoXSHWZ6tStQUOKnXiLUSSbssO0GD8zsj29EReTQe/v28?=
 =?us-ascii?Q?uacLqtHJUuUqOs6dollvyg/+tXDtPOlJ/fgX8QDISUVlE/mhWiATdZTHWWSa?=
 =?us-ascii?Q?5oUbfbDvo6z5xUIi648QvbkGOEEkTQCRYt4LLByScy+LGr7xuxi+AeoWcm+4?=
 =?us-ascii?Q?ZkHKkSdgq0ojiRtqWduvXbakV4VbAY0IN92sb7fjVlfTjQRxVVA2dyGDOghD?=
 =?us-ascii?Q?UTsoMgKwGXeXze7cCPu19vXEUDxOlKbs7yTXtY1oPwK+lf9CHdvmqJT4aBho?=
 =?us-ascii?Q?3i43KmfXS3VYp10QkFr2D+6XX7MgaHEtspvUNU08KooUs6206oeHWmpRhhus?=
 =?us-ascii?Q?aMSKhWjhP7sVkSGCWZ4P8flm2QMg1alzoxtogId2sRLCJHjNMcX2fcxZtQiu?=
 =?us-ascii?Q?9WIw/cYy/4VB2mQwp05aisfa2i3+1akFPdlvbodu7FikpTfiAjo3qvekFt5G?=
 =?us-ascii?Q?R5gNn4d7VjCDTbnv5CCeBqkyqQovZEtYX8FroFxFz+5XLYXSk6JJJCAvGw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:15:40.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f8d300-83ed-4304-48e3-08de08422a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

Needed to query the CSA size and alignment for SDMA
user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 ++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 34311f32be4c6..872d81f73244a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,11 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_csa_info {
+	u32 size;
+	u32 alignment;
+};
+
 struct amdgpu_sdma_funcs {
 	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
 	int (*start_kernel_queue)(struct amdgpu_ring *ring);
@@ -133,6 +138,8 @@ struct amdgpu_sdma {
 	struct list_head	reset_callback_list;
 	bool			no_user_submission;
 	bool			disable_uq;
+	void (*get_csa_info)(struct amdgpu_device *adev,
+			     struct amdgpu_sdma_csa_info *csa_info);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index aa89d915d3f98..ae1e7eb677749 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1282,6 +1282,17 @@ static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)
 	}
 }
 
+/* all sizes are in bytes */
+#define SDMA6_CSA_SIZE       32
+#define SDMA6_CSA_ALIGNMENT  4
+
+static void sdma_v6_0_get_csa_info(struct amdgpu_device *adev,
+				   struct amdgpu_sdma_csa_info *csa_info)
+{
+	csa_info->size = SDMA6_CSA_SIZE;
+	csa_info->alignment = SDMA6_CSA_ALIGNMENT;
+}
+
 static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1314,6 +1325,7 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v6_0_set_irq_funcs(adev);
 	sdma_v6_0_set_mqd_funcs(adev);
 	sdma_v6_0_set_ras_funcs(adev);
+	adev->sdma.get_csa_info = &sdma_v6_0_get_csa_info;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 84d0e1aa4d501..3c32b5161739d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1267,6 +1267,17 @@ static void sdma_v7_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+/* all sizes are in bytes */
+#define SDMA7_CSA_SIZE       32
+#define SDMA7_CSA_ALIGNMENT  4
+
+static void sdma_v7_0_get_csa_info(struct amdgpu_device *adev,
+				   struct amdgpu_sdma_csa_info *csa_info)
+{
+	csa_info->size = SDMA7_CSA_SIZE;
+	csa_info->alignment = SDMA7_CSA_ALIGNMENT;
+}
+
 static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1300,6 +1311,7 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v7_0_set_vm_pte_funcs(adev);
 	sdma_v7_0_set_irq_funcs(adev);
 	sdma_v7_0_set_mqd_funcs(adev);
+	adev->sdma.get_csa_info = &sdma_v7_0_get_csa_info;
 
 	return 0;
 }
-- 
2.51.0

