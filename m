Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB0AC44502
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74E910E4DB;
	Tue,  7 Jul 2026 14:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u46b/pJf";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9050710E4DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chy4RS1cct1ysxBPOa59CtovfBmxYHETGzfXP0Xmhy1d0dkuOlxTmaHzU+EHwf3A9HsXgTVrlK9O6vOyMWzpQiIGVUrlgClH9Ie+9ATjyUY7ZMhQYFxzQPJyWYhqh/0t/L4ia3gqWrpkBhpSpjla8BTOLf/4DNGffMVFBwLYjkQsA/UKoYecJfhCKPypZ72Wa9PpZ6kZxRGiC06ehl70L0eQ4hHp4z1fJdL8rvPTuZEnBmObiGtJlmAElT+HR2Sr2M6Iv7GwjONTc/01i7SnmnKmTXaPIG5tSe6kuodRMYE5Gtse5PMHS+l6KxuSNjrbmmgtdDBDZhRms6RjKfwQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSgy15btE1J8o1vWOnOCk4vF5JR6Es8GfIb+pLRcdtA=;
 b=D2iM7mn4uzIs8AUap3+PISU/pEYvPyjaIbRbDiwWqW23EwchE+d3fregGP2flQv+l0oDYBQlbXjV7UwL3aPFfj6Gq1xoeZ7Im0axBmh9/Xr1VI1OG/UW4KenYfAnswyOA6NLbweGGkKouebEC2VLaE/sXVCPaus5zCqA/B8MmC4mrsKlLO7ztritTxqnfApqrttKWukzKzt4qpysdUfPRfYvTaADqcCjYIkZ75tvxHSm1W8ZkpZoagfHGrCqMnvThRyDwc7WMXwCRHxbLk7E9dnVxijex/BPVfTbtex17CrhyuDKPcrFof3c4BzAv3sg5YCCZBN2vqRCNW7Lolotkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSgy15btE1J8o1vWOnOCk4vF5JR6Es8GfIb+pLRcdtA=;
 b=u46b/pJfp5QZgHqpwwPHb0M0nwerZS/TK8PLaVndpTbbx41tT0gFdpIlBQoqDkKcyWGkZMz2QkFuJmvVglOqvxrlGInbj8b/Dge8nrBVjYXKwG5pTEBzRfL1xWR/fphFXXFwQvM2Hr+NYl4f6Hc6c9hkGgqOj4BwKfowpSgL1zE=
Received: from BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:34:31 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::88) by BYAPR21CA0027.outlook.office365.com
 (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.2 via Frontend Transport; Tue, 7
 Jul 2026 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/sdma7.1: don't do MMIO in MQD init
Date: Tue, 7 Jul 2026 10:34:17 -0400
Message-ID: <20260707143420.2104857-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707143420.2104857-1-alexander.deucher@amd.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: f496e530-ad5b-47b3-8c46-08dedc34db70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L6yvMNa/pxFEp+tx0mt4A8V2ophDG0IrIjhFSfFHwx7tAHx4s9SlbzD6Jw4TDTxFcDuA8XIi5jTUKAIj31McxeipgGYKtjWd8XiOb4pwB1ealv3c0c6sRv4RsNL4/8zqBBznjUB5G+Qt8bW9T7GfLoaXS3L0FZSL8Ez0HXQFXxmBqEAzCkvy22rtdx+SIQyX/lvxDXe426ZfdCdNknLWtYrHVMc2l9qhQgYF19BKG+3SFmLwMEXuTUsyAL5+ISECrNacQ2ayTKXlh0afTPGveUc51kGtzWGlpJL9v/qKTz+q57JCzZpJxty6bZN7k/QAnFzWqgiL4bRtFJIY6nfrogsl3C/vl+ICCzEtxn+tb5esbDTxexg0ATFqKSqXC7zuW37lgGwv8lScC8OYmHAN3SM+PWacP7xcw97TtKaosEB595DZwP1Feg1F6O+9Ww6TKngppYHbcUsZMOc9lXOaBzke1AC6B8J3a2nZlIiFV3eHEc5egt3Jph0amkIkfBbuwRtwQHyniqDgjk8tCxN6Lhr66F6jFDeyY4xcPvG0dLPy29HcBwKhJu4iruhPCDUN74zg9hUHegTdOIyPTLCY+wszqvba1gKCSKJnF74vab3V8dUBFLkYO1VeSd/tz/LyWkfQIUFjTko328eD4EXM8Lz8dxW2IBnEuEwXrN8wOi31Cpwn6KLWsxSjH9LRubapU9KKet2/gGCdnV0jtgYFjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +RcL0Dl2fb0gJnBR4w7fSy7I/tvmEo98dkjVAaHbNAcDASqDYJMYWtTW7B80S4q9GBeu8aRlexzA77PXxuvYpe2oT0WEB31UYWZcJtsAemxzuTaIb7ZdlfIgT3ZKJgpOVCaLdOUY2FLDCXquSCd5ZddiqQ1aBMD1IkyVACJihc8uZUn+uz73N8dOktOotzdhrTxc6XG9taYDdMJNzLfrhGYw/+k1KTcBnW3149lZkNbyyGu0Ex3tStmTouJZoak6V3RBXTLf86pqpvry4x5WiGIkmRa9WF1ivBZwka452a2f1Eayih2RnPrIUsGqSi0e4hOfB2hbRTd/3cv2abwTWus/1VDqfz6zqRvBNzc6MHx4W/mogW5+vjZIUynZNyx5ug0ZBxLqnV29H040IyM5czFMMf5dD5iGEvg7kMyvo9SPN1EKoqiuH95bf6VeWfn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:31.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f496e530-ad5b-47b3-8c46-08dedc34db70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 3a358a54f7c57..3fb73fd1a568d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -879,8 +879,7 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
-							regSDMA0_SDMA_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = 0x00000100; //regSDMA0_QUEUE0_IB_CNTL_DEFAULT
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.55.0

