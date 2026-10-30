Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C71606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 02:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lf0Mp5iu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23813112623;
	Fri, 30 Oct 2026 02:48:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E05D112623
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 02:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OElUle1W1R4z/A8ozXcQ3hMWgpZRDPVsDz/BrA0LLqSxNv731u8kbCPEVO1+ObOgTPhMnNLUJM4Hosx94498/OeTNgE7QKOH9RDM4IcPVcTv31vC9/fBvHOySfTnlE1jRGRA75Ma1GIUAMXqewetK95KkUOcVhmR4yOoJMSK8PEnLxUJtJhGt2AkBmB6tGabEsLz2tpjOYukGOreoncE2N2fZW6426mmpZ8674zD+PBAdQjYJ1YL1ZsOWNb8vU34UYODt3PBylYpZ4dqwuCcdjRbas1Tq1DMWxF9HpKsCfhvybxWelOiZh59K+RCggEI7lC1hy0QYflw3qq8f5Se/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffDNxIbReOeiMc2XVpkQVzJqyrxnizO9DWlxm/cL6ts=;
 b=yH5Ujvum7L2/H5rHxKWoLxfYhdPF8Px47Ku2cMBay57tk6VX9GYYE3ltRvYAXFmKoaPi7jLXxT7R5Fs19FAcywx+RJoGcHvRd0qurx4C+SqVA938Hdj6LXe90Ge5396DjF9jB4S/Zt5/8GkF8SbExqBrRCidhJGFsr5Mp8qksPHZRpBGTf0jb7TO6bSRIYUFiJUsm70rC4xFcTxv3jhfchLsKamnj8450LUUh9QXnw+UCsrKODub//faHPdrTwSC/nzK3Ptbw/e9EcKB/YaDdQlFOT3TiWulgsuGYF/P+gm9xAQ7UXA4tpS1NZ3DwH5B4aTURRKUOlna3mOzJyzSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffDNxIbReOeiMc2XVpkQVzJqyrxnizO9DWlxm/cL6ts=;
 b=Lf0Mp5iuEOJRw+fv40i70foQNe5ORZYSKEOJ8aM1jktkpk3jyv2wWnV5xVZ1st7u8gZs4ZilAluj0Wsv9Y695CNWyqfptJ4QyK8ysyDoXoUSO/wczJS696318kxBD9m4/AWqj9fH+SqEnoUR1ZMpww1dl2UaELkm9yHK7D6ucmY=
