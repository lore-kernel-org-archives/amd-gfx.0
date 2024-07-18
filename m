Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B0CC3DA70
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A1B10E8EA;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vZPjjWa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D5E10E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWXJ+NBcsiu4H2Sc91UZUZKjnmZ3hhgIF86FTfE0KsSl63bpxx5YBC3Q0mp/0SNc6QkNMDi5PQghTjKsH+QNXiyLUxWK6DagYUVazwdF8iF54JILs0Gf+51GuSJvG0lyQ14iGVEwG1FZcDGdsHYbaYArRsBrBsTI/1yBOYIiIqcbNFvqlJt7Jqd30Ryej4WkYS9/BeBvC1+iKPxvJGEgfgqXQ3tRynSu0+nOk68GOMLJhf3dqClzjnKgKwaHIS8/QUu35XVNsHSM+etmHtZQx7jh7xdH/HagzSWT0n1ZDAucEJIfr8+Qb6ua0ObTUOzAtM5QnxtN+dGewVok4MaFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEo+NTI9sCNdpP9ruUqzlzRk90h6XPJZvua3+AG1Wls=;
 b=gFGHQEL/IccxIFnFgh1Vjhve3nUlC+esvnzfWXji3URyhlDgH4n7C50VvgofP3zJ+DY/IQHHkq3A1IYZ3+37pKOKlvj9DHe3XjvQs/gx0oyJyfzTDVVCEm5xJYW8GfdXek0cGXEiBu+O6TPxsNRviXNhR9Q9aJSSekQlPtaoilqqvmpMOysEqxD86R7YSN5tM+6XnoRvpLGKERGZeeyQ3XkeyyMM6UVa1t9oT4VIGWAnhMa0etFhV2AExFzUggahon6uiZiCvFEhzt3e5mxD2mggsR5ezVa8pazXY43vRom3G5nF7+8eyonZFwHgvXXyzugKxgyH0GNcg2E0rbSGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEo+NTI9sCNdpP9ruUqzlzRk90h6XPJZvua3+AG1Wls=;
 b=1vZPjjWajmX0xHgC2sJ27jXdPj557Bt/cbgzfZwUmdfBMrxviUwGnZeGIZz+g8k1EAvQy9rSZnWGDlQspeMUYTbwpYWnAFIivM0sbvVb2ZOC0wnUlFTgKJnBdrjZjIaIAKqIUNMd8mkkbvPGw0zNV2bAU872QORaFQAEkIYYBtY=
Received: from BL1PR13CA0077.namprd13.prod.outlook.com (2603:10b6:208:2b8::22)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 14:08:06 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::72) by BL1PR13CA0077.outlook.office365.com
 (2603:10b6:208:2b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/34] drm/amdgpu/gfx_9.4.3: wait for reset done before remap
