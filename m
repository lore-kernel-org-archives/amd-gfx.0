Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D3EFCE4C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F5B10EAD3;
	Wed,  4 Mar 2026 22:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXR0bIVT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D069810EACF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo9b8hHXASei0rlTvg1l6BamGtdroczAkiykTFQmnGrX35mhdm9Qg1XzsMaqXtafdkXaRfLZcMxJienUM/1iOHCadUuxMZPF5XvjqMmCYfABvVkLqCr1k2UqgTLoB0YBMduXGLhlDYCEi8nFWPzkQpd6mCQ8MvaFeZMrSMKwHJN6QnuyFHkIgXTxF9UW9CyczVtgzOkVTwpgqkW9eTWpKzhG8nH0iYnS5T5wSf4NJv7s9IXlRQaJjtd27Du9LIaRIEnLDclCQSepzVGvUlqK4O8nLBv21LVIIFpzb/gT2JhHs0xfBnuuQWVlBzfXZovf0AZG0+LPELKASOcZpaOe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qNGlNDtlyjzlf8RgNxOMIINzD+BY7x7ge5w3KpjjBs=;
 b=SSHSaflwxw5sAxCY+mqJMw1TWSYriwFXVYEd6wWYhQQRDkw5fi31i6CJxqOG+lrZ9H+m6seDRsiN06opuVhI9JPK52C1IhUpra+MA6STuqQ8UCOIz1KGoeyLn3lyRyR5ZkscvZFtNEYhf2Ki3SV2aYqtg7ejcX5lxgysSUx2G2DFoD/y34H+WF9UfjPqJsLbMB64O2NBm+ZlWTB9BykSDMLPg9WgDPcm1AUajSCyuWrDjXwSlv/MPcQtB5E67TjyKvWw6PSeWug9hAq9UWdmYg1qJkCJtbucJz7kGj/FbisQld9phgyX60Pl6H1ykL2ghHl5uroYwAnTbkHsAM9R1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qNGlNDtlyjzlf8RgNxOMIINzD+BY7x7ge5w3KpjjBs=;
 b=DXR0bIVTUlQpoqti04XiaLC7fgrRubLo5roPQG7YR3yF+nNGuu+IWedrxGhOzGbgDlHob4NOMLrSEEnOOksf+4JlX6o0l8H5lV8EIOJ4jExEE+xVgSu97XQFYj0/AHepzn9KKqIbpUOPBNti2Yq8QpJ//OhSgDBcQi/55DBJ5UE=
Received: from MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:28:45 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::1e) by MW4PR04CA0123.outlook.office365.com
 (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:44 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 1/5] drm/amdgpu: add MQD update on cu_flags
Date: Wed, 4 Mar 2026 17:28:25 -0500
Message-ID: <20260304222829.3688601-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
References: <20260304222829.3688601-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 196c682b-8bae-4fac-3a6e-08de7a3d65a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: CnhVAmaNgHLbYn6kYW5M6qvzSNZ2JlByRJGC0eGt+cQhRN2AcIVC7jW3qfmAwx8Radwu4SkkIyLKHWMgzdbPvWixx3U32wngdWAQe2DtCjktlff90akOhTAe+T4uaV052M9DQk+OR36Lbw058BREAFkoHEHTNVReipdyT4mwipU7vgyxftVPhKz6cZLMSYz85QzMns63KCYSDEMAUYbl5OGYOQHClCrQnL2etaPB0SNk5sVDWb3uIbOo8PrdLYVYNAgEmlq6aq8pi1Fxkf+xnvuUrYx6+XVmWHJWXPjYwRLGBtXehjb8Izbrc/sr7bjzqUQx1GHkfZz4Iim8eaq8vT6el2kk9iZ3zdj+mM7soSiu1AeSMmVrWU8z9e5yKDCgwlF2sjMhxcv534hcELkIM5/eUNQuh37eYp0RzvI0pgRHtxN7/zBiezMQgOAyC9YlN1GdcruPAjf8fQ3dHGFfUqL4lWkKnPZb4Yqx2eFJgi8IpcynhyCHvpL5UT1J2nh6b5QYguwzm4RThTcKW6Lmxc6e6pcmK3aYUQJdDHgqARjPUXqvZV39a161eB/NAkjBUPcfyQmm+WUHm92DBpUTdK978c6ihuv4BVdK7nnkEuFxnvotXTtBDgNUcUu4u7B1DO/2r2v0IIsVzegjJX3MPXuNtB/zFkVhEpPa1joMIShfKzpJkhgjD5PYR0UDQL2BM59SecHIa6PKDGj8RNvOkqe59QDivSXgUhA+J1jpM7EhMCSLfrl/5v0xwKaEyAlzew659kalTXhqq9M5MDD0/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CbHW5JS4XzG2tf0E4raD3rGL6QMTDSzIzcerfvizKZ2eN8jQcDfv203whj/CFHguNU0VZdv6l3Mhc7mMhcGZPx3jkFjJzlPSFiCrNnJYy0OCF47o/DAWduhYvnCdKmiwTgawfCkKXUwydYn0b0RqrqQWfytR5tsWxRT4y+OTtHVre/NwRpZGXIkWpFObR0FFfRl6pHLRePQgW4HaKnDtbJF4akQ9MWtqZsl7Y3IF27sefxYnFrJP2u8ESwZerSnNZRbx64bA/4t1ukYSmhHldZuN3FV0+0e/Z1MBgvgihvk2Txm7thMRnU3TToO7bxk9hRd/VOGrm+SA8eisCFnt9Xf0WARyw2/ZFwa5M88u15CbBC7NhHCCrRm9KX+RHflOU4dwiF4vvu8ltmjCkmaX0V0NxXKLV2PFInB2xDkIp1BRzi/iMEfkO9+uEpWRNhGZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:44.8778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 196c682b-8bae-4fac-3a6e-08de7a3d65a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

pass queue properties flags at runtime, add new
MQD update flag to control performance count enable.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 116e509e7bed..4e9513cbe7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -796,6 +796,8 @@ enum amdgpu_mqd_update_flag {
        AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
        AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
        AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+       AMDGPU_UPDATE_FLAG_PERFCOUNT_ENABLE = 5,
+       AMDGPU_UPDATE_FLAG_PERFCOUNT_DISABLE = 6,
 };
 
 struct amdgpu_mqd_prop {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 412c00ecd97f..173fd09b5650 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -389,6 +389,7 @@ static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *queue,
 		props->cu_mask = cu_mask;
 		props->cu_mask_count = count;
 		props->is_user_cu_masked = (cu_mask != NULL);
+
 	}
 
 	/* Parse HQD priority and other compute properties */
@@ -623,6 +624,7 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 
 	userq_props->queue_size = args_in->queue_size;
 	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->cu_flags = args_in->flags;
 
 	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
 
-- 
2.34.1

