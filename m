Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91688C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA53410E52C;
	Wed, 10 May 2023 21:24:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE65810E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiTR2tCAh1y8LAlY22bzPj6ISyGDZQ42R+Eq9p9RX7Pd5mf5Ou4dY8JqGP7i8cE+zHkZ/wwEWPkkdfccwwJ9vT4TInron3JxbdcOnKtGahjSShziMqVaIJFH2U8Y9USko/LLUnfeH90QVtJ3Q8r3iPxJOFmTHaE0Cqh6G8kpsi6XuNZ9+8ZfPAoS3RHFDNoXvgJFM+D+l3E6Up7fvTYQR34vQ57vA8p/Irce+u+YQTF5owJtBjawAd/ZtIRdZ4siFDIrY3A9iktAvmUREKDe7iKDsCYh0iR6bdx/cRYTgxYt84AEm9UUbTxlNTqh2Zoebz4eQFBjK5mcIkT0Iaphjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9Cl4fZqQlNrRWS9RgcUO6SqQsgroFxBh+J6saupGIc=;
 b=KEjncJP7iEr6E6ui3r+X2vlLQCqiHpKGvFwoZOydltIgJ9IDHhXa8Y+WuF8KeVHiPZWpYDeDIKNdSCz8uwnsjpWkdqJF0vMPLZB+W7V4WEo0lGAnnXv/Fp3W6R5LDoPSTMh5sLw8S1OPA6kLx/g82YtON464QkR25ELNM332H9Y+9KPe7eh6p6YNg4JuyV9wtjhf+1lJn4X3OPwYdgVCyPQ/e1rdQwVg1aC8zHWsLp/dDnbH2AFJeubLvKBvrsj7xPL/cM61q8mHkO6Y+f7TpGSbZs9oa1Xoae/nPoxvrslJKKfBwfILL80QnC0tv/du6k1nXPj8nelpwYT0Y0L8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Cl4fZqQlNrRWS9RgcUO6SqQsgroFxBh+J6saupGIc=;
 b=Kmg2n8/itikH1kpVpylYXFIr5k90urWLR6KJLOKwNR4ICWhd/A5DW6FozFZeu/5HS34gNFnpGNylQUysj2eozX3oulr5DvCnxzHcCGaXKgu5lCrXTdnGQ84HuHbsAPTHjfyOYMcU9i8xsNOeKvMBGBO1yzve2Ex6NaPgNFcNwBc=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:52 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::5c) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/29] drm/amdgpu: add partition scheduler list update
Date: Wed, 10 May 2023 17:23:09 -0400
Message-ID: <20230510212333.2071373-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: af07a9a1-f4c8-4f57-cf30-08db519cda1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQbRC5BwSTnZzMPeORhMi/sUmqPSci6/50HUooah7mOcV9joY7O6oNxE+YzTq8X9juO8E6zcvOUIc8lnZ2sPzMnERDlKKbRjO7PMYnvwArClqOJ4vdOQh1g3MCf6BxrYddteWj/XLmI9MXx1Y/LGfBvCq10HFkKBTwf3+O8qIQ8Cmloks/IrxbTA520nidHQKmVTno3z+y/W5r9GUr+qa5jM9QGQmuTKLVCSWpu1hmHgU0xzLSFu5djy6N31SexTrI1NEHYR4qHGvDaClXUR290LYrwz0qMzwBGNIjN2QdZiLTC59oeHV+d1LjV6TA191yuq37axNNLmomO3CYeMB3gTtEfhDS22YFc9oEkxUB0L+Um6EROixUF7t+/UiCVXyL/UlsMwAWUSe8SEpGIolQ8t4owwihvJpKGCxEQBxaJZObEBHsdkIMbL+M0+3+OEubY81oRgfiPYYKGClXP1exrApj53dwvoOa37IrG7nrEzmHnKsApTdWrNi5+4X49icLA8wFBHowfp4d+S9NlEki7qQQOYE54QINIK2937idGKW+fYBfjY71mqAhNfbPfhNLNZ3IDu8Amv2qvBmJTFjsZc0c6jOyptsvlu0cVycPbHxuT/TrDz9j+Ni22gF9UfbtilPE/Ek7CDSQX12BpPKumG2z2oiq868BXse8jaajFahMadAVJ1KjAVwwr8E+Q3KJrZnvsWfrDBpUtER+ptqdEz94hKzcDPbPd9VpP7ugo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(426003)(83380400001)(336012)(47076005)(2616005)(36860700001)(5660300002)(8676002)(36756003)(82740400003)(1076003)(26005)(186003)(16526019)(40480700001)(54906003)(478600001)(70586007)(86362001)(6666004)(15650500001)(2906002)(82310400005)(70206006)(4326008)(6916009)(8936002)(81166007)(41300700001)(356005)(40460700003)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:51.7563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af07a9a1-f4c8-4f57-cf30-08db519cda1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add partition scheduler list update in late init
and xcp partition mode switch.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |  2 +
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 67 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40c5845c78df..321b689db601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2473,6 +2473,8 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		}
 	}
 
