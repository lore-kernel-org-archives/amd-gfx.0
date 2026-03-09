Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC38AF417F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DA810E515;
	Mon,  9 Mar 2026 14:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydTwNiE/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0C510E514
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doDL9HVxNXuT2pN64FbVfBoxxSLoBHhcsxiBTchyjc20JgofaL9oKmotTK0gDorSv1mzgpOm5nA/a7lIHTe6okw5DC6sHkAKXplja8XhYbZkoCkVxucu4V5qVsMB1BQgdfLgeaG5ekeUyKagMB88/zpZMEDObFJqwekj+BDB3ZgOVSb7OC1pf4iSMTXbNr75+v+4ok4JSkYPK2vJrr2sl/xWHXPuNsl1mTeaS/wycKSKuoY9/h776KxZdEsEJa/aEBSmalVem30kUCsr/IEXAD0fDolAiO1nRBrFhMUThEAHffxEMKwIZGibD/C1MyCtTSPY1gvwMCLEVENq+2VCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2GhVquOe6gPd/YKmAh+oq6oiaaJMF592YChNrBVEDU=;
 b=GJ7FAZpsb4ECGmI3+MZ9dpkBlvhr/6aMln4Abvm5QI1yGHMGEFcfJMLC+oMhqZbM8vr6Byk0MJtAiNRli4WemR6YkweOVMs8Bbqi5tvLcVbw4dqhNvpaXyhJAhzJKSNNLleymBOSsDhoAyl/EcQOPl32Ro1136Lwte8w+W09oHuDFwJJA8pFThQMCY8+cg0n129izc5YTn851Sj62MQQyDGscUpe2vSJqzNRkHPaXnCvH5KnpnMMZ3ogRkkzgFMsDlmOrV80kIGGCoCdufJEhKOneVNZPSG6eRxoB1ZOST/sD2XVbe1/uAlCV8uGLfoKI+Lgj9bg2xDTfqFD6dK2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2GhVquOe6gPd/YKmAh+oq6oiaaJMF592YChNrBVEDU=;
 b=ydTwNiE/aLR52GR8+KQAUzcHsb9a1RpBPrXku6pUPbKahDi+5mb64+zmx2GiBu/KxKuxLLszwJhP48HZhnOfl6P7mJ0pmEx9ZbJ43KGqQt7D1S3tflfFisLUaVipI5KlwwZIxu1Ly+irCbBAGK3HnsbqgkKlTVkeAHeTaEyIRPI=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:41 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::21) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Mon,
 9 Mar 2026 14:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 07:56:40 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip.Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Update MTYPE for GFX12.1
