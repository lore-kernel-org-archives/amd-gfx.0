Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465AACA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 14:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D047110E437;
	Fri,  2 Oct 2026 14:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vjpaJTTK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB7210E437
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 14:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM8OFkOnNPk3RZ1p88ITZiiEKV/A/9gcN/s6LkwlMK/rS8G+SEPqilrlgrlASc6sYcndaEUaJMs0daFWOkUIeiaSPEzEi8xIb4eep5Om10CgBXdNx0lFr3DMAiEKh97t3t1yw6he70k19XXc2ZblqjsWWW+g1CNdSXD5K0eozRLf/9q05cou5PK3WjUTX9EVFNSHR4bGSTAp6nCx1unjRLA6NBAILer2iOU24KGhd+66O0lJtQjhodH1G/n7Hgz0AmdPGmLzvGJ1mYCDITeIZPE0h9n/JNC5ZNSQnzTMgMyTo0pXicxPHpGGAj0J3rMp9efeDeCuX1yGH5xikQMH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb7I0IJHlkLbh01iHgE1UbobnHqkxcKWCNNjdotauMY=;
 b=tzThGT6XVLlMejp2LyzWNb6Ke0FVHZE5lHoi+iYrd7HNIMU3nAViQjHbkiQ70NSyjO7k6zkIR3KRqzPpvETJyRDvHyfJydoevj+1BkJGouZreDWYb/7VD04KG1AeV3VMeftMzaOq4qquvio1UuZhGm3PYZpLhjdto6Mt5ICdp6voZgGSl6KdTfPwS0l8tAbrt6p75CRaXZ3SsYZeRNfl6yKnguJ31MFr6WL9JBySFpreyNtWDDVHL1nJquA1xybF9JoQP351imQdDZ2EpZE5VzYo43qdkOBH1tVoyf6L1egVRp+G6SPjdnDzhXu7Upqu0GDnE+ZO3RSzw42RBp0J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb7I0IJHlkLbh01iHgE1UbobnHqkxcKWCNNjdotauMY=;
 b=vjpaJTTKF2MwGVhWKBLhqom8UwnGgNf5mAP2xX+bjT1f4lyDL0gqSUBmoMAF0O9kitSkaBPVm5fRXBHnrbw8qMLIAlGmWPInSIG/fKyX9fRToeVDMd8WsB6e5NjSS4o8nQZNf2n6+7fAsZuAAdSgIoBXFqAxT1Cetsf+3iM43ig=
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 14:29:39 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::3b) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 14:29:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 14:29:38 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:29:37 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Use feedback buffer for VCE destroy message
Date: Fri, 2 Oct 2026 16:29:03 +0200
Message-ID: <20261002142902.9422-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c98c85-994e-4c68-6ab3-08df20919704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: wTTPfY4Ty4hnjj3YAjqCZ3Te91VxJugt6ZhAlxIcBL9ZAnSkw70YG4/YTFfHnqOiGPHWW7n3Ojdn7O1U7l/HizvnSE/QYIzsDFOJWVZUw5bnlQtUKzq/6Be1QxzYbcUfdaiR+6CMcHhgqktg3nxjFeWp9dONawVzFxowrODQ87O5D3S6BRkpv+dkqtAtlxgK+lCR2ddr3wIDDemDq+mfRTrhm4JbBQ6hnYXoMLDeowq47k9dNAa2osIGUSJjEM6CnGyAmjnRaZ4ljWm1LANTNtUHqZfqpnexqdq2LYKLyVzM1Qf+/pn3a6FN9xFLBwiRH42BL903SfL/VN4PQ3ojFdJVbv6l6WcclQJ/B2ACY3BzQ7j3nryubO/ymYIIPpw3VGUWEjbmPHKzSxpGPSiUGb/5UlR3oNVG68AfoRqrv3kvV83QUbfcVhBvBV3cb8JkVIaj8wlSh075ovKswiyAxePNrTemuiDu4Mjq9jlBfaRSMPPBGKtCWg3Rse24kAjIiBB/e74X/blEiqDxiB7wyMLPAqvsQWld5h50YgPY8eyz9GdKYKsoDhK7bRhnfI86Z/MLX7M4nkCz2IAHgBaU5y/vRBz0qYkNVl9Yh7ASwxyobK8IK64Ku6CLzC1MiBjDIYmjrTPK0B1W8wn6GKHOkbVRoz3xnjjp35rW0pekuAdhh6mtYbedvpu/VxsrCWWykqXUMov/I6o40oz8des0TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RQApfEq0rqHmWhjbSm7skY8JMYdOWtDWdsAoJa258vI/XuECSzSm7CKRzEXwrKqVd7f1OKKE9Rbhl9kGIRBDW/ma2kA7B3fpz/khnWpU9xZqXpPN5aguwSSYvIsmFwQBYsxo9OQ7OaajUFBVGHeR1PuqnCkiGG73UCfClIxEdBDv+mS98ViN0KTwdIrp82RnmV0I7JG3K4xxlUdJd0o4m9rgH7r+0oJXtPr7kIpXqHKKG8YxUtNosEs1ocIMvpDGTIlvBZsG123B9Yz6oFlGk50lw2TmiToMuToxQDLakhwUXS8Jg67AaQvpTemx2/pHrlm7+9BGRHezgYhZ6Ma740uwDp7zRRt96+CPGEuuxurd6tpJmN6StiwjH+Ebx8ILZ9+d6tVaUcXPwwq3gYiG84Vkxy3XItKDi6kT9lrJ1C/RD1979J2iz13gOWGNk0OF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:29:38.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c98c85-994e-4c68-6ab3-08df20919704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

VCE 1 and 2 always output feedback, same as for create message
we must provide a valid buffer.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1f7a98cdce5a..39d87f3df9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -558,7 +558,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	const unsigned int ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	struct amdgpu_ib ib_msg;
 	struct dma_fence *f = NULL;
+	uint64_t addr;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
@@ -571,7 +573,17 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	if (r)
 		return r;
 
+	memset(&ib_msg, 0, sizeof(ib_msg));
+	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
+	r = amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			  direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+			  &ib_msg);
+	if (r)
+		goto err;
+
 	ib = &job->ibs[0];
+	/* let addr point to page boundary */
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
 
 	/* stitch together an VCE destroy msg */
 	ib->length_dw = 0;
@@ -585,9 +597,15 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	ib->ptr[ib->length_dw++] = 0x00000001; /* destroy session */
 	ib->ptr[ib->length_dw++] = 0x00000000;
 	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0xffffffff; /* feedback is not needed, set to 0xffffffff and firmware will not output feedback */
+	ib->ptr[ib->length_dw++] = 0xffffffff;
 	ib->ptr[ib->length_dw++] = 0x00000000;
 
+	ib->ptr[ib->length_dw++] = 0x00000014; /* len */
+	ib->ptr[ib->length_dw++] = 0x05000005; /* feedback buffer */
+	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] = addr;
+	ib->ptr[ib->length_dw++] = 0x00000001;
+
 	ib->ptr[ib->length_dw++] = 0x00000008; /* len */
 	ib->ptr[ib->length_dw++] = 0x02000001; /* destroy cmd */
 
@@ -598,6 +616,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 		r = amdgpu_job_submit_direct(job, ring, &f);
 	else
 		f = amdgpu_job_submit(job);
+	amdgpu_ib_free(&ib_msg, f);
 	if (r)
 		goto err;
 
-- 
2.43.0