+	amdgpu_xcp_update_partition_sched_list(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 9b627a8b1d5c..78fce5aab218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -118,6 +118,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 
 int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 {
+	struct amdgpu_device *adev = xcp_mgr->adev;
 	struct amdgpu_xcp_ip ip;
 	uint8_t mem_id;
 	int i, j, ret;
@@ -153,6 +154,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	}
 
 	xcp_mgr->num_xcps = num_xcps;
+	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index c90ea34ef9ec..073ae95e6dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -102,6 +102,70 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	}
 }
 
+static void aqua_vanjaram_xcp_gpu_sched_update(
+		struct amdgpu_device *adev,
+		struct amdgpu_ring *ring,
+		unsigned int sel_xcp_id)
+{
+	unsigned int *num_gpu_sched;
+
+	num_gpu_sched = &adev->xcp_mgr->xcp[sel_xcp_id]
+			.gpu_sched[ring->funcs->type][ring->hw_prio].num_scheds;
+	adev->xcp_mgr->xcp[sel_xcp_id].gpu_sched[ring->funcs->type][ring->hw_prio]
+			.sched[(*num_gpu_sched)++] = &ring->sched;
+	DRM_DEBUG("%s :[%d] gpu_sched[%d][%d] = %d", ring->name,
+			sel_xcp_id, ring->funcs->type,
+			ring->hw_prio, *num_gpu_sched);
+}
+
+static int aqua_vanjaram_xcp_sched_list_update(
+		struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		atomic_set(&adev->xcp_mgr->xcp[i].ref_cnt, 0);
+		memset(adev->xcp_mgr->xcp[i].gpu_sched, 0, sizeof(adev->xcp_mgr->xcp->gpu_sched));
+	}
+
+	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		return 0;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
+		ring = adev->rings[i];
+		if (!ring || !ring->sched.ready)
+			continue;
+
+		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
+
+		/* VCN is shared by two partitions under CPX MODE */
+		if ((ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
+			ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
+			adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+			aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id + 1);
+	}
+
+	return 0;
+}
+
+static int aqua_vanjaram_update_partition_sched_list(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->num_rings; i++) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+			ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+			aqua_vanjaram_set_xcp_id(adev, ring->xcc_id, ring);
+		else
+			aqua_vanjaram_set_xcp_id(adev, ring->me, ring);
+	}
+
+	return aqua_vanjaram_xcp_sched_list_update(adev);
+}
+
 static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
 					 enum amd_hw_ip_block_type block,
 					 int8_t inst)
@@ -483,7 +547,8 @@ struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
 	.switch_partition_mode = &aqua_vanjaram_switch_partition_mode,
 	.query_partition_mode = &aqua_vanjaram_query_partition_mode,
 	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details,
-	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id
+	.get_xcp_mem_id = &aqua_vanjaram_get_xcp_mem_id,
+	.update_partition_sched_list = &aqua_vanjaram_update_partition_sched_list
 };
 
 static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
-- 
2.40.1