Date: Thu, 18 Jul 2024 10:07:22 -0400
Message-ID: <20240718140733.1731004-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 94101c94-da07-4976-3cc1-08dca7330ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXsG7wWx+d/ULqUmJxPaeoaec8X+nldbWTt9gkzDH01XwzNTQNLwGIMvHJyF?=
 =?us-ascii?Q?xB4STMFBvcgQpmHkhD/3+9iJPDbRH6/I8ieRVdng6e8W8OOkJgMp3ocKhi8S?=
 =?us-ascii?Q?waRB0Dbak77LbXv4JtOlJbqt4TmztbtPhfapk3lEe6eYp+KwO64a0HTCHRIs?=
 =?us-ascii?Q?al0VogUN88tYSs23Fuoqfr4Xq0MPxIi6PlTP5Zhv/xS9aasfe6X5rrc4c0ES?=
 =?us-ascii?Q?4pumHTAWxAlKiJFTmVKqZx1nGtPDtcUKvPiMgGGbPB0z//Zg7/FbVue8JDft?=
 =?us-ascii?Q?aznhzjzd0Nr4U6bAqUcBxahkuzxadodB19FB5m4vypUzxUvf0lDG4ckfP6k/?=
 =?us-ascii?Q?aIGl6iWE/ULuZsS5AZX5JA2yZgp0vrweJYt1kN20+m617JP5zdegrXy/BHI8?=
 =?us-ascii?Q?sSCQ1l8S1I3uiQkfyBV2aUuD4i0k/ATMi0eue0NfvuFmSll9vjQd2rVRc8i1?=
 =?us-ascii?Q?6CnMKOnnskbxv5XFcgjA4eJXKfnueC7FhoHgjQk8bkUvbrBGgkKxaP7FBB3t?=
 =?us-ascii?Q?nCQQeTDvOUjkSS8eWGS0ShaDa6rEfw3pjYEVkD/JbAtj3hNX8iZH8gTDKl7b?=
 =?us-ascii?Q?hXoITJEfpe1U5iSfBrbMHx7UFaxhTEp11IzDIWdDkcwC6Y2uknmOmM7E4AiB?=
 =?us-ascii?Q?iIhWMrVI/Ve3lZdQm0Pynx0lj0Zq9XzZuzxerOBr78B9BqPlZi1yrzxPa5Mk?=
 =?us-ascii?Q?3g2/wMmbODv78bxLgMcPONTtdHx1UotAplqD0r1UZ+fO5GuukmgQa7fcQhf9?=
 =?us-ascii?Q?SmxbUQcqyrRYNxuNTY7RdYw44qmKTIW4VXlk9medqoWB/A5KYWu9JLUv+Lo7?=
 =?us-ascii?Q?o8xcBCXoOaaDhvaVD336eDfrUc2EeNPL2d5W/dX399zj0NuIvNPNEQAI5tFl?=
 =?us-ascii?Q?M9otl5B2iutLVHbnPRwsAeCqozxKctHetIin5yjGzomv/bCjiy480jRagEQW?=
 =?us-ascii?Q?TxIs0SxdlJpCM3lI+4ykhYgX6VCpGk/SHUPARjsY+iLBSIb+9BglfqwPQTrO?=
 =?us-ascii?Q?0zLt3f5OKKUklt/7hWPz3CTBsCqVrFoD/yhup9fZ3/vNHe0DRfOVwAsJJu7l?=
 =?us-ascii?Q?ESqk/q8PLS5vIHPcKeO82ym1KNGreJ/7GwtTvbL52uZRZO3KVY3tVsl0NXuU?=
 =?us-ascii?Q?4TAdx86XR6951krX4c/82zgcFX976a/JTMu0wSK4dUpuFmmyWyRKAK7kjD+4?=
 =?us-ascii?Q?FmqR7pX1SMc+nakLZPp8p6zesvpWOHU0jqvN7EetbB/9rTuS7NI4KKHSGVDi?=
 =?us-ascii?Q?xUV6BmMtaYfr/hMAkPnb/TaDxWem9BghVSbR5jDeYiBOiCRL0+TpYR7WATy+?=
 =?us-ascii?Q?3qmpZSSK0eJSOl+VRlqVhrkHY6dvNGyR0Z2JLB3y0Ou8y7mNb7JIROebSLpM?=
 =?us-ascii?Q?W3aFCEQneKu1kmXHungElOMob7AEeFESo5y17W200j3cZXOr2FSxLH8WcngH?=
 =?us-ascii?Q?4O+gJ0MLAY+AgjVlSFBX5cp6tpnKGDWS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:05.9535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94101c94-da07-4976-3cc1-08dca7330ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 37 +++++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 394790d00385..717320d92e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3270,7 +3270,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -3292,9 +3292,28 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, ring->xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, ring->xcc_id);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
+
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-		DRM_ERROR("fail to resv mqd_obj\n");
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
 		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
@@ -3304,15 +3323,21 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
-		DRM_ERROR("fail to unresv mqd_obj\n");
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
 		return r;
 	}
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r){
-		DRM_ERROR("fail to remap queue\n");
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	if (r) {
+		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 	return amdgpu_ring_test_ring(ring);
-- 
2.45.2