Date: Mon, 9 Mar 2026 10:56:11 -0400
Message-ID: <20260309145629.2844495-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3067b7-acf6-48a5-3443-08de7dec12a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: hBLuvukfr0boGiCbOHx05NAVoN+Yth1vwy4Oltl8NyDLgaQ7LocUp3SxiJY3NzaX8Jbh8XtJaKe26tqiFMUCKJ+N/mKBag6iMdYDs+VusLjbSUX4wz1EvpJ2IiPutER6tWCh/YmAE4l7dZyMVh/9uHx5I5zPuYFWNDWOkZ9RMrGXb366xfqcPv6aR7uW3zB9yQ3CDPGgnorI7pmq1BW4xoONMUuEEsHQP8pylShm7d9Wtu+0YCS37WFVOfYlEa/EFvhuBjGLUuj1b7S5yIIqsx6wj30/6zW4u31R/x1o34JMhUX6g8b7bkImHwZjiWzb36Yhb7ZJw0FhEpcc320or4hu5CypOlpONv7vO6C2iTD8dM+86kkNcAhNBA+QW0sSSXanqmTaQfcQ1VMaTqpxPaNrO1pjdeSmCnUSd7A4RB/Ww20WS9zC3eS2LScPLsMfKdIa2Vh8LuraIICi6eiruO/uo8jPR+jLR2tED0uXR80PGMq9zNJIo3EuVW+OV4pjeePnNgaAF1JXZ/3HqAMfve3fpIrvBtyo6DmddPYxO5UjbudBJl3WT3EV5yWeytg8aeb882jF3SbZLVLKNfgz1kToqryw7JwIkM/9H8TUGHCzLZpANNRvOXKLZi/e5DXjIEkvJkj/bv9NLwyn3QUToPFE7i26dfLW07rIv2i+IQxXbwVJhw6S3e9I1WYbTz+bxBDIg3dQzhftfeOhb7KLE5riTewtx/25zpMQf5S53EpohhO9dT/kwY7cM41gZ0zAHQ+NsYCJNkQlKC9TFi8J+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jteBmvbH5hIs9VCNMyH58vBfXr0sxgKAnqWf0S1V9iDiOd7iQXNn8BC15H2L1glm1nMzsuI8Q/x6GefHX0jVOXwQ47Am0KqUxKqSF5gyS65Rq+pb+9Y8kNFnkNyXp/W7AaSeGbeDnu9KLOJm1hCZHDHfcKqByfrVxsRBFxG4mvt8Xl7R3AP0RIfIsAqc7MQMGQyNyhFxHtcucxz40sz0zyXD5uDT6akSn8YNW2+Uh8JB60vsaJ9bOTNdmI3MRr4IqEeodDvmiFHksk8DJqMGvUkcYRo2WP2K9+5UnVVfMUPReoJ937aueaXZWdbCR1cXXtF0UN1CePkCbjDOgl9YRYk10w2+tpayDufC/bRcuff+mxVsa67TkWHml+EjcrfRi0tQM/cHGs7wz8yVONc1q9y+FtUHziHsG30T+5Z6Nby4C8MtkhxvrZizquOQZH+u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:41.0730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3067b7-acf6-48a5-3443-08de7dec12a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Update MTYPE for GFX12.1 for AID A0 and A1

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip.Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 12 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 29 ++++++++++++++------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index c49112d8300e2..bc86e6c8e063a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -524,13 +524,16 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
-	unsigned int mtype, mtype_local;
+	unsigned int mtype, mtype_local, mtype_remote;
 	bool snoop = false;
 	bool is_local = false;
 
 	switch (gc_ip_version) {
 	case IP_VERSION(12, 1, 0):
-		mtype_local = MTYPE_RW;
+		bool is_aid_a1 = (adev->rev_id & 0x10);
+
+		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
+		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
 		if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
@@ -547,10 +550,7 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		} else if (ext_coherent) {
 			mtype = is_local ? mtype_local : MTYPE_UC;
 		} else {
-			if (is_local)
-				mtype = mtype_local;
-			else
-				mtype = MTYPE_NC;
+			mtype = is_local ? mtype_local : mtype_remote;
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fcddb54a439f9..35c16c77ba65b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1219,7 +1219,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
-	unsigned int mtype_local;
+	unsigned int mtype_local, mtype_remote;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
@@ -1307,20 +1307,23 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
 	case IP_VERSION(12, 1, 0):
+		bool is_aid_a1 = (node->adev->rev_id & 0x10);
+		bool is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
+				(bo_node->adev == node->adev);
+
+		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+							is_aid_a1 ?
+							AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
 		snoop = true;
-		if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-								AMDGPU_VM_MTYPE_RW;
-			/* local HBM  */
-			if (bo_node->adev == node->adev)
-				mapping_flags |= mtype_local;
-			/* Remote GPU memory */
-			else
-				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC :
-								AMDGPU_VM_MTYPE_NC;
-		/* system memory accessed by the dGPU */
+
+		if (is_local) /* local HBM  */ {
+			mapping_flags |= mtype_local;
+		} else if (ext_coherent) {
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else {
-			mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			/* system memory or remote VRAM */
+			mapping_flags |= mtype_remote;
 		}
 		break;
 	default:
-- 
2.53.0