Received: from SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::9)
 by LV0PR12MB389050.namprd12.prod.outlook.com (2603:10b6:408:60a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:48:07 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::3b) by SJ2P220CA0012.outlook.office365.com
 (2603:10b6:a03:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 02:48:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 02:48:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 21:48:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
 work
Date: Fri, 30 Oct 2026 10:47:47 +0800
Message-ID: <20261030024747.3083509-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024747.3083509-1-Prike.Liang@amd.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|LV0PR12MB389050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca7a3f9-cfc4-4765-2587-08df36303a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|260925022911599003|260925021911599003|260925021311599003|5023799004|11063799006|56012099006|261009221227099003|261009221727099003|261009220027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261009223327099003|261021121427099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: tBDCIpNvIHHvC8ApPwSA5l8gZi3ZJXNnYMMGqUB33Tq/zUodUtWcyLWfhpX7NGz61QEJhD7iZVU6HUxUwE7f4gCpRktFaNPKzb5l75Wam7Fws/wGRuKk3VXuD4bUBG8duF8UvXeTSCswzuJm9TziDwWLUYqC6OS+s+IUd0idhj+keBwPf0cH6mrhmP1ezubj5aoeUJufr37URu/a52efQ1WHF+WyqRoXYZf6gy4CaGxGO27B9Wjt4cwY9ePlsEbQnaVw5MhVI0QmnuVxeEKEUTcQVZJgBbvVXqcEZD/+mJVxqUhfeogahlcafmdkmZIf5ez+nWs+K4PowHlm2zYR/aEF7ZLtirnDSBAkeAgG9vY6VYvPj2dpeC5iyBRTHckdzzqjXqBm/q2p+++3Lad8OLIpbZ9aE2CTC4ndGchhrN+s1CtYZBmBbTx1OAtzgzzWHvAV0yM6r3eLvsucT7aSscm0IaN0upZxK02f49yu/QcngVh0u68O1FA4vn9t6GE4uMEt+FYGDDTq6HrJzYBvGIYqKn+ciitMAHy8rhHOLqZw96TDHfywE8eCjhWkd6VIDZ+auxbzDHR51EsexV7U8BvpK+Nn8Chj2TELzijmiurJZ9eOu40SupSo2gCYChXVGoxNwq0UfG2bjaO2Qqm6ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(56012099006)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261009223327099003)(261021121427099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fehZJNa7DURAPWrWEsvbA8Qr87gmzZ+QWTLbtz+75hw3C4vi0yOMQMEltnsNBSn/hxgFGe3Ettrn5eI8S5Vijic1YHseCLe/JwGO7Oy307NdzG+gHW+ubha8aXpPraLq8X/kWiEvXvkt7PVqN8VCs80OL+27xSn0I35wHKn1CQbDsnASFkQMoSjOnslDzgn/Yf5zdQdWKn+c9cbEnUD3/Xb6ZvDX+X1DAgyxq8RvIL9FYtdMDgJM6udA4WAvMyVNyjpXZnG47YbzXHbvdK3bUYYMagtGtcME+obD6zWZi52qF4X0WS2Gh37ULJIVihAXEhjcex8Fnk1LIZ6d1DKeHMQ6mEQkXKrmzy1WYhcDaRmBUTFCeClVd+KokW22O/MdkZlHgZJhGrZoa0z7xT7DcjLJZ8NbTm7oeGultRLmk+iXwR1Z986zEKpEuM/NrpW6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:48:06.8815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca7a3f9-cfc4-4765-2587-08df36303a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB389050
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The common JPEG and VCN idle workers program power gating and DPG pause,
so they must not run while a GPU reset is in progress. Recovery must not
wait for them either, since everything the workers depend on then
becomes a dependency of GPU recovery.

Make the workers take reset_domain->sem for read, so they wait for a
running reset instead of touching the hardware. hw_fini/suspend, the
hw_init error paths and begin_use, the latter for the IB tests, run from
GPU recovery as well, so only skip waiting for the idle work when the
reset itself calls them. The reset holds the semaphore for write and
would otherwise deadlock on a worker blocked on it. Outside a reset the
cancel stays synchronous as before.

A device can also be torn down while a peer in its XGMI reset domain is
being reset. hw_fini then doesn't wait for the worker either, and is
skipped entirely if the peer's reset has already suspended the device.
Cancel the idle work synchronously in early_fini, which only runs on
teardown and before any hw_fini, so the worker is done before the
hardware it touches is torn down.

Update versions:
v1: https://lists.freedesktop.org/archives/amd-gfx/2026-October/155441.html
v2: https://lists.freedesktop.org/archives/amd-gfx/2026-October/156119.html

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc; Leo Liu <leo.liu@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 30 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 36 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  5 ++--
 24 files changed, 125 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 2b0e658b63b6..87f0ba6a79d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -95,9 +95,30 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	/* Called on teardown even if sw_init never ran */
+	if (!ip_block->status.sw)
+		return 0;
+
+	/* hw_fini may not wait while a peer in the reset domain resets */
+	cancel_delayed_work_sync(&ip_block->adev->jpeg.idle_work);
+
+	return 0;
+}
+
+static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(adev))
+		cancel_delayed_work(&adev->jpeg.idle_work);
+	else
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+}
+
 int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
 {
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 
 	return 0;
 }
@@ -114,6 +135,9 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -129,6 +153,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
@@ -136,7 +162,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 05d58e6bbfab..a473becb5def 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -156,6 +156,7 @@ struct amdgpu_jpeg {
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev);
+int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block);
 int amdgpu_jpeg_suspend(struct amdgpu_device *adev);
 int amdgpu_jpeg_resume(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..6c12d8aa3c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -299,6 +299,26 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 }
 
