Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8850EC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F8610E416;
	Tue,  9 May 2023 22:14:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0AA10E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpl0qaUnqOaloXnf/fqPow7wBGMwbMOMvV86T5H165HLI1cQmHUwkzYhyZTSUo3nKQNJZ6X9dzmLidcfqbn5pTQ0GGTO8RRBMv21x1pCt/M58KsrNtUuso75d2Cs8Wk+tzPOBo1S0p9fw0zcpdDVjonOcke1+iy7lkghKXX3yEeD4pkht/2IB7euKw6UU8matvHVc19W+4Qy6nOeA0zKnIDFR6AxkCSQmjl5p4ItYDRWxmH2pN2Q3yRCzX8HGMZa883m4TWST0ab8B2WqN3x65kkqqaftV8rFpWjD47B+41WjjWjT+7FU4oV16Am1kEI7OG+N1zFJdLJsfOy/OnsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AORfruvOOHr9+SJNrqESP3pF+TTJttyH6+/ZNSku+Hw=;
 b=NmFb2sEuYgsWDdtiWsbX/GH5NA9GV/GvSCoV4Moen6RQv8ZHg7Iuaw7UzGDPqUqS6Xbg39fY/Z78w2GLgvZqPs0DISJTgdnXF3Ai9TIgRBiT8e0hS3Hk3ZD3mogzDYPK3iHr5J83AcGl/205nWSbjj5db9ajjE9iX5W6k4n4yAdaR4uTPxBHENJZmgA2yrVunrmRCwKp95lpIzxmSkSK80s4jqaG8zyQgzlQ56rzVioNSMl2UiwrSVnostPB4FB2Grc8yYp+aN1f8SjoRH67tQ7veFoCNDmwTYzO47AwLkM4yhjUTUR9BOgBb8T6wJnOfERna88+EUG8tubyxFB8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AORfruvOOHr9+SJNrqESP3pF+TTJttyH6+/ZNSku+Hw=;
 b=WYBo/We+6B+4wGUw5se7uer+4iaB4jhX1KnWFyotnTVD5odQ515vLTXXzfFOkzDqIExvhJ520xK8qq1WG4PY15zf5Nf5tx7umIGF303goVA5wnWtQcBY3p5b5RQwOFkko7S+QzbEsi+IgZ2ZrWyg/2J6zutu3p61hKQW5f7A+oQ=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:29 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::3a) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdkfd: Add xcp reference to kfd node
Date: Tue, 9 May 2023 18:14:05 -0400
Message-ID: <20230509221408.476829-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 35056382-83d2-438d-0186-08db50dac21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH3AQbhJLBX2slGJn0hREchh0y8CovpFBSOBXrrl99EWSTJfhEybW72JcihlkJF1RI8OR4mrgNqlntERrYP3FCk5J4LZpe/ZEFKNdIjsucQQ0tTJskPRAvokyqYSLmuOc2IKvsG4ySm8LCicF3v/CieLNrw1o1hrB0dRIG/s0uW2OG+RRvnB49miEkdKNTW/Pc9XIACGrz3fV5owyEcuMN14IS3pefqLdb889e/Rk9nbY/HVgVyP/vbjpXbhufLbkdvzAhuOcmb2I1dOgTYZhDsfp3TpT/u/mGYDYvqiGAOP/xlEEtIqmoI0oNMYTLwP6X+QHQazWtOd8Yu9qww92EnKphL/6sL6gPLZSWZeKVm2zmMB5OG1ZdrVwHLIZAykNRW2ztcrH6Ng9fSXu3gTr1OyWhektL4P3P4qsG10Aqb/Xpdt3HRQj85HaeAbbduI1K4uuRUoG7AkG3DwgYMI4ojbsP4mLuPlY++Z04M5hsCA4eF2fibieR4EMCQAkNorvPJTE8GS6g8Vh5TpSLb3S8b2zrH0TC1JJW6efJ1+McQZ3nQquLTKaEwxLUd2PzmzkxbGpFzU5xUFr2wHNDTexA5Tsgho43Zbm1yukUXByzBE1NIqB8LYmG+bDj1SxEYy6kzR6Q1wRo3tZKxRCkZZcKIk3Q0uOwmiCpiF7mS1s4AnL7HqIo7MmWqd8z2RbsEFdTjNvjeL+jb5gqQBn98jRWSisSom69liyxB+cYVJ06I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(6916009)(4326008)(86362001)(478600001)(70206006)(316002)(70586007)(7696005)(54906003)(36756003)(336012)(47076005)(2616005)(83380400001)(426003)(1076003)(26005)(36860700001)(6666004)(8936002)(5660300002)(41300700001)(8676002)(82310400005)(40480700001)(81166007)(16526019)(82740400003)(2906002)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:29.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35056382-83d2-438d-0186-08db50dac21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Fetch xcp information from xcp_mgr and also add xcc_mask to kfd node.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 19 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  3 +++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4293cbf9ceb0..647c3313c27e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -594,6 +594,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
 	unsigned int max_proc_per_quantum;
 	int num_xcd, partition_mode;
+	int xcp_idx;
 
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
@@ -603,11 +604,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
-	num_xcd = NUM_XCC(kfd->adev->gfx.xcc_mask);
-	if (num_xcd == 0 || num_xcd == 1 || kfd->adev->gfx.num_xcc_per_xcp == 0)
-		kfd->num_nodes = 1;
-	else
-		kfd->num_nodes = num_xcd / kfd->adev->gfx.num_xcc_per_xcp;
+	kfd->num_nodes = amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
+
 	if (kfd->num_nodes == 0) {
 		dev_err(kfd_device,
 			"KFD num nodes cannot be 0, GC inst: %d, num_xcc_in_node: %d\n",
@@ -735,7 +733,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 				kfd->num_nodes);
 
 	/* Allocate the KFD nodes */
-	for (i = 0; i < kfd->num_nodes; i++) {
+	for (i = 0, xcp_idx = 0; i < kfd->num_nodes; i++) {
 		node = kzalloc(sizeof(struct kfd_node), GFP_KERNEL);
 		if (!node)
 			goto node_alloc_error;
@@ -745,6 +743,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		node->kfd = kfd;
 		node->kfd2kgd = kfd->kfd2kgd;
 		node->vm_info.vmid_num_kfd = vmid_num_kfd;
+		node->xcp = amdgpu_get_next_xcp(kfd->adev->xcp_mgr, &xcp_idx);
+		/* TODO : Check if error handling is needed */
+		if (node->xcp)
+			amdgpu_xcp_get_inst_details(node->xcp, AMDGPU_XCP_GFX,
+						    &node->xcc_mask);
+		else
+			node->xcc_mask =
+				(1U << NUM_XCC(kfd->adev->gfx.xcc_mask)) - 1;
+
 		node->num_xcc_per_node = max(1U, kfd->adev->gfx.num_xcc_per_xcp);
 		node->start_xcc_id = node->num_xcc_per_node * i;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6e1c15682c28..559ac5efdc26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -278,6 +278,9 @@ struct kfd_node {
 	unsigned int start_xcc_id;	/* Starting XCC instance
 					 * number for the node
 					 */
+	uint32_t xcc_mask; /* Instance mask of XCCs present */
+	struct amdgpu_xcp *xcp;
+
 	/* Interrupts */
 	struct kfifo ih_fifo;
 	struct workqueue_struct *ih_wq;
-- 
2.40.1

