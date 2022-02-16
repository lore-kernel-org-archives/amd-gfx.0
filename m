Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD42C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBE810E6AD;
	Wed, 16 Feb 2022 08:09:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1A10E6AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbxrSMfvAEPfeFWBVbvqVdvvbb0aOW04aPOAAAROa7BwAIfYUqFj0zhhUasDEAwYuBctEdVuqYTeE8t6fsii4g0VbYaERoybMifsTBOZKHHPQpsegVu+stH07Hs/7bv4iLBzKpTR3iOQF4m3r4NK6lekgrxc64EdPtxZOa9JU0wyMzLFIQv/awHrxGK/zIbBDhNjlOk2o/q8CuZW4wteqIlHLUlVmg2jmEFgT2O0eaeZ2ks7HkQK/us0YBPB/0K9sD9qQUV8O1DRW5BGwxdCObW7uMbJwJMB2Ekbq6lpX5bcOYW+E0aa/IsIoOYvxkvflF0rZVzVbVCD72jYIKHxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDUJfWhmI5NZv7egCm1yDh+zkYGpLFCwuJnfa62Qb8I=;
 b=QQEfFGGK+MLx5RgcmjcGAi4IpPjhVL8Gkcdy3K5UasVhvum/64TsdMMXz/JyY5Ka+5kwYaWmSpZF3kJBclJ/2b5CcqskyFnx6WRlYO3E5BMd1cz4wqT0tEp+WqUScd+NbJtz7cyIR4AowG4VEhAtIK+MYfVkU0WW1rh92xhwHOUcUTKNFWzW7yA8Y7PX+9tMk3j9czgBBpk8SZRBV4iu7P7VBcacQ+lfaIwW1oNfBojOenujIQumfV3edSbu3V+OMmVtMicHjJw6JWDMo0/8LzTDyveTZYWTUa7t2nGjWADvxcMd7vqGlRSuglkUMLuFzVI0bFKvjzuPqMSUFTPp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDUJfWhmI5NZv7egCm1yDh+zkYGpLFCwuJnfa62Qb8I=;
 b=b1I/VPzHNkFYqYbs7pk1mPYbwzd0WD59ZGjR2wYZiZ1POPmH/ojS0VJUT4/DSRoyGQ5AwosAq9T73IcQb+WqbuwICzSIfIb8IEZeRxov4tGTdHIWsO4XlV5XbT+1xRQG8FLQRtdhJpTs5m3+tj/HnyzjkO5dXGmjaYUCBlPNXDw=
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 08:09:11 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d0) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:08 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/7] drm/amdgpu: define amdgpu_ras_late_init to call all
 ras blocks' .ras_late_init
Date: Wed, 16 Feb 2022 16:08:03 +0800
Message-ID: <20220216080804.3560484-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f4f8fc-e416-400d-b6eb-08d9f1239d0a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5817:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB58171E7220D7B014D58348FCFC359@DM4PR12MB5817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqRkT4M3+EWS5htaeto/p+htGO3Rm5lT8ans79RMZQBFeecb6kbrNp6jCR9pMx6hOpmnVK9EruDyPvdd0bS6zFdjWVF7Kx5NCiOnOB+hqor+MsZEiWVjJFiNqzLj/qCI2R9U85rg5B3SADOaLxj53WAlToFcf/NghAsSbn3HAzl7TE4tMboFsbC7JKOdhU4cn7+WpkV7QxSLEPHvd8Oc3dM6zVi0NcalmEyUXht1ecevpAWu4NmP/wNLZ/cAkLG1WxjPoVArdMW6bFHTqZxVSI/8OGge4Yf8cUWhr2ZgDD1pwE22f9X9Uf3A3Ltl3Ql9+N+1h0NyJFm5Zn7x0vO71eZuKBXZ9Kgs+rvuz8aR0xzQ1lGwfhAYmxd8z+vePCFW/CiYwNcnTrA9Or1d6fA8IapXtRqnrPYUauytjCmEnBuLYLM4QXwLyEFM8a0jULQ9LBT6e+NmHEwdqV9MvJ+z5D/KwwHKA/PuwwtMQLQd7hmjuNjQrA317OZCC4LYVKN4mQPQMQdwtyogJwGK3iSEbri/Bed/6neZ0JyDs3kzkGt7laGWA5ojy2gvV+yr4qttOpGqJKSFwmvs/fadjqCw16teQd3DHHWXM0FRwJCohKDoUEVRW/XZf1GmNXmwCobEqf8f4LqVtx6Z2iN4WnWz4t9A4fcmPjAoqm1jxd8K/vtUsGnD3sihZfEt6hJvNC+qoeRKxgbggZr4P7q04Rc6C/zso0S0iSrZX7ngRkA7FEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(426003)(26005)(2906002)(1076003)(336012)(186003)(7696005)(16526019)(83380400001)(81166007)(86362001)(5660300002)(70586007)(47076005)(2616005)(36860700001)(82310400004)(8676002)(70206006)(356005)(8936002)(6916009)(36756003)(508600001)(54906003)(40460700003)(316002)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:10.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f4f8fc-e416-400d-b6eb-08d9f1239d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define amdgpu_ras_late_init to call all ras blocks' .ras_late_init.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 44 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 25 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 +--
 7 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a74a1b74a172..d90388dd5362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2625,6 +2625,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	r = amdgpu_ras_late_init(adev);