+int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	/* Called on teardown even if sw_init never ran */
+	if (!ip_block->status.sw)
+		return 0;
+
+	/* hw_fini may not wait while a peer in the reset domain resets */
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	}
+
+	return 0;
+}
+
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -459,6 +479,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(vcn_inst->adev))
+		cancel_delayed_work(&vcn_inst->idle_work);
+	else
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -470,6 +499,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -499,6 +531,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
@@ -507,7 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
 	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
-		cancel_delayed_work_sync(&vcn_inst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vcn_inst);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..509c83799a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -522,10 +522,12 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
 
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
 				enum vcn_ring_type type, uint32_t vcn_instance);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index f03c1a37c8dd..1b498190954d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -166,7 +166,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -181,7 +181,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
@@ -792,6 +792,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.early_init = jpeg_v2_0_early_init,
 	.sw_init = jpeg_v2_0_sw_init,
 	.sw_fini = jpeg_v2_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_0_hw_init,
 	.hw_fini = jpeg_v2_0_hw_fini,
 	.suspend = jpeg_v2_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 46293664fd28..80c79aeeb410 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -227,7 +227,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -243,7 +243,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
@@ -665,6 +665,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.early_init = jpeg_v2_5_early_init,
 	.sw_init = jpeg_v2_5_sw_init,
 	.sw_fini = jpeg_v2_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_5_hw_init,
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
@@ -681,6 +682,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.early_init = jpeg_v2_5_early_init,
 	.sw_init = jpeg_v2_5_sw_init,
 	.sw_fini = jpeg_v2_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_5_hw_init,
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 361d0f4b4bc7..3411a32d00ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -181,7 +181,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -196,7 +196,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
@@ -564,6 +564,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.early_init = jpeg_v3_0_early_init,
 	.sw_init = jpeg_v3_0_sw_init,
 	.sw_fini = jpeg_v3_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v3_0_hw_init,
 	.hw_fini = jpeg_v3_0_hw_fini,
 	.suspend = jpeg_v3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 4e8eed2b62db..4a916cc2bd01 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -210,7 +210,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -225,7 +225,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
@@ -748,6 +748,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.early_init = jpeg_v4_0_early_init,
 	.sw_init = jpeg_v4_0_sw_init,
 	.sw_fini = jpeg_v4_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_hw_init,
 	.hw_fini = jpeg_v4_0_hw_fini,
 	.suspend = jpeg_v4_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 9f298c4ea8ff..6b62731495ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -443,7 +443,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -459,7 +459,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -1227,6 +1227,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.early_init = jpeg_v4_0_3_early_init,
 	.sw_init = jpeg_v4_0_3_sw_init,
 	.sw_fini = jpeg_v4_0_3_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_3_hw_init,
 	.hw_fini = jpeg_v4_0_3_hw_fini,
 	.suspend = jpeg_v4_0_3_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a1496412810c..109237055eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -238,7 +238,7 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -254,7 +254,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
@@ -807,6 +807,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.early_init = jpeg_v4_0_5_early_init,
 	.sw_init = jpeg_v4_0_5_sw_init,
 	.sw_fini = jpeg_v4_0_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_5_hw_init,
 	.hw_fini = jpeg_v4_0_5_hw_fini,
 	.suspend = jpeg_v4_0_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 1a4594d5d952..c0bacaafdf7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -178,7 +178,7 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -193,7 +193,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
@@ -683,6 +683,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.early_init = jpeg_v5_0_0_early_init,
 	.sw_init = jpeg_v5_0_0_sw_init,
 	.sw_fini = jpeg_v5_0_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_0_hw_init,
 	.hw_fini = jpeg_v5_0_0_hw_fini,
 	.suspend = jpeg_v5_0_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index efdc537ec81e..9ae23235d16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -314,7 +314,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -330,7 +330,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -887,6 +887,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = jpeg_v5_0_1_sw_init,
 	.sw_fini = jpeg_v5_0_1_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_1_hw_init,
 	.hw_fini = jpeg_v5_0_1_hw_fini,
 	.suspend = jpeg_v5_0_1_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index eb3dc9558e0d..0fc58d25abe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -287,7 +287,7 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -303,7 +303,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -871,6 +871,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = jpeg_v5_0_2_sw_init,
 	.sw_fini = jpeg_v5_0_2_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_2_hw_init,
 	.hw_fini = jpeg_v5_0_2_hw_fini,
 	.suspend = jpeg_v5_0_2_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 0cbb2b8a7e78..d5bc6820ad8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -161,7 +161,7 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	return r;
 }
 
