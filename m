Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24499FD4F3D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 20:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D0210E783;
	Tue, 10 Mar 2026 20:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I08HdAKN";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE9810E783
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 20:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9P+Vj8mkklbBPy26oDhX40TBZX873dkzrjg69sCX+8HPnYfPifzP2CpZF9d5/SEhSGSrRr1wVZw/Y6tbDGTMHi2BVGLO7gdAW/TSU6xpS2kZdKXUYmgfmL5RKHRg2untq7PtGLYAcOBEjFSAx+VvKKe+Ibz8q+ZlLkjgsOF/SN3wTxKP0+amlaRmd+YlX8SKKW63rmnkrJskm9PY0kLoNFXmecFwgJDclugCEAxJoLfwGh0Fm15r7qOm5T0dgwq2F9kweY22KvP/cCL9cmIeENIt14sZU+7RCqfNZTYSDpqT8P9wsBruyXLjGikW9nLEXX8xvTjXV5GdF2zRn0FBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A2IJZUBXOfXfn1C8hhLiPj7S9IqH7jUCurQNVS443U=;
 b=gdzPFS2yQrxvVXM9MBFI0A6GQIbC5Xw9FyoVIEjmdQy4a8/VQGzJ+GEmJbNM2+0oTaYmV/ixPi7Eyx66iYHXVrRUzlz9yToay/X0kJ0atRg+pHDxUBAjvfLDw8UzmioSabcrkVLerLmNOcYN10NAQV1xUlxiC5Ja2VBs7waqG1qXsKQN+ivjln6l8mVTvamPl/KmumePJJTc+3B6OY4wMpdUas0oVYngLdQifX4RAmXAwkT5UKqfSQAwq3CLJsSXRAYHjY0b+jOeNbjEk8AXt5uZCnqRrtMyFdMbAl9IaY4PsHho3emVabW5Tt/P/sDvVe2+AL+CC9TqizC0Abcibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A2IJZUBXOfXfn1C8hhLiPj7S9IqH7jUCurQNVS443U=;
 b=I08HdAKNP4fVK1dPYmd7/eWkAxpr/7e9n/9arJ/0euh879YBXQ2qr/TquAptgugbdKVTyAoyLBTvbO6lPCMZ5DMvYU+HNi85NBDByZos3cAtI+S7Yl+8MOrUl/IOPWH4DllxyroXDwVbvr+enx1it/q3GBl8Bh/NMfWR+FZkESk=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 20:41:20 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4e) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Tue,
 10 Mar 2026 20:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 20:41:19 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 15:41:18 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <lijo.lazar@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <chenglei.xie@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH v3] drm/amdgpu: force fence completion for all rings before
 and after reset
Date: Tue, 10 Mar 2026 16:41:13 -0400
Message-ID: <20260310204113.2282056-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
References: <36bdc19b-87c3-4ed2-ab60-b1f97cb9c0a7@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b277b6e-f84c-4905-8354-08de7ee5629a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: AgU0LFA6hKvrVh++mka23Pt5mXboxV+h+pIGvCaneAfdM+sZG1746pJmkBQpmPI7xnd8ARp1FXqM+zFjYfloqHH/iPt2da13xnWSLGF6lU6AXwA2PwbYpYOX3JTd+jRoA/As7frD4TcAVr7zlb3TqLy9iahawMNLaNDwcSfEa37nM5okgYeq4WLrLoGD4GpCXr8EFFuZReftw33JKO/GBDXAumvSFZB87RfLvJH5lA3QhHcL5w/17WRpe5NtuJYmc36m9G46YMEAUEv+KAAtGRp+0ED7NoGyJRUUC9PLdL1vnjXewDTlpgzy3Lb70ucEqRnF07GW0uiHIcNpbz3cN9INuX/fl3ewWcFbfmel2lbsytCBlhZKjqPzoWyysviMQOtprr+Fw4jb4D/4IlhdqsLxZtwk+EuLTfXcf8GrwgfN/dI6EsP/ZcmcF7WRkH5vKpv1Ae7JlnlhaVTlt3d+8RajfFnCk6Lgk24ZhSgLVRHa9Th5V2ViCjUiAvt2/+wANKwHLBYJtBBm8wKuMtm5tCzGEOM6J4OWyxCyCK8rkrLiZP9lP/vH7UKJbCUwkzZLE/hk7lPn6DBoZZZI+f9J1yZzg6L/NgHvC0picc6uPptkqbweAevDVargiar/1UvGapjrLVMRnDNfweQsIBvgqkmKj+6HnUn0yQbp+GC40SI6k+lhBnO/izR12rHr+dQ99J9s8W6F78tBf0wFJvwcOI4vmCIQsd5Jnt36oRyxf4yAC/gekVLECVRJYobnqwrt4gcNL4v2FOBl9/tU4H6Kzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LIbUZ3LoLLzkl1TsUg3lYJRWDJQ3YTpfz6zJZDq3EpGYcKAaj5Hzx5JkQROt/9hluZvh8h7jHTdkG9bqlqExvV0TAgXH8enpDdyiEtIkDGwo8x2c87EPZKmG3BVWSFh3GH+IXFG/5vXg6mqiKhTaerlZ28//FRbXc8vk9ft1a1/aqbUG5YKyjOrxS/BuLGIjRw9rUv4u1Fg9No6QUx3Tx/vNDCJzaUHIwE2CEniD+icHA/RE98oP5ftv5e1uiVHnmkcyRcT0cXEpclN6eRxlXRBxueNZGD5MBbwYy+77lazt2IhEKOow64SI+WTtIAanZZMhBwfAn4P1e8cFdllYVYj5Fi0OqZSaPVRfqa7GlHXnW3udoPgCYncv4gPlkPilvZxFIl9xfnAjPhL9E3mOT98asEM7+iFnLPyoFqjybgNIgytj4S+44KfNCohETHDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 20:41:19.8968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b277b6e-f84c-4905-8354-08de7ee5629a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

After GPU reset, the hardware queue is cleared and all pending fences
are lost, but the fence writeback memory stays stale. If the driver
keeps submitting to the KIQ ring during reset (e.g. HDP flush),
sync_seq advances while writeback does not, so amdgpu_fence_emit_polling()
waits for lost fences and hits -ETIMEDOUT, blocking further KIQ use.

Also, current logic on amdgpu_device_pre_asic_reset() skips force completion on
rings without GPU scheduler(e.g KIQ)

v3: Use ring->fence_drv.initialized instead of amdgpu_ring_sched_ready()
so that every ring with a fence driver(including KIQ) gets force_completion
before reset in amdgpu_device_pre_asic_reset(), and after reinit in amdgpu_device_reset_sriov().
That syncs writeback with sync_seq and avoids the timeout.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e1e9c824598f..2a8ff85ddb771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4985,7 +4985,7 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 				     struct amdgpu_reset_context *reset_context)
 {
-	int r;
+	int i, r;
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
@@ -5022,6 +5022,16 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* After reset and reinitialization, force completion on all rings to discard any lost fences sent during reset. */
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->fence_drv.initialized)
+			continue;
+
+		amdgpu_fence_driver_force_completion(ring);
+	}
+
 	hive = amdgpu_get_xgmi_hive(adev);
 	/* Update PSP FW topology after reset */
 	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
@@ -5238,14 +5248,13 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
-	/* block all schedulers and reset given job's ring */
+	/* Force completion on all rings with fence driver so pending fences are signalled and writeback is synced before reset. */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-		if (!amdgpu_ring_sched_ready(ring))
+		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
-		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
 
-- 
2.34.1

