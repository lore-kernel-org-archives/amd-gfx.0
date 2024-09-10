Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FDBECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 03:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF40810E691;
	Tue, 10 Sep 2024 03:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PF+XeyO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E07B10E63A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 03:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abCTL8BIfpiawXuY7M1gzDy35EZRTkFJN3xLBYKu4NfVER51LKZo90xqVIBTOHxcJ7OSjrSKlLbhqabWBj9FJETfHvVcab0zNM6eloi9ffqY3mTiZX8oDRn/LBg8vkaEJ7Yqd8vd60h1knBzJn6Cj2ea5M6LUHI2ZOb+gqz9P/WU6dTAfG5kkb7Plngx8b07bHWsegGSSlchnqw2RaDVjCrMYKtPfMStwLVTPSemmTR6pahSt1yLc+eFBU/mmqItIT3jEC+ntcIDfGLRwMqiCKV4sHPn03x8NAIC8JovV/HHQYUtUTplLL2Q6DWnwIZS0FSCftARvyrs+ZJw9a+udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQJyXiu+OWq6LRwejjM38JY5+n9EWmi3+T9LwTaupf4=;
 b=tfgEtJsInGVZTPEXZgVCIkvXKQjI3A+10y6t36LTBAu6YOdA5Lwf/iIpZ82IwRSIFq5LEMnnVgNC0pp3P5O21LpgdJimGd90z9dtsfHZ6YWDtKw0kGV4vegFsztXwNBE3PlDfNdo9Kwh1OTN2ANhRK2+NThoZmL04jxe9AXs04wgkFIOtIjBSmjW2yFZ74MWNvY6TpxKsieljL3T6jqAYD61r46pOWRX/SXFGMx6eWirHC9WzdL4gu6BdhFkPQALgww0QGcvq/6NSJpjLloRkxcTXGk0omroBiVA6IdqcUq+AGYI/jWUv1BVKAarRb2JvyHAK7eho9G4CHyHEcd3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQJyXiu+OWq6LRwejjM38JY5+n9EWmi3+T9LwTaupf4=;
 b=5PF+XeyOgmSFc9ahAroOgtGYB7+9X5P1AKHYYvAtaRTcB3j0Su/mg767lj7QVuzfv02UVwuOqwxVpN1FPXRjr4Tr+yIx82H+ax6mPiJZbiSqr0Q+KjCU4pjq9z8MyOKfv1ed2tkWxHkJqL4UrTg7h+x6M2JXWWZmfuXy08JFqy8=
