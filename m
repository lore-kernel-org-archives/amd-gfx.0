Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F94C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 03:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B11210EA2F;
	Fri, 14 Oct 2022 03:35:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D9310EA2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 03:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPNERGkaTHyIVfvsLGg5xM9olaeYbiL01bWsV1OoyF8yxZisJoxxv9AgfiGo61XQKFjdTukfULfpd1gIFECq5jgwnyVNsf0/UVwNSWkg1IAuIc1XJskFJFID4bSMpcc9x2K1WbVnLWr2UAOLbeSrkL7YwL2VD/nmC/llWx3EIDcMstRq9WmsS5dfX+WQ07z7TxkYn8vem8eXYCQ+16Gc0a6iMmUvqY7R/a6+E5vETpUn/ZakQdBWSWd8JEMPIXU/3llFYjJ2+90AhLbnvmFv2KZf6ejfmscxVdaeTUJrQh5hqcrtZ0EnFl9iIAEmOdey2ohAN0YdP6OTMN8WUjnTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu0u6PBUsZl8CidC4NtJL41ozMJoxKKgPgVfgpnRZgE=;
 b=KVonAF2dRyRk4/Rydf4zolypSxjYvcapYVRw2+mBRhjWQe8nz71Ft3NZ/J/mhs6KXR5Gsute9ATv2RfhBIodCnQnQyQw61C8Glp3QW9fdwybHtdfaekmywt8SL5NwZDMAuerm++X44jG8octqMci/pWV5YeU0QezEDeucexMl3yRM5AaGr2ny0ipCCNk3K+pc/0W2LbNlnkZBUYaZu3YVKvWFA1E3Kc2bi9uAObKZ5KvgfRz5xSDFez3ut7kPSvJDgCx3Pv7xMVeRettZdcYjFfRG0DpoW0BubWu0tDPTlmxygEEZ8tAYvDH9Mpx3s2OqDL9Ra3MiEx/0k/1rvpMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu0u6PBUsZl8CidC4NtJL41ozMJoxKKgPgVfgpnRZgE=;
 b=AaB87AQjvrCSr9oZY8gTvZB2Q5xe3QF4ezxnXTyE+2l9Y1UAXcV+hBa+xRlFt5SPwsJsl7pfXthfzKIY29Y+tfhQGTjG09p8BucGiOJSJdDFBn6UgC1rjGU1HYWxwbyg3mst62xay2A/ZgYQd6kDBDpqLSCkT2X6fGv0NINKPvk=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:35:09 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::8f) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Fri, 14 Oct 2022 03:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 03:35:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 22:35:08 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 13 Oct 2022 22:35:05 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Date: Fri, 14 Oct 2022 11:34:20 +0800
Message-ID: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: dfae244a-eaa5-46b1-684c-08daad95176a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdyNHHoc4zJ7QGqTDsdlibL7ZTU+X+EUv5S2XBerGFflztGmDml7hRU3KHKlNQhpiaXszPDDyjMfq99KzdnxjOmYrfOBm8wfFbsWT23UbWY3uSwSvto+Ykdlnhp95IN1V3w8m9MjLDqKYJJFXqAGChvkaIJso87857cPWN7IcKWepqpZkqcImONt6RMOLrP733ILVvp2LD+QpzG8OBxiBB5zcjNlXLHYZEC4yIgIjWhK6LkZmeYhl5S6MDMB79EwDpVKHQhwHAebGEYS9IERPqfA3xFzNl0AbJCQ/MMuAIb+3yY919pDwUFeuAxv2XR7iFjnMV5KFhlfh6zGYtLzCWcWXN/QPUDgBFKxcJZn6cYXXUIvCKnGOhb2IyCr2M2+2rgeOuad/wsbjuUFOcFQteffji8tEBfApy/FVNaX+96k/mb/55ayyyhw/ukV+M7udfmiwk08Yn2hoN/ytNLFrnqMGMuuRhQzjWU8YipljhskyszJeV89Kqdp//KIv2nEHynMYbH3gbwThs/dvX8pKshAHaJ/SgtAUAcRs4Xb4vTSXJXRFFSChZm6tHcwawPn4XxYdmoVHnnwVEwyokkerEIZV5KqW6ekjAZfC4aEejSHH7v72hMcfD0BcMYvHyPadaf9YMXZGZJ1gnXSwZOV06SKYZAJ2/wrUz5WEBw28vac4T1UWdZmd8tynpJ7ukRigWm/OdFA7yQ/ABkKfoZetO7Pyvgx2uN2kuJYLp4+kIEPhi2XhTx82d9UuzdbWmKx/iuarxttNQmlISRL+IsK5yoYAmr+iF5/QXCkrkwnjfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(54906003)(6916009)(40480700001)(47076005)(86362001)(316002)(426003)(4326008)(8676002)(6666004)(70586007)(70206006)(82740400003)(41300700001)(36860700001)(7696005)(26005)(5660300002)(82310400005)(36756003)(356005)(336012)(81166007)(1076003)(186003)(40460700003)(8936002)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:35:08.0147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfae244a-eaa5-46b1-684c-08daad95176a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update: Remove redundant comments as Christian suggests.

[Why]
If mes is not dequeued during fini, mes will be in an uncleaned state
during reload, then mes couldn't receive some commands which leads to
reload failure.

[How]
Perform MES dequeue via MMIO after all the unmap jobs are done by mes
and before kiq fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 41 +++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index ad980f4b66e1..ea8efa52503b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -130,6 +130,9 @@ struct amdgpu_mes {
 	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
 
+	/* dequeue sched pipe via kiq */
+	void                            (*kiq_dequeue_sched)(struct amdgpu_device *adev);
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 257b2e4de600..7c75758f58e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)
 		if (amdgpu_gfx_disable_kcq(adev))
 			DRM_ERROR("KCQ disable failed\n");
 
+		if (adev->mes.ring.sched.ready && adev->mes.kiq_dequeue_sched)
+			adev->mes.kiq_dequeue_sched(adev);
+
 		amdgpu_mes_kiq_hw_fini(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b48684db2832..eef29646b074 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
@@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
+	adev->mes.kiq_dequeue_sched = &mes_v11_0_kiq_dequeue_sched;
 
 	r = amdgpu_mes_init(adev);
 	if (r)
@@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)
 	return 0;
 }
 
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	int i;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+	}
+	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_EN, 0);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_HIT, 1);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	adev->mes.ring.sched.ready = false;
+}
+
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 {
 	uint32_t tmp;
@@ -1257,9 +1295,6 @@ static int mes_v11_0_hw_init(void *handle)
 
 static int mes_v11_0_hw_fini(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	adev->mes.ring.sched.ready = false;
 	return 0;
 }
 
-- 
2.25.1

