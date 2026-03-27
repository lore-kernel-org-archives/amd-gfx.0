Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C210ED674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC8710EC91;
	Fri, 27 Mar 2026 13:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DF+vvIu3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0539E10EC8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 13:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nia1Ya4YEdebOeiW42O3QcHet1gx0KG5TbzOO45+iBtg5PFYYLyx3xDXqGFjTblX0i5MezhI3t89VlhlxASuJXLxA2HhV46dFfbL+V3tQTXk0F5uzRZNag0dzX6XEtI3bPV+oKe2WaPmJsGeku0kmArTkF5hcclBt0QUTKX7AaTkRP11GKF11dLz49+mkLS45KXMaQBYQUrxU+3ANTyLdN6ljQzja7dHjyRKPIWhJHkDeNUgml903ILVD7Q7J7CokrP0Jhi0mZGX8/XTilg9/H4Up9loNAsTohIHQZnVh4dxT5P8THTUTFtByN7IOXuYKQWXbpsYb+HVd4EFGm4INQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/y+xEkqk0iZNOizRcdZiBFBjpTwVPFPHulTt+FvEw0=;
 b=dil09GaWSbHhaQoOeI/9kbeTUJ3KJtE7KvQ8+tuzC30V/EIm0Z3avaMPQ9FyQf+ycvCBMRqe+OvWdUb+gGmGGgc8P/VqgzvAO06ODrZ8NQmLxlkQgwrxIbktf4LuHVZhbnWsW6mmmcnT7OFmZabgiX/lz9ElyRFUhbY5BMIgBbih1krV9P6ZdR0yqTxs1dun99BnnbJZ9o7DPBb+3a1wBpPHuMuCT8l4WC8IpuMMhCxn+OoAx9RwNkX7i/ix6yDZnL9deypzKmMomL+684zBaTYpdNo04nIG6iF0hpG9hn7QOejKS2SV4E7cw6yxQ3u5InHGhoRlHFs8SxLOhBKz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/y+xEkqk0iZNOizRcdZiBFBjpTwVPFPHulTt+FvEw0=;
 b=DF+vvIu3e514GdjzSBbFQITO3Ie0Kx92BxrNi5N1hdIxNGSd1XVrx/ZRjBJlBPh1NkbVKMGbcDsVuqo319JFQgkawxeniCzncgHDE/39684Pht5CztdxkQRoZEVz9Hof3aVOLC3hujm7Pb9X/FrQ/CtTyfPZKOkVokU6vgreCD4=
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 13:04:48 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::41) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Fri,
 27 Mar 2026 13:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 13:04:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 08:04:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 06:04:46 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 08:04:45 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
Date: Fri, 27 Mar 2026 09:04:24 -0400
Message-ID: <20260327130425.474166-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130425.474166-1-benjamin.cheng@amd.com>
References: <20260327130425.474166-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bcf64f-95dc-4f6a-a247-08de8c016c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aV9nW8pfk+EbYl6dJf/wcVC4ZI+pO5T+NCvDhF760rQKX90B4HcWRqPLgYzNnD34PnoBnpBSILdFNCKCyz2hjSQcQmsFragYVvrFGXNyEEpCsLGPXqRyxsx2FcUAwmfey2KeF2kdvj9e767HRyccMtviv7Jx9oivCwP8FalC0DdqDat9LT56DHPfX7kXbE5mmp/B98rYQPBdyjy8V7XH/RGY+l0pHhTicIFJ6qlkX7N+T00Qi5z6IqqSd6vH5jjCks11HcJUZdq8ON8gJXOWteV3GW0xzzpP516khQ8W+/t8VwSQ7YHuOTIPmQOjgSB1THakcZvze1JXKh4r+08o2VDajuoKQZgQDSuYPWCDalj51qDSyjLd60w5pAC18YVad3bhLD105vJToyta5nHcZ9HhPz0erBrVqcGkxKdhl+rM42oX21pTTM1a+QBURl0j7jXCHliCcyOgiCPbAGS1cUxyAIrAD9iqxq/+WpmTYvZNWOsKn0o9YRp7wFEqSaIdCzzyR2Jj/yDi6MSFcr6TN4G++m2WZj2xNSpH7wMeDx/m55xWxcTu9y94pJ/vvAz2AkQPfyWHf4OU+jwqFQLm42681HEJXhc8Yfjpcr9U18RoJ4Vv6Z4gD9azqCChCxn5rspJVXi920YGw5nAeOX9QVT4oLwxvN7gigS3evDb7ANpPphHELRp8Ge22lKEzR/mraWaJQairNb+93NM8C30osTBy9caRNSRDgwUPjOImtNFIgSpoCw5HvaM02MFoGhQuJzZBOOKzCrfD6v0FuXXlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n1QDsmADRdq0LPoIHwzQSaLvCEYC8cYsLoT0xXoyNXXSpjRyxA5neg6/AfbB3Ot59xkla4UkCqEvF0eeQU1lrPfhiCblNNUpOaZzBPjVLb2ECFawnD0PbU3fEP8KYafSkONDKTAOEzGDRWJmWkn1OeePculDIci/EwMzwr9kIWR7V2BPbTIYjdj1wkAS84ytdyHHi1iYyIrKgnEYGG/WH+Iri5dO5D8uMRSroVB9hmJL0suHFUD0kpgR2U+R/fTxUaOyccdCmUyZG7OcZtZxoOF8q/lsmFSBAod3lYSk8dwB7n43d/Wbkp4JGScQi10C8RS/UtVlmUVe4sPBNJuYeYrh9S+OVItrmAQHQyG4tkghDSpUxSUBES/R0EK0l/ObKiJteKAdM1Iz9pbc/wS4/m9+NP3o88eFrEc5O60AkUn1ufQk2fhuRSMAm4qj8UR4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:04:47.0586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bcf64f-95dc-4f6a-a247-08de8c016c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d17219be50f3..1a1cdc14841a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1847,6 +1847,11 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1863,8 +1868,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1872,7 +1877,16 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1882,7 +1896,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
-- 
2.53.0