Received: from SJ0PR13CA0172.namprd13.prod.outlook.com (2603:10b6:a03:2c7::27)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 03:39:36 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::b) by SJ0PR13CA0172.outlook.office365.com
 (2603:10b6:a03:2c7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 03:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:39:35 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 22:39:33 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu/mes11: update mes_reset_queue function to
 support sdma queue
Date: Tue, 10 Sep 2024 11:39:16 +0800
Message-ID: <20240910033918.6035-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 9518a938-ca6b-4221-9187-08dcd14a30b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2IVNtDod+EuVFK4dTC7UeXbPAexa7D8XTtR0qdxrxjT2voB/38Bs5S9AXs5?=
 =?us-ascii?Q?3RBmtbqVJH8tMszkztzpYOB1uP9N8NN9qKcu2rqbUVfxdNjruuzwlwr8MuL/?=
 =?us-ascii?Q?IqXXT/6786LVq0NDUxU/OOk6vWDSmP46nTxSgbe/M+g83ry3//N2/DRxkuSu?=
 =?us-ascii?Q?uF892UP1gTxg3d1LPXuMQpfYB3c1Hv6ouD8Xw9cT3deZ4VGsgPpSJnxWkYdw?=
 =?us-ascii?Q?sd1E3oDt961HR2dNlVOWPCreNW0O5gugEWd1es3wjNouANNe9XL5e+d9/FCN?=
 =?us-ascii?Q?PQShZMTpOxUEEIw5S0+C+V3F9UwWsxhuketEMuGLCZYXlhHPvBeR/P/ySoto?=
 =?us-ascii?Q?LvgDwwZF7RDx7JyErRB1BJlltSiDgIFC/Ye+3BPF4M1+qKaxYyJy4+51TrXb?=
 =?us-ascii?Q?GE2nI3RLs6P+SFFAzS7jgUOs034pZT1ao8z7Mh2ZmGbw7Hhwh9kPRmo5oKs2?=
 =?us-ascii?Q?aN8j7V10SnNBwUbRqa6ghtVVWJQF55wn9bSfVxnrVs0XvrT5Y0e0l7WckjTC?=
 =?us-ascii?Q?r2NUUTzenw18lHThI0LSZof+PFkx4pef9BjF6K+KvrfUnU5iBSMG2uhevapY?=
 =?us-ascii?Q?6IFnLCCjQn+UFzsxNgljq/0qbW0rhh69GMudUyQrHsyR2j/N2j2je3f5JAlB?=
 =?us-ascii?Q?5wSBUTxFAVNKGu71AyfJYKf0fq0hRWAslDvYc7Fdenk3tJk/6Hzt1ptP6Xpc?=
 =?us-ascii?Q?n+3ithI1fqus1fRRLyYo3omC0N99rgFCHwKWg7e1YOZgPhN383bNzmCjpol7?=
 =?us-ascii?Q?1aA8RU+KcwzCyAJkSwcmj/4s3aEHcWjkVmn4V6BlkRNHmFP0a+4yUOYLyYvw?=
 =?us-ascii?Q?epoiR4LoLJujlf2Xi00odGfeIbR+Cah1MZY7D9nFM6g+YMz5T0gC2TFBrBFN?=
 =?us-ascii?Q?70nSGbdX7gQykw24ifSxhdcIrXbAB72ssQmem2Hx4ECc5xioz/RfTcoQp+D8?=
 =?us-ascii?Q?1FMqOGjpaSOFLnqkKMK+A4cPpHNy8/RthFN66P+LrmS4op7XbkVkAWU5ZWXz?=
 =?us-ascii?Q?WhRPqjUOei2uGM1pEyXusJjQsQlXVDhToe3UIqVPnOu8dTl92XrdkNh5LMd/?=
 =?us-ascii?Q?C7UK+1ugzXuxbAxr7OxuWPTuf8zNnAOLZ9+8KJX2FikYSvIHMtKQ9FNe6j0D?=
 =?us-ascii?Q?62AjkOtAZzLoPNEjeAVxMi+yk2rWZgSTt8i9C6eevPZvsxQPZPa6qyTaanXD?=
 =?us-ascii?Q?mPUrBwGOH1We2EIigbBXKu168JM8GtTxW4+5kHRy3xjL+rwfXs1ke2V6RdbZ?=
 =?us-ascii?Q?0bu0J4n8LRmR780idks3GImhg6/WpgLZSb+mJIsvqG9YFj7jst0TSpPF328u?=
 =?us-ascii?Q?OBM3c8RwSS2T3JIbZfqDNnrgOeRpjJWVNEuIIEeXeNX7MLQugmEtqPXu8n+0?=
 =?us-ascii?Q?hQcZRzLWjfb6ejloWKZBYDTT2lXHV8RnP4io/sFahLBYM2QFpQntXRqO/xSI?=
 =?us-ascii?Q?QSRcsAifFzKhILeOMS1ZXHkQg8GO0ert?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:39:35.2933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9518a938-ca6b-4221-9187-08dcd14a30b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

Reset sdma queue through mmio based on me_id and queue_id.

v2: simplify callflows and register calculation.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 27 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5174ed31ae5c..285ea4cdd5b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -914,7 +914,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.me_id = ring->me;
 	queue_input.pipe_id = ring->pipe;
 	queue_input.queue_id = ring->queue;
-	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.mqd_addr = ring->mqd_obj ? amdgpu_bo_gpu_offset(ring->mqd_obj) : 0;
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c4212b6fbc56..9dba72779391 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -366,7 +366,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 				      uint32_t queue_id, uint32_t vmid)
 {
 	struct amdgpu_device *adev = mes->adev;
-	uint32_t value;
+	uint32_t value, reg;
 	int i, r = 0;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
@@ -422,6 +422,31 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		}
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		switch (me_id) {
+		case 1:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA1_QUEUE_RESET_REQ);
+			break;
+		case 0:
+		default:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RESET_REQ);
+			break;
+		}
+
+		value = 1 << queue_id;
+		WREG32(reg, value);
+		/* wait for queue reset done */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32(reg) & value))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			r = -ETIMEDOUT;
+		}
 	}
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-- 
2.25.1