+	if (r) {
+		DRM_ERROR("amdgpu_ras_late_init failed %d", r);
+		return r;
+	}
+
 	amdgpu_ras_set_error_query_ready(adev, true);
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ebf4194b0699..49dd81c0db2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -449,50 +449,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *adev)
 
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
-	int r;
-
-	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
-		r = adev->umc.ras->ras_block.ras_late_init(adev, adev->umc.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_late_init) {
-		r = adev->mmhub.ras->ras_block.ras_late_init(adev, adev->mmhub.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
-		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, adev->gmc.xgmi.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
-		r = adev->hdp.ras->ras_block.ras_late_init(adev, adev->hdp.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mp0.ras && adev->mca.mp0.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp0.ras->ras_block.ras_late_init(adev, adev->mca.mp0.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mp1.ras && adev->mca.mp1.ras->ras_block.ras_late_init) {
-		r = adev->mca.mp1.ras->ras_block.ras_late_init(adev, adev->mca.mp1.ras_if);
-		if (r)
-			return r;
-	}
-
-	if (adev->mca.mpio.ras && adev->mca.mpio.ras->ras_block.ras_late_init) {
-		r = adev->mca.mpio.ras->ras_block.ras_late_init(adev, adev->mca.mpio.ras_if);
-		if (r)
-			return r;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1aff88fcea76..b5286a0d9c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2522,6 +2522,31 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 		amdgpu_ras_disable_all_features(adev, 1);
 }
 
+int amdgpu_ras_late_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_block_list *node, *tmp;
+	struct amdgpu_ras_block_object *obj;
+	int r;
+
+	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+		if (!node->ras_obj) {
+			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			continue;
+		}
+		obj = node->ras_obj;
+		if (obj->ras_late_init) {
+			r = obj->ras_late_init(adev, &obj->ras_comm);
+			if (r) {
+				dev_err(adev->dev, "%s failed to execute ras_late_init! ret:%d\n",
+					obj->ras_comm.name, r);
+				return r;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /* do some fini work before IP fini as dependence */
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 837d1b79a9cb..143a83043d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
+int amdgpu_ras_late_init(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bb40ab83fc22..1997f129db9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4791,12 +4791,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
-		r = adev->gfx.ras->ras_block.ras_late_init(adev, adev->gfx.ras_if);
-		if (r)
-			return r;
-	}
-
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index af5a1c93861b..e26c39fcd336 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1894,10 +1894,7 @@ static int sdma_v4_0_late_init(void *handle)
 			adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 	}
 
-	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
-		return adev->sdma.ras->ras_block.ras_late_init(adev, adev->sdma.ras_if);
-	else
-		return 0;
+	return 0;
 }
 
 static int sdma_v4_0_sw_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 464d635a0487..ba983398c9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1186,15 +1186,11 @@ static int soc15_common_early_init(void *handle)
 static int soc15_common_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
-		r = adev->nbio.ras->ras_block.ras_late_init(adev, adev->nbio.ras_if);
-
-	return r;
+	return 0;
 }
 
 static int soc15_common_sw_init(void *handle)
-- 
2.25.1

