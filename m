Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB62CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D5710F67F;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A141710F28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXFMReSABjsRrUtugizCzvuAZpO51nM0FAqOgWFJGhJybcOFFPHmHnehCXuwt35jiBbHzYNI7ZOH5CHXlOKUoTTmziYjCC8HRWQ22CuP9UYIqvnRxPmnzFU0O2AM/6U5a0QR3NYgPSJka1H8+8wwOjV5yuWJ/MzzPtxMPdsCHPgp2tTmyTqYyl233w2MBqiqqmbsLFC29f1/73jVbYc3+iTu0LIBmUH8CWNDq1EwOk6xNIkzoGcqxmerFp4h5+xg+1jkVAwuvOrdk16fDmAFIDQKktJMX1lL01DFa2Iefjo4lo746/2ff0tOzjSnpfs8Sd1f2uDAWu8d9msvwPfzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBqWBSDiv7z0B8kQjvr9NKvK4wAzEHkTgyvKU2gScr4=;
 b=Va+8Mfke+exUrKQIcTQJD00c3OKHu546EvnsKOGSADZFMCwKRGC7R4JXN+pBM/LA4H3Ti0FH80dJA0qbKA/V+WGNi70t9iwvERkO694O2JfN+ephaVVydOSFcNqeHwfP2fk42KGTXt8EyfbRHSYviRoRKqBhxT5KIHzFH8LkelFG4EYafK0s1DbCifyLrP18jYKHlcb8032NQM+JAkeY4hFd1vgpR/G0EMFApbvqHp7ltCFgIvJA8Y540b354xZmmhUab8KX/ShcpLb/gkQS13oP7ilz4uheJHaV8nn9jAb+s2RUNudhjv1tM+KvBp0ZQ3Db7m8P54W0SxywdPn4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBqWBSDiv7z0B8kQjvr9NKvK4wAzEHkTgyvKU2gScr4=;
 b=mKRTCdo7vfqm4U4SYWRgUBOApHNKZxBX8+V+YinDNtH7amctHJzk75meS4ACnlSjd1m9+ALFGif9QezqOF6sW266N7oQS6R7MElhRaPmdd2o8n/QHcimm8qUZgJ8Yib2ChWaJ5eaXCnOKLib+5e4HBw91pjSlzyfGCw2Tppahv8=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by BN8PR12MB3026.namprd12.prod.outlook.com (2603:10b6:408:41::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Fri, 29 Apr
 2022 17:47:13 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::45) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 57/73] drm/amdgpu/mes: use ring for kernel queue submission
Date: Fri, 29 Apr 2022 13:46:08 -0400
Message-ID: <20220429174624.459475-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd1dd4e-71e6-45ff-e39b-08da2a084ae9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3026:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB302653C33AC8EC7A873AEC33F7FC9@BN8PR12MB3026.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENC3ogRGsHWHR46rGLw0PK/1c6/o3r0XAX8IwZlKmztS6Tcyx7ZIBtwXumn6X48VugqZvVpfkErDuzsAYcGGNMoCBn2OOpwVyFdWBDUabRQeDFLToGY3capNEbm1qHqN4ab1ZNRh/0WXVZCkMe6C4g77U4/iKI4MTbe7qH6Aia+8+3iWPLsot6IWMaDrw3FfX1CnUnLi0QnjXKIe861mJVnLOKSnzWquQpP9jFYk/n9r2tzFyDw9SfrOfgz/4ceY5hQf0b1XxHxLpcCARBK0i+PGzxacnVsV7tnm37j9TgDTFfZXxPK2N2ovDZCC+JhMedfxhtd6c/ZgzzQqrEby1NREpVKCX2ndW036o6zvR1RRMShgqPJ5WdsbsjX9y/yLGsC/WFqmuKFsH+iOZmKVaW6veIOi7WSglELMGmQZZyBBiI2JPlZi1Ta1l3Duy7+YsA9y3KVgP6gmKvnbxVa1doALLgEA+BofcAcMhBzhcjArfDGwaihWS6jsP6OgG6ihRQkMtZMS58GMMOeqBPh1VPUTVk/SS7TagsZ11ddJX63MDtycYW5y+HDwlFvE2WdjG9CJK4P5k331wR9pkyS4R/xZz0IBpdxkMlwrBkYQcB/Kw/AR8mnFHv4YdqeTDL5QSrh8dp4WOlXJ7WDLc2SIhBJlR7pkZJwnV6yN20yz+jP0YqOVEnMy8KXIAt7ifyn+oClSzTASH6gxPaZBTVMIig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(7696005)(40460700003)(66574015)(426003)(336012)(16526019)(8936002)(2906002)(356005)(508600001)(186003)(5660300002)(47076005)(316002)(26005)(36860700001)(54906003)(6916009)(2616005)(70586007)(70206006)(1076003)(82310400005)(86362001)(36756003)(81166007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:13.0356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd1dd4e-71e6-45ff-e39b-08da2a084ae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3026
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Use ring as the front end for kernel queue submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 93 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  5 ++
 2 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4e99adcfbb0e..827391fcb2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -753,3 +753,96 @@ int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs)
 	WARN_ON(1);
 	return -EINVAL;
 }
+
+int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
+			int queue_type, int idx,
+			struct amdgpu_mes_ctx_data *ctx_data,
+			struct amdgpu_ring **out)
+{
+	struct amdgpu_ring *ring;
+	struct amdgpu_mes_gang *gang;
+	struct amdgpu_mes_queue_properties qprops = {0};
+	int r, queue_id, pasid;
+
+	mutex_lock(&adev->mes.mutex);
+	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
+	if (!gang) {
+		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
+		mutex_unlock(&adev->mes.mutex);
+		return -EINVAL;
+	}
+	pasid = gang->process->pasid;
+
+	ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
+	if (!ring) {
+		mutex_unlock(&adev->mes.mutex);
+		return -ENOMEM;
+	}
+
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->is_mes_queue = true;
+	ring->mes_ctx = ctx_data;
+	ring->idx = idx;
+	ring->no_scheduler = true;
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+				      compute[ring->idx].mec_hpd);
+		ring->eop_gpu_addr =
+			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+	}
+
+	switch (queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		ring->funcs = adev->gfx.gfx_ring[0].funcs;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		ring->funcs = adev->gfx.compute_ring[0].funcs;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		ring->funcs = adev->sdma.instance[0].ring.funcs;
+		break;
+	default:
+		BUG();
+	}
+
+	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		goto clean_up_memory;
+
+	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
+
+	dma_fence_wait(gang->process->vm->last_update, false);
+	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
+	mutex_unlock(&adev->mes.mutex);
+
+	r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
+	if (r)
+		goto clean_up_ring;
+
+	ring->hw_queue_id = queue_id;
+	ring->doorbell_index = qprops.doorbell_off;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
+			queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
+		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
+			queue_id);
+	else
+		BUG();
+
+	*out = ring;
+	return 0;
+
+clean_up_ring:
+	amdgpu_ring_fini(ring);
+clean_up_memory:
+	kfree(ring);
+	mutex_unlock(&adev->mes.mutex);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 36684416f277..1fe5c869f37e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -254,4 +254,9 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 			    int *queue_id);
 int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
 
+int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
+			int queue_type, int idx,
+			struct amdgpu_mes_ctx_data *ctx_data,
+			struct amdgpu_ring **out);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