@@ -176,7 +176,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
@@ -671,6 +671,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 	.early_init = jpeg_v5_3_0_early_init,
 	.sw_init = jpeg_v5_3_0_sw_init,
 	.sw_fini = jpeg_v5_3_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_3_0_hw_init,
 	.hw_fini = jpeg_v5_3_0_hw_fini,
 	.suspend = jpeg_v5_3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index b3e63d6e79a8..897310d04f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* Override the work func */
-	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
+	/* Own lockdep class, this work is still cancelled synchronously */
+	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
 
 	amdgpu_vcn_setup_ucode(adev, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 12ac20484396..706089744803 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -310,7 +310,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	amdgpu_vcn_cancel_idle_work(adev->vcn.inst);
 	return r;
 }
 
@@ -326,7 +326,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+	amdgpu_vcn_cancel_idle_work(vinst);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (vinst->cur_state != AMD_PG_STATE_GATE &&
@@ -2103,6 +2103,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.early_init = vcn_v2_0_early_init,
 	.sw_init = vcn_v2_0_sw_init,
 	.sw_fini = vcn_v2_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v2_0_hw_init,
 	.hw_fini = vcn_v2_0_hw_fini,
 	.suspend = vcn_v2_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2b2abe689508..c3f2265f50fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		/* Override the work func */
-		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+		/* Own lockdep class, this work is still cancelled synchronously */
+		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
 
 		amdgpu_vcn_setup_ucode(adev, j);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6543f21daa1e..8f256d962ce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -433,7 +433,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -457,7 +457,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -2366,6 +2366,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.early_init = vcn_v3_0_early_init,
 	.sw_init = vcn_v3_0_sw_init,
 	.sw_fini = vcn_v3_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v3_0_hw_init,
 	.hw_fini = vcn_v3_0_hw_fini,
 	.suspend = vcn_v3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8b5646297c2e..b68746b37a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -358,7 +358,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -382,7 +382,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -2287,6 +2287,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.early_init = vcn_v4_0_early_init,
 	.sw_init = vcn_v4_0_sw_init,
 	.sw_fini = vcn_v4_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_hw_init,
 	.hw_fini = vcn_v4_0_hw_fini,
 	.suspend = vcn_v4_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0c58ca25d7b5..a1bfcece38fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -404,7 +404,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -425,7 +425,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
@@ -2035,6 +2035,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
 	.hw_fini = vcn_v4_0_3_hw_fini,
 	.suspend = vcn_v4_0_3_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a6eaa57ec2ee..fb5336f46ac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -335,7 +335,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -1690,6 +1690,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.early_init = vcn_v4_0_5_early_init,
 	.sw_init = vcn_v4_0_5_sw_init,
 	.sw_fini = vcn_v4_0_5_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_5_hw_init,
 	.hw_fini = vcn_v4_0_5_hw_fini,
 	.suspend = vcn_v4_0_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 055729a42094..b18c61e6d099 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -299,7 +299,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -1476,6 +1476,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.early_init = vcn_v5_0_0_early_init,
 	.sw_init = vcn_v5_0_0_sw_init,
 	.sw_fini = vcn_v5_0_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_0_hw_init,
 	.hw_fini = vcn_v5_0_0_hw_fini,
 	.suspend = vcn_v5_0_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 55a4b2f9463f..a5d3ee06fced 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -351,7 +351,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -372,7 +372,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
@@ -1660,6 +1660,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
 	.hw_fini = vcn_v5_0_1_hw_fini,
 	.suspend = vcn_v5_0_1_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ea6cdbcb6352..1b7897bb9953 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -266,7 +266,7 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -287,7 +287,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
@@ -1451,6 +1451,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = vcn_v5_0_2_sw_init,
 	.sw_fini = vcn_v5_0_2_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_2_hw_init,
 	.hw_fini = vcn_v5_0_2_hw_fini,
 	.suspend = vcn_v5_0_2_suspend,
-- 
2.34.1

